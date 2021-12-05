import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/models/cart_model.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/products_provider.dart';
import 'package:pirai_code_challenge/views/LoginFlow/login.dart';
import 'package:pirai_code_challenge/views/LoginFlow/signup.dart';
import 'package:pirai_code_challenge/views/Splashscreen/splashscreen.dart';
import 'package:pirai_code_challenge/views/home.dart';
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
        ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider()),
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
        ChangeNotifierProxyProvider<UserModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, um, cart) {
            cart ??= CartModel();
            cart.updateUserModel(um);
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'EuCart',
        theme: ThemeData(
          // primarySwatch: Colors.blueGrey,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Color(0xFF0DF5E4),
            textStyle: TextStyle(color: Colors.black)
          )),
          scaffoldBackgroundColor: const Color(0xFF1F1A30),
          // buttonTheme: ButtonThemeData(buttonColor: const Color(0xFF0DF5E4)),
          // iconTheme: IconThemeData(color: const Color(0xFF0DF5E4)),
        ),
        home: SplashScreen(),
        routes: {
          LoginView.routeName: (context) => LoginView(),
          // SplashScreen.routeName: (context) => SplashScreen(),
          Singup.routeName: (context) => Singup(),
          Home.routeName: (context) => Home(),
        },
      ),
    );
  }
}
