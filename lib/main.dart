import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/views/LoginFlow/login.dart';
import 'package:pirai_code_challenge/views/Products/product_view.dart';
import 'package:pirai_code_challenge/views/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
        ChangeNotifierProvider<CartModel>(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'EuCart',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF1F1A30),
        ),
        home: SplashScreen(),
        routes: {
          LoginView.routeName: (context) => LoginView(),
          SplashScreen.routeName: (context) => SplashScreen(),
          ProductView.routeName: (context) => ProductView(),
        },
      ),
    );
  }
}
