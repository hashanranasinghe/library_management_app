import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/screens/category_book_screen.dart';
import 'package:library_management_app/screens/loginscreen.dart';
import 'package:library_management_app/screens/profile_screen.dart';
import 'package:library_management_app/screens/provide_book_list_screen.dart';
import 'package:library_management_app/widgets/list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DrawerWidget({required this.scaffoldKey});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              ListTileField(
                  function: () {}, icon: Icons.home_outlined, text: 'Home'),
              ListTileField(
                  function: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ProvideBooksListScreen.routName);

                  },
                  icon: Icons.video_collection_outlined,
                  text: 'Books obtained'),
              ListTileField(
                  function: () {},
                  icon: Icons.video_collection_outlined,
                  text: 'Share Video List'),
              ListTileField(
                  function: () {},
                  icon: Icons.contact_page_outlined,
                  text: 'Contacts'),
              ListTileField(
                  function: () {},
                  icon: Icons.favorite_border,
                  text: 'My Contacts'),
              ListTileField(
                  function: () {
                    Navigator.of(context)
                        .pushNamed(ProfileScreen.routeName);
                  },
                  icon: Icons.person_outline_rounded,
                  text: 'My Profile'),
              ListTileField(
                  function: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routName);
                  },
                  icon: Icons.logout_outlined,
                  text: 'Log Out'),
              Padding(padding: EdgeInsets.only(top: 100)),
              // Stack(
              //   children: [
              //     Positioned(
              //       child: SizedBox(
              //           height: 200, width: 200, child: Image.asset('')),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
