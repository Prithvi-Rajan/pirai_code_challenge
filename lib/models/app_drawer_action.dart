import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/services/auth_service.dart';

final appDrawerActions = [
  AppDrawerAction(
    title: 'Products',
    icon: Icon(
      Icons.list,
      color: const Color(0xFF0DF5E4),
    ),
  ),
  AppDrawerAction(
    title: 'Cart',
    icon: Icon(
      Icons.shopping_cart_rounded,
      color: const Color(0xFF0DF5E4),
    ),
  ),
  AppDrawerAction(
    title: 'Sign Out',
    onClick: () {
      FirebaseAuthService.signOut();
    },
    icon: Icon(
      Icons.logout_rounded,
      color: const Color(0xFF0DF5E4),
    ),
  )
];

class AppDrawerAction {
  final String title;
  final Function? onClick;
  final Widget icon;

  AppDrawerAction(
      {required this.title,  this.onClick, required this.icon});
}
