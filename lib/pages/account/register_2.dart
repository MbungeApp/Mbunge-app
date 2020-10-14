import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbunge/utils/counties.dart';

class RegisterPage2 extends StatefulWidget {
  final PageController controller;
  RegisterPage2({@required this.controller});

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  String gender = '';
  int genderValue = 0;
  File _image;
  String countyValue = "select your county";
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
                  buildTitle(context),
                  buildUploadPic(context),
                  buildSubtitle(context),
                  buildDOBTextfield(),
                  buildCountyDropDown(),
                  buildGenderRadio(),
                  buildDoneButton(),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          FlatButton(
            onPressed: () => widget.controller.jumpToPage(1),
            child: Text("go back"),
          )
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
      ),
      child: Text(
        "Almost there..",
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return Text(
      "profile picture is optional",
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget buildUploadPic(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: _image == null
                  ? AssetImage("assets/images/no-pic.png")
                  : FileImage(_image),
              radius: 50,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
                onPressed: () => showImageDialog(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDOBTextfield() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: dateController,
        keyboardType: TextInputType.datetime,
        onChanged: (value) {
          //TODO
        },
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

  Widget buildCountyDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField(
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
          )
          // child: DropdownButton<String>(
          //   isExpanded: true,
          //   // iconEnabledColor: Col,
          //   hint: Text("County"),
          //   value: countyValue,
          //   onChanged: (String value) {
          //     setState(() {
          //       countyValue = value;
          //     });
          //   },
          //   items: counties.map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(
          //         value,
          //       ),
          //     );
          //   }).toList(),
          // ),
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

  Widget buildDoneButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        splashColor: Colors.black,
        color: Theme.of(context).primaryColorDark,
        child: Text(
          "Done",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
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
      // builder: (BuildContext context, Widget child) {
      //   return Theme(
      //     data: ThemeData.light(),
      //     child: child,
      //   );
      // },
    );
    // TODO format date
    dateController.text = date.toUtc().toString();
  }

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose one option"),
          actions: <Widget>[
            FlatButton(
              child: Text("Gallery"),
              onPressed: () async {
                File profilePic = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                setState(() {
                  _image = profilePic;
                });
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Camera"),
              onPressed: () async {
                File profilePic = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                setState(() {
                  _image = profilePic;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
