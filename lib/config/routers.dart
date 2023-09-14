import 'package:get/get.dart';
import 'package:shopping_app99/view/home_page.dart';
import 'package:shopping_app99/view/order/custommer_info_page.dart';
import 'package:shopping_app99/view/order/order_detail.dart';
import 'package:shopping_app99/view/product/product_detail_page.dart';
import 'package:shopping_app99/view/user/login_page.dart';
import 'package:shopping_app99/view/user/register_page.dart';

import '../view/order/order_payment_page.dart';
import '../view/order/order_tracking_page.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => const LoginPage(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/register',
        page: () => const RegisterPage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/home',
        page: () => const HomePage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/product-detail',
        page: () => const ProductDetailPage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/customer-info',
        page: () => const CustomerInfoPage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/order-payment',
        page: () => const OrderPaymentPage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/order-detail',
        page: () => const OrderDetailPage(),
        transition: Transition.circularReveal,
        // middlewares: [MyMiddleware()],
        transitionDuration: const Duration(milliseconds: 500),
      ),
  GetPage(
    name: '/order-tracking',
    page: () => const OrderTrackingPage(),
    transition: Transition.circularReveal,
    // middlewares: [MyMiddleware()],
    transitionDuration: const Duration(milliseconds: 500),
  ),



    ];

// class MyMiddleware extends GetMiddleware {
//   @override
//   GetPage? onPageCalled(GetPage? page) {
//     print(page?.name);
//     return super.onPageCalled(page);
//   }
// }
