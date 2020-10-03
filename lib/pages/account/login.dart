import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final PageController controller;
  LoginPage({@required this.controller});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        keyboardType: TextInputType.emailAddress,
        autovalidate: true,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: "Email address",
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  Widget buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: TextFormField(
        obscureText: passwordVisible,
        autovalidate: true,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.security),
          suffixIcon: IconButton(
            icon: passwordVisible
                ? Icon(Icons.visibility_off)
                :  Icon(Icons.visibility),
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
        onPressed: () => Navigator.pushNamed(context, "/verify"),
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
              fontWeight: FontWeight.bold),
        ),
        fillColor: Colors.grey,
        splashColor: Colors.black,
        constraints: BoxConstraints(minHeight: 40, minWidth: 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () => Navigator.pushNamed(context, "/home"),
      ),
    );
  }
}
