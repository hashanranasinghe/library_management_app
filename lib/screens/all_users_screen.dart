import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/models/createaccount.dart';

class AllUsersScreen extends StatefulWidget {
  static const routName = 'all-users-screen';
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  Stream<List<CreateAccount>> allUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => CreateAccount.fromMap(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<CreateAccount>>(
        stream: allUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went to wrong");
          } else if (snapshot.hasData) {
            final books = snapshot.data!;
            return ListView(children: books.map(buildBook).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildBook(CreateAccount user) => ListTile(
        title: Text(user.name.toString()),
      );
}
