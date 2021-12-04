import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(maxWidth: 240),
        child: Consumer<UserModel>(
          builder: (context, user, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'EuCart',
                style:
                    GoogleFonts.cagliostro(fontSize: 36, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 60,
                child: Text(
                  user.currentUser?.displayName?.substring(0, 1) ?? 'U',
                  style:
                      GoogleFonts.cagliostro(fontSize: 48, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.currentUser?.displayName ?? 'User',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                user.currentUser?.email ?? 'test@test.com',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
