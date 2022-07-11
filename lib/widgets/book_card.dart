import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/widgets/details_dialog.dart';
import 'package:library_management_app/widgets/list_card_field.dart';

class BookCard extends StatefulWidget {
  final ProvideBook? provideBook;
  final AddBook? addBook;
  final String? index;
  final String? change;
  const BookCard(
      {Key? key, this.provideBook, this.index, this.addBook, this.change})
      : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  String? lateDay;
  @override
  void initState() {
    lateDays();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.change.toString() != "change"
        ? ListCardField(
            imageUrl: widget.provideBook!.pBookImageUrl,
            textName: widget.provideBook!.pBookName,
            late: lateDay,
            detailsFunction: () {
              // DetailsDialog.builtDetailsDialog(
              //     context,
              //     widget.provideBook!.pBookImageUrl.toString(),
              //     widget.provideBook!.pUserName.toString(),
              //     widget.provideBook!.pBookName.toString(),
              //     widget.provideBook!.pDate.toString(),
              //     widget.provideBook!.pReturnDate.toString());
              lateDays();
            },
            deleteFunction: () {
              deleteProvideBook(int.parse(widget.index.toString()));
              deleteUserBook(int.parse(widget.index.toString()));
            },
          )
        : ListCardField(
            imageUrl: widget.addBook!.bImageUrl,
            textName: widget.addBook!.bName,
          );
  }

  Future deleteProvideBook(index) async {
    var data =
        await FirebaseFirestore.instance.collection('provideBooks').get();

    await FirebaseFirestore.instance
        .collection("provideBooks")
        .doc(data.docs[index].id)
        .delete();
  }

  Future deleteUserBook(index) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.provideBook!.pid)
        .collection('provideBooks')
        .where(widget.provideBook!.pid.toString())
        .get();

    print(data.docs[int.parse(index)].id.toString());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.provideBook!.pid)
        .collection('provideBooks')
        .doc(data.docs[int.parse(index)].id)
        .delete();
  }

  void lateDays() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    if (widget.provideBook?.pReturnDate.toString() != null) {
      var y =
          int.parse(widget.provideBook!.pReturnDate.toString().substring(0, 4));
      var m =
          int.parse(widget.provideBook!.pReturnDate.toString().substring(5, 6));
      var d =
          int.parse(widget.provideBook!.pReturnDate.toString().substring(7));

      DateTime r = DateTime.parse(
          formatDate(DateTime(y, m, d), [yyyy, '-', mm, '-', dd]));
      var l = date.difference(r).inDays;
      print(date);
      print(r);
      print(l);

      if (l > 0) {
        print("Late");
      } else {
        setState(() {
          lateDay = "You have time";
        });
      }
    }
  }
}
