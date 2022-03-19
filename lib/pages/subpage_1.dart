import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubPage1 extends StatefulWidget {
  const SubPage1({Key? key}) : super(key: key);

  @override
  State<SubPage1> createState() => _SubPage1State();
}

class _SubPage1State extends State<SubPage1> {
  @override
  Widget build(BuildContext context) {
    Widget page = Container(
      color: Colors.deepPurple.shade300,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: const Text("Sub page 1"),
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
