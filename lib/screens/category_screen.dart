import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/screens/category_book_screen.dart';
import 'package:library_management_app/widgets/card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routName = 'category-screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CardView(
                    topic: "Action and Adventure",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: 'Action and Adventure',
                            ),
                          ));
                    }),
                CardView(
                    topic: "Classics",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Classics",
                            ),
                          ));
                    }),
              ],
            ),
            Row(
              children: [
                CardView(
                    topic: "Comic Book or Graphic Novel",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Comic Book or Graphic Novel",
                            ),
                          ));
                    }),
                CardView(
                    topic: "Detective and Mystery",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Detective and Mystery",
                            ),
                          ));
                    }),
              ],
            ),
            Row(
              children: [
                CardView(
                    topic: "Fantasy",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Fantasy",
                            ),
                          ));
                    }),
                CardView(
                    topic: "Historical Fiction",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Historical Fiction",
                            ),
                          ));
                    }),
              ],
            ),
            Row(
              children: [
                CardView(
                    topic: "Horror",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Horror",
                            ),
                          ));
                    }),
                CardView(
                    topic: "Literary Fiction",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryBooksScreen(
                              text: "Literary Fiction",
                            ),
                          ));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
