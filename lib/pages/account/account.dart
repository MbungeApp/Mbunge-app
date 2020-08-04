import 'package:flutter/material.dart';
import 'package:mbunge/pages/account/register_1.dart';

import 'widgets/clipper.dart';
import 'login.dart';
import 'register_2.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          buildClipPath(context),
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LoginPage(controller: pageController),
              RegisterPage1(controller: pageController),
              RegisterPage2(controller: pageController),
            ],
          )
        ],
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
