import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';
import 'package:library_management_app/screens/loginscreen.dart';
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
      Timer(const Duration(seconds: 3), () {
        if (finalEmail == null) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
        } else {
          Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routName);
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
          Text("Library")
        ],
      ),
    );
  }
}
