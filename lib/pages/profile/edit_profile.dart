import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/cubit/updateprofile_cubit.dart';
import 'package:mbunge/models/edit_user_model.dart';
import 'package:mbunge/models/login_response.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/repository/user_repository.dart';
import 'package:mbunge/util/constants.dart';

class EditProfile extends StatefulWidget {
  final LoginUser user;

  const EditProfile({Key key, this.user}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<int> genderStream;
  AnimationController animationController;
  Animation<double> nameOffset;
  Animation<double> emailOffset;
  Animation<double> countyOffset;
  Animation<double> genderOpacity;

  Animation<double> _nameOpacity;
  Animation<double> _emailOpacity;
  Animation<double> _countyOpacity;
  Animation<double> _buttonsOpacity;

  LoginUser get profile => widget.user;

  TextEditingController firstNameController;
  TextEditingController secondNameController;
  TextEditingController emailController;
  TextEditingController countyController;

  UpdateprofileCubit updateprofileCubit;

  @override
  void initState() {
    updateprofileCubit = UpdateprofileCubit(
      UserRepository(),
      SharePreferenceRepo(),
    );
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..addListener(() {
            setState(() {});
          })
          ..forward();

    nameOffset = Tween<double>(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Interval(0.2, 0.7, curve: Curves.decelerate)))
        .animate(animationController);

    emailOffset = Tween<double>(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Interval(0.3, 0.8, curve: Curves.decelerate)))
        .animate(animationController);
    countyOffset = Tween<double>(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Interval(0.4, 0.9, curve: Curves.decelerate)))
        .animate(animationController);
    genderOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Interval(0.5, 1.0, curve: Curves.decelerate)))
        .animate(animationController);

    _nameOpacity = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.1, 0.7),
    );
    _emailOpacity = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.2, 0.8),
    );
    _countyOpacity = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.3, 0.9),
    );
    _buttonsOpacity = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.4, 1.0),
    );

    genderStream = ValueNotifier(
      profile?.gender != null ? profile?.gender ?? 0 : 1,
    )..addListener(() {
        setState(() {});
      });
    firstNameController = TextEditingController(text: profile?.firstName);
    secondNameController = TextEditingController(text: profile?.lastName);
    emailController = TextEditingController(text: profile?.emailAddress);
    countyController = TextEditingController(text: profile?.county);
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
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    countyController.dispose();
    genderStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => updateprofileCubit,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Edit Profile"),
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              animationController.reverse().whenComplete(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        body: BlocListener(
          cubit: updateprofileCubit,
          listener: (context, state) {
            if (state is Updateprofilesuccess) {
              showInSnackBar(
                "Updated successfully",
                Colors.green,
              );
              Future.delayed(
                Duration(seconds: 1),
                () {
                  Navigator.of(context).pop(state.user);
                },
              );
            }
            if (state is UpdateprofileError) {
              showInSnackBar(
                state.message,
                Colors.orange,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildNameWidget(size, context),
                    buildEmailWidget(size, context),
                    buildCountyWidget(size, context),
                    buildGenderWidget(theme),
                    Opacity(
                      opacity: _buttonsOpacity.value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildDoneButton(context, genderStream.value),
                            buildCancelButton(context, genderStream.value),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGenderWidget(ThemeData theme) {
    return Opacity(
      opacity: genderOpacity.value,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Text("Gender"),
            ),
            ValueListenableBuilder(
              valueListenable: genderStream,
              builder: (BuildContext context, int value, Widget child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Chip(
                          backgroundColor: genderStream.value == 0
                              ? theme.primaryColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          label: Text(
                            "Male",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        onPressed: () {
                          genderStream.value = 0;
                        },
                      ),
                    ),
                    Flexible(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Chip(
                          backgroundColor: genderStream.value == 1
                              ? theme.primaryColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          label: Text(
                            "Female",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        onPressed: () {
                          genderStream.value = 1;
                        },
                      ),
                    ),
                    Flexible(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Chip(
                          backgroundColor: genderStream.value == 2
                              ? theme.primaryColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          label: Text(
                            "Other",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        onPressed: () {
                          genderStream.value = 2;
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCancelButton(BuildContext context, int i) {
    return MaterialButton(
      color: Colors.transparent,
      elevation: 0.0,
      disabledColor: Colors.grey,
      minWidth: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Cancel",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildDoneButton(BuildContext context, int i) {
    return MaterialButton(
      color: Colors.grey.shade700,
      disabledColor: Colors.grey,
      minWidth: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Update",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        EditUserModel editUserModel = EditUserModel(
          county: countyController.text,
          emailAddress: emailController.text,
          firstName: firstNameController.text,
          gender: genderStream.value,
          phoneNumber: profile.phoneNumber,
          lastName: secondNameController.text,
        );
        updateprofileCubit.updateProfile(
          profile.id,
          editUserModel,
        );
        // updateDetails(i);
      },
    );
  }

  Widget buildNameWidget(Size size, BuildContext context) {
    return Opacity(
      opacity: _nameOpacity.value,
      child: Transform.translate(
        offset: Offset(
          size.width * nameOffset.value,
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Text("First Name"),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: firstNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Text("Last Name"),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: secondNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailWidget(Size size, BuildContext context) {
    return Opacity(
      opacity: _emailOpacity.value,
      child: Transform.translate(
        offset: Offset(
          size.width * emailOffset.value,
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Opacity(
                opacity: 0.6,
                child: Text("Email Address"),
              ),
              SizedBox(height: 5),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountyWidget(Size size, BuildContext context) {
    return Opacity(
      opacity: _countyOpacity.value,
      child: Transform.translate(
        offset: Offset(
          size.width * countyOffset.value,
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Opacity(
                opacity: 0.6,
                child: Text("County"),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField(
                hint: Text("Select county"),
                value: countyController.text,
                items: counties.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (String value) {
                  countyController.text = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
