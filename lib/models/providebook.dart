class ProvideBook {
  String? pid;
  String? pUserName;
  String? pBookName;
  String? pDate;

  ProvideBook({this.pid, this.pUserName, this.pBookName, this.pDate});

  factory ProvideBook.fromMap(map) {
    return ProvideBook(
        pid: map['pid'],
        pUserName: map['pUserName'],
        pBookName: map['pBookName'],
        pDate: map['pDate']);
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'pUserName': pUserName,
      'pBookName': pBookName,
      'pDate': pDate,
    };
  }
}
