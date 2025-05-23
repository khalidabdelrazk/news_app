import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier{
  bool _showSearch = false;
  bool _isSearching = false;
  get showSearch => _showSearch;
  get isSearching => _isSearching;
  void search(bool val){
    if (_showSearch != val) {
      _showSearch = val;
      _isSearching = val;
      notifyListeners();
    }
  }
}