import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubPage2 extends StatefulWidget {
  const SubPage2({Key? key}) : super(key: key);

  @override
  State<SubPage2> createState() => _SubPage2State();
}

class _SubPage2State extends State<SubPage2> {
  @override
  Widget build(BuildContext context) {
    Widget page = Container(
      color: Colors.teal.shade200,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: const Text("Sub page 2"),
    );
    return Platform.isIOS
        ? SafeArea(
            top: false,
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(),
              child: page,
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: page,
          );
  }
}
