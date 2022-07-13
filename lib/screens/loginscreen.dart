import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/api/validator.dart';
import 'package:library_management_app/screens/admin_home_screen.dart';
import 'package:library_management_app/screens/all_books_screen.dart';
import 'package:library_management_app/screens/signup_screen.dart';
import 'package:library_management_app/widgets/button.dart';
import 'package:library_management_app/widgets/input_field.dart';
import 'package:library_management_app/widgets/input_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome back!"),
            _buildEmail(),
            _buildPassword(),
            _buildLoginButton(),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account ?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'InriaSans',
                        fontWeight: FontWeight.bold)),
                TextButton(
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignupScreen.routName);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return InputField(
        controller: emailController,
        textInputType: TextInputType.emailAddress,
        text: "Email",
        function: Validator.emailValidate);
  }

  Widget _buildPassword() {
    return InputPasswordField(
      textEditingController: passwordController,
      text: "Password",
      function: Validator.passwordValidate,
    );
  }

  Widget _buildLoginButton() {
    return ButtonField(
        function: () async {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', emailController.text);
          signIn(emailController.text, passwordController.text);
        },
        text: "Sign In");
  }

  Future<void> signIn(String email, String password) async {
    if (_form.currentState!.validate()) {
      print(email);
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successfully"),
                if (email == "test@gmail.com")
                  {
                    Navigator.of(context)
                        .pushReplacementNamed(AdminHomeScreen.routName),
                  }
                else
                  {
                    Navigator.of(context)
                        .pushReplacementNamed(AllBooksScreen.routName),
                  }
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: 'Incorrect Email or Password.',
            toastLength: Toast.LENGTH_LONG);
      });
    }
  }
}
