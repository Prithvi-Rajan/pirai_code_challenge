import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pirai_code_challenge/constants.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/views/home.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<CartModel>(builder: (context, cart, child) {
        if (cart.products.isEmpty)
          return Center(
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Your Cart is empty."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, Home.routeName);
                      },
                      icon: Icon(Icons.list),
                      label: Text(
                        "Browse Catalogue",
                      ),
                    ),
                  )
                ],
              ),
            )),
          );
        else
          return LayoutBuilder(builder: (context, constraints) {
            var we = constraints.maxWidth;
            bool _isMobileView = isMobileView(we);

            if(_isMobileView)
            return SingleChildScrollView(
              child: Column(
                children: [
                  total(cart),
                  cartItems(cart),
                ],
            
              ),
            );
            else
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: cartItems(cart),
                ),
                Expanded(
                  child: total(cart),
                )
              ],
            );
          });
      }),
    );
  }

  Widget cartItems(CartModel cart) {
    return GridView.builder(
      controller: ScrollController(),
      itemCount: cart.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => ProductCard(
        key: ValueKey(cart.products[index].id.toString()),
        product: cart.products[index],
        isInCart: cart.isProductInCart(cart.products[index]),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 1200,
        mainAxisExtent: 240,
      ),
    );
  }

  Widget total(CartModel cartModel) {
    final productsInCart = cartModel.products;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: productsInCart.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(productsInCart[index].title),
                  trailing: Text('\$ ${productsInCart[index].price}'),
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Net Total",
                    style: Theme.of(context).textTheme.headline6),
                trailing: Text(
                  '\$ ${cartModel.total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        //TODO
                      },
                      icon: Icon(Icons.card_giftcard),
                      label: Text("Checkout")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
