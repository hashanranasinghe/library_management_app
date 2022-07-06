import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:library_management_app/models/createaccount.dart';
import 'package:library_management_app/models/models.dart';

class ProvideBookScreen extends StatefulWidget {
  const ProvideBookScreen({Key? key}) : super(key: key);

  @override
  State<ProvideBookScreen> createState() => _ProvideBookScreenState();
}

Future<List<CreateAccount>> getUserSuggestion(String query) async {
  QuerySnapshot qn = await FirebaseFirestore.instance.collection("users").get();
  final List users = qn.docs;
  return users.map((json) => CreateAccount.fromMap(json)).where((user) {
    final nameLower = user.name.toString().toLowerCase();
    final queryLower = query.toLowerCase();
    return nameLower.contains(queryLower);
  }).toList();
}

Future<List<AddBook>> getBookSuggestion(String query) async {
  QuerySnapshot qn = await FirebaseFirestore.instance.collection("books").get();
  final List books = qn.docs;
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
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
        ],
      ),
    );
  }
}
