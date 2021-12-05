import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Timer(
        Duration(milliseconds: 3000),
        () => Provider.of<UserModel>(context, listen: false)
            .addAuthStateListener());
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: he * 0.15,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                      width: we * 0.9,
                      height: he * 0.4,
                    ),
                  ),
                  FadeAnimation(
                    delay: 2,
                    child: Text(
                      'EuCart',
                      style: GoogleFonts.cagliostro(
                          fontSize: 36, color: Colors.white),
                    ),
                  ),
                  FadeAnimation(
                    delay: 3,
                    child: Text(
                      'Eur Shopping Experience',
                      style: GoogleFonts.cagliostro(
                          fontSize: 24, color: Colors.grey),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
