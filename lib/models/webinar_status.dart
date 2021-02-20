// To parse this JSON data, do
//
//     final webinarStatus = webinarStatusFromJson(jsonString);

import 'dart:convert';

WebinarStatus webinarStatusFromJson(String str) =>
    WebinarStatus.fromJson(json.decode(str));

String webinarStatusToJson(WebinarStatus data) => json.encode(data.toJson());

class WebinarStatus {
  WebinarStatus({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory WebinarStatus.fromJson(Map<String, dynamic> json) => WebinarStatus(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.channelExist,
    this.mode,
    this.broadcasters,
    this.audience,
    this.audienceTotal,
  });

  bool channelExist;
  int mode;
  List<int> broadcasters;
  List<dynamic> audience;
  int audienceTotal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        channelExist: json["channel_exist"],
        mode: json["mode"],
        broadcasters: json["broadcasters"] != null
            ? List<int>.from(json["broadcasters"].map((x) => x))
            : [],
        audience: json["audience"] != null
            ? List<dynamic>.from(json["audience"].map((x) => x))
            : [],
        audienceTotal: json["audience_total"],
      );

  Map<String, dynamic> toJson() => {
        "channel_exist": channelExist,
        "mode": mode,
        "broadcasters": List<dynamic>.from(broadcasters.map((x) => x)),
        "audience": List<dynamic>.from(audience.map((x) => x)),
        "audience_total": audienceTotal,
      };
}
