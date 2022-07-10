import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/widgets/book_card.dart';

class ProvideBooksListScreen extends StatefulWidget {
  const ProvideBooksListScreen({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  State<ProvideBooksListScreen> createState() => _ProvideBooksListScreenState();
}

class _ProvideBooksListScreenState extends State<ProvideBooksListScreen> {


  late List<Object> _provideBookList;
  bool isLoading = true;
  final _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getProvideBookList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == false?
            ListView.builder(
            itemCount: _provideBookList.length,
            itemBuilder: (context, index) {
              return BookCard(
                  provideBook: _provideBookList[index] as ProvideBook,
                  index: index.toString());
            }):Center(child: const CircularProgressIndicator()));
  }

  Future getProvideBookList() async {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    if(widget.text == "admin"){
      var data =
      await FirebaseFirestore.instance.collection("provideBooks").get();
      setState(() {
        _provideBookList =
            List.from(data.docs.map((doc) => ProvideBook.fromMap(doc)));
        isLoading = false;
      });
    }else{
      var data =
      await FirebaseFirestore.instance.collection("provideBooks").doc(uid).collection("provideBooks").get();
      setState(() {
        _provideBookList =
            List.from(data.docs.map((doc) => ProvideBook.fromMap(doc)));
        isLoading = false;
      });
    }



  }
}
