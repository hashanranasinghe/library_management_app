import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/models/provider.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/screens/all_users_screen.dart';
import 'package:library_management_app/screens/category_screen.dart';
import 'package:library_management_app/screens/loginscreen.dart';
import 'package:library_management_app/screens/profile_screen.dart';
import 'package:library_management_app/screens/provide_book_list_screen.dart';
import 'package:library_management_app/screens/provide_book_screen.dart';
import 'package:library_management_app/widgets/card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final video = Provider.of<BookData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('email');
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routName);
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
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
                    print(video.bName);
                    Navigator.of(context).pushNamed(AllBooksScreen.routName);
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
                    Navigator.of(context)
                        .pushReplacementNamed(AddBookScreen.routName);
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
                    Navigator.of(context).pushNamed(ProvideBookScreen.routName);
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
