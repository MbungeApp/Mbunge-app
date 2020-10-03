import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/clipper.dart';

class ConfirmCode extends StatefulWidget {
  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> firstInput;
  Animation<Offset> secondInput;
  Animation<Offset> thirdInput;
  Animation<Offset> fourthInput;
  Timer _timer;
  int _start = 30;

  void startTimer() {
    if (mounted) {
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
              _start = 30;
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    } else {
      print("Timer is nil");
    }
  }

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();

  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  FocusNode thirdNode = FocusNode();
  FocusNode fourthNode = FocusNode();
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    firstInput = Tween<Offset>(begin: Offset(0, 50), end: Offset.zero)
        .chain(
            CurveTween(curve: Interval(0.0, 1.0, curve: Curves.easeInOutBack)))
        .animate(animationController);

    first.addListener(() {
      setState(() {});
      if (first.text.length > 0) {
        secondNode.requestFocus();
      }
    });
    second.addListener(() {
      setState(() {});
      if (second.text.length > 0) {
        thirdNode.requestFocus();
      }
    });
    third.addListener(() {
      setState(() {});
      if (third.text.length > 0) {
        fourthNode.requestFocus();
      }
    });
    fourth.addListener(() {
      setState(() {});
      if (fourth.text.length > 0) {
        fourthNode.unfocus();
      }
      // else{
      //   fourthNode.unfocus();
      //   thirdNode.requestFocus();
      // }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    first.dispose();
    second.dispose();
    third.dispose();
    fourth.dispose();

    firstNode.dispose();
    secondNode.dispose();
    thirdNode.dispose();
    fourthNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          buildClipPath(context),
          buildBody(context),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        15,
        MediaQuery.of(context).size.height * 0.1,
        15,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(5),
            elevation: 10.0,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildTitle(context),
                  buildSubtitle(context),
                  _start < 30 && _start != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Please wait for $_start seconds",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.red),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        build1st(context),
                        build2nd(context),
                        build3rd(context),
                        build4th(context),
                      ],
                    ),
                  ),
                  buildResendButton(),
                  buildConfirmButton(),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("go back"),
          )
        ],
      ),
    );
  }

  Widget buildConfirmButton() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      child: RawMaterialButton(
        child: Text(
          "CONFIRM",
          style: TextStyle(
            letterSpacing: 0.6,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        fillColor: CupertinoColors.systemGrey,
        splashColor: Colors.black,
        constraints: BoxConstraints(
          minHeight: 40,
          minWidth: 200,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: first.text.isNotEmpty &&
                second.text.isNotEmpty &&
                third.text.isNotEmpty &&
                fourth.text.isNotEmpty
            ? () {
                //make the api call
              }
            : null,
      ),
    );
  }

  Widget buildResendButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FlatButton(
        onPressed: _start < 30 && _start != 0
            ? null
            : () {
                startTimer();
              },
        child: Text("Didn't get code, resend code"),
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Enter the four digit code sent to your email",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 45,
      ),
      child: Text(
        "Code Confirm",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget build4th(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(right: 15, left: 7.5),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            focusNode: fourthNode,
            controller: fourth,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autovalidate: true,
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              hintText: "*",
            ),
          ),
        ),
      ),
    );
  }

  Widget build3rd(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 9, right: 7.5),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: third,
            focusNode: thirdNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autovalidate: true,
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              hintText: "*",
            ),
          ),
        ),
      ),
    );
  }

  Widget build2nd(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 7.5, right: 9),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: second,
            focusNode: secondNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autovalidate: true,
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              hintText: "*",
            ),
          ),
        ),
      ),
    );
  }

  Widget build1st(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 7.5),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: first,
            focusNode: firstNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autovalidate: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              hintText: "*",
            ),
          ),
        ),
      ),
    );
  }

  Widget buildClipPath(BuildContext context) {
    return ClipPath(
      clipper: ShapeClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.pink,
              Colors.red,
            ],
          ),
        ),
      ),
    );
  }
}
