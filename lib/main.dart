import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/provider.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/screens/loginscreen.dart';
import 'package:library_management_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => BookData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        routes: {
          AdminHomeScreen.routName: (ctx) => const AdminHomeScreen(),
          AddBookScreen.routName: (ctx) => const AddBookScreen(),
          AllBooksScreen.routName: (ctx) => const AllBooksScreen(),
          SignupScreen.routName: (ctx) => const SignupScreen(),
          LoginScreen.routName: (ctx) => const LoginScreen(),


        },
      ),
    );
  }
}
