// To parse this JSON data, do
//
//     final webinarModel = webinarModelFromJson(jsonString);

import 'dart:convert';

List<WebinarModel> webinarModelFromJson(String str) => List<WebinarModel>.from(json.decode(str).map((x) => WebinarModel.fromJson(x)));

String webinarModelToJson(List<WebinarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WebinarModel {
    WebinarModel({
        this.id,
        this.agenda,
        this.hostedBy,
        this.description,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.scheduleAt,
        this.postponed,
    });

    String id;
    String agenda;
    String hostedBy;
    String description;
    int duration;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime scheduleAt;
    bool postponed;

    factory WebinarModel.fromJson(Map<String, dynamic> json) => WebinarModel(
        id: json["id"],
        agenda: json["agenda"],
        hostedBy: json["hosted_by"],
        description: json["description"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        scheduleAt: DateTime.parse(json["schedule_at"]),
        postponed: json["postponed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "agenda": agenda,
        "hosted_by": hostedBy,
        "description": description,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "schedule_at": scheduleAt.toIso8601String(),
        "postponed": postponed,
    };
}
