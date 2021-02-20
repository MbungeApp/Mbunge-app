import 'package:flutter/material.dart';
import 'package:mbunge/pages/splashscreen/splash_item.dart';
import 'package:mbunge/widgets/shimmer.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  PageController _pageController;
  int currentIndex = 0;
  List<SplashPage> _pages = [
    SplashPage(
      "assets/images/1.png",
      "Public Participation",
      "Participate in parliament public participations\nfrom anywhere",
    ),
    SplashPage(
      "assets/images/2.png",
      "Meet your Waheshimiwa",
      "Learn more about your Mheshimiwas right here\nthrough online webinars",
    ),
    SplashPage(
      "assets/images/3.png",
      "Welcome to Mbunge App",
      "The best way to participate in thegrowth of this country.\nClick the welcome button to get started.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          currentIndex = _pageController.page.toInt();
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildPageView(),
          buildContent(size, theme),
          buildPageviewIndicators()
        ],
      ),
    );
  }

  Widget buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return Image.asset(
          _pages[index].imagePath,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget buildContent(Size size, ThemeData theme) {
    return AnimatedSwitcher(
      key: ValueKey(currentIndex),
      duration: Duration(milliseconds: 500),
      child: Align(
        alignment: currentIndex == 1
            ? Alignment.topLeft
            : currentIndex == 2
                ? Alignment.centerLeft
                : Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(
            top: currentIndex == 1 ? size.height * 0.2 : 0,
            bottom: currentIndex == 1
                ? 0
                : currentIndex == 2
                    ? 0
                    : size.height * 0.2,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _pages[currentIndex].title,
                style: theme.textTheme.headline4.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Text(
                _pages[currentIndex].body,
                style: TextStyle(
                  color: Colors.white60,
                ),
                textAlign:TextAlign.start,
              ),
              currentIndex == 2
                  ? OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white70,
                      ),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/account");
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageviewIndicators() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          bottom: 30.0,
        ),
        child: Row(
          children: [
            Flexible(
              child: Row(
                children: _pages.map((page) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: _pages.indexOf(page) == currentIndex
                            ? Colors.transparent
                            : Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0, 
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Spacer(),
            Flexible(
              child: Shimmer.fromColors(
                highlightColor: Colors.black12,
                baseColor: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
