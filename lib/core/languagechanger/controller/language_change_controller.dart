// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageChangeController with ChangeNotifier {
//   Locale? _appLocale;
//   Locale? get appLocale => _appLocale;

//   Future<void> loadLanguage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String? languageCode = sp.getString('language_code');
//     if (languageCode != null) {
//       _appLocale = Locale(languageCode);
//       notifyListeners();
//     } else {
//       _appLocale = const Locale('en');
//       notifyListeners();
//     }
//   }

//   void changeLanguage(Locale type) async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     _appLocale = type;
//     await sp.setString('language_code', type.languageCode);
//     notifyListeners();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  Future<void> loadLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');
    _appLocale =
        languageCode != null ? Locale(languageCode) : const Locale('en');
    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', type.languageCode);
    _appLocale = type;
    notifyListeners();
  }

  // 🔥 دالة جديدة
  void setInitialLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }
}
