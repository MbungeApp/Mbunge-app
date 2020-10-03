import 'package:flutter/material.dart';

class RegisterPage1 extends StatefulWidget {
  final PageController controller;
  RegisterPage1({@required this.controller});
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
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
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildName(),
                    buildEmail(),
                    buildPhoneNo(),
                    buildPassword(),
                    buildConfirmPassword(),
                    buildDoneButton(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          FlatButton(
            onPressed: () => widget.controller.jumpToPage(0),
            child: Text("Already have an account, Login here"),
          )
        ],
      ),
    );
  }

  Widget buildName() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                //todo
              },
              decoration: InputDecoration(
                labelText: "First Name",
                prefixIcon: Icon(
                  Icons.person,
                ),
                enabled: true,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 10, left: 5),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                //todo
              },
              decoration: InputDecoration(
                labelText: "Last Name",
                prefixIcon: Icon(
                  Icons.person,
                ),
                enabled: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          //todo
        },
        decoration: InputDecoration(
          labelText: "Email Address",
          prefixIcon: Icon(
            Icons.email,
          ),
          enabled: true,
        ),
      ),
    );
  }

  Widget buildPhoneNo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          //todo
        },
        decoration: InputDecoration(
          labelText: "Phone Number",
          prefixIcon: Icon(
            Icons.phone,
          ),
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          //todo
        },
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(
            Icons.security,
          ),
          enabled: true,
        ),
      ),
    );
  }

  Widget buildConfirmPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          //todo
        },
        decoration: InputDecoration(
          labelText: "Confirm password",
          prefixIcon: Icon(
            Icons.security,
          ),
          enabled: true,
        ),
      ),
    );
  }

  Widget buildDoneButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: MaterialButton(
        child: Text(
          "REGISTER",
          style: TextStyle(
              letterSpacing: 0.6,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () => widget.controller.jumpToPage(2),
      ),
    );
  }
}
