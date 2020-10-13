// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

part of '_http.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.code,
    this.user,
  });

  int code;
  RegisterUser user;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        code: json["Code"],
        user: RegisterUser.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "User": user.toJson(),
      };
}

class RegisterUser {
  RegisterUser({
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

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
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
