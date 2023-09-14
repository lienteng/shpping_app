import 'package:flutter/cupertino.dart';
import 'package:shopping_app99/model/basket.dart';
import 'package:shopping_app99/model/category.dart';
import 'package:shopping_app99/model/order_model.dart';
import 'package:shopping_app99/model/product.dart';

class UserProvider extends ChangeNotifier {
  // to do

  int tapIndex = 0;
  void setTapIndex(int currentIndex) {
    tapIndex = currentIndex;
    notifyListeners();
  }

  String tapTitle = 'home';
  void setTapTitle(String title) {
    tapTitle = title;
    notifyListeners();
  }

  List<Category> categories = [];
  void setCategories(List<Category> items) {
    categories = items;
    notifyListeners();
  }

  List<Category> getCategories() {
    return categories;
  }

  // for product by category
  List<Product> cateProducts = [];
  void setCateProducts(List<Product> items) {
    cateProducts = items;
    notifyListeners();
  }

  List<Product> getCateProducts() {
    return cateProducts;
  }

  // for popular products

  List<Product> popularProducts = [];
  void setPopularProducts(List<Product> items) {
    popularProducts = items;
    notifyListeners();
  }

  List<Product> getPopularProducts() {
    return popularProducts;
  }

  // for all products

  List<Product> products = [];
  void setProducts(List<Product> items) {
    products = items;
    notifyListeners();
  }

  List<Product> getProducts() {
    return products;
  }

  // for favorite product

  List<Product> favoriteProducts = [];
  void setFavoriteProducts(List<Product> items) {
    favoriteProducts = items;
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return favoriteProducts;
  }

  // basket list
  List<Basket> basketList = [];
  void setBasketList(Basket item) {
    basketList.add(item);
    notifyListeners();
  }

  List<Basket> getBasketList() {
    return basketList;
  }

  void clearBasket(int index) {
    basketList.removeAt(index);
    notifyListeners();
  }

   List<Order> orders = [];
  void setOrders(List<Order> items) {
    orders = items;
    notifyListeners();
  }

  List<Order> getOrders() {
    return orders;
  }
}
