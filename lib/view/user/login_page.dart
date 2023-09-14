import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app99/api/http_api.dart';
import 'package:shopping_app99/model/user.dart';
import 'package:shopping_app99/utils/helpers.dart';
import '../../utils/validator.dart';
import '../common/custom_input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textUserName = TextEditingController();
  final TextEditingController textPassword = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  dynamic login() {
    Helpers.loadingDialog(context);
    var body = {
      'username': textUserName.text,
      'password': textPassword.text,
    };


    String? usernameValidation = Validators.validateUserName(textUserName.text);
    String? passwordValidation = Validators.validatePassword(textPassword.text);


    if (usernameValidation != null) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Get.back();
        Helpers.waringDialog(
          context,
          message: usernameValidation,
        );
      });
      return;
    }
    if (passwordValidation != null) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Get.back();
        Helpers.waringDialog(
          context,
          message: passwordValidation,
        );
      });
      return;
    }

    // if (textUserName.text.isEmpty) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.back();
    //     Helpers.waringDialog(
    //       context,
    //       message: "The username is required",
    //     );
    //   });
    //
    //   return;
    // }
    // if (textPassword.text.isEmpty) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.back();
    //     Helpers.waringDialog(
    //       context,
    //       message: "The password is required",
    //     );
    //   });
    //   return;
    // }

    HttpApi.post('user/login', body: body).then((value) {
      if (value == null) {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.back();
          Helpers.waringDialog(
            context,
            message: "Server Unavailable",
          );
        });
        return;
      }

      if (value.statusCode == 200) {
        final res = jsonDecode(value.body);
        if (res['resCode'] == '0000') {
          print(res['data']);
          Future.delayed(const Duration(seconds: 3)).then((value) {
            Get.back();

            User user = User.fromJson(res['data']);
            final box = Hive.box('myBox');
            box.put('is_login', '1');
            box.put('current_user', jsonEncode(user));

            Get.toNamed('/home');
          });
        } else {
          Future.delayed(const Duration(seconds: 3)).then((value) {
            Get.back();
            Helpers.waringDialog(
              context,
              message: "Username or password invalid",
            );
          });
        }
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.back();
          Helpers.waringDialog(
            context,
            message: "Server Unavailable",
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'Welcome Back',
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
                  const SizedBox(height: 50),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onPressed: () {},
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
                      'Login',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    onPressed: () {
                      login();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          " Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
