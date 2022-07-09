import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/models/createaccount.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/widgets/button.dart';

class ProvideBookScreen extends StatefulWidget {
  const ProvideBookScreen({Key? key}) : super(key: key);
  static const routName = 'provide-book-screen';

  @override
  State<ProvideBookScreen> createState() => _ProvideBookScreenState();
}

Future<List<CreateAccount>> getUserSuggestion(String query) async {
  QuerySnapshot qn = await FirebaseFirestore.instance.collection("users").get();
  final List users = qn.docs;
  try {
    return users.map((doc) => CreateAccount.fromMap(doc)).where((user) {
      final nameLower = user.name.toString().toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  } catch (e) {
    print(e);
    throw e;
  }
}

Future<List<AddBook>> getBookSuggestion(String query) async {
  QuerySnapshot qu = await FirebaseFirestore.instance.collection("books").get();
  final List books = qu.docs;
  return books.map((json) => AddBook.fromMap(json)).where((book) {
    final nameLower = book.bName.toString().toLowerCase();
    final queryLower = query.toLowerCase();
    return nameLower.contains(queryLower);
  }).toList();
}

class _ProvideBookScreenState extends State<ProvideBookScreen> {
  final TextEditingController typeAheadUserController = TextEditingController();
  final TextEditingController typeAheadBookController = TextEditingController();
  String? datePick;
  String? returnDatePick;
  DateTime date = DateTime(2022, 12, 24);
  String? id;
  String? name;
  String? imageUrl;
  String? selectBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Provide a Book"),
          SizedBox(
            height: 50,
          ),
          TypeAheadField<CreateAccount?>(
            textFieldConfiguration:
                TextFieldConfiguration(controller: typeAheadUserController),
            suggestionsCallback: getUserSuggestion,
            itemBuilder: (context, CreateAccount? suggestion) {
              final user = suggestion!;
              return ListTile(
                title: Text(user.name.toString()),
              );
            },
            hideSuggestionsOnKeyboardHide: false,
            debounceDuration: Duration(milliseconds: 500),
            noItemsFoundBuilder: (context) => Container(
              height: 100,
              child: Center(
                child: Text("No User found."),
              ),
            ),
            onSuggestionSelected: (CreateAccount? suggestion) {
              final user = suggestion!;
              setState(() {
                id = user.id.toString();
                name = user.name.toString();
              });

              typeAheadUserController.text = user.name.toString();
            },
          ),
          TypeAheadField<AddBook?>(
            textFieldConfiguration:
                TextFieldConfiguration(controller: typeAheadBookController),
            suggestionsCallback: getBookSuggestion,
            itemBuilder: (context, AddBook? suggestion) {
              final book = suggestion!;
              return ListTile(
                title: Text(book.bName.toString()),
              );
            },
            hideSuggestionsOnKeyboardHide: false,
            debounceDuration: Duration(milliseconds: 500),
            noItemsFoundBuilder: (context) => Container(
              height: 100,
              child: Center(
                child: Text("No book found."),
              ),
            ),
            onSuggestionSelected: (AddBook? suggestion) {
              final book = suggestion!;
              setState(() {
                selectBook = book.bName.toString();
                imageUrl = book.bImageUrl.toString();
              });
              typeAheadBookController.text = book.bName.toString();
            },
          ),
          Container(
            child: TextFormField(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                var rDate = new DateTime(date.year, date.month, date.day + 14);
                print(rDate);

                if (newDate == null) return;
                setState(() {
                  datePick =
                      "${newDate.year.toString()}-${newDate.month.toString()}-${newDate.day.toString()}";
                  returnDatePick = "${rDate.year.toString()}-${rDate.month.toString()}-${rDate.day.toString()}";
                });
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
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ButtonField(
        function: () {
          provideBook(id, name, selectBook, datePick, imageUrl, returnDatePick);
          provideBookAdmin(
              id, name, selectBook, datePick, imageUrl, returnDatePick);
        },
        text: "Provide");
  }

  Future provideBook(String? uid, String? name, String? bookName, String? date,
      String? imageUrl, String? returnDate) async {
    final pBook = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('provideBooks')
        .doc();

    final books = ProvideBook(
      pid: uid,
      pUserName: name,
      pBookName: bookName,
      pBookImageUrl: imageUrl,
      pReturnDate: returnDate,
      pDate: date,
    );

    final json = books.toMap();

    await pBook.set(json).whenComplete(() => Fluttertoast.showToast(
        msg: 'Provide Successfully', toastLength: Toast.LENGTH_LONG));
    print(uid);
    print(name);
  }

  Future provideBookAdmin(String? uid, String? name, String? bookName,
      String? date, String? imageUrl, String? returnDate) async {
    final pBook = FirebaseFirestore.instance.collection('provideBooks').doc();

    final books = ProvideBook(
      pid: uid,
      pUserName: name,
      pBookName: bookName,
      pBookImageUrl: imageUrl,
      pReturnDate: returnDate,
      pDate: date,
    );

    final json = books.toMap();

    await pBook.set(json);
  }
}
