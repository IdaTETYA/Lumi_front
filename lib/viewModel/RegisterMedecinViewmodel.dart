import 'package:flutter/material.dart';
import '../models/medecin.dart';
import '../services/RegisterService.dart';

class RegisterMedecinViewModel extends ChangeNotifier {
  int currentStep = 1;
  Medecin medecin = Medecin();
  bool isSubmitting = false;

  final RegisterService _registerService = RegisterService();

  void setNom(String value) {
    medecin.nom = value;
    medecin.nomError = value.isEmpty ? 'Le nom est requis' : null;
    notifyListeners();
  }

  void setPrenom(String value) {
    medecin.prenom = value;
    medecin.prenomError = value.isEmpty ? 'Le prénom est requis' : null;
    notifyListeners();
  }

  void setDateDeNaissance(String value) {
    medecin.dateDeNaissance = value;
    medecin.dateDeNaissanceError = value.isEmpty ? 'La date de naissance est requise' : null;
    notifyListeners();
  }

  void setSexe(String? value) {
    medecin.sexe = value;
    medecin.sexeError = value == null ? 'Le sexe est requis' : null;
    notifyListeners();
  }

  void setNumeroTelephone(String value) {
    medecin.numeroTelephone = value;
    if (value.isEmpty) {
      medecin.numeroTelephoneError = 'Le numéro de téléphone est requis';
    } else {
      medecin.numeroTelephoneError = null;
    }
    notifyListeners();
  }

  void setVille(String value) {
    medecin.ville = value;
    medecin.villeError = value.isEmpty ? 'La ville est requise' : null;
    notifyListeners();
  }


  void setLieuService(String value) {
    medecin.lieuService = value;
    medecin.lieuServiceError = value.isEmpty ? 'Le lieu de service est requis' : null;
    notifyListeners();
  }

  void setSpecialite(String value) {
    medecin.specialite = value;
    medecin.specialiteError = value.isEmpty ? 'La spécialité est requise' : null;
    notifyListeners();
  }

  // void setLongitude(String value) {
  //   medecin.longitude = value;
  //   if (value.isEmpty) {
  //     medecin.longitudeError = 'La longitude est requise';
  //   } else {
  //     try {
  //       double longitudeValue = double.parse(value);
  //       if (longitudeValue < -180 || longitudeValue > 180) {
  //         medecin.longitudeError = 'La longitude doit être entre -180 et 180';
  //       } else {
  //         medecin.longitudeError = null;
  //       }
  //     } catch (e) {
  //       medecin.longitudeError = 'Longitude invalide';
  //     }
  //   }
  //   notifyListeners();
  // }

  void setLatitude(String value) {
    medecin.latitude = value;
    if (value.isEmpty) {
      medecin.latitudeError = 'La latitude est requise';
    } else {
      try {
        double latitudeValue = double.parse(value);
        if (latitudeValue < -90 || latitudeValue > 90) {
          medecin.latitudeError = 'La latitude doit être entre -90 et 90';
        } else {
          medecin.latitudeError = null;
        }
      } catch (e) {
        medecin.latitudeError = 'Latitude invalide';
      }
    }
    notifyListeners();
  }

  void setNumeroONMC(String value) {
    medecin.numeroONMC = value;
    if (value.isEmpty) {
      medecin.numeroONMCError = 'Le numéro ONMC est requis';
    } else if (!RegExp(r'^[A-Z0-9]{5,10}$').hasMatch(value)) {
      // Exemple de validation : numéro ONMC doit être alphanumérique, entre 5 et 10 caractères
      medecin.numeroONMCError = 'Le numéro ONMC doit être alphanumérique et contenir entre 5 et 10 caractères';
    } else {
      medecin.numeroONMCError = null;
    }
    notifyListeners();
  }

  Future<void> setEmail(String value) async {
    medecin.email = value;
    medecin.emailError = null;

    if (medecin.email.isEmpty) {
      medecin.emailError = 'L\'email est requis';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(medecin.email)) {
      medecin.emailError = 'L\'email n\'est pas valide';
    } else {
      try {
        final exists = await _registerService.checkEmail(medecin.email);
        if (exists) {
          medecin.emailError = 'Cet email est déjà utilisé';
        }
      } catch (e) {
        medecin.emailError = 'Erreur lors de la vérification de l\'email: $e';
      }
    }

    notifyListeners();
  }

  void setPassword(String value) {
    medecin.password = value;
    medecin.passwordError = value.isEmpty
        ? 'Le mot de passe est requis'
        : value.length < 8
        ? 'Le mot de passe doit contenir au moins 8 caractères'
        : null;
    notifyListeners();
  }

  void setAccepteConditions(bool value) {
    medecin.accepteConditions = value;
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
        // Informations personnelles
        if (medecin.nomError == null &&
            medecin.prenomError == null &&
            medecin.dateDeNaissanceError == null &&
            medecin.sexeError == null &&
            medecin.numeroTelephoneError == null) {
          currentStep++;
          notifyListeners();
        }
      } else if (step == 2) {
        // Informations professionnelles
        if (medecin.villeError == null &&
            medecin.lieuServiceError == null &&
            medecin.specialiteError == null &&
            medecin.numeroONMCError == null) {
          print('Validation Step 2: lieuServiceError = ${medecin.lieuServiceError}');
          currentStep++;
          notifyListeners();
        }
      }
    }
  }

  Future<void> registerMedecin(BuildContext context) async {
    try {
      if (!medecin.accepteConditions) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vous devez accepter les conditions d\'utilisation')),
        );
        return;
      }

      isSubmitting = true;
      notifyListeners();

      final medecinData = medecin.toMap();
      print('Données envoyées : $medecinData');
      final response = await _registerService.registerMedecin(medecinData);

      print('Réponse de l\'API : $response');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Inscription réussie')),
      );
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print('Erreur lors de l\'inscription : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  void reset() {
    currentStep = 1;
    medecin.reset();
    isSubmitting = false;
    notifyListeners();
  }
}