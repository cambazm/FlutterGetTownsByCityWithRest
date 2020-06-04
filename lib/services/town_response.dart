import 'dart:convert';

class TownResponse {
  final bool status;
  final List<Town> data;

  TownResponse({this.status, this.data});

  factory TownResponse.fromRawJson(String str) =>
      TownResponse.fromJson(json.decode(str));

  factory TownResponse.fromJson(Map<String, dynamic> json) => TownResponse(
      status: json['status'],
      data: List<Town>.from(
          json["data"].map((x) => Town.fromJson(x))));
}

class Town {
  final String name;
  final String id;
  final String city;

  Town({this.name, this.id, this.city});

  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(
      name: json['name'] as String,
      id: json['_id'] as String,
      city: json['city'] as String,
    );
  }
}
