import 'package:shopping_app99/model/product.dart';

class Basket {
  String? id;
  Product? product;
  int? qty;
  double? total;

  Basket({
    this.id,
    this.product,
    this.qty,
    this.total,
  });
}
