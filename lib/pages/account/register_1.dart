import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/blocs/register/register_bloc.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/user_repository.dart';
import 'package:mbunge/utils/counties.dart';

class RegisterPage1 extends StatefulWidget {
  final PageController controller;
  RegisterPage1({@required this.controller});
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  String gender = '';
  int genderValue = 0;
  String countyValue = "select your county";
  RegisterRequest registerRequest = RegisterRequest();
  User user = User();
  final _formKey = GlobalKey<FormState>();
  RegisterBloc registerBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dateController = TextEditingController();

  _handleRadioButton(int i) {
    if (i == 0) {
      setState(() {
        genderValue = i;
        gender = 'male';
      });
    } else if (i == 1) {
      setState(() {
        genderValue = i;
        gender = 'female';
      });
    }
    print(gender);
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
  void dispose() {
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: BlocProvider(
        create: (context) {
          registerBloc = RegisterBloc(UserRepository());
          return registerBloc;
        },
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterInitial) {
              showInSnackBar("Loading", Colors.grey);
            }
            if (state is RegisterSuccess) {
              showInSnackBar("Registered successully", Colors.green);
              _formKey.currentState.reset();
              Timer(Duration(seconds: 5), () {
                widget.controller.jumpToPage(0);
              });
            }
            if (state is RegisterError) {
              showInSnackBar("Error", Colors.orange);
            }
          },
          child: Padding(
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
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildName(),
                          buildEmail(),
                          buildPhoneNo(),
                          buildPassword(),
                          buildDOBTextfield(),
                          buildCountyDropDown(),
                          buildGenderRadio(),
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
          ),
        ),
      ),
    );
  }

  Widget buildCountyDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField(
          hint: Text("Select county"),
          items: counties.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
          onChanged: (String value) {
            setState(() {
              countyValue = value;
            });
          },
          onSaved: (value) {
            user.county = value;
          },
        ),
      ),
    );
  }

  Widget buildGenderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: RadioListTile(
            title: Text("Male"),
            value: 0,
            groupValue: genderValue,
            onChanged: _handleRadioButton,
          ),
        ),
        Flexible(
          child: RadioListTile(
            title: Text("Female"),
            value: 1,
            groupValue: genderValue,
            onChanged: _handleRadioButton,
          ),
        )
      ],
    );
  }

  Widget buildName() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (value) {
                user.firstName = value;
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
            child: TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (value) {
                user.lastName = value;
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

  Widget buildDOBTextfield() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: dateController,
        keyboardType: TextInputType.datetime,
        // onSaved: (value) {
        // user.dateBirth = DateTime.parse(value);
        // },
        onTap: () => getDate(),
        decoration: InputDecoration(
          hintText: "Date of Birth",
          prefixIcon: Icon(
            Icons.calendar_today,
          ),
          enabled: true,
        ),
      ),
    );
  }

  getDate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    dateController.text = date.toUtc().toString();
  }

  Widget buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          user.emailAddress = value;
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
      child: TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (value) {
          user.phoneNumber = value;
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
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          user.password = value;
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RawMaterialButton(
        child: Text(
          "REGISTER",
          style: TextStyle(
              letterSpacing: 0.6,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        fillColor: Colors.grey,
        splashColor: Colors.black,
        constraints: BoxConstraints(minHeight: 40, minWidth: 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            user.gender = genderValue;
            registerRequest.user = user;
            registerRequest.type = "mobile";
            registerRequest.fcmToken = "";

            registerBloc.add(RegisterUserEvent(registerRequest));
          }
        },
      ),
    );
  }
}
