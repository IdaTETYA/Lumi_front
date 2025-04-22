class Medecin {
  String nom;
  String prenom;
  String dateDeNaissance;
  String? sexe;
  String numeroTelephone;
  String lieuService;
  String ville;
  String quartier;
  String? longitude;
  String? latitude;
  String specialite;
  String email;
  String password;
  bool accepteConditions;
  String  numeroONMC;


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
  String? longitudeError;
  String? latitudeError;
  String? specialiteError;
  String? lieuServiceError;
  String? numeroONMCError;

  Medecin({
    this.nom = '',
    this.prenom = '',
    this.dateDeNaissance = '',
    this.sexe,
    this.numeroTelephone = '',
    this.ville = '',
    this.quartier = '',
    this.email = '',
    this.password = '',
    this.accepteConditions = false,
    this.lieuService = '',
    this.longitude = '',
    this.latitude = '',
    this.specialite = '',
    this.numeroONMC = '',


    this.nomError,
    this.prenomError,
    this.dateDeNaissanceError,
    this.sexeError,
    this.numeroTelephoneError,
    this.villeError,
    this.quartierError,
    this.emailError,
    this.passwordError,
    this.latitudeError,
    this.longitudeError,
    this.lieuServiceError,
    this.specialiteError,
    this.numeroONMCError,


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
    accepteConditions = false;
    specialite = '';
    longitude = '';
    latitude = '';
    lieuService = '';


    lieuServiceError =null;
    nomError = null;
    prenomError = null;
    dateDeNaissanceError = null;
    sexeError = null;
    numeroTelephoneError = null;
    villeError = null;
    quartierError = null;
    emailError = null;
    passwordError = null;
    specialiteError = null;
    longitudeError = null;
    latitudeError = null;
    numeroONMCError = null;

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
      'email': email,
      'password': password,
      'longitude': longitude,
      'latitude': latitude,
      'lieu_de_travail': lieuService,
      'specialite':specialite,
      'numero_onmc': numeroONMC,
      'accepte_conditions': accepteConditions

    };
  }
}