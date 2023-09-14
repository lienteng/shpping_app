import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/model/order_model.dart';
import 'package:shopping_app99/provider/user_provider.dart';

import '../model/user.dart';
import '../utils/helpers.dart';

class OrderController {
  String getOrderStatus(String orderStatusId) {
    if (orderStatusId == '1') {
      return 'order__submitted';
    } else if (orderStatusId == '2') {
      return 'order__accepted';
    } else if (orderStatusId == '3') {
      return 'order__packing';
    } else if (orderStatusId == '4') {
      return 'order__on_the_way';
    } else if (orderStatusId == '5') {
      return 'order__delivered';
    } else if (orderStatusId == '6') {
      return 'order__completed';
    } else {
      return 'order__cancelled';
    }
  }

  Color getOrderStatusColor(String orderStatusId) {
    if (orderStatusId == '1') {
      return const Color(0xffE74C3C);
    } else if (orderStatusId == '2') {
      return const Color(0xff3498DB);
    } else if (orderStatusId == '3') {
      return const Color(0xff8E44AD);
    } else if (orderStatusId == '4') {
      return const Color(0xffF1C40F);
    } else if (orderStatusId == '5') {
      return const Color(0xff76D7C4);
    } else if (orderStatusId == '6') {
      return const Color(0xff1E8449);
    } else {
      return const Color(0xff99A3A4);
    }
  }

  Future<void> fetchOrders(BuildContext context, UserProvider provider,
      {String? limit, String? offset}) async {
    final box = Hive.box('myBox');
    User? u = User.fromJson(jsonDecode(box.get("current_user")));
    var body = {
      "user_id": u.id,
    };
    await HttpApi.post('get/orders?limit=$limit&offset=$offset', body: body)
        .then((response) {
      if (response!.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['resCode'] == '0000') {
          final data = res['data'];
          final orders = orderFromJson(jsonEncode(data));
          if (orders.isNotEmpty) {
            if (provider.orders.isEmpty) {
              provider.setOrders(orders);
            } else {
              provider.orders.addAll(orders.reversed);
              provider.setOrders(provider.orders);
            }
          }
        } else {
          Future.delayed(const Duration(seconds: 3)).then((value) async {
            Helpers.waringDialog(context, message: res['message']);
          });
        }
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) async {
          Helpers.waringDialog(context, message: 'Internal Server Issue');
        });
      }
    });
  }

  void goToDetailPage(String billNo) {
    Get.toNamed(
      '/order-detail',
      parameters: {'bill_no': billNo},
    );
  }
  void goToTrackingPage(String statusId) {
    Get.toNamed(
      '/order-tracking',
      parameters: {'order_status_id': statusId},
    );
  }
}