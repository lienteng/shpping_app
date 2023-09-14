import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helpers.dart';
import '../common/custom_app_bar.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int currentStep = 0;
  bool submitted = false;
  bool accepted = false;
  bool packing = false;
  bool onTheWay = false;
  bool delivered = false;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    dynamic data = Get.parameters;
    String orderStatusId = data['order_status_id'];
    if (orderStatusId == '1') {
      currentStep = 0;
      submitted = true;
      accepted = false;
      packing = false;
      onTheWay = false;
      delivered = false;
      completed = false;
    } else if (orderStatusId == '2') {
      currentStep = 1;
      submitted = true;
      accepted = true;
      packing = false;
      onTheWay = false;
      delivered = false;
      completed = false;
    } else if (orderStatusId == '3') {
      currentStep = 2;
      submitted = true;
      accepted = true;
      packing = true;
      onTheWay = false;
      delivered = false;
      completed = false;
    } else if (orderStatusId == '4') {
      currentStep = 3;
      submitted = true;
      accepted = true;
      packing = true;
      onTheWay = true;
      delivered = false;
      completed = false;
    } else if (orderStatusId == '5') {
      currentStep = 4;
      submitted = true;
      accepted = true;
      packing = true;
      onTheWay = true;
      delivered = true;
      completed = false;
    } else {
      currentStep = 5;
      submitted = true;
      accepted = true;
      packing = true;
      onTheWay = true;
      delivered = true;
      completed = true;
    }
    // 'order__submitted': 'Submitted',
    // 'order__accepted': 'Accepted',
    // 'order__packing': 'Packing',
    // 'order__on_the_way': 'On the way',
    // 'order__delivered': 'Delivered',
    // 'order__completed': 'Completed',
    // 'order__cancelled': 'Cancelled',
    return Scaffold(
      appBar: CustomAppBar(
        title: Helpers.getString('order__tracking'),
        leadingOnPress: () => Get.back(),
      ),
      body: Stepper(
        currentStep: currentStep,
        steps: [
          Step(
            title: Text(Helpers.getString('order__submitted')),
            content: SizedBox.shrink(),
            isActive: submitted,
          ),
          Step(
            title: Text(Helpers.getString('order__accepted')),
            content: SizedBox.shrink(),
            isActive: accepted,
          ),
          Step(
            title: Text(Helpers.getString('order__packing')),
            content: SizedBox.shrink(),
            isActive: packing,
          ),
          Step(
            title: Text(Helpers.getString('order__on_the_way')),
            content: SizedBox.shrink(),
            isActive: onTheWay,
          ),
          Step(
            title: Text(Helpers.getString('order__delivered')),
            content: SizedBox.shrink(),
            isActive: delivered,
          ),
          Step(
            title: Text(Helpers.getString('order__completed')),
            content: SizedBox.shrink(),
            isActive: completed,
          ),
        ],
        type: StepperType.vertical,
        controlsBuilder: (context, details) {
          return Container();
        },
      ),
    );
  }
}