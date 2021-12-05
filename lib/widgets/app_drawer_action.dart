import 'package:flutter/material.dart';

class AppDrawerAction extends StatelessWidget {
  final String title;
  final Function onClick;
  final Widget icon;

  AppDrawerAction(
      {required this.title, required this.onClick, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      leading: icon,
      onTap: () => onClick,
    );
  }
}
