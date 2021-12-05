import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/models/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? _products;

  List<ProductModel>? get products {
    if (_products == null) {
      _getProducts();
    }
    return _products;
  }

  Future<void> _getProducts() async {
    final url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));
    final json = JsonDecoder().convert(response.body);
    _products?.clear();
    _products ??= [];
    for (var product in json) {
      _products!.add(
        ProductModel(
            id: product['id'],
            title: product['title'],
            description: product['description'],
            price: product['price'].toString(),
            image: product['image'],
            rating: product['rating']['rate'].toString(),
            ratingCount: product['rating']['count'].toString()),
      );
    }
    notifyListeners();    
  }

  List<ProductModel> findProducts(List<String> ids)  {
    return (_products?? []).where((e) => ids.contains(e.id.toString())).toList();
  }

  
}
