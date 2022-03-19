import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimize_with_overlay/pages/video_page.dart';
import 'package:minimize_with_overlay/provider_models/app_state_model.dart';
import 'package:minimize_with_overlay/tabs/first_tab.dart';
import 'package:minimize_with_overlay/tabs/second_tab.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tabs = const [FirstTab(), SecondTab()];
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.airplane), label: "Tab 1"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.game_controller), label: "Tab 2")
  ];
  int activeTabIndex = 0;
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    overlayEntry = OverlayEntry(builder: (context) {
      return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          bottom: context.watch<AppStateModel>().isVideoMinimized
              ? (Navigator.of(context).canPop()
                  ? MediaQuery.of(context).padding.bottom
                  : (50 + MediaQuery.of(context).padding.bottom))
              : 0,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 50),
            child: !context.watch<AppStateModel>().isVideoStarted
                ? Container()
                : VideoPage(
                    videoName: context
                        .watch<AppStateModel>()
                        .activeVideoListItem!
                        .title,
                    videoUrl:
                        context.watch<AppStateModel>().activeVideoListItem!.url,
                  ),
          ));
    });
    if (!context.read<AppStateModel>().isOverlayPlayerAdded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _insertOverlay(context);
        context.read<AppStateModel>().setIsOverlayPlayerAdded(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: bottomNavItems),
            tabBuilder: (context, index) =>
                CupertinoTabView(builder: (context) => tabs[index]),
          )
        : Scaffold(
            body: tabs[activeTabIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: activeTabIndex,
              onTap: (tabIndex) {
                setState(() {
                  activeTabIndex = tabIndex;
                });
              },
            ),
          );
  }

  void _insertOverlay(BuildContext context) {
    context.read<AppStateModel>().addToOverlayEntry(overlayEntry: overlayEntry);
    return Overlay.of(context)!.insert(
      overlayEntry,
    );
  }
}
