import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/animation/fade_animation.dart';

class ProductView extends StatefulWidget {
  static const routeName = 'ProductView';
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1A30),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: we,
            height: he,
            child: Column(children: <Widget>[
              FadeAnimation(
                delay: 0.8,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                  width: we * 0.9,
                  height: he * 0.4,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
