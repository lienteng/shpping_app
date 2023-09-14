import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopping_app99/view/common/custom_loading.dart';

class Helpers {
  static String getString(String key) {
    if (key != '') {
      return key.tr;
    }
    return '';
  }
  static String getFormatDateTime(DateTime dateTime) {
    final DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss');
    final String date = format.format(dateTime);
    return date;
  }

  static String getPriceFormat(String price) {
    NumberFormat format = NumberFormat("₭#,###");
    return format.format(double.parse(price));
  }

  static void waringDialog(BuildContext context, {String? message}) {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: const TextStyle(fontWeight: FontWeight.normal),
        descTextAlign: TextAlign.center,
        animationDuration: const Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: const TextStyle(
          color: Colors.red,
        ),
        alertAlignment: Alignment.center,
      ),
      type: AlertType.warning,
      title: "Waring",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(14.0),
          child: Text(
            "OK",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ).show();
  }

  static void successDialog(BuildContext context,
      {Function()? onPressed, String? message}) {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: const TextStyle(fontWeight: FontWeight.normal),
        descTextAlign: TextAlign.center,
        animationDuration: const Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: const TextStyle(
          color: Colors.green,
        ),
        alertAlignment: Alignment.center,
      ),
      type: AlertType.success,
      title: "Waring",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: onPressed,
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(14.0),
          child: Text(
            "OK",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ).show();
  }

  static void loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomLoading();
      },
    );
  }
}
