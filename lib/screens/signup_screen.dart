import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/api/validator.dart';
import 'package:library_management_app/models/createaccount.dart';
import 'package:library_management_app/screens/loginscreen.dart';
import 'package:library_management_app/widgets/button.dart';
import 'package:library_management_app/widgets/input_field.dart';
import 'package:library_management_app/widgets/input_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routName = 'signup-screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _passwordVisible = false;
  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: const Text(
                    "Create Your Account",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  )),
              Form(
                key: _form,
                child: Column(
                  children: [
                    _buildName(),
                    _buildAge(),
                    _buildPhoneNumber(),
                    _buildAddress(),
                    _buildId(),
                    _buildEmail(),
                    _buildPassword(),
                    _buildConfirmPassword(),
                    _buildSignupButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                            fontFamily: 'InriaSans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routName);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return InputField(
        iconData: Icons.face,
        controller: nameController,
        textInputType: TextInputType.name,
        text: "Full Name",
        function: Validator.nameValidate);
  }

  Widget _buildAge() {
    return InputField(
      iconData: Icons.calendar_today,
      controller: ageController,
      textInputType: TextInputType.number,
      text: "Age",
      function: Validator.age,
    );
  }

  Widget _buildPhoneNumber() {
    return InputField(
        iconData: Icons.phone,
        controller: phoneNumberController,
        textInputType: TextInputType.number,
        text: "Phone Number",
        function: Validator.phoneNumber);
  }

  Widget _buildAddress() {
    return InputField(
        iconData: Icons.home,
        controller: addressController,
        textInputType: TextInputType.streetAddress,
        text: "Address",
        function: Validator.nameValidate);
  }

  Widget _buildId() {
    return InputField(
        iconData: Icons.numbers_outlined,
        controller: idNumberController,
        textInputType: TextInputType.number,
        text: "Id Number",
        function: Validator.nicValidate);
  }

  Widget _buildEmail() {
    return InputField(
        iconData: Icons.email_rounded,
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

  Widget _buildConfirmPassword() {
    return Container(
      child: TextFormField(
        controller: confirmPasswordController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (confirmPasswordController.text != passwordController.text) {
            return "Password do not match.";
          }
        },
        obscureText: !_passwordVisible,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          filled: true,
          fillColor: Color(0xFFE3E3E3FF),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFCE0326), width: 2.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            Icons.key,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            color: primaryColor,
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }

  Widget _buildSignupButton() {
    return ButtonField(
        function: () {
          signUp(emailController.text, passwordController.text);
        },
        text: "Sign Up");
  }

  void signUp(String email, String password) async {
    if (_form.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFileStore()})
          .catchError((e) {
        Fluttertoast.showToast(
          msg: 'The email address is already taken.',
          toastLength: Toast.LENGTH_LONG,
        );
      });
    }
  }

  postDetailsToFileStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CreateAccount createAccount = CreateAccount();
    //writing all values
    createAccount.name = nameController.text;
    createAccount.age = ageController.text;
    createAccount.number = phoneNumberController.text;
    createAccount.address = addressController.text;
    createAccount.idNumber = idNumberController.text;
    createAccount.email = user!.email;
    createAccount.id = user.uid;

    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(createAccount.toMap());

    //Fluttertoast.showToast(msg: "Account created successfully.");
    Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
  }
}
