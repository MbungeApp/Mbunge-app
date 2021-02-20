// To parse this JSON data, do
//
//     final responses = responsesFromJson(jsonString);

import 'dart:convert';

List<Responses> responsesFromJson(String str) => List<Responses>.from(json.decode(str).map((x) => Responses.fromJson(x)));
Responses responseOneFromJson(String str) => Responses.fromJson(json.decode(str));

String responsesToJson(List<Responses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Responses {
    Responses({
        this.id,
        this.userId,
        this.participationId,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    String id;
    String userId;
    String participationId;
    String body;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    factory Responses.fromJson(Map<String, dynamic> json) => Responses(
        id: json["id"],
        userId: json["user_id"],
        participationId: json["participation_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "participation_id": participationId,
        "body": body,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.emailAddress,
    });

    String id;
    String firstName;
    String lastName;
    String emailAddress;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
    };
}