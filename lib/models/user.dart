import 'dart:core';

class User {
  final String idUser;
  final String nom;
  final String prenom;
  final String? dateDeNaissance;
  final String? sexe;
  final String? ville;
  final String? quartier;
  final String? numeroTelephone;
  final String email;
  final String role;
  final String? specialite;
  final String? numeroONMC;
  final String? lieuDeTravail;
  final double? latitudeLieuDeTravail;
  final double? longitudeLieuDeTravail;
  final String? stadeDeGrossesse;
  final int statutCompte;
  final bool? estConnecte;
  final String? deviceToken;
  final bool? recevoirNotifications;
  final String? theme;
  final String? derniereConnexion;
  final String? emailVerifieAt;
  final bool? accepteConditions;
  final String? derniereActivite;
  final int? nombreConnexions;
  final String? createdAt;
  final String? updatedAt;
  final String? motifRefus;

  User({
  required this.idUser,
  required this.nom,
  required this.prenom,
  this.dateDeNaissance,
  this.sexe,
  this.ville,
  this.quartier,
  this.numeroTelephone,
  required this.email,
  required this.role,
  this.specialite,
  this.numeroONMC,
  this.lieuDeTravail,
  this.latitudeLieuDeTravail,
  this.longitudeLieuDeTravail,
  this.stadeDeGrossesse,
  required this.statutCompte,
  this.estConnecte,
  this.deviceToken,
  this.recevoirNotifications,
  this.theme,
  this.derniereConnexion,
  this.emailVerifieAt,
  this.accepteConditions,
  this.derniereActivite,
  this.nombreConnexions,
  this.createdAt,
  this.updatedAt,
  this.motifRefus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
  idUser: json['id_user'],
  nom: json['nom'],
  prenom: json['prenom'],
  dateDeNaissance: json['date_de_naissance'],
  sexe: json['sexe'],
  ville: json['ville'],
  quartier: json['quartier'],
  numeroTelephone: json['numero_telephone'],
  email: json['email'],
  role: json['role'],
  specialite: json['specialite'],
  numeroONMC: json['numeroONMC'],
  lieuDeTravail: json['lieu_de_travail'],
  latitudeLieuDeTravail: json['latitude_lieu_de_travail']?.toDouble(),
  longitudeLieuDeTravail: json['longitude_lieu_de_travail']?.toDouble(),
  stadeDeGrossesse: json['stade_de_grossesse'],
  statutCompte: json['statut_compte'],
  estConnecte: json['est_connecte'],
  deviceToken: json['device_token'],
  recevoirNotifications: json['recevoir_notifications'],
  theme: json['theme'],
  derniereConnexion: json['derniere_connexion'],
  emailVerifieAt: json['email_verifie_at'],
  accepteConditions: json['accepte_conditions'],
  derniereActivite: json['derniere_activite'],
  nombreConnexions: json['nombre_connexions'],
  createdAt: json['created_at'],
  updatedAt: json['updated_at'],
  motifRefus: json['motif_refus'],
  );
  }
  }











