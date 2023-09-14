import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/view/favorite_container.dart';
import 'package:shopping_app99/view/home_container.dart';
import 'package:shopping_app99/view/order_container.dart';
import 'cart_container.dart';
import '../provider/user_provider.dart';
import '../utils/helpers.dart';
import 'common/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProvider? userProvider;
  bool isDark = true;
  final box = GetStorage();
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final List<Widget> screens = [
    const HomeContainer(),
    const FavoriteContainer(),
    const CartContainer(),
    const OrderContainer(),
  ];
  @override
  Widget build(BuildContext context) {
    userProvider ??= Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Helpers.getString(userProvider!.tapTitle),
        iconData: Icons.menu,
        leadingOnPress: () {},
        actions: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: Get.locale!.languageCode == 'lo'
                  ? const AssetImage('assets/images/eng.png')
                  : const AssetImage('assets/images/lao.png'),
              child: MaterialButton(
                shape: const CircleBorder(),
                onPressed: () {
                  if (Get.locale!.languageCode == 'lo') {
                    Get.updateLocale(const Locale('en', 'US'));
                  } else {
                    Get.updateLocale(const Locale('lo', 'LO'));
                  }
                  box.write('currentLang', Get.locale!.languageCode);
                  userProvider!.tapTitle = Helpers.getString('home');
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageStorage(
        bucket: pageStorageBucket,
        child: screens.elementAt(userProvider!.tapIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).backgroundColor,
        items: [
          BottomNavigationBarItem(
            label: Helpers.getString('home'),
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: Helpers.getString('favorite'),
            icon: const Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: Helpers.getString('cart'),
            icon: const Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: Helpers.getString('orders'),
            icon: const Icon(Icons.list),
          ),
        ],
        currentIndex: userProvider!.tapIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor:
            isDark == false ? Colors.white : Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  _onItemTapped(int index) {
    userProvider!.favoriteProducts = [];
    userProvider!.orders = [];
    if (index == 0) {
      userProvider!.tapTitle = 'home';
    } else if (index == 1) {
      userProvider!.tapTitle = 'favorite';
    } else if (index == 2) {
      userProvider!.tapTitle = 'cart';
    } else {
      userProvider!.tapTitle = 'orders';
    }
    setState(() {
      userProvider!.tapIndex = index;
    });
  }

}
