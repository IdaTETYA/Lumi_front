class Patient {
  String nom;
  String prenom;
  String dateDeNaissance;
  String? sexe;
  String numeroTelephone;
  String ville;
  String quartier;
  String email;
  String password;
  bool hasFamilyHistory;
  bool accepteConditions;

  // Erreurs
  String? nomError;
  String? prenomError;
  String? dateDeNaissanceError;
  String? sexeError;
  String? numeroTelephoneError;
  String? villeError;
  String? quartierError;
  String? emailError;
  String? passwordError;

  Patient({
    this.nom = '',
    this.prenom = '',
    this.dateDeNaissance = '',
    this.sexe,
    this.numeroTelephone = '',
    this.ville = '',
    this.quartier = '',
    this.email = '',
    this.password = '',
    this.hasFamilyHistory = false,
    this.accepteConditions = false,
    this.nomError,
    this.prenomError,
    this.dateDeNaissanceError,
    this.sexeError,
    this.numeroTelephoneError,
    this.villeError,
    this.quartierError,
    this.emailError,
    this.passwordError,
  });

  // Méthode pour réinitialiser les données
  void reset() {
    nom = '';
    prenom = '';
    dateDeNaissance = '';
    sexe = null;
    numeroTelephone = '';
    ville = '';
    quartier = '';
    email = '';
    password = '';
    hasFamilyHistory = false;
    accepteConditions = false;

    nomError = null;
    prenomError = null;
    dateDeNaissanceError = null;
    sexeError = null;
    numeroTelephoneError = null;
    villeError = null;
    quartierError = null;
    emailError = null;
    passwordError = null;
  }

  // Méthode pour convertir en Map pour l'envoi à l'API
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'date_de_naissance': dateDeNaissance,
      'sexe': sexe?.toLowerCase(),
      'numero_telephone': numeroTelephone,
      'ville': ville,
      'quartier': quartier,
      'email': email,
      'password': password,
      'as_antecedent_familiaux': hasFamilyHistory,
      'accepte_conditions': accepteConditions
    };
  }
}