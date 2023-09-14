import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app99/model/product.dart';
import 'package:shopping_app99/utils/helpers.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    Key? key,
    this.product,
    this.onPressed,
    this.height = 90,
  }) : super(key: key);
  final Product? product;
  final Function()? onPressed;
  final double? height;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    String proName = widget.product!.nameEn;
    if (Get.locale!.languageCode == "lo") {
      proName = widget.product!.nameLo;
    }
    double price = widget.product!.price;
    double discount = widget.product!.discount;
    double priceDiscount = price - discount;
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/no-image.png',
                  height: 90,
                ),
                Text(
                  proName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  Helpers.getPriceFormat('${widget.product!.price}'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      decoration: discount > 0
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: discount > 0 ? Colors.red : null),
                ),
                if (discount > 0)
                  Text(
                    Helpers.getPriceFormat('$priceDiscount'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
