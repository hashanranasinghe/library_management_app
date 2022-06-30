import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';import 'package:library_management_app/screens/all_books_screen.dart';



Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AdminHomeScreen(),
      routes: {
        AdminHomeScreen.routName: (ctx) => const AdminHomeScreen(),
        AddBookScreen.routName: (ctx) => const AddBookScreen(),
        AllBooksScreen.routName: (ctx) => const AllBooksScreen(),
      },
    );
  }
}


