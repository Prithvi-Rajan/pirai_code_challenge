import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/main.dart';
import 'package:pirai_code_challenge/models/product_model.dart';

void showSnackBar(message) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(
    content: Text(message),
  ));
}

Future<List> getProducts() async {
  final url = 'https://fakestoreapi.com/products';
  final response = await http.get(Uri.parse(url));
  final json = JsonDecoder().convert(response.body);
  final productsList = [];
  for (var product in json) {
    productsList.add(
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
  return productsList;
}
