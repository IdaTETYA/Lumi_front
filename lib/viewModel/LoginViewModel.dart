import 'package:flutter/material.dart';
import '../services/RegisterService.dart';

class LoginViewModel extends ChangeNotifier {
  final RegisterService _registerService = RegisterService();

  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  bool _isSubmitting = false;

  String get email => _email;
  String get password => _password;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isSubmitting => _isSubmitting;

  void setEmail(String value) {
    _email = value;
    _validateEmail();
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _validatePassword();
    notifyListeners();
  }

  void _validateEmail() {
    if (_email.isEmpty) {
      _emailError = 'L\'email est requis';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email)) {
      _emailError = 'Entrez un email valide';
    } else {
      _emailError = null;
    }
  }

  void _validatePassword() {
    if (_password.isEmpty) {
      _passwordError = 'Le mot de passe est requis';
    } else if (_password.length < 6) {
      _passwordError = 'Le mot de passe doit contenir au moins 6 caractères';
    } else {
      _passwordError = null;
    }
  }

  Future<void> login(BuildContext context) async {
    _validateEmail();
    _validatePassword();

    if (_emailError != null || _passwordError != null) {
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    notifyListeners();

    try {
      final data = {
        'email': _email,
        'password': _password,
      };
      await _registerService.login(data); // Appel de l'API via RegisterService
      // Si la connexion réussit, RegisterService stocke déjà les données dans SharedPreferences
      // Naviguer vers LumiScreen
      Navigator.pushReplacementNamed(context, '/lumi');
    } catch (e) {
      // Gérer les erreurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}