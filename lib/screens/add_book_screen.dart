import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/api/constant.dart';
import 'package:library_management_app/api/firebase_api.dart';
import 'package:library_management_app/models/models.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/widgets/input_field.dart';
import 'package:library_management_app/api/validator.dart';
import 'package:library_management_app/widgets/button.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);
  static const routName = 'add-book-screen';

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  File? file;
  Uint8List? bytes;
  String? fileName;
  String? datePick;
  UploadTask? task;
  DateTime date = DateTime(2022, 12, 24);
  final selectCategory = [
    "Action and Adventure",
    "Classics",
    "Comic Book or Graphic Novel",
    "Detective and Mystery",
    "Fantasy",
    "Historical Fiction",
    "Horror",
    "Literary Fiction"
  ];
  String? value;

  TextEditingController bNameController = TextEditingController();
  TextEditingController bAuthorController = TextEditingController();
  TextEditingController bDesController = TextEditingController();
  TextEditingController bCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      fileName = file != null ? basename(file!.path) : 'No File Selected';
      datePick == null ? datePick = "Adding Date" : datePick;
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: const Text(
                  "Add Book",
                  style: TextStyle(fontSize: 20),
                )),
            _buildBName(),
            _buildBAuthorName(),
            _buildBDes(),
            Container(
              child: TextFormField(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  if (newDate == null) return;
                  setState(() => datePick =
                      "${newDate.year.toString()}-${newDate.month.toString()}-${newDate.day.toString()}");
                  print(newDate);
                },
                readOnly: true,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  contentPadding: const EdgeInsets.all(5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  hintText: datePick,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            ),
            SizedBox(
              height: 50,
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                width: 315,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 2, color: Colors.black),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  underline: Container(color: Colors.transparent),
                  hint: Text(
                    'Select Category',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  items: selectCategory.map(buildMenuUnit).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                  value: value,
                ),
              ),
            ),
            _buildBCount(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              child: TextButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Select video',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(primaryColor))),
            ),
            SizedBox(height: 8),
            Text(
              fileName!,
              style: TextStyle(
                  color: primaryColor,
                  fontFamily: 'InriaSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBName() {
    return InputField(
      controller: bNameController,
      text: 'Book Name',
      textInputType: TextInputType.name,
      function: Validator.nameValidate,
    );
  }

  Widget _buildBAuthorName() {
    return InputField(
      controller: bAuthorController,
      text: 'Author Name',
      textInputType: TextInputType.name,
      function: Validator.nameValidate,
    );
  }

  Widget _buildBDes() {
    return InputField(
      controller: bDesController,
      text: 'Description',
      textInputType: TextInputType.text,
      function: Validator.nameValidate,
    );
  }

  Widget _buildBCount() {
    return InputField(
      controller: bCountController,
      text: 'Count',
      textInputType: TextInputType.number,
      function: Validator.nameValidate,
    );
  }

  Widget _buildButton(context) {
    return ButtonField(
      text: 'Add',
      function: () {
        uploadFile(context);
      },
    );
  }

  //selecting image
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    final p = result.files.first.bytes;
    setState(() {
      bytes = p;
    });
  }

  //upload the image
  Future uploadFile(context) async {
    if (file == null) return;
    final fileName = basename(file!.path);

    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    final snapshot = await task!.whenComplete(() {
      return Fluttertoast.showToast(
          msg: "Complete", toastLength: Toast.LENGTH_LONG);
    });
    final urlDownload = await snapshot.ref.getDownloadURL();
    addBookAdmin(bNameController.text, bAuthorController.text, value,
        bDesController.text, datePick, bCountController.text, urlDownload);
    print('Download-Link: $urlDownload');
  }

  DropdownMenuItem<String> buildMenuUnit(String cate) => DropdownMenuItem(
        value: cate,
        child: Text(
          cate,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Future addBookAdmin(bName, bAuthorName, bCategory, bDescription, bAddDate,
      bCount, bImageUrl) async {
    final docBook = FirebaseFirestore.instance.collection('books').doc();

    final books = AddBook(
        uid: docBook.id,
        bName: bName,
        bAuthorName: bAuthorName,
        bCategory: bCategory,
        bDescription: bDescription,
        bAddDate: bAddDate,
        bCount: bCount,
        bImageUrl: bImageUrl);

    final json = books.toMap();

    await docBook.set(json);
  }
}
