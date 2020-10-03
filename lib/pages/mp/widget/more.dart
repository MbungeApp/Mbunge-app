import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreMps extends StatefulWidget {
  final PageController pageController;
  MoreMps({this.pageController});
  @override
  _MoreMpsState createState() => _MoreMpsState();
}

class _MoreMpsState extends State<MoreMps> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
        ),
        middle: Text("All MPs"),
      ),
      child: Center(
        child: Text("sdfdfd"),
      ),
    );
  }
}
