import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/constants.dart';
import 'package:pirai_code_challenge/views/Cart/cart.dart';
import 'package:pirai_code_challenge/views/Products/product_view.dart';
import 'package:pirai_code_challenge/widgets/app_drawer.dart';

class Home extends StatefulWidget {
  static const routeName = "Home";
  final startMenuIndex;
  const Home({Key? key, this.startMenuIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _menuIndex = 0;

  List<Widget> _menu = [
    ProductView(),
    CartView(),
  ];

  @override
  void initState() {
    _menuIndex = widget.startMenuIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    bool _isMobileView = isMobileView(we);
    return Scaffold(
      drawer: _isMobileView
          ? drawer()
          : null,
      appBar: _isMobileView
          ? AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Text('EuCart'),
              centerTitle: true,
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_isMobileView)
            drawer(),
          Expanded(child: _menu[_menuIndex]),
        ],
      ),
    );
  }

  Widget drawer()=> AppDrawer(
              selectedIndex: _menuIndex,
              onMenuClicked: (int index) {
                setState(() {
                  _menuIndex = index;
                });
              },
            );
}
