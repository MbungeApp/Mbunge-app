import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/blocs/authentication/authentication_bloc.dart';
import 'package:mbunge/blocs/login/login_bloc.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/user_repository.dart';
import 'package:mbunge/repository/share_preferences.dart';

class LoginPage extends StatefulWidget {
  final PageController controller;
  LoginPage({@required this.controller});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginRequest loginRequest = LoginRequest();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool passwordVisible = true;
  LoginBloc loginBloc;

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  void showInSnackBar(String value, Color bgColor) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        loginBloc = LoginBloc(UserRepository(), SharePreferenceRepo());
        return loginBloc;
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginInitial) {
            showInSnackBar("Loading", Colors.grey);
          }
          if (state is LoginSuccess) {
            showInSnackBar(
                "Success, Hello ${state.user.firstName}", Colors.green);
            _formKey.currentState.reset();
            Timer(Duration(seconds: 4), () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoggedIn(user: state.user));
              Navigator.popAndPushNamed(context, "/home");
            });
          }
          if (state is LoginError) {
            showInSnackBar("Error", Colors.orange);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
              15,
              MediaQuery.of(context).size.height * 0.1,
              15,
              0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 10.0,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildEmailInput(),
                        buildPasswordInput(),
                        buildForgetPassword(),
                        buildLoginButton(),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                FlatButton(
                  onPressed: () => widget.controller.jumpToPage(1),
                  child: Text("Don't have an account, Register here"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: "Phone number",
          prefixIcon: Icon(Icons.phone),
        ),
        onSaved: (value) {
          loginRequest.phone = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your phone number';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: TextFormField(
        obscureText: passwordVisible,
        autocorrect: false,
        onSaved: (value) {
          loginRequest.password = value;
        },
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.security),
          suffixIcon: IconButton(
            icon: passwordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildForgetPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () => Navigator.popAndPushNamed(context, "/verify"),
        child: Text("forgot password ? Recover here"),
      ),
    );
  }

  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RawMaterialButton(
        child: Text(
          "LOGIN",
          style: TextStyle(
            letterSpacing: 0.6,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        fillColor: Colors.grey,
        splashColor: Colors.black,
        constraints: BoxConstraints(minHeight: 40, minWidth: 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () {
          // Navigator.pushNamed(context, "/home");
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            loginBloc.add(SignInWithPhone(loginRequest));
          }
        },
      ),
    );
  }
}
