import 'dart:convert';
import 'package:flutter/services.dart';

class AuthService {
  List<dynamic> _users = [];

  Future<void> _loadUserData() async {
    final String response = await rootBundle.loadString('assets/mock_users.json');
    _users = json.decode(response);
  }

  Future<bool> authenticate(String username, String password) async {
    if (_users.isEmpty) {
      await _loadUserData();
    }
    for (var user in _users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }
}
