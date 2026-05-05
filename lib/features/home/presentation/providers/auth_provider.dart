import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  void login(String email, String password) {
    // Mock login logic
    _isLoggedIn = true;
    _userName = 'John Doe';
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
