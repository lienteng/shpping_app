// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  String billNo;
  DateTime orderDate;
  int cusId;
  String cusName;
  String cusPhone;
  double lat;
  double lng;
  int subTotal;
  int discPct;
  int discAmt;
  int taxPct;
  int taxAmt;
  int grandTotal;
  String ccySymbol;
  int status;
  int orderStatusId;

  Order({
    required this.billNo,
    required this.orderDate,
    required this.cusId,
    required this.cusName,
    required this.cusPhone,
    required this.lat,
    required this.lng,
    required this.subTotal,
    required this.discPct,
    required this.discAmt,
    required this.taxPct,
    required this.taxAmt,
    required this.grandTotal,
    required this.ccySymbol,
    required this.status,
    required this.orderStatusId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        billNo: json["bill_no"],
        orderDate: DateTime.parse(json["order_date"]),
        cusId: json["cus_id"],
        cusName: json["cus_name"],
        cusPhone: json["cus_phone"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        subTotal: json["sub_total"],
        discPct: json["disc_pct"],
        discAmt: json["disc_amt"],
        taxPct: json["tax_pct"],
        taxAmt: json["tax_amt"],
        grandTotal: json["grand_total"],
        ccySymbol: json["ccy_symbol"],
        status: json["status"],
        orderStatusId: json["order_status_id"],
      );

  Map<String, dynamic> toJson() => {
        "bill_no": billNo,
        "order_date": orderDate.toIso8601String(),
        "cus_id": cusId,
        "cus_name": cusName,
        "cus_phone": cusPhone,
        "lat": lat,
        "lng": lng,
        "sub_total": subTotal,
        "disc_pct": discPct,
        "disc_amt": discAmt,
        "tax_pct": taxPct,
        "tax_amt": taxAmt,
        "grand_total": grandTotal,
        "ccy_symbol": ccySymbol,
        "status": status,
        "order_status_id": orderStatusId,
      };
}