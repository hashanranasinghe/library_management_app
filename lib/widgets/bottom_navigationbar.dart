import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/screens/all_users_screen.dart';
import 'package:library_management_app/screens/category_screen.dart';
import 'package:library_management_app/screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routName = 'nav-screen';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 2;
  final screens = [const AdminHomeScreen(), const CategoryScreen(), const AllBooksScreen(), const AllUsersScreen(),const ProfileScreen()];
  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.category_outlined,
      size: 30,
    ),
    Icon(
      Icons.book_outlined,
      size: 30,
    ),
    Icon(
      Icons.group,
      size: 30,
    ),
    Icon(
      Icons.face,
      size: 30,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: primaryColor,
          backgroundColor: Colors.transparent,
          index: index,
          height: 60,
          items: items,
          onTap: (index) {
            setState(() => this.index = index);
          },
        ),
      ),
    );
  }
}
