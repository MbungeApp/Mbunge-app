import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef bool GetPageControllerValueCallback();

class SplashPage extends StatefulWidget {
  final int index;
  final String imagePath;
  final Color bgColor;
  final String title;
  final String body;
  final bool isWhite;
  final GetPageControllerValueCallback getPageControllerValueCallback;

  SplashPage({
    @required this.index,
    @required this.imagePath,
    @required this.bgColor,
    @required this.title,
    @required this.body,
    @required this.isWhite,
    @required this.getPageControllerValueCallback,
  });

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> opacityAnimation;
  Animation<double> slide;
  // Small docs
  // right to left -> true //incrementing
  // left to right -> false //decrementing
  bool get left2right => widget.getPageControllerValueCallback();

  @override
  void initState() {
    print(left2right);
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          })
          ..forward();
    opacityAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 1.0),
    );
    slide = Tween<double>(begin: left2right ? 100 : -100, end: 0)
        .chain(CurveTween(curve: Interval(0.0, 1.0, curve: Curves.ease)))
        .animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.23,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.index == 0
                ? Opacity(
                    opacity: opacityAnimation.value,
                    child: Image.asset(widget.imagePath),
                  )
                : widget.index == 2
                    ? Transform.scale(
                        scale: animationController.value * math.pi * 0.35,
                        child: Image.asset(widget.imagePath),
                      )
                    : widget.index == 3
                        ? Transform.rotate(
                            angle: animationController.value * math.pi * 2,
                            child: Image.asset(widget.imagePath),
                          )
                        : Transform.translate(
                            offset: Offset(slide.value, 0),
                            child: Image.asset(widget.imagePath),
                          ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 20,
              ),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.body,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
