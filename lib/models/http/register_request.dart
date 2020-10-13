// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

part of '_http.dart';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  RegisterRequest({
    this.user,
    this.type,
    this.fcmToken,
  });

  User user;
  String type;
  String fcmToken;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        user: User.fromJson(json["user"]),
        type: json["type"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "type": type,
        "fcm_token": fcmToken,
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.password,
    this.phoneNumber,
    this.county,
    this.gender,
  });

  String firstName;
  String lastName;
  String emailAddress;
  String password;
  String phoneNumber;
  String county;
  int gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        county: json["county"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "password": password,
        "phone_number": phoneNumber,
        "county": county,
        "gender": gender,
      };
}
