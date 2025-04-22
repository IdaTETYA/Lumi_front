import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  static const String baseUrl = 'http://192.168.100.40:8000/api';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<bool> checkEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/verifierEmail'),
        headers: _headers,
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['exists'] == true;
      } else {
        throw Exception('Erreur lors de la vérification de l\'email: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  /// Enregistre un nouveau patient
  Future<Map<String, dynamic>> registerPatient(Map<String, dynamic> patientData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/patient'),
        headers: _headers,
        body: jsonEncode(patientData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        final errorData = jsonDecode(response.body);
        final errors = errorData['errors'] as Map<String, dynamic>;
        String errorMessage = errors.entries
            .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
            .join('; ');
        throw Exception(errorMessage);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Erreur lors de l\'inscription');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  Future<Map<String, dynamic>> registerMedecin(Map<String, dynamic> medecinData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/medecin'),
        headers: _headers,
        body: jsonEncode(medecinData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        final errorData = jsonDecode(response.body);
        final errors = errorData['errors'] as Map<String, dynamic>;
        String errorMessage = errors.entries
            .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
            .join('; ');
        throw Exception(errorMessage);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Erreur lors de l\'inscription');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: _headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Stocker les données utilisateur après un login réussi
        await saveUserData(responseData);
        return responseData;
      } else {
        throw Exception('Échec de la connexion: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  // Stocker les données utilisateur dans SharedPreferences
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', userData['token'] ?? '');
    await prefs.setString('user_email', userData['user']['email'] ?? '');
    await prefs.setString('user_id', userData['user']['id_user'].toString() ?? '');
    await prefs.setString('user_name', userData['user']['nom'] ?? '');
  }

  // Récupérer l'email de l'utilisateur courant
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // Récupérer le nom de l'utilisateur courant
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  // Récupérer l'ID de l'utilisateur courant
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  // Récupérer le token de l'utilisateur courant
  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  // Déconnexion : Supprimer les données utilisateur
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_email');
    await prefs.remove('user_id');
    await prefs.remove('user_name');
  }
}