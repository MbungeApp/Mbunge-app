import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context) {
  final bool isIos = true; //Platform.isIOS;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return isIos
          ? CupertinoAlertDialog(
              title: Text("Almost There"),
              content: Text(
                  "By clicking \"Get started\" you would have agreed to MbungeApp terms of service and licences"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Get started"),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/account");
                  },
                ),
                FlatButton(
                  child: Text("Exit"),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            )
          : AlertDialog(
              title: Text("Almost There"),
              content: Text(
                  "By clicking \"Get started\" you would have agreed to MbungeApp terms of service and licences"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Get started"),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/account");
                  },
                ),
                FlatButton(
                  child: Text("Exit"),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
    },
  );
}
