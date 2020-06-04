import 'dart:convert';

class CityResponse {
  final bool status;
  final List<City> data;

  CityResponse({this.status, this.data});

  factory CityResponse.fromRawJson(String str) =>
      CityResponse.fromJson(json.decode(str));

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
      status: json['status'],
      data: List<City>.from(
          json["data"].map((x) => City.fromJson(x))));
}

class City {
  final String name;
  final String id;

  City({this.name, this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      id: json['_id'] as String,
    );
  }
}
