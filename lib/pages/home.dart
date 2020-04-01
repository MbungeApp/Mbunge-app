import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/blocs/authentication/authentication_bloc.dart';

class Decide extends StatefulWidget {
  @override
  DecideState createState() => DecideState();
}

class DecideState extends State<Decide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.popAndPushNamed(context, "/splash");
          } else if (state is Authenticated) {
            Navigator.popAndPushNamed(context, "/home");
          }
        },
        child: Center(child: Image.asset("assets/images/logo.png")),
      ),
    );
  }
}
