import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final isInCart;
  const ProductCard({Key? key, required this.product, this.isInCart})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(product);
}

class _ProductCardState extends State<ProductCard> {
  final ProductModel product;

  _ProductCardState(this.product);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF0DF5E4).withOpacity(0.7),
                    offset: Offset(0, 3),
                    blurRadius: 6)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 180,
                          width: 180,
                          imageUrl: product.image),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Provider.of<CartModel>(context,
                                              listen: false)
                                          .updateCart(product);
                                    },
                                    child: widget.isInCart
                                        ? Icon(
                                            Icons.check_circle_outline,
                                            color: const Color(0xFF0DF5E4),
                                          )
                                        : Icon(
                                            Icons.add_circle_outline_rounded,
                                          ))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    // padding: const EdgeInsets.only(
                                    //     left: 32.0, top: 8.0, bottom: 8.0),
                                    child: Text(
                                      '\$ ${product.price}',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // padding: const EdgeInsets.only(
                                    //     left: 32.0, top: 8.0, bottom: 8.0),
                                    child: Text(
                                      '${product.rating}/5 (${product.ratingCount})',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          )),
    );
  }
}
