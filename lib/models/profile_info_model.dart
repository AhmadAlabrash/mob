import 'dart:convert';

ProfileInfoModel profileInfoModelFromJson(String str) =>
    ProfileInfoModel.fromJson(json.decode(str));

String profileInfoModelToJson(ProfileInfoModel data) =>
    json.encode(data.toJson());

class ProfileInfoModel {
  Data? data;

  ProfileInfoModel({
    this.data,
  });

  factory ProfileInfoModel.fromJson(Map json) => ProfileInfoModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  dynamic id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic country;
  dynamic countryId;
  dynamic state;
  dynamic stateId;
  dynamic city;
  dynamic cityId;
  String? experienceLevel;
  String? phone;
  String? image;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.countryId,
    this.state,
    this.stateId,
    this.city,
    this.cityId,
    this.experienceLevel,
    this.phone,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        country: json["country"],
        countryId: json["country_id"],
        state: json["state"],
        stateId: json["state_id"],
        city: json["city"],
        cityId: json["city_id"],
        experienceLevel: json["experience_level"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country": country,
        "country_id": countryId,
        "state": state,
        "state_id": stateId,
        "city": city,
        "city_id": cityId,
        "experience_level": experienceLevel,
        "phone": phone,
        "image": image,
      };
}
