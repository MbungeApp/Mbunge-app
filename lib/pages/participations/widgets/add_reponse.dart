import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/responses/addresponse_bloc.dart';
import 'package:mbunge/cubit/responses/getresponses_bloc.dart';
import 'package:mbunge/repository/webinar_repository.dart';

class AddReponse extends StatefulWidget {
  final String particiId;
  final GetresponsesBloc getresponsesBloc;

  const AddReponse({Key key, this.particiId,@required this.getresponsesBloc})
      : super(key: key);
  @override
  _AddReponse createState() => _AddReponse();
}

class _AddReponse extends State<AddReponse> {
  AddresponseBloc _addresponseBloc;
  ValueNotifier<String> body = ValueNotifier("");
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    body.addListener(() {
      setState(() {});
    });
    _addresponseBloc = AddresponseBloc(WebinarRepository());
    super.initState();
  }

  @override
  void dispose() {
    body.dispose();
    _addresponseBloc.close();
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
      body: BlocProvider(
        create: (context) => _addresponseBloc,
        child: BlocListener<AddresponseBloc, AddresponseState>(
          cubit: _addresponseBloc,
          listener: (context, state) {
            if (state is AddingInProgress) {
              showInSnackBar(
                'Submitting your response',
                Colors.black54,
              );
            }
            if (state is AddresponseSuccessfully) {
              showInSnackBar(
                ' Added Successfully',
                Colors.greenAccent,
              );
              _formKey.currentState.reset();
              
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pop(context, state.responses);
              });
            }
            if (state is AddresponseError) {
              showInSnackBar(
                'An error occured',
                Colors.orange,
              );
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
                      child:
                          Text("Submit a question to the guest on the agenda"),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add"),
        onPressed: () {
          FocusScope.of(context).unfocus();
          _formKey.currentState.save();
          if (_formKey.currentState.validate()) {
            _addresponseBloc.add(
              AddYourOpinion(
                body.value,
                widget.particiId,
              ),
            );
          }
        },
      ),
    );
  }
}
