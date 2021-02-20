import 'dart:convert';

List<MPs> mPsFromJson(String str) =>
    List<MPs>.from(json.decode(str).map((x) => MPs.fromJson(x)));

String mPsToJson(List<MPs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MPs {
  MPs({
    this.id,
    this.name,
    this.image,
    this.constituency,
    this.county,
    this.martialStatus,
    this.dateBirth,
    this.bio,
    this.images,
  });

  String id;
  String name;
  String image;
  String constituency;
  String county;
  String martialStatus;
  DateTime dateBirth;
  String bio;
  dynamic images;

  factory MPs.fromJson(Map<String, dynamic> json) => MPs(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        constituency: json["constituency"],
        county: json["county"],
        martialStatus: json["martial_status"],
        dateBirth: DateTime.parse(json["date_birth"]),
        bio: json["bio"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "constituency": constituency,
        "county": county,
        "martial_status": martialStatus,
        "date_birth": dateBirth.toIso8601String(),
        "bio": bio,
        "images": images,
      };
}
