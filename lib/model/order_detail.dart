// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

List<OrderDetail> orderDetailFromJson(String str) => List<OrderDetail>.from(json.decode(str).map((x) => OrderDetail.fromJson(x)));

String orderDetailToJson(List<OrderDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetail {
  int? id;
  String? billNo;
  int? productId;
  String? prodNameLo;
  String? prodNameEn;
  int? salePrice;
  int? saleQty;
  int? discPct;
  int? discAmt;
  int? saleTotal;
  String? barcode;
  String? imagePath;

  OrderDetail({
    this.id,
    this.billNo,
    this.productId,
    this.prodNameLo,
    this.prodNameEn,
    this.salePrice,
    this.saleQty,
    this.discPct,
    this.discAmt,
    this.saleTotal,
    this.barcode,
    this.imagePath,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    billNo: json["bill_no"],
    productId: json["product_id"],
    prodNameLo: json["prod_name_lo"],
    prodNameEn: json["prod_name_en"],
    salePrice: json["sale_price"],
    saleQty: json["sale_qty"],
    discPct: json["disc_pct"],
    discAmt: json["disc_amt"],
    saleTotal: json["sale_total"],
    barcode: json["barcode"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bill_no": billNo,
    "product_id": productId,
    "prod_name_lo": prodNameLo,
    "prod_name_en": prodNameEn,
    "sale_price": salePrice,
    "sale_qty": saleQty,
    "disc_pct": discPct,
    "disc_amt": discAmt,
    "sale_total": saleTotal,
    "barcode": barcode,
    "image_path": imagePath,
  };
}
