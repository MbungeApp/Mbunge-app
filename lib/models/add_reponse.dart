// To parse this JSON data, do
//
//     final addResponse = addResponseFromJson(jsonString);

import 'dart:convert';

AddResponse addResponseFromJson(String str) => AddResponse.fromJson(json.decode(str));

String addResponseToJson(AddResponse data) => json.encode(data.toJson());

class AddResponse {
    AddResponse({
        this.userId,
        this.userName,
        this.participationId,
        this.body,
    });

    String userId;
    String userName;
    String participationId;
    String body;

    factory AddResponse.fromJson(Map<String, dynamic> json) => AddResponse(
        userId: json["user_id"],
        userName: json["user_name"],
        participationId: json["participation_id"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "participation_id": participationId,
        "body": body,
    };
}