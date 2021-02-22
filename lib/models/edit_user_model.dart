// To parse this JSON data, do
//
//     final editUserModel = editUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditUserModel editUserModelFromJson(String str) =>
    EditUserModel.fromJson(json.decode(str));

String editUserModelToJson(EditUserModel data) => json.encode(data.toJson());

class EditUserModel {
  EditUserModel({
    @required this.firstName,
    @required this.lastName,
    @required this.emailAddress,
    @required this.county,
    @required this.phoneNumber,
    @required this.gender,
  });

  final String firstName;
  final String lastName;
  final String emailAddress;
  final String county;
  final String phoneNumber;
  final int gender;

  factory EditUserModel.fromJson(Map<String, dynamic> json) => EditUserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        county: json["county"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "county": county,
        "phone_number": phoneNumber,
        "gender": gender,
      };
}
