import 'dart:convert';

CityDropdownModel cityDropdownModelFromJson(String str) =>
    CityDropdownModel.fromJson(json.decode(str));

String cityDropdownModelToJson(CityDropdownModel data) =>
    json.encode(data.toJson());

class CityDropdownModel {
  List<City>? cities;

  CityDropdownModel({
    this.cities,
  });

  factory CityDropdownModel.fromJson(Map json) => CityDropdownModel(
        cities: json["data"] == null
            ? []
            : List<City>.from(json["data"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  dynamic id;
  String? name;
  dynamic stateId;

  City({
    this.id,
    this.name,
    this.stateId,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
