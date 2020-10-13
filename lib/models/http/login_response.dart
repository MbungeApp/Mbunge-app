// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

part of '_http.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.token,
    this.user,
  });

  String token;
  LoginUser user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["Token"],
        user: LoginUser.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "Token": token,
        "User": user.toJson(),
      };
}

class LoginUser {
  LoginUser({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.password,
    this.phoneNumber,
    this.dateBirth,
    this.gender,
    this.verified,
    this.county,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String firstName;
  String lastName;
  String emailAddress;
  String password;
  String phoneNumber;
  DateTime dateBirth;
  int gender;
  bool verified;
  String county;
  DateTime createdAt;
  DateTime updatedAt;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        dateBirth: DateTime.parse(json["date_birth"]),
        gender: json["gender"],
        verified: json["verified"],
        county: json["county"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "password": password,
        "phone_number": phoneNumber,
        "date_birth": dateBirth.toIso8601String(),
        "gender": gender,
        "verified": verified,
        "county": county,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
