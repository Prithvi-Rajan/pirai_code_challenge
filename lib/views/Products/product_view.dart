import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pirai_code_challenge/animation/fade_animation.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/utilitiy_functions.dart';
import 'package:pirai_code_challenge/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  static const routeName = 'ProductView';
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List products = [];
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    products = await getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            // width: we,
            // height: he,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                    delay: 0.8,
                    child: Text(
                      'Welcome, ${Provider.of<UserModel>(context, listen: false).currentUser?.displayName}',
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          letterSpacing: 2),
                    ),
                  ),
                  Container(
                    width: we * 0.6,
                    child: ListView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          ProductCard(product: products[index]),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
