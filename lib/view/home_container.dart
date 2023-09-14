import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/model/category.dart';
import 'package:shopping_app99/model/product.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/utils/helpers.dart';
import 'package:shopping_app99/view/product/product_item_widget.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  UserProvider? userProvider;
  final List<String> imageList = [
    'https://png.pngitem.com/pimgs/s/43-434027_product-beauty-skin-care-personal-care-liquid-tree.png',
    'https://e7.pngegg.com/pngimages/261/15/png-clipart-junk-food-candy-fizzy-drinks-convenience-food-junk-food-food-eating-thumbnail.png',
    'https://w7.pngwing.com/pngs/748/506/png-transparent-fizzy-drinks-energy-drink-pepsi-fast-food-drink-food-plastic-bottle-packaging-and-labeling-thumbnail.png',
    'https://png.pngitem.com/pimgs/s/43-434027_product-beauty-skin-care-personal-care-liquid-tree.png'
  ];

  @override
  void initState() {
    super.initState();
  }

  fetchCategories() {
    HttpApi.get('get-categories').then((response) {
      print(response!.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['resCode'] == '0000') {
          final data = body['data'];
          print(data);
          final items = categoryFromJson(jsonEncode(data));
          if (items.isNotEmpty) {
            if (userProvider?.categories == null) {
              userProvider?.setCategories(items);
            } else {
              userProvider?.categories.addAll(items.reversed);
              userProvider?.setCategories(userProvider!.categories);
            }
          }
        }
      }
    });
  }

  fetchProductByCategory(String cateId) {
    var body = {'cate_id': cateId};
    HttpApi.post('products-by-category?limit=50', body: body).then((response) {
      print(response!.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['resCode'] == '0000') {
          final data = body['data'];
          print(data);
          final items = productFromJson(jsonEncode(data));
          if (items.isNotEmpty) {
            if (userProvider?.cateProducts == null) {
              userProvider?.setCateProducts(items);
            } else {
              userProvider?.cateProducts.addAll(items.reversed);
              userProvider?.setCateProducts(userProvider!.cateProducts);
            }
          }
        }
      }
    });
  }

  fetchPopularProducts() {
    HttpApi.get('products-popular').then((response) {
      print(response!.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['resCode'] == '0000') {
          final data = body['data'];
          print(data);
          final items = productFromJson(jsonEncode(data));
          if (items.isNotEmpty) {
            if (userProvider?.popularProducts == null) {
              userProvider?.setPopularProducts(items);
            } else {
              userProvider?.popularProducts.addAll(items.reversed);
              userProvider?.setPopularProducts(userProvider!.popularProducts);
            }
          }
        }
      }
    });
  }

  fetchProducts() {
    HttpApi.get('products-random-get').then((response) {
      print(response!.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['resCode'] == '0000') {
          final data = body['data'];
          print(data);
          final items = productFromJson(jsonEncode(data));
          if (items.isNotEmpty) {
            if (userProvider?.products == null) {
              userProvider?.setProducts(items);
            } else {
              userProvider?.products.addAll(items.reversed);
              userProvider?.setProducts(userProvider!.products);
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
      fetchCategories();
      fetchProductByCategory('');
      fetchPopularProducts();
      fetchProducts();
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final cates = provider.getCategories();
        final cateProducts = provider.getCateProducts();
        final popularProducts = provider.getPopularProducts();
        final products = provider.getProducts();
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: imageList.length,
                  itemBuilder: (context, index, pageViewIndex) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(imageList[index]),
                          scale: 3,
                          fit: BoxFit.contain,
                        )),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 2,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 288,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helpers.getString('category'),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              if (cates.isNotEmpty)
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cates.length,
                                    itemBuilder: (context, index) {
                                      String cate = cates[index].nameEn;
                                      if (Get.locale!.languageCode == 'lo') {
                                        cate = cates[index].nameLo;
                                      }
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            provider.cateProducts = [];

                                            fetchProductByCategory(
                                              cates[index].id.toString(),
                                            );
                                            setState(() {});
                                          },
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Center(
                                              child: Text(
                                                cate,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if (cateProducts.isNotEmpty)
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cateProducts.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProductItemWidget(
                                        product: cateProducts[index],
                                        onPressed: () {
                                          Get.toNamed(
                                            'product-detail',
                                            arguments: cateProducts[index],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Helpers.getString('product_popular'),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (popularProducts.isNotEmpty)
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: popularProducts.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductItemWidget(
                                      product: popularProducts[index],
                                      onPressed: () {
                                        Get.toNamed(
                                          'product-detail',
                                          arguments: popularProducts[index],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Helpers.getString('all_products'),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (products.isNotEmpty)
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductItemWidget(
                              product: products[index],
                              onPressed: () {
                                Get.toNamed(
                                  'product-detail',
                                  arguments: products[index],
                                );
                              },
                            );
                          },
                          childCount: products.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
