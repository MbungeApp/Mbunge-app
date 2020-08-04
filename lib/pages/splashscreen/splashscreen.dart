import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbunge/pages/splashscreen/page.dart';

import 'accept_terms.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController pageController = PageController();
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          buildPageView(),
          buildPageViewIndicator(),
        ],
      ),
    );
  }

  Widget buildPageViewIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              buildIndicator(),
              buildNextButton(),
            ],
          ),
          buildSkipButton()
        ],
      ),
    );
  }

  Widget buildNextButton() {
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.right_chevron,
        size: 40,
        color: pageOffset == 2 ? Colors.black : Colors.white,
      ),
      onPressed: () => pageController.page.toInt() < 3
          ? pageController.jumpToPage(pageController.page.toInt() + 1)
          : showAlertDialog(context),
    );
  }

  Widget buildSkipButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        borderSide: BorderSide(
          color: pageOffset == 2 ? Colors.black87 : Colors.white70,
        ),
        child: Text(
          "skip",
          style: TextStyle(
            color: pageOffset == 2 ? Colors.black : Colors.white,
          ),
        ),
        onPressed: () => showAlertDialog(context),
      ),
    );
  }

  Widget buildIndicator() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: SizedBox(
          width: double.infinity,
          height: 30,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: pageOffset == index
                        ? Colors.transparent
                        : pageOffset.toInt() == 2
                            ? Colors.black87
                            : Colors.white,
                    border: pageOffset == index
                        ? Border.all(
                            color: index == 2 ? Colors.black87 : Colors.white,
                            width: 2,
                          )
                        : Border(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildPageView() {
    Size size = MediaQuery.of(context).size;
    double percentageStart, percentageEnd;

    return GestureDetector(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              SplashPage(
                imagePath: "assets/illustrate/04.png",
                // bgImagePath: "assets/images/4.jpg",
                bgColor: Colors.black.withOpacity(0.9),
                isWhite: false,
                getPageControllerValueCallback: () {
                  if (percentageStart == null || percentageEnd == null) {
                    return false;
                  } else {
                    return percentageStart > percentageEnd ? true : false;
                  }
                },
                body:
                    "Public Participation\n\nParticipate in parliament public participation from anywhere",
              ),
              SplashPage(
                imagePath: "assets/illustrate/01.png",
                // bgImagePath: "assets/images/3.jpg",
                bgColor: Colors.red,
                isWhite: false,
                getPageControllerValueCallback: () {
                  if (percentageStart == null || percentageEnd == null) {
                    return false;
                  } else {
                    return percentageStart > percentageEnd ? true : false;
                  }
                },
                body:
                    "Parliament Proceedings\n\nMbunge app lets you be in check with " +
                        "parliament proceedings.",
              ),
              SplashPage(
                imagePath: "assets/illustrate/02.png",
                // bgImagePath: "assets/images/1.jpg",
                bgColor: Colors.white.withOpacity(0.75),
                isWhite: true,
                getPageControllerValueCallback: () {
                  if (percentageStart == null || percentageEnd == null) {
                    return false;
                  } else {
                    return percentageStart > percentageEnd ? true : false;
                  }
                },
                body:
                    "Meet your waheshimiwa\n\nLearn more about your Mheshimiwas every " +
                        "week on mbunge, Register and get started.",
              ),
              SplashPage(
                imagePath: "assets/illustrate/05.png",
                // bgImagePath: "assets/images/4.jpg",
                bgColor: Colors.green,
                getPageControllerValueCallback: () {
                  if (percentageStart == null || percentageEnd == null) {
                    return false;
                  } else {
                    return percentageStart > percentageEnd ? true : false;
                  }
                },
                isWhite: false,
                body: "MbungeApp\n\nThe best way to participate in the " +
                    "growth of this country. Let's get started.",
              ),
            ],
          ),
          buildGradient(),
        ],
      ),

      // Drag start events
      // Return a point of start
      onHorizontalDragStart: (DragStartDetails dragStartDetails) {
        double startX = dragStartDetails.localPosition.dx;
        double deviceWidth = size.width;
        double whatPercentFromZero = (startX / deviceWidth) * 100;
        percentageStart = whatPercentFromZero;
        // print(
        //   // "Start Local: $startX\n Device width: $deviceWidth\n
        //   " Percentage start: $whatPercentFromZero",
        // );
      },
      // Details update as it goes on
      onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        double endX = dragUpdateDetails.localPosition.dx;
        double deviceWidth = size.width;
        double whatPercentWhileDone = (endX / deviceWidth) * 100;
        percentageEnd = whatPercentWhileDone;
        // print(
        //   "Percentage done: $whatPercentWhileDone\n",
        // );
      },
      onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
        if (percentageStart == null) {
          // do nothing
        } else if (percentageEnd == null) {
          // do nothing
        } else if (percentageStart > percentageEnd) {
          // print("Left to Right: ${percentageStart - percentageEnd}");

          //increment
          if ((percentageStart - percentageEnd) > 20) {
            if (pageController.page.toInt() < 3) {
              pageController.jumpToPage(pageController.page.toInt() + 1);
            }
          }
        } else if (percentageStart < percentageEnd) {
          // print("Right to Left: ${percentageEnd - percentageStart}");

          // decrement
          if ((percentageEnd - percentageStart) > 20) {
            if (pageController.page.toInt() != 0) {
              pageController.jumpToPage(pageController.page.toInt() - 1);
            }
          }
        }
      },
      onHorizontalDragCancel: () {
        print("end");
      },
    );
  }

  Widget buildGradient() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              pageOffset.toInt() == 0
                  ? Colors.black.withOpacity(0.9)
                  : pageOffset.toInt() == 1
                      ? Colors.red.withOpacity(0.9)
                      : pageOffset.toInt() == 2
                          ? Colors.transparent
                          : pageOffset.toInt() == 3
                              ? Colors.green.withOpacity(0.9)
                              : Colors.black,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
