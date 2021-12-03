import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(product);
}

class _ProductCardState extends State<ProductCard> {
  final ProductModel product;
  _ProductCardState(this.product);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return Container(
      color: Colors.white,
      height: 240,
      width: width * 0.6,
      child: Row(
        children: [
          Container(
              color: Colors.white,
              height: 120,
              width: 120,
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
              )),
          Container(
            width: width - 120,
            child: Column(
              children: [
                Text(product.title),
                Text(
                  product.description,
                  maxLines: 5,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(product.price),
              ],
            ),
          )
        ],
      ),
    );
  }
}
