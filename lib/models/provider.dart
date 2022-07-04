import 'package:flutter/foundation.dart';

class BookData extends ChangeNotifier {
  String? _bName;
  String? _bAuthorName;
  String? _bCategory;
  String? _bDescription;
  String? _bAddDate;
  String? _bCount;
  String? _bImageUrl;

  void addingData(String bName, String bAuthorName, String bCategory,
      String bDescription, String bAddDate, String bCount, String bImageUrl) {
    _bName = bName;
    _bAuthorName = bAuthorName;
    _bCategory = bCategory;
    _bDescription = bDescription;
    _bAddDate = bAddDate;
    _bCount = bCount;
    _bImageUrl = bImageUrl;
    notifyListeners();
  }

  String? get bName => _bName;
  String? get bAuthorName => _bAuthorName;
  String? get bCategory => _bCategory;
  String? get bDescription => _bDescription;
  String? get bAddDate => _bAddDate;
  String? get bCount => _bCount;
  String? get bImageUrl => _bImageUrl;
}
