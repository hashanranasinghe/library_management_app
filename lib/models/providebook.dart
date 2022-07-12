import 'package:cloud_firestore/cloud_firestore.dart';

class ProvideBook {
  String? pid;
  String? pUserName;
  String? pBookName;
  String? pBookImageUrl;
  DateTime? pDate;
  DateTime? pReturnDate;

  ProvideBook({this.pid, this.pUserName, this.pBookName, this.pDate,this.pBookImageUrl,this.pReturnDate});

  factory ProvideBook.fromMap(map) {
    return ProvideBook(
        pid: map['pid'],
        pUserName: map['pUserName'],
        pBookName: map['pBookName'],
        pBookImageUrl: map['pBookUrl'],
        pReturnDate: (map['pReturnDate'] as Timestamp).toDate() ,
        pDate: (map['pDate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'pUserName': pUserName,
      'pBookName': pBookName,
      'pBookUrl' : pBookImageUrl,
      'pReturnDate': pReturnDate,
      'pDate': pDate,
    };
  }
}
