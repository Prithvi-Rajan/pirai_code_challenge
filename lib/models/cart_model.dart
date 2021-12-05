import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/models/product_model.dart';
import 'package:pirai_code_challenge/models/user_model.dart';

class CartModel extends ChangeNotifier {
  UserModel? _userModel;

  List<ProductModel> products = [];

  void updateUserModel(UserModel _um) {
    _userModel = _um;
    getCartFromCloud();
  }

  void getCartFromCloud() {
    final uid = _userModel?.currentUser?.uid;
    if ((uid ?? '').isEmpty) return;
    notifyListeners();

    //TODO: Get Cart details form cloud using uid
  }

  void updateCart(ProductModel id) {
    int index = products.indexWhere((e) => e.id == id.id);

    if (index == -1) {
      //Add to cart
      products.add(id);
    } else {
      //Remove from cart
      products.removeAt(index);
    }

    notifyListeners();

    //TODO: Update Cart details to cloud using uid
    final uid = _userModel?.currentUser?.uid;
    if ((uid ?? '').isEmpty) return;
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
}
