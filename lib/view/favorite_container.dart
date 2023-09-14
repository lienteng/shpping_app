import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/model/product.dart';
import 'package:shopping_app99/model/user.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/view/product/product_item_widget.dart';
import '../utils/helpers.dart';
import 'package:hive/hive.dart';

class FavoriteContainer extends StatefulWidget {
  const FavoriteContainer({super.key});

  @override
  State<FavoriteContainer> createState() => _FavoriteContainerState();
}

class _FavoriteContainerState extends State<FavoriteContainer> {
  UserProvider? userProvider;
  final box = Hive.box('myBox');
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  fetchFavoriteProducts() {
    User? user = User.fromJson(jsonDecode(box.get("current_user")));
    var body = {
      'user_id': "${user.id}",
    };
    HttpApi.post('favorite/products', body: body).then((response) {
      print(response!.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['resCode'] == '0000') {
          final data = body['data'];
          print(data);
          final items = productFromJson(jsonEncode(data));
          if (items.isNotEmpty) {
            if (userProvider?.favoriteProducts == null) {
              userProvider?.setFavoriteProducts(items);
            } else {
              userProvider?.favoriteProducts.addAll(items.reversed);
              userProvider?.setFavoriteProducts(userProvider!.favoriteProducts);
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context);
      fetchFavoriteProducts();
    }
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          final products = provider.getFavoriteProducts();
          return CustomScrollView(
            slivers: [
              if (products.isNotEmpty)
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ProductItemWidget(
                          product: products[index],
                          onPressed: () {
                            Get.toNamed(
                              'product-detail',
                              arguments: products[index],
                            );
                          },
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
