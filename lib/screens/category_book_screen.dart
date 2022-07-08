import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/models.dart';


class CategoryBooksScreen extends StatefulWidget {
  final String text;
  const CategoryBooksScreen({Key? key, required this.text}) : super(key: key);
  static const routName = 'all-books-screen';

  @override
  State<CategoryBooksScreen> createState() => _CategoryBooksScreenState();
}

class _CategoryBooksScreenState extends State<CategoryBooksScreen> {

  Stream<List<AddBook>> allBooks() {

      return FirebaseFirestore.instance
          .collection("books")
          .where('bCategory', isEqualTo: widget.text)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => AddBook.fromMap(doc.data())).toList());

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<AddBook>>(
        stream: allBooks(),
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

  Widget buildBook(AddBook addBook) => ListTile(
        leading: Image.network(addBook.bImageUrl.toString()),
        title: Text(addBook.bName.toString()),
        subtitle: Text(addBook.bAuthorName.toString()),
      );
}
