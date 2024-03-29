import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/all_users_screen.dart';
import 'package:library_management_app/screens/category_screen.dart';
import 'package:library_management_app/screens/profile_screen.dart';
import 'package:library_management_app/screens/provide_book_list_screen.dart';
import 'package:library_management_app/screens/provide_book_screen.dart';
import 'package:library_management_app/widgets/bottom_navigationbar.dart';
import 'package:library_management_app/widgets/card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static const routName = 'admin-home-screen';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Object> _list = [];

  Future getData() async {
    var data = await FirebaseFirestore.instance.collection("books").get();
    setState(() {
      _list = List.from(data.docs.map((doc) => AddBook.fromMap(doc)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView(
                  topic: "All Books",
                  icon: Icons.book_outlined,
                  function: () {
                    Navigator.of(context).pushNamed(BottomNavigation.routName);
                  },
                ),
                CardView(
                  topic: "Category",
                  icon: Icons.category_outlined,
                  function: () {
                    Navigator.of(context).pushNamed(CategoryScreen.routName);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView(
                  topic: "Users",
                  icon: Icons.supervised_user_circle_sharp,
                  function: () {
                    Navigator.of(context).pushNamed(AllUsersScreen.routName);
                  },
                ),
                CardView(
                  topic: "Add Book",
                  icon: Icons.add_box_outlined,
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBookScreen(text: "user"),
                        ));
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView(
                  topic: "Profile",
                  icon: Icons.supervised_user_circle_sharp,
                  function: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                ),
                CardView(
                  topic: "Provide book",
                  icon: Icons.supervised_user_circle_sharp,
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProvideBookScreen(
                            text: 'add',
                          ),
                        ));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView(
                  topic: "Provide",
                  icon: Icons.supervised_user_circle_sharp,
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProvideBooksListScreen(text: "admin"),
                        ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
