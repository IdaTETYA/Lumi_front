export type CreateDocumentDto = {
  titre: string;
  type: string;
  medecin_id: string;
}

export type UpdateDocumentDto = {}

export type MedecinDto = {
  id_user: string;
  nom: string;
  prenom: string;
  specialite: string;
  email?: string;
  numero_telephone?: string;
  sexe: string,

}

export type DocumentDto = {
  id_document: string;
  titre: string;
  type: string;
  file: string;
  medecin_id: string;
  valide_par_id: string;
  statut: number;
  medecin: MedecinDto;
  created_at: string;
  updated_at: string;
  motif_refus: string;
}

export class Document {
  #data: DocumentDto;

  public constructor(data: DocumentDto) {
    this.#data = data;
  }

  get id(): string {
    return this.#data.id_document;
  }

  get nom(): string {
    return (this.#data.medecin.nom) + " " + (this.#data.medecin.prenom);
  }

  get prenom(): string {
    return this.#data.medecin.prenom;
  }

  get specialite(): string {
    return this.#data.medecin.specialite;
  }

  get email(): string {
    return <string>this.#data.medecin.email;
  }

  get numero_telephone(): string {
    return <string>this.#data.medecin.numero_telephone;
  }

  get titre(): string {
    return this.#data.titre;
  }

  get type(): string {
    return this.#data.type;
  }

  get file(): string {
    return this.#data.file;
  }

  get medecin_id(): string {
    return this.#data.medecin_id;
  }

  get valide_par_id(): string {
    return this.#data.valide_par_id;
  }

  get status(): string {
    switch (this.#data.statut) {
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

  get createdAt(): Date {
    return new Date(this.#data.created_at);
  }

  get updatedAt(): Date {
    return new Date(this.#data.updated_at);
  }

  get motifRefus(): string {
    return this.#data.motif_refus;
  }

  // get total():number{
  //   return this.#data.total;
  // }
  //
  // get verified():number{
  //   return this.#data.verified;
  // }

  createElement(a1: string) {

  }
}
