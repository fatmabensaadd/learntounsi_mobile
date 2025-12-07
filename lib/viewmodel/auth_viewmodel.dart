import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;
  bool loading = false;
  String? error;

  // Connexion
  Future<void> login(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await _authService.login(email, password);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  // Inscription
  Future<void> register(String email, String password, String username) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await _authService.register(email, password, username);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  // Déconnexion
  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }
}
