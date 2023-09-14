import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/utils/helpers.dart';
import 'package:shopping_app99/view/common/custom_app_bar.dart';

import '../../utils/validator.dart';
import '../common/custom_input_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController textUserName = TextEditingController();
  final TextEditingController textPassword = TextEditingController();
  final TextEditingController textMobileNo = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  dynamic register() {
    var body = {
      'username': textUserName.text,
      'password': textPassword.text,
      'mobile_no': textMobileNo.text,
      'role_id': "2",
      'is_active': '1',
      'admin_system': "0",
    };
    // String? usernameValidation = Validators.validateUserName(textUserName.text);
    // String? passwordValidation = Validators.validatePassword(textPassword.text);
    // String? phonedValidation = Validators.validatePhoneNumber(textMobileNo.text);
    //
    //
    // if (usernameValidation != null) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.back();
    //     Helpers.waringDialog(
    //       context,
    //       message: usernameValidation,
    //     );
    //   });
    //   return;
    // }
    // if (passwordValidation != null) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.back();
    //     Helpers.waringDialog(
    //       context,
    //       message: passwordValidation,
    //     );
    //   });
    //   return;
    // }
    // if (phonedValidation != null) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.back();
    //     Helpers.waringDialog(
    //       context,
    //       message: phonedValidation,
    //     );
    //   });
    //   return;
    // }

    if (textUserName.text.isEmpty) {
      Helpers.waringDialog(
        context,
        message: "The username is required",
      );
      return;
    }
    if (textPassword.text.isEmpty) {
      Helpers.waringDialog(
        context,
        message: "The password is required",
      );
      return;
    }
    if (textMobileNo.text.isEmpty) {
      Helpers.waringDialog(
        context,
        message: "The mobile number is required",
      );
      return;
    }

    HttpApi.post('user/register', body: body).then((value) {
      print(value!.statusCode);

      if (value.statusCode == 200) {
        final res = jsonDecode(value.body);
        if (res['resCode'] == '0000') {
          Helpers.successDialog(
            context,
            message: 'Registration Successful',
            onPressed: () => Get.offAllNamed('/'),
          );
        } else {
          Helpers.waringDialog(
            context,
            message: res['message'],
          );
        }
      } else {
        Helpers.waringDialog(
          context,
          message: "Server Unavailable",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        leadingOnPress: () => Navigator.pop(context),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'Customer Info',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(color: Colors.white, width: 0),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Theme.of(context).backgroundColor,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: Theme.of(context).primaryColor,
                    child: SizedBox(
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            CustomInputText(
                              prefixIcon: Icons.person,
                              text: "Username",
                              controller: textUserName,
                            ),
                            const SizedBox(height: 10),
                            CustomInputText(
                              prefixIcon: Icons.lock_open,
                              text: "Password",
                              controller: textPassword,
                            ),
                            const SizedBox(height: 10),
                            CustomInputText(
                              prefixIcon: Icons.phone_iphone,
                              text: "Mobile No.",
                              controller: textMobileNo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: width * 0.9,
                    height: 55,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    onPressed: () {
                      register();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
