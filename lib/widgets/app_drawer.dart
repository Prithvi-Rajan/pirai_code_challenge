import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/auth_service.dart';
import 'package:pirai_code_challenge/widgets/app_drawer_action.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _appDrawerActions = [
    AppDrawerAction(
      title: 'Cart',
      onClick: () {},
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
                backgroundColor: const Color(0xFF0DF5E4),
                child: Text(
                  user.currentUser?.displayName?.substring(0, 1) ?? 'U',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cagliostro(
                      fontSize: 48,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.currentUser?.displayName ?? 'User',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                user.currentUser?.email ?? 'test@test.com',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: _appDrawerActions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => _appDrawerActions[index],
              )
            ],
          ),
        ),
      ),
    );
  }
}
