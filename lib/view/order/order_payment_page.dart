import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/model/customer.dart';
import 'package:shopping_app99/model/user.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/utils/helpers.dart';
import 'package:shopping_app99/view/common/custom_app_bar.dart';
import 'package:shopping_app99/api/http_api.dart';

class OrderPaymentPage extends StatefulWidget {
  const OrderPaymentPage({super.key});

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  UserProvider? userProvider;
  User? user;
  final box = Hive.box('myBox');
  String? phone;
  String? name;
  String? buildingAddress;
  String? shippingAddress;
  String? lat;
  String? lng;
  double amount = 0;
  double subTotal = 0;
  double discount = 0;
  getUserLogin() {
    User? u = User.fromJson(jsonDecode(box.get("current_user")));
    user = u;
    setState(() {});
  }

  submitOrder() {
    try {
      Helpers.loadingDialog(context);
      DateTime dateTime = DateTime.now();
      String billNumber = DateFormat('B-yyyyMMddHHmmssSSS').format(dateTime);
      String date = DateFormat('yyyy-MM-dd').format(dateTime);
      final Map<String, dynamic> params = <String, dynamic>{};
      params["bill_no"] = billNumber;
      params["order_date"] = date;
      params["cus_id"] = '${user!.id}';
      params["cus_name"] = '$name';
      params["cus_phone"] = "$phone";
      params["lat"] = lat;
      params["lng"] = lng;
      params["sub_total"] = '$subTotal';
      params["disc_pct"] = "0";
      params["disc_amt"] = "$discount";
      params["tax_pct"] = "0";
      params["tax_amt"] = "0";
      params["grand_total"] = "$amount";
      params["ccy_symbol"] = "₭";
      params["status"] = "1";
      params["order_status_id"] = "1";

      for (int i = 0; i < userProvider!.basketList.length; i++) {
        params['order_details[$i][bill_no]'] = billNumber;
        params['order_details[$i][product_id]'] =
        '${userProvider!.basketList[i].product!.id}';
        params['order_details[$i][prod_name_lo]'] =
            userProvider!.basketList[i].product!.nameLo;
        params['order_details[$i][prod_name_en]'] =
            userProvider!.basketList[i].product!.nameEn;
        params['order_details[$i][sale_price]'] =
        '${userProvider!.basketList[i].product!.price}';
        params['order_details[$i][sale_qty]'] =
        '${userProvider!.basketList[i].qty}';
        params['order_details[$i][disc_pct]'] = '0';
        params['order_details[$i][disc_amt]'] =
        '${userProvider!.basketList[i].product!.discount}';
        params['order_details[$i][sale_total]'] =
        '${userProvider!.basketList[i].total}';
      }

      HttpApi.post2('submit/order', body: params).then((response) {
        if (response!.statusCode == 200) {
          final res = jsonDecode(response.body);
          if (res['resCode'] == '0000') {
            Future.delayed(const Duration(seconds: 3)).then((value) async {
              Get.back();
              Helpers.successDialog(context, message: 'Order Submitted',
                  onPressed: () {
                    userProvider!.basketList.clear();
                    userProvider!.setTapIndex(3);
                    userProvider!.setTapTitle('orders');
                    Get.toNamed('/home');
                  });
            });
          } else {
            Future.delayed(const Duration(seconds: 3)).then((value) async {
              Get.back();
              Helpers.waringDialog(
                context,
                message: res['message'],
              );
            });
          }
        } else {
          Future.delayed(const Duration(seconds: 3)).then((value) async {
            Get.back();
            Helpers.waringDialog(
              context,
              message: 'Internal Server Issue',
            );
          });
        }
      });
    } catch (err) {
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        Get.back();
        Helpers.waringDialog(
          context,
          message: 'Internal Server Issue',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context);
      getUserLogin();
      dynamic data = Get.parameters;
      phone = data['phone'];
      name = data['name'];
      buildingAddress = data['building'];
      shippingAddress = data['shipping'];
      lat = data['lat'];
      lng = data['lng'];
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: Helpers.getString('order__order_payment'),
        leadingOnPress: () => Get.back(),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          amount = 0;
          subTotal = 0;
          discount = 0;
          for (var basket in provider.basketList) {
            discount = discount + (basket.product!.discount * basket.qty!);
            subTotal = subTotal + (basket.product!.price * basket.qty!);
          }
          amount = subTotal;
          if (discount > 0) {
            amount = amount - discount;
          }
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            children: [
                              Text(
                                'Name: $name',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Phone: $phone',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Building Address: $buildingAddress',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Shipping Address: $shippingAddress',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              // Text(
                              //   'LatLng: ($lat, $lng)',
                              //   style: Theme.of(context).textTheme.bodyMedium,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final item = provider.basketList[index];
                            String name = item.product!.nameEn;
                            if (Get.locale!.languageCode == 'lo') {
                              name = item.product!.nameLo;
                            }
                            double price = item.product!.price;
                            double d = item.product!.discount * item.qty!;
                            if (d > 0) {
                              price = price - d;
                            }
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/no-image.png',
                                    height: 90,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          'Price: ${Helpers.getPriceFormat('${item.product!.price}')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          'Discount: ${Helpers.getPriceFormat('$d')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.green),
                                        ),
                                        Text(
                                          'Total: ${Helpers.getPriceFormat('${item.total}')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'x${item.qty}',
                                    style:
                                    Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            );
                          },
                          childCount: provider.basketList.length,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Sub Total: ${Helpers.getPriceFormat('$subTotal')}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      'Discount: ${Helpers.getPriceFormat('$discount')}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.green),
                    ),
                    Text(
                      'Payment Amount: ${Helpers.getPriceFormat('$amount')}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        submitOrder();
                      },
                      color: Theme.of(context).primaryColor,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        Helpers.getString('customer__submit'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
