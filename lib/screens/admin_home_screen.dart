import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/widgets/card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static const routName = 'admin-home-screen';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home"
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardView(
                topic: "All Books",
              icon: Icons.book_outlined,
              function: (){
                Navigator.of(context).pushReplacementNamed(AllBooksScreen.routName);

              },),
              CardView(topic: "Category",
                icon: Icons.category_outlined,
              function: (){

              },)
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardView(topic: "Users",
                icon: Icons.supervised_user_circle_sharp,
              function: (){

              },),
              CardView(topic: "Add Book",
                icon: Icons.add_box_outlined,
              function: (){
                Navigator.of(context).pushReplacementNamed(AddBookScreen.routName);
              },)
            ],

          )
        ],
      ),


    );
  }
}
