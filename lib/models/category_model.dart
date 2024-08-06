import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category>? data;
  Links? links;

  CategoryModel({
    this.data,
    this.links,
  });

  factory CategoryModel.fromJson(Map json) => CategoryModel(
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"]!.map((x) => Category.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
      };
}

class Category {
  dynamic id;
  String? name;
  List<SubCategory>? subCategories;

  Category({
    this.id,
    this.name,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        subCategories: json["sub_categories"] == null
            ? []
            : List<SubCategory>.from(
                json["sub_categories"]!.map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_categories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategory {
  dynamic id;
  dynamic categoryId;
  String? subCategory;
  String? slug;

  SubCategory({
    this.id,
    this.categoryId,
    this.subCategory,
    this.slug,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        subCategory: json["sub_category"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "sub_category": subCategory,
        "slug": slug,
      };
}

class Links {
  dynamic next;

  Links({
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
