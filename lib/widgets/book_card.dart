import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management_app/models/models.dart';
import 'package:library_management_app/models/providebook.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/provide_book_screen.dart';
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
  String? punishment;
  String? days;
  String? docId;
  @override
  void initState() {
    lateDays();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.change.toString() == "change"
        ? ListCardField(
            imageUrl: widget.addBook!.bImageUrl,
            textName: widget.addBook!.bName,
      detailsFunction: (){
              print(widget.addBook!.uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    AddBookScreen(text: widget.addBook!.uid.toString()),
                  ));
      },

          )
        : widget.change.toString() == "user"
            ? ListCardField(
                imageUrl: widget.provideBook!.pBookImageUrl,
                textName: widget.provideBook!.pBookName,
                late: lateDay,
                detailsFunction: () {
                  DetailsDialog.builtDetailsDialog(
                      context,
                      widget.provideBook!.pBookImageUrl.toString(),
                      widget.provideBook!.pUserName.toString(),
                      widget.provideBook!.pBookName.toString(),
                      "${widget.provideBook!.pDate?.year}-${widget.provideBook!.pDate?.month}-${widget.provideBook!.pDate?.day}",
                      "${widget.provideBook!.pReturnDate?.year}-${widget.provideBook!.pReturnDate?.month}-${widget.provideBook!.pReturnDate?.day}",
                      days,
                      punishment);
                },
              )
            : ListCardField(
                imageUrl: widget.provideBook!.pBookImageUrl,
                textName: widget.provideBook!.pBookName,
                late: lateDay,
                detailsFunction: () {
                  DetailsDialog.builtDetailsDialog(
                      context,
                      widget.provideBook!.pBookImageUrl.toString(),
                      widget.provideBook!.pUserName.toString(),
                      widget.provideBook!.pBookName.toString(),
                      "${widget.provideBook!.pDate?.year}-${widget.provideBook!.pDate?.month}-${widget.provideBook!.pDate?.day}",
                      "${widget.provideBook!.pReturnDate?.year}-${widget.provideBook!.pReturnDate?.month}-${widget.provideBook!.pReturnDate?.day}",
                      days,
                      punishment);
                },
                deleteFunction: () {
                  deleteProvideBook(int.parse(widget.index.toString()));
                  deleteUserBook(int.parse(widget.index.toString()));
                },
      updateFunction: () async{
        FirebaseFirestore.instance
            .collection('provideBooks')
            .where('pid', isEqualTo: widget.provideBook!.pid)
            .get()
            .then((value) {
          for (var element in value.docs) {
            print(element.id);
            setState((){
              docId = element.id;
            });
          }
        });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProvideBookScreen(text: docId),
            ));
      },
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

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.provideBook!.pid)
        .collection('provideBooks')
        .doc(data.docs[index].id)
        .delete()
        .whenComplete(() => Fluttertoast.showToast(
            msg: 'Delete Successfully', toastLength: Toast.LENGTH_LONG));
  }

  void lateDays() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    if (widget.provideBook?.pReturnDate != null) {
      var l =
          date.difference(widget.provideBook?.pReturnDate as DateTime).inDays;
      print(date);
      print(l);
      print(widget.provideBook?.pReturnDate.toString());

      if (l > 0) {
        var total = 0;
        for (var i = 0; i <= l; i++) {
          total = total + 20;
        }
        print(total);
        setState(() {
          days = l.toString();
          punishment = total.toString();
          lateDay = "Late";
        });

        print("Late");
      } else {

        setState(() {

          lateDay = "You have time";
        });
      }
    }
  }
}
