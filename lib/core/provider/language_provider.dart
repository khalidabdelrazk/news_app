import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  final String _languageKey = 'lang';
  String _selectedLang = 'en';
  late SharedPreferences _pref;

  final List<String> _possibleLang = [
    'ar',
    'de',
    'en',
    'es',
    'fr',
  ];

  String get selectedLanguage => _selectedLang;
  List<String> get possibleLang => _possibleLang;

  LanguageProvider() {
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    _pref = await SharedPreferences.getInstance();
    _selectedLang = _pref.getString(_languageKey) ?? 'en';
  }

  void setLang(String string) {
    _pref.setString(_languageKey, string);
    _selectedLang = string;
    notifyListeners();
  }
}
