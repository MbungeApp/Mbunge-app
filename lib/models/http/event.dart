// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

part of '_http.dart';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    Event({
        this.id,
        this.name,
        this.body,
        this.picture,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String name;
    String body;
    String picture;
    DateTime createdAt;
    DateTime updatedAt;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        body: json["body"],
        picture: json["picture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "body": body,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
