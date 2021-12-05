import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/models/product_model.dart';
import 'package:pirai_code_challenge/services/utilitiy_functions.dart';
import 'package:pirai_code_challenge/widgets/app_drawer.dart';
import 'package:pirai_code_challenge/widgets/product_card.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  static const routeName = '/cart';
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    bool isMobileView = we < 800;
    return Scaffold(
      drawer: isMobileView ? AppDrawer() : null,
      appBar: isMobileView
          ? AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Text('EuCart'),
              centerTitle: true,
            )
          : null,
      body: Row(
        children: [
          if (!isMobileView) AppDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: we * 0.7,
                        child: Consumer<CartModel>(
                          builder: (context, cart, child) {
                            var products = [];
                            getProducts().then((value) =>
                                cart.cart.forEach((key, inCart) {
                                  if (inCart) {
                                    ProductModel product = value.firstWhere(
                                        (element) => element.id == key);
                                    setState(() {
                                      products.add(ProductModel(
                                          id: product.id,
                                          title: product.title,
                                          description: product.description,
                                          price: product.price,
                                          image: product.image,
                                          rating: product.rating,
                                          ratingCount: product.ratingCount));
                                    });
                                  }
                                }));

                            return GridView.builder(
                              itemCount: products.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ProductCard(
                                product: products[index],
                                isInCart:
                                    cart.cart[products[index].id] ?? false,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 600,
                                mainAxisExtent: 240,
                              ),
                            );
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
