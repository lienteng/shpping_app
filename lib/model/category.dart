// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  int id;
  String nameLo;
  String nameEn;

  Category({
    required this.id,
    required this.nameLo,
    required this.nameEn,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        nameLo: json["name_lo"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_lo": nameLo,
        "name_en": nameEn,
      };
}
