import 'package:flutter/material.dart';
import '../services/RegisterService.dart';
import '../models/patient.dart'; // Importez la classe Patient

class RegisterPatientViewModel extends ChangeNotifier {
  int currentStep = 1;
  Patient patient = Patient(); // Instance de Patient pour stocker les données
  bool isSubmitting = false;

  final RegisterService _registerService = RegisterService();

  void setNom(String value) {
    patient.nom = value;
    patient.nomError = value.isEmpty ? 'Le nom est requis' : null;
    notifyListeners();
  }

  void setPrenom(String value) {
    patient.prenom = value;
    patient.prenomError = value.isEmpty ? 'Le prénom est requis' : null;
    notifyListeners();
  }

  void setDateDeNaissance(String value) {
    patient.dateDeNaissance = value;
    patient.dateDeNaissanceError = value.isEmpty ? 'La date de naissance est requise' : null;
    notifyListeners();
  }

  void setSexe(String? value) {
    patient.sexe = value;
    patient.sexeError = value == null ? 'Le sexe est requis' : null;
    notifyListeners();
  }

  void setNumeroTelephone(String value) {
    patient.numeroTelephone = value;
    patient.numeroTelephoneError = value.isEmpty ? 'Le numéro de téléphone est requis' : null;
    notifyListeners();
  }

  void setVille(String value) {
    patient.ville = value;
    patient.villeError = value.isEmpty ? 'La ville est requise' : null;
    notifyListeners();
  }

  void setQuartier(String value) {
    patient.quartier = value;
    patient.quartierError = value.isEmpty ? 'Le quartier est requis' : null;
    notifyListeners();
  }

  Future<void> setEmail(String value) async {
    patient.email = value;
    patient.emailError = null;

    if (patient.email.isEmpty) {
      patient.emailError = 'L\'email est requis';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(patient.email)) {
      patient.emailError = 'L\'email n\'est pas valide';
    } else {
      try {
        final exists = await _registerService.checkEmail(patient.email);
        if (exists) {
          patient.emailError = 'Cet email est déjà utilisé';
        }
      } catch (e) {
        patient.emailError = 'Erreur lors de la vérification de l\'email: $e';
      }
    }

    notifyListeners();
  }

  void setPassword(String value) {
    patient.password = value;
    patient.passwordError = value.isEmpty
        ? 'Le mot de passe est requis'
        : value.length < 8
        ? 'Le mot de passe doit contenir au moins 8 caractères'
        : null;
    notifyListeners();
  }

  void setHasFamilyHistory(bool value) {
    patient.hasFamilyHistory = value;
    notifyListeners();
  }

  void setAccepteConditions(bool value) {
    patient.accepteConditions = value;
    notifyListeners();
  }

  void goToPreviousStep() {
    if (currentStep > 1) {
      currentStep--;
      notifyListeners();
    }
  }

  void canGoToNextStep(int step, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      if (step == 1) {
        if (patient.nomError == null &&
            patient.prenomError == null &&
            patient.dateDeNaissanceError == null &&
            patient.sexeError == null &&
            patient.numeroTelephoneError == null) {
          currentStep++;
          notifyListeners();
        }
      } else if (step == 2) {
        if (patient.villeError == null && patient.quartierError == null && patient.emailError == null) {
          currentStep++;
          notifyListeners();
        }
      }
    }
  }

  Future<void> registerPatient(BuildContext context) async {
    try {
      isSubmitting = true;
      notifyListeners();

      final patientData = patient.toMap();
      print('Données envoyées : $patientData');
      final response = await _registerService.registerPatient(patientData);

      print('Réponse de l\'API : $response');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Inscription réussie')),
      );
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print('Erreur lors de l\'inscription : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Err'
            'eur: $e')),
      );
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  void reset() {
    currentStep = 1;
    patient.reset();
    isSubmitting = false;
    notifyListeners();
  }
}