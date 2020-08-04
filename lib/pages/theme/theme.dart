import 'package:flutter/material.dart';
import 'package:mbunge/blocs/theme/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChoose extends StatefulWidget {
  final Function function;
  ThemeChoose({this.function});
  @override
  _ThemeChooseState createState() => _ThemeChooseState();
}

class _ThemeChooseState extends State<ThemeChoose>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1;
  Color color;
  Color newColor;

  @override
  void initState() {
    super.initState();
    getDefaults();
    _controller = (AnimationController(
        vsync: this, duration: Duration(milliseconds: 800)))
      ..addListener(() => setState(() {}));
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn)),
    );
  }

  void getDefaults() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int defaultTheme = preferences.getInt('apptheme') ?? 0;
    setState(() {
      color = appThemeData[getDecide(defaultTheme)].primaryColor;
    });
  }

  final List colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: color,
          ),

          _controller.isAnimating
              ? Transform.scale(
                  scale: _animation1.value * 3,
                  child: Container(
                    height: deviceSize.height,
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                      color: newColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : Container(),

          ListView.builder(
            itemCount: AppTheme.values.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              final itemAppTheme = AppTheme.values[i];

              return InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: itemAppTheme == AppTheme.DarkTheme
                          ? Colors.black
                          : appThemeData[itemAppTheme].primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    height: 70,
                    width: 70,
                  ),
                ),
                onTap: () {
                  setState(() {
                    newColor = appThemeData[itemAppTheme].primaryColor;
                  });
                  _controller.forward().whenComplete(() {
                    setState(() {
                      color = appThemeData[itemAppTheme].primaryColor;
                    });
                    // BlocProvider.of<ThemeBloc>(context)
                    //     .add(ThemeChanged(theme: itemAppTheme));
                    _controller.reset();
                  });
                },
              );
            },
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: InkWell(
          //     child: Container(
          //       margin: EdgeInsets.all(15.0),
          //       decoration: BoxDecoration(
          //         border: Border.all(),
          //         shape: BoxShape.circle,
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Text("Ok"),
          //       ),
          //     ),
          //     onTap: () async {
          //       return widget.function();
          //     },
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Text("ok"),
        onPressed: () async {
          return widget.function();
        },
      ),
    );
  }

  getDecide(int i) {
    AppTheme x;
    switch (i) {
      case 0:
        x = AppTheme.Green;
        break;
      case 1:
        x = AppTheme.Blue;
        break;
      case 2:
        x = AppTheme.Red;
        break;
      case 3:
        x = AppTheme.Pink;
        break;
      case 4:
        x = AppTheme.Purple;
        break;
      case 5:
        x = AppTheme.Orange;
        break;
      case 6:
        x = AppTheme.DarkTheme;
        break;
    }
    return x;
  }
}
