// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String barcode;
  String nameLo;
  String nameEn;
  String cateLo;
  String cateEn;
  String unitLo;
  String unitEn;
  double cost;
  double profit;
  double price;
  int qty;
  int minQty;
  double discount;
  int isPopular;
  String description;
  String imagePath;

  Product({
    required this.id,
    required this.barcode,
    required this.nameLo,
    required this.nameEn,
    required this.cateLo,
    required this.cateEn,
    required this.unitLo,
    required this.unitEn,
    required this.cost,
    required this.profit,
    required this.price,
    required this.qty,
    required this.minQty,
    required this.discount,
    required this.isPopular,
    required this.description,
    required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        barcode: json["barcode"],
        nameLo: json["name_lo"],
        nameEn: json["name_en"],
        cateLo: json["cate_lo"],
        cateEn: json["cate_en"],
        unitLo: json["unit_lo"],
        unitEn: json["unit_en"],
        cost: json["cost"].toDouble(),
        profit: json["profit"].toDouble(),
        price: json["price"].toDouble(),
        qty: json["qty"],
        minQty: json["min_qty"],
        discount: json["discount"].toDouble(),
        isPopular: json["is_popular"] ?? 0,
        description: json["description"] ?? '',
        imagePath: json["image_path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "barcode": barcode,
        "name_lo": nameLo,
        "name_en": nameEn,
        "cate_lo": cateLo,
        "cate_en": cateEn,
        "unit_lo": unitLo,
        "unit_en": unitEn,
        "cost": cost,
        "profit": profit,
        "price": price,
        "qty": qty,
        "min_qty": minQty,
        "discount": discount,
        "is_popular": isPopular,
        "description": description,
        "image_path": imagePath,
      };
}
