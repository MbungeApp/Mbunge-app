// To parse this JSON data, do
//
//     final participation = participationFromJson(jsonString);

part of "_http.dart";

List<Participation> participationFromJson(String str) =>
    List<Participation>.from(
        json.decode(str).map((x) => Participation.fromJson(x)));


class Participation {
  Participation({
    this.id,
    this.name,
    this.sector,
    this.body,
    this.postedBy,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String sector;
  String body;
  String postedBy;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
        id: json["id"],
        name: json["name"],
        sector: json["sector"],
        body: json["body"],
        postedBy: json["posted_by"],
        expireAt: DateTime.parse(json["expire_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sector": sector,
        "body": body,
        "posted_by": postedBy,
        "expire_at": expireAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
