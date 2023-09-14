import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app99/view/common/custom_app_bar.dart';

import '../../api/http_api.dart';
import '../../model/order_detail.dart';
import '../../provider/user_provider.dart';
import '../../utils/helpers.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import '../../utils/helpers.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<OrderDetail>? details = [];
  UserProvider? userProvider;
  @override
  void initState() {
    super.initState();
  }

  void fetchOrderDetail(String billNo) {
    var body = {'bill_no': billNo};
    HttpApi.post('get/orders-details', body: body).then((response) {
      if (response!.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['resCode'] == '0000') {
          details = orderDetailFromJson(jsonEncode(res['data']));
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider == null) {
      userProvider ??= Provider.of<UserProvider>(context);
      dynamic data = Get.parameters;
      String billNo = data['bill_no'];
      fetchOrderDetail(billNo);
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: Helpers.getString('order__details'),
        leadingOnPress: () => Get.back(),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (details!.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: details!.length,
                itemBuilder: (context, index) {
                  final detail = details![index];
                  String? name = detail.prodNameEn;
                  if (Get.locale!.languageCode == 'lo') {
                    name = detail.prodNameLo;
                  }
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Helpers.getString('order_detail__pro_name'),
                                    style:
                                    Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 5),
                                  Material(
                                    shape: const CircleBorder(),
                                    color: Theme.of(context).primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        '${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                name!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Helpers.getString('order__price'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                Helpers.getPriceFormat('${detail.salePrice}'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Helpers.getString('cart__qty'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                '${detail.saleQty}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Helpers.getString('order_detail__total'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Helpers.getPriceFormat('${detail.saleTotal}'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}