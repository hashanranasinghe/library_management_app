import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/models/provider.dart';
import 'package:provider/provider.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({Key? key}) : super(key: key);
  static const routName = 'all-books-screen';




  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {

  Stream<List<AddBook>> allBooks()=> FirebaseFirestore.instance
      .collection("books").snapshots().
  map((snapshot) => snapshot.docs.map((doc) => AddBook.fromMap(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<AddBook>>(
        stream: allBooks(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Something went to wrong");
          }else if(snapshot.hasData){
            final books = snapshot.data!;
            return ListView(
              children: books.map(buildBook).toList()
            );
          }else{
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
