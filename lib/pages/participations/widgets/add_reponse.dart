import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/cubit/questioncubit_cubit.dart';

class AddReponse extends StatefulWidget {
  final String particiId;
  final QuestioncubitCubit questioncubitCubit;

  const AddReponse({Key key, this.particiId, @required this.questioncubitCubit})
      : super(key: key);
  @override
  _AddReponse createState() => _AddReponse();
}

class _AddReponse extends State<AddReponse> {
  ValueNotifier<String> body = ValueNotifier("");
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    body.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    body.dispose();
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Add Question",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener(
        cubit: widget.questioncubitCubit,
        listener: (context, state) {
          if (state is QuestioncubitSuccess) {
            if (state.message != "") {
              showInSnackBar(
                state.message,
                Colors.orange,
              );
              if (state.message.contains("succes")) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: kToolbarHeight / 3,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Opacity(
                    opacity: 0.7,
                    child: Text("Submit a question to the guest on the agenda"),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    minLines: 4,
                    onSaved: (value) {
                      body.value = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        // borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add"),
        onPressed: () {
          FocusScope.of(context).unfocus();
          showInSnackBar(
            "Adding your question",
            Colors.orange,
          );
          _formKey.currentState.save();
          if (_formKey.currentState.validate()) {
            widget.questioncubitCubit.addQuestion(
              id: widget.particiId,
              body: body.value,
            );
          }
        },
      ),
    );
  }
}
