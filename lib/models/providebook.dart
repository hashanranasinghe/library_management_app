class ProvideBook {
  String? pid;
  String? pUserName;
  String? pBookName;
  String? pBookImageUrl;
  String? pDate;
  String? pReturnDate;

  ProvideBook({this.pid, this.pUserName, this.pBookName, this.pDate,this.pBookImageUrl,this.pReturnDate});

  factory ProvideBook.fromMap(map) {
    return ProvideBook(
        pid: map['pid'],
        pUserName: map['pUserName'],
        pBookName: map['pBookName'],
        pBookImageUrl: map['pBookUrl'],
        pReturnDate: map['pReturnDate'],
        pDate: map['pDate']);
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
