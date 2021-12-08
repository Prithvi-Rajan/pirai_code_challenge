import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/services/products_provider.dart';
import 'package:pirai_code_challenge/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  static const routeName = '/products';
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CartModel, ProductsProvider>(
        builder: (context, cart, pp, child) {
      if (pp.products == null)
        return Center(
          child: SizedBox.square(
              dimension: 60, child: CircularProgressIndicator()),
        );

      if (pp.products!.isEmpty)
        return Center(
          child:
              SizedBox.square(dimension: 60, child: Text("No Products found")),
        );
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: GridView.builder(
          controller: ScrollController(),
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: pp.products!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ProductCard(
            product: pp.products![index],
            isInCart: cart.isProductInCart(pp.products![index]),
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 800,
            mainAxisExtent: 240,
          ),
        ),
      );
    });
  }
}
