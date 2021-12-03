import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/animation/fade_animation.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<UserModel>(context, listen: false).addAuthStateListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
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
