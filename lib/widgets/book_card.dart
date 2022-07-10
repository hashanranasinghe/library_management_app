import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/widgets/details_dialog.dart';
import 'package:library_management_app/widgets/list_card_field.dart';

class BookCard extends StatefulWidget {
  final ProvideBook provideBook;
  final String? index;
  const BookCard({Key? key, required this.provideBook, this.index})
      : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return ListCardField(
      imageUrl: widget.provideBook.pBookImageUrl,
      textName: widget.provideBook.pBookName,
      detailsFunction: () {
        DetailsDialog.builtDetailsDialog(
            context,
            widget.provideBook.pBookImageUrl.toString(),
            widget.provideBook.pUserName.toString(),
            widget.provideBook.pBookName.toString(),
            widget.provideBook.pDate.toString(),
            widget.provideBook.pReturnDate.toString());
      },
      deleteFunction: () {
        deleteVideo(int.parse(widget.index.toString()));
      },
    );
  }

  Future deleteVideo(index) async {
    var data =
        await FirebaseFirestore.instance.collection('provideBooks').get();

    await FirebaseFirestore.instance
        .collection("provideBooks")
        .doc(data.docs[index].id)
        .delete();
  }
}
