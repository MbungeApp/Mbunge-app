import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ErrorAppWidget extends StatelessWidget {
  final String message;

  const ErrorAppWidget({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FlareActor(
            'assets/images/no-conn.flr',
            animation: 'init',
          ),
        ),
        Flexible(child: Text(message))
      ],
    );
  }
}
