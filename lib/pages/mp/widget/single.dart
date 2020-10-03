import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleMpPage extends StatefulWidget {
  final PageController pageController;
  SingleMpPage({this.pageController});
  @override
  _MPPageState createState() => _MPPageState();
}

class _MPPageState extends State<SingleMpPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> heightFactorAnimation;
  bool animationDone = false;
  bool expanded = false;
  double start;
  double end;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    heightFactorAnimation = Tween<double>(begin: 0.85, end: 0.4)
        .chain(
          CurveTween(curve: Interval(0.1, 1.0, curve: Curves.linear)),
        )
        .animate(animationController);
    animationController.addStatusListener((current) {
      if (current == AnimationStatus.completed) {
        animationDone = true;
        setState(() {
          expanded = !expanded;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // on-tap
  onBottomTap() {
    setState(() {
      if (animationDone) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      animationDone = !animationDone;
    });
  }

  onBottomDragStart(dragStartDetails) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double startPosition = dragStartDetails.globalPosition.dy;
    double percentageStart =
        (((startPosition - deviceHeight) / deviceHeight) * 100) * -1;
    setState(() {
      start = percentageStart;
    });
  }

  onBottomDragUpdate(dragUpdateDetails) {
    double endPosition = dragUpdateDetails.globalPosition.dy;
    double deviceHeight = MediaQuery.of(context).size.height;
    double percentageEnd =
        (((endPosition - deviceHeight) / deviceHeight) * 100) * -1;
    setState(() {
      end = percentageEnd;
    });
  }

  onBottomDragEnd(dragEndDetails) {
    if (end > start) {
      if ((end - start) > 10) {
        animationController.forward();
      }
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: heightFactorAnimation.value,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _buildImage(),
                    // User details
                    Positioned(
                      bottom: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: _buildUserDetails(),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 1.05 - heightFactorAnimation.value,
                  child: GestureDetector(
                    onTap: () => onBottomTap(),
                    onVerticalDragStart: (dragStartDetails) =>
                        onBottomDragStart(dragStartDetails),
                    onVerticalDragUpdate: (dragUpdateDetails) =>
                        onBottomDragUpdate(dragUpdateDetails),
                    onVerticalDragEnd: (dragEndDetails) =>
                        onBottomDragEnd(dragEndDetails),
                    child: _buildPageDetails(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/illustrate/04.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  CupertinoColors.systemOrange,
                  Colors.transparent,
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.32,
          ),
        )
      ],
    );
  }

  Widget _buildUserDetails() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "12",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  "photos",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "20",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  "age (years)",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "John Mayer",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Kijabe",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("more")),
                    onPressed: () {
                      widget.pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                      //TODO
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: expanded
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Text(
                    "Nostrud amet proident adipisicing sint magna sit Est cillum velit anim culpa nostrud ut velit officia commodo." *
                        10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                  child: Text(
                    "Photos",
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              "assets/illustrate/0${i + 1}.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
