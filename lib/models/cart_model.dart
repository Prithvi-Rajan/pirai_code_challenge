import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/models/product_model.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/auth_service.dart';

class CartModel extends ChangeNotifier {
  UserModel? _userModel;

  List<ProductModel> products = [];

  void updateUserModel(UserModel _um) {
    _userModel = _um;
    getCartFromCloud();
  }

  void getCartFromCloud() async {
    final uid = _userModel?.currentUser?.uid;
    if ((uid ?? '').isEmpty) return;
    var documentSnapshot =
        await FirebaseAuthService.db.collection('users').doc(uid).get();
    var data = documentSnapshot.data();
    List<dynamic> cart = data?['cart'] ?? [];
    products.clear();
    products = await Future.wait(cart.map((e) => getProductInfoForId(e)));

    notifyListeners();
  }

  void updateCart(ProductModel product) async {
    int index = products.indexWhere((e) => e.id == product.id);
    final uid = _userModel?.currentUser?.uid;

    if ((uid ?? '').isEmpty) return;

    if (index == -1) {
      FirebaseAuthService.db.collection('users').doc(uid).update({
        'cart': FieldValue.arrayUnion([product.id])
      }).catchError((e){
        products.removeWhere((element) => element.id == product.id);
        notifyListeners();
      });
      products.add(product);
    } else {
      //Remove from cart
      await FirebaseAuthService.db.collection('users').doc(uid).update({
        'cart': FieldValue.arrayRemove([product.id])
      }).catchError((e){
         products.removeWhere((element) => element.id == product.id);
        notifyListeners();
      });
      products.removeAt(index);
    }

    notifyListeners();
  }

  double get total {
    double _total = 0.0;
    for (var e in products) _total += (double.tryParse(e.price) ?? 0.0);
    return _total;
  }

  bool isProductInCart(ProductModel product) {
    if (products.indexWhere((e) => e.id == product.id) >= 0) return true;
    return false;
  }

  Future<ProductModel> getProductInfoForId(int id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await http.get(Uri.parse(url));
    final product = JsonDecoder().convert(response.body);
    return ProductModel(
        id: product['id'],
        title: product['title'],
        description: product['description'],
        price: product['price'].toString(),
        image: product['image'],
        rating: product['rating']['rate'].toString(),
        ratingCount: product['rating']['count'].toString());
  }
}
