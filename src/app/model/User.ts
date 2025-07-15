export interface LoginResponse {
  user: User;
  token: string;
}



export interface User {
  id_user: string;
  nom: string;
  prenom: string;
  date_de_naissance?: string;
  sexe?: string;
  ville?: string;
  quartier?: string;
  numero_telephone: string;
  email: string;
  role: 'patient' | 'medecin' | 'admin';
  specialite?: string;
  numero_onmc?: string;
  lieu_de_travail?: string;
  latitude_lieu_de_travail?: number;
  longitude_lieu_de_travail?: number;
  as_antecedent_familiaux?: string;
  statut_compte: number;
  est_connecte?: boolean;
  device_token?: string;
  recevoir_notifications?: boolean;
  theme?: string;
  derniere_connexion?: string;
  email_verifie_at?: string;
  accepte_conditions?: boolean;
  derniere_activite?: string;
  nombre_connexions?: number;
  created_at: string;
  updated_at: string;
  motif_refus: string;
}

export type DoctorDto = {
  id_user: string;
  nom: string;
  prenom: string;
  email: string;
  numero_telephone: string;
  role: 'patient' | 'medecin' | 'admin';
  specialite: string;
  statut_compte: number;
  numero_onmc: string;
  lieu_de_travail: string;
  created_at: string;
  updated_at: string;
  motif_refus: string;
  longitude: number;
  latitude: number;
  nombre_connexions: number;
  derniere_connexion: string;
};


export class Doctor {
  #data: DoctorDto;

  public constructor(data: DoctorDto) {
    this.#data = data;
  }

  get id(): string {
    return this.#data.id_user;
  }

  get nom(): string {
    return this.#data.nom;
  }
  get prenom(): string {
    return this.#data.prenom;
  }

  get email(): string {
    return this.#data.email;
  }

  get numTelephone(): string {
    return this.#data.numero_telephone;
  }

  get specialite(): string {
    return this.#data.specialite;
  }

  get onmc(): string {
    return this.#data.numero_onmc;
  }

  get lieuTravail(): string {
    return this.#data.lieu_de_travail;
  }

  get longitude(): number {
    return this.#data.longitude;
  }

  get latitude(): number {
    return this.#data.latitude;
  }

  get fullName(): string {
    return `${this.#data.prenom} ${this.#data.nom}`;
  }

  get status(): string {
    switch (this.#data.statut_compte) {
      case 0:
        return 'pending';
      case 1:
        return 'validated';
      case -1:
        return 'rejected';
      default:
        return 'null';
    }
  }
  get motifRefus(): string {
    return this.#data.motif_refus;
  }

  get createdAt(): Date {
    return new Date(this.#data.created_at ) ;
  }

  get updatedAt(): Date {
    return new Date(this.#data.updated_at);
  }

  get derniereConnexion(): Date {
    return new Date(this.#data.derniere_connexion);
  }

  get nombreConnexions(): number {
    return this.#data.nombre_connexions;
  }

  // Ajout de la propriété stats calculée
  get stats(): { daysRegistered: number; completionScore: number } {
    const daysRegistered = this.calculateDaysRegistered();
    const completionScore = this.calculateCompletionScore();
    return {
      daysRegistered,
      completionScore,
    };
  }

  private calculateDaysRegistered(): number {
    const today = new Date();
    const createdAt = new Date(this.#data.created_at);
    const diffTime = Math.abs(today.getTime() - createdAt.getTime());
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // Nombre de jours
  }

  private calculateCompletionScore(): number {
    let score = 0;
    if (this.#data.nom) score += 20;
    if (this.#data.prenom) score += 20;
    if (this.#data.email) score += 20;
    if (this.#data.numero_telephone) score += 20;
    if (this.#data.specialite) score += 10;
    if (this.#data.numero_onmc) score += 10;
    return Math.min(score, 100); // Score maximum de 100
  }
}
