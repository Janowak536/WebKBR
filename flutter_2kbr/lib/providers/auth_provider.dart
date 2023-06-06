import 'package:flutter/widgets.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool isAdmin = false;
  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString('jwt') != null;
    isAdmin = await ApiService().isAdmin();
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.setBool(
        'isAdmin', false); // Set isAdmin value to false on logout
    _isLoggedIn = false;
    isAdmin = false; // Update the isAdmin value in the provider
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
