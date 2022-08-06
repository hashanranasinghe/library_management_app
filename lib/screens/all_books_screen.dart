import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/screens/all_users_screen.dart';
import 'package:library_management_app/screens/category_screen.dart';
import 'package:library_management_app/screens/profile_screen.dart';
import 'package:library_management_app/widgets/book_card.dart';
import 'package:library_management_app/widgets/bottom_navigationbar.dart';
import 'package:library_management_app/widgets/drawer_widget.dart';
import 'package:library_management_app/widgets/topwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({Key? key}) : super(key: key);
  static const routName = 'all-books-screen';

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  void didChangeDependencies() {
    getBookList();
    getValidationData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Object> _bookList;
  bool isLoading = true;
  String? finalEmail;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return finalEmail != "test@gmail.com"
        ? Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            drawer: DrawerWidget(
              scaffoldKey: _scaffoldKey,
            ),
            body: Column(
              children: [
                TopScreenWidget(
                    scaffoldKey: _scaffoldKey,
                    topLeft: SizedBox(
                      height: 50,
                      width: 50,
                    )),
                isLoading == false
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _bookList.length,
                        itemBuilder: (context, index) {
                          return BookCard(
                              change: "change",
                              addBook: _bookList[index] as AddBook,
                              index: index.toString());
                        })
                    : Center(child: const CircularProgressIndicator())
              ],
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                isLoading == false
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _bookList.length,
                        itemBuilder: (context, index) {
                          return BookCard(
                              change: "change",
                              addBook: _bookList[index] as AddBook,
                              index: index.toString());
                        })
                    : const Center(child: CircularProgressIndicator())
              ],
            ),
          );
  }

  Future getBookList() async {
    var data = await FirebaseFirestore.instance.collection("books").get();
    setState(() {
      _bookList = List.from(data.docs.map((doc) => AddBook.fromMap(doc)));
      isLoading = false;
    });
  }
}
