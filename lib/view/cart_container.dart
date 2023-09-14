import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/utils/helpers.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({super.key});

  @override
  State<CartContainer> createState() => _CartCartContainer();
}

class _CartCartContainer extends State<CartContainer> {
  UserProvider? userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider ??= Provider.of<UserProvider>(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (userProvider!.basketList.isEmpty)
                SliverToBoxAdapter(
                  child: Text(
                    Helpers.getString('cart__no_data'),
                  ),
                ),
              if (userProvider!.basketList.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final baskets = userProvider!.basketList;
                      String productName = baskets[index].product!.nameLo;
                      if (Get.locale!.languageCode == "en") {
                        productName = baskets[index].product!.nameEn;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/no-image.png',
                                height: 90,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        '${Helpers.getString('cart__qty')}: ${baskets[index].qty}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        '${Helpers.getString('cart__price')}: ${Helpers.getPriceFormat('${baskets[index].total}')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      addQty(index);
                                    },
                                    color: Theme.of(context).primaryColor,
                                    shape: const CircleBorder(),
                                    child: Text(
                                      '+',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      removeQty(index);
                                    },
                                    color: Colors.grey,
                                    shape: const CircleBorder(),
                                    child: Text(
                                      '-',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: userProvider!.basketList.length,
                  ),
                ),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            Get.toNamed('customer-info');
          },
          color: Theme.of(context).primaryColor,
          child: Text(
            Helpers.getString('cart__check_out'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  void addQty(int index) {
    userProvider!.basketList[index].qty =
        userProvider!.basketList[index].qty! + 1;
    double price = userProvider!.basketList[index].product!.price;
    double discount = userProvider!.basketList[index].product!.discount;
    double priceAfterDiscount = price - discount;
    int qty = userProvider!.basketList[index].qty!;
    double total = priceAfterDiscount * qty;
    userProvider!.basketList[index].total = total;

    setState(() {});
  }

  void removeQty(int index) {
    userProvider!.basketList[index].qty =
        userProvider!.basketList[index].qty! - 1;

    if (userProvider!.basketList[index].qty! == 0) {
      userProvider!.clearBasket(index);
      setState(() {});
      return;
    }
    double price = userProvider!.basketList[index].product!.price;
    double discount = userProvider!.basketList[index].product!.discount;
    double priceAfterDiscount = price - discount;
    int qty = userProvider!.basketList[index].qty!;
    double total = priceAfterDiscount * qty;
    userProvider!.basketList[index].total = total;

    setState(() {});
  }
}
