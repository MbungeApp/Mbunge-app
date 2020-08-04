import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final String imagePath;
  // final String bgImagePath;
  final Color bgColor;
  final String body;
  final bool isWhite;
  final Function() getPageControllerValueCallback;

  SplashPage(
      {@required this.imagePath,
      // this.bgImagePath,
      @required this.bgColor,
      @required this.body,
      @required this.isWhite,
      @required this.getPageControllerValueCallback});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> opacityAnimation;
  Animation<double> slide;
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
      curve: Interval(0.1, 1.0),
    );
    slide = Tween<double>(
      begin: left2right ? 80 : -80,
      end: 0,
    )
        .chain(CurveTween(curve: Interval(0.3, 1.0, curve: Curves.ease)))
        .animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: widget.bgColor
          // image: DecorationImage(
          //   image: AssetImage(widget.bgImagePath),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //     widget.bgColor,
          //     BlendMode.hardLight,
          //   ),
          // ),
          ),
      child: Opacity(
        opacity: opacityAnimation.value,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.23,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(widget.imagePath),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.body,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black,
                        // color: widget.isWhite ? Colors.black : Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
