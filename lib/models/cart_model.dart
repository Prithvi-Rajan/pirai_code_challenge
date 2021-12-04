import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  Map<int, bool> _in_cart = Map<int, bool>();

  Map<int, bool> get cart => _in_cart;

  void updateCart(int id) {
    bool inTheCart = _in_cart.containsKey(id);
    _in_cart.addAll({id: inTheCart ? !(_in_cart[id] ?? false) : true});
    notifyListeners();
  }
}
