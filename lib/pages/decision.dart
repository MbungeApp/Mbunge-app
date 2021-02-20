import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/authentication/authentication_bloc.dart';

class DecisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (state is UnAuthenticated) {
              Navigator.popAndPushNamed(context, "/spalsh");
            } else if (state is Authenticated) {
              Navigator.popAndPushNamed(context, "/home");
            }
          });
          return Center(child: CircularProgressIndicator(strokeWidth: 1.5,));
        },
      ),
    );
  }
}
