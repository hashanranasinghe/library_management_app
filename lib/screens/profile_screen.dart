import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/widgets/drawer_widget.dart';
import 'package:library_management_app/widgets/topwidget.dart';
import '../api/Validator.dart';
import '../widgets/input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = 'Profile screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final userCollection = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  String? detailName;
  String? detailEmail;
  String? detailAge;
  String? detailPhoneNum;
  String? detailAddress;
  String? detailIdNum;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopScreenWidget(
              scaffoldKey: _scaffoldKey,
              topLeft: SizedBox(
                height: 50,
                width: 50,
              )),
          isLoading == true
              ? Column(
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontFamily: 'InriaSans',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildName(),
                    _buildAge(),
                    _buildPhoneNum(),
                    _buildAddress(),
                    _buildIdNum(),
                    _buildEmail(),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextButton(
                          onPressed: () async {
                            updateUserInfo(
                                nameController.text,
                                emailController.text,
                                ageController.text,
                                phoneNumberController.text,
                                idNumberController.text,
                                addressController.text);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Update',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'InriaSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor))),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ],
                ))
        ],
      ),
    );
  }

  Widget _buildName() {
    return InputField(
        text: 'Full Name',
        iconData: Icons.face,
        function: Validator.nameValidate,
        controller: nameController..text = detailName!,
        textInputType: TextInputType.name);
  }

  Widget _buildEmail() {
    return InputField(
      iconData: Icons.email_rounded,
      controller: emailController..text = detailEmail!,
      text: 'User email',
      detail: detailEmail,
      textInputType: TextInputType.emailAddress,
      function: Validator.emailValidate,
    );
  }

  Widget _buildAge() {
    return InputField(
      controller: ageController..text = detailAge!,
      iconData: Icons.calendar_today,
      text: 'Age',
      detail: detailAge,
      textInputType: TextInputType.number,
      function: Validator.age,
    );
  }

  Widget _buildPhoneNum() {
    return InputField(
      iconData: Icons.phone,
      controller: phoneNumberController..text = detailPhoneNum!,
      text: 'Phone Number',
      detail: detailPhoneNum,
      textInputType: TextInputType.number,
      function: Validator.phoneNumber,
    );
  }

  Widget _buildAddress() {
    return InputField(
      iconData: Icons.home,
      controller: addressController..text = detailAddress!,
      text: 'Address',
      detail: detailAddress,
      textInputType: TextInputType.streetAddress,
      function: Validator.nameValidate,
    );
  }

  Widget _buildIdNum() {
    return InputField(
      iconData: Icons.numbers_outlined,
      controller: idNumberController..text = detailIdNum!,
      text: 'Id Number',
      detail: detailIdNum,
      textInputType: TextInputType.number,
      function: Validator.nicValidate,
    );
  }

  Future getCurrentUser() async {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
    String userName = documentSnapshot.get('name');
    String email = documentSnapshot.get('email');
    String age = documentSnapshot.get('age');
    String address = documentSnapshot.get('address');
    String phoneNumber = documentSnapshot.get('number');
    String idNumber = documentSnapshot.get('idNumber');

    setState(() {
      detailName = userName;
      detailEmail = email;
      detailAge = age;
      detailPhoneNum = phoneNumber;
      detailAddress = address;
      detailIdNum = idNumber;

      isLoading = true;
    });
    print(detailEmail);
    print(detailName);
    return [userName, email];
  }

  Future updateUserInfo(String name, String email, String age, String phoneNum,
      String idNum, String address) async {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    return await userCollection.doc(uid).set({
      'id': uid,
      'name': name,
      'email': email,
      'age': age,
      'address': address,
      'number': phoneNum,
      'idNumber': idNum,
    }).whenComplete(() => Fluttertoast.showToast(msg: "uploaded successfully.")
        .whenComplete(() => Navigator.of(context)
            .pushReplacementNamed(ProfileScreen.routeName)));
  }
}
