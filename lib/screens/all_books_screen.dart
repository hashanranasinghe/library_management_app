import 'package:flutter/material.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({Key? key}) : super(key: key);
  static const routName = 'all-books-screen';

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("All Books"),
          Card(
            child: Column(
              children: [
                Image.network("https://firebasestorage.googleapis.com/v0/b/library-app-f8365.appspot.com/o/files%2FIMG_20220630_084733.jpg?alt=media&token=98aba0b1-e2b1-4e00-96de-252a01265302",
                width: 100,
                height: 100,),
                Text("First Book")

              ],
            ),
          )
        ],
      ),
    );
  }
}
