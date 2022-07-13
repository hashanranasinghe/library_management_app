class AddBook {
  String? uid;
  String? bName;
  String? bAuthorName;
  String? bCategory;
  String? bDescription;
  String? bAddDate;
  String? bCount;
  String? bImageUrl;

  AddBook(
      {this.uid,
      this.bName,
      this.bAuthorName,
      this.bCategory,
      this.bDescription,
      this.bAddDate,
      this.bCount,
      this.bImageUrl});

  factory AddBook.fromMap(map) {
    return AddBook(
        uid: map['uid'],
        bName: map['bName'],
        bAuthorName: map['bAuthorName'],
        bCategory: map['bCategory'],
        bDescription: map['bDescription'],
        bAddDate: map['bAddDate'],
        bCount: map['bCount'],
        bImageUrl: map['bImageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'bName': bName,
      'bAuthorName': bAuthorName,
      'bCategory': bCategory,
      'bDescription': bDescription,
      'bAddDate': bAddDate,
      'bCount': bCount,
      'bImageUrl': bImageUrl
    };
  }
}
