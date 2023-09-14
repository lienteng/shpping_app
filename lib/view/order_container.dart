import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/controller/order_controller.dart';
import 'package:shopping_app99/model/product.dart';
import 'package:shopping_app99/model/user.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/view/product/product_item_widget.dart';

import '../utils/helpers.dart';

class OrderContainer extends StatefulWidget {
  const OrderContainer({super.key});

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  UserProvider? userProvider;
  final box = Hive.box('myBox');
  bool isLoading = true;
  final OrderController controller = OrderController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context);
      controller.fetchOrders(context, userProvider!);
    }
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          final orders = provider.getOrders();
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                if (orders.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final order = orders[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.goToDetailPage(order.billNo);
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Helpers.getString('order__no'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        order.billNo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Helpers.getString('order__date'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        Helpers.getFormatDateTime(
                                            order.orderDate),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Helpers.getString('order__price'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        Helpers.getPriceFormat(
                                            '${order.grandTotal}'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Helpers.getString('order__status'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Card(
                                        color: controller.getOrderStatusColor(
                                            '${order.orderStatusId}'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (order.orderStatusId != 7) {
                                              controller.goToTrackingPage(
                                                  '${order.orderStatusId}');
                                            }
                                          },
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2,
                                            ),
                                            child: Text(
                                              Helpers.getString(
                                                  controller.getOrderStatus(
                                                      '${order.orderStatusId}')),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: orders.length,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}