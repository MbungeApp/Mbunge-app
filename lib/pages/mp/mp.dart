import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbunge/pages/mp/widget/more.dart';
import 'package:mbunge/pages/mp/widget/single.dart';

class MpPage extends StatefulWidget {
  @override
  _MpPageState createState() => _MpPageState();
}

class _MpPageState extends State<MpPage> {
  double pageOffset = 0;
  PageController _pageController = PageController();
  String direction;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.page;
        direction = _listener();
      });
    });
    super.initState();
  }

  String _listener() {
    if (_pageController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      return "right";
    } else {
      return "left";
    }
  }

  @override
  Widget build(BuildContext context) {
    double currentAnim = pageOffset - pageOffset.toInt();
    return Material(
      color: CupertinoColors.lightBackgroundGray,
      child: PageView(
        controller: _pageController,
        children: <Widget>[
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(
                  top: paddingTop1(currentAnim),
                  right: currentAnim != 0 ? currentAnim * 30 : 0,
                ),
                child: child,
              );
            },
            child: ClipRRect(
              borderRadius: currentAnim != 0
                  ? BorderRadius.circular(10)
                  : BorderRadius.circular(0),
              child: SingleMpPage(
                pageController: _pageController,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(
                  top: paddingTop2(currentAnim),
                ),
                child: child,
              );
            },
            child: ClipRRect(
              borderRadius: currentAnim != 0
                  ? BorderRadius.circular(10)
                  : BorderRadius.circular(0),
              child: MoreMps(
                pageController: _pageController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double paddingTop1(double currentAnim) {
    if (currentAnim == 0) {
      return 0;
    } else {
      if (direction == "right" && currentAnim <= 0.3) {
        return currentAnim * 120;
      } else if (direction == "left" && currentAnim <= 0.5) {
        if (currentAnim > 0.3) {
          return 0.3 * 120;
        } else {
          return currentAnim * 120;
        }
      } else {
        return 0.3 * 120;
      }
    }
  }

  double paddingTop2(double currentAnim) {
    if (currentAnim == 0) {
      return 0;
    } else {
      if (direction == "right" && currentAnim <= 0.5) {
        return 0.3 * 120;
      } else {
        if ((1 - currentAnim) > 0.3) {
          return 0.3 * 120;
        } else {
          return (1 - currentAnim) * 120;
        }
      }
    }
  }
}
