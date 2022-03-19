import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimize_with_overlay/pages/home_page.dart';
import 'package:minimize_with_overlay/provider_models/app_state_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApp(
            title: 'Minimize feature',
            home: HomePage(),
            theme: CupertinoThemeData(
                barBackgroundColor: Colors.white,
                primaryColor: CupertinoColors.darkBackgroundGray,
                brightness: Brightness.light),
          )
        : MaterialApp(
            title: 'Minimize feature',
            theme: ThemeData(
                primaryColor: Colors.grey.shade800,
                primarySwatch: Colors.blueGrey,
                brightness: Brightness.light),
            home: const HomePage(),
          );
  }
}
