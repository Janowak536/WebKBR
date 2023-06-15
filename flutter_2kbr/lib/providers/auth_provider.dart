import 'package:flutter/widgets.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool isAdmin = false;
  int? _clientId = 0;
  int? get clientId => _clientId;

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString('jwt') != null;
    isAdmin = await ApiService().isAdmin();
    _clientId = prefs.getInt('clientId'); // Odczytanie clientId
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.setBool('isAdmin', false);
    await prefs.remove('clientId'); // Usunięcie clientId przy wylogowaniu
    _isLoggedIn = false;
    isAdmin = false;
    _clientId = null; // Ustawienie clientId na null
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
