import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString('jwt') != null;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    _isLoggedIn = false;
    notifyListeners();
  }

  void toggleLoginStatus() {
    _isLoggedIn = !_isLoggedIn;
    notifyListeners();
  }

  void refreshLoginStatus() {
    checkLoginStatus();
  }
}
