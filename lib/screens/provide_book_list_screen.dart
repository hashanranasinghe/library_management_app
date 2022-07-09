import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/widgets/details_dialog.dart';

class ProvideBooksListScreen extends StatefulWidget {
  const ProvideBooksListScreen({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  State<ProvideBooksListScreen> createState() => _ProvideBooksListScreenState();
}

class _ProvideBooksListScreenState extends State<ProvideBooksListScreen> {
  final _auth = FirebaseAuth.instance;

  Stream<List<ProvideBook>> provideBooks() {
    User? user = _auth.currentUser;
    final uid = user!.uid;

    if (widget.text == "user") {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('provideBooks')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProvideBook.fromMap(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection("provideBooks")
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProvideBook.fromMap(doc.data()))
              .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProvideBook>>(
        stream: provideBooks(),
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

  Widget buildBook(ProvideBook provideBook) => ListTile(
      title: Text(provideBook.pBookName.toString()),
      subtitle: Text(provideBook.pDate.toString()),
      trailing: widget.text == "admin"
          ? IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                DetailsDialog.builtDetailsDialog(
                    context,
                    provideBook.pBookImageUrl.toString(),
                    provideBook.pUserName.toString(),
                    provideBook.pBookName.toString(),
                    provideBook.pDate.toString(),
                    provideBook.pReturnDate.toString());
              },
            )
          : Container(
              width: 1,
            ));
}
