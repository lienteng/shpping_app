import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/model/basket.dart';
import 'package:shopping_app99/model/product.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/utils/helpers.dart';
import 'package:badges/badges.dart' as badges;

import '../../model/user.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? product;
  bool isFavorite = false;
  final box = Hive.box('myBox');
  UserProvider? userProvider;

  @override
  void initState() {
    super.initState();
  }

  dynamic createFavorite() {
  
    User? user = User.fromJson(jsonDecode(box.get("current_user")));
    print(user.id);
    var body = {
      "user_id": "${user.id}",
      "product_id": "${product!.id}",
    };
    HttpApi.post('favorite/create', body: body).then((value) {
      if (value!.statusCode == 200) {}
    });
  }

  dynamic deleteFavorite() {
    User? user = User.fromJson(jsonDecode(box.get("current_user")));
    print(user.id);
    var body = {
      "user_id": "${user.id}",
      "product_id": "${product!.id}",
    };
    HttpApi.post('favorite/delete', body: body).then((value) {
      if (value!.statusCode == 200) {}
    });
  }

  dynamic findFavorite() {
    User? user = User.fromJson(jsonDecode(box.get("current_user")));
    print(user.id);
    var body = {
      "user_id": "${user.id}",
      "product_id": "${product!.id}",
    };
    HttpApi.post('favorite/find', body: body).then((response) {
      if (response!.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['resCode'] == '0000') {
          setState(() {
            isFavorite = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    product = Get.arguments;
    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context);
      findFavorite();
    }
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: Helpers.getString('product__product_detail'),
      //   leadingOnPress: () => Get.back(),
      // ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  primary: true,
                  leading: MaterialButton(
                    onPressed: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          userProvider!.setTapIndex(2);
                          userProvider!.setTapTitle('cart');
                          Get.toNamed('/home');
                        },
                        icon: badges.Badge(
                          badgeContent: Text(
                            '${userProvider!.basketList.length}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          position:
                              badges.BadgePosition.topEnd(top: -15, end: -8),
                          child: Icon(
                            Icons.shopping_cart_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Image.asset(
                    'assets/images/no-image.png',
                    height: 200,
                  ),
                ),
                if (product != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).hoverColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Helpers.getString('product__product_detail'),
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (isFavorite == true) {
                                      setState(() {
                                        isFavorite = false;
                                      });
                                      deleteFavorite();
                                    } else {
                                      setState(() {
                                        isFavorite = true;
                                      });
                                      createFavorite();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFavorite == false
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Product Name: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  product!.nameEn,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Price: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  Helpers.getPriceFormat(
                                      product!.price.toString()),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Discount: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  Helpers.getPriceFormat(
                                      product!.discount.toString()),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).hoverColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        addToBasket(product!);
                      },
                      child: Text('Add To Cart'),
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        addToBasket(product!,buyNow: true);
                      },
                      child: Text('Buy Now'),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToBasket(Product product, {bool buyNow = false}) {
    double price = product.price;
    double discount = product.discount;
    double total = price - discount;
    Basket basket = Basket(
      id: '${product.id}',
      product: product,
      qty: 1,
      total: total,
    );
    if(buyNow){
      userProvider!.setBasketList(basket);
      userProvider!.setTapIndex(2);
      userProvider!.setTapTitle('cart');
      Get.toNamed('/home');
    }
    if (userProvider!.basketList.isEmpty) {
      userProvider!.setBasketList(basket);
      return;
    } else {
      for (var item in userProvider!.basketList) {
        if (product.id == item.product!.id) {
          int qty = item.qty! + 1;
          item.qty = qty;
          item.total = (product.price - product.discount) * qty;
          return;
        }
      }
      userProvider!.setBasketList(basket);
    }

  }
}
