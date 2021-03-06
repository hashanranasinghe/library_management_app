import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/screens/loginscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 5), () {
        if (finalEmail == null) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
        } else if (finalEmail == "test@gmail.com") {
          Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routName);
        } else {
          Navigator.of(context).pushReplacementNamed(AllBooksScreen.routName);
        }
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Library",style: TextStyle(
            fontSize: 60,
            color: primaryColor,
          ),)),
          Lottie.network(
            'https://assets8.lottiefiles.com/packages/lf20_n2yhd0lo.json',
            repeat: true,
          ),
        ],
      ),
    );
  }
}
