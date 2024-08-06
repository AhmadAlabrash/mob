// To parse this JSON data, do
//
//     final skillDropdownModel = skillDropdownModelFromJson(jsonString);

import 'dart:convert';

SkillDropdownModel skillDropdownModelFromJson(String str) =>
    SkillDropdownModel.fromJson(json.decode(str));

String skillDropdownModelToJson(SkillDropdownModel data) =>
    json.encode(data.toJson());

class SkillDropdownModel {
  AllSkills? allSkills;

  SkillDropdownModel({
    this.allSkills,
  });

  factory SkillDropdownModel.fromJson(json) => SkillDropdownModel(
        allSkills: json["allSkills"] == null
            ? null
            : AllSkills.fromJson(json["allSkills"]),
      );

  Map<String, dynamic> toJson() => {
        "allSkills": allSkills?.toJson(),
      };
}

class AllSkills {
  List<Skill>? skill;
  dynamic nextPageUrl;

  AllSkills({
    this.skill,
    this.nextPageUrl,
  });

  factory AllSkills.fromJson(Map<String, dynamic> json) => AllSkills(
        skill: json["data"] == null
            ? []
            : List<Skill>.from(json["data"]!.map((x) => Skill.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": skill == null
            ? []
            : List<dynamic>.from(skill!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Skill {
  dynamic id;
  String? skill;
  dynamic status;

  Skill({
    this.id,
    this.skill,
    this.status,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skill: json["skill"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill": skill,
        "status": status,
      };
}
