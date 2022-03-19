import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimize_with_overlay/pages/subpage_2.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.deepOrangeAccent.shade100,
      alignment: Alignment.center,
      child: CupertinoButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "To subpage 2",
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
                  CupertinoIcons.chevron_forward,
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (_) => const SubPage2()));
          }),
    );
  }
}
