import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Observable, throwError} from 'rxjs';
import {catchError, map} from 'rxjs/operators';
import {Doctor, DoctorDto} from '../model/User';
import {environment} from '../../environments/environment';
import {Document, DocumentDto} from '../model/Document';

@Injectable({
  providedIn: 'root'
})
export class DoctorService {
  private apiUrl = environment.hostUrl+'/api/medecins';

  header = { Authorization: `Bearer ${localStorage.getItem('token')}` };


  constructor(private http: HttpClient) {}

  getDoctors(): Observable<Doctor[]> {
    const headers = { Authorization: `Bearer ${localStorage.getItem('token')}` };
    return this.http.get<DoctorDto[]>(this.apiUrl, { headers }).pipe(
      map(doctors => doctors.map(doctor=>new Doctor(doctor))),
      catchError(error => {
        console.error('Erreur lors de la récupération des médecins:', error);
        return throwError(() => new Error('Échec de la récupération des données'));
      })
    );
  }

  getDoctorDocument(id: string): Observable<{ documents: Document[], total: number, verified: number }> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
    });
    return this.http.get<{ documents: DocumentDto[], total: number, verified: number, status: string }>(`${this.apiUrl}/${id}/documents`, { headers }).pipe(
      map(response => ({
        documents: response.documents.map(document => new Document(document)),
        total: response.total,
        verified: response.verified
      })),
      catchError(err => {
        console.error('Erreur lors du chargement des documents du médecin :', err);
        return throwError(() => new Error('Erreur lors du chargement des documents du médecin'));
      })
    );
  }

  getDoctorById(id: string): Observable<Doctor> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
    });
    return this.http.get<any>(`${this.apiUrl}/${id}`, {headers}).pipe(
      map(doctor=> {
        const medecin = doctor.medecin;
        return new Doctor(medecin);
      }),
      catchError(error=>{
        console.error('error lors du chargement des informations du medecin ');
        return throwError(()=>new Error('Erreur lors du chargement des informations du medecin'));
      })
    )
  }



  // getDoctorById(id: string): Observable<Doctor> {
  //   const headers= this.header;
  //   return this.http.get<DoctorDto>(`${this.apiUrl}/${id}`, {headers}).pipe(
  //     map(response => {
  //       console.log('Réponse brute de l\'API:', response); // Log 1: Vérifier la réponse brute
  //       const medecin = response;
  //       const dto: DoctorDto = {
  //         id_user: medecin.id_user,
  //         nom: medecin.nom,
  //         prenom: medecin.prenom,
  //         email: medecin.email,
  //         numero_telephone: medecin.numero_telephone,
  //         specialite: medecin.specialite,
  //         statut_compte: medecin.statut_compte,
  //         numero_onmc: medecin.numero_onmc,
  //         lieu_de_travail: medecin.lieu_de_travail,
  //         created_at: medecin.created_at,
  //         updated_at: medecin.updated_at,
  //         motif_refus: medecin.motif_refus,
  //         longitude: medecin.longitude,
  //         latitude: medecin.latitude,
  //         nombre_connexions: medecin.nombre_connexions,
  //         derniere_connexion: medecin.derniere_connexion,
  //       };
  //       console.log('Objet DoctorDto après mapping:', dto); // Log 2: Vérifier l'objet mappé
  //       return new Doctor(dto);
  //     }),
  //     catchError(error => {
  //       console.error('Erreur lors de la récupération du médecin:', error);
  //       return throwError(() => new Error('Échec de la récupération des données'));
  //     })
  //   );
  // }


  validedDoctor(id : string): Observable<Doctor> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    const body=1;
    console.log('2i2m',token);
    return this.http.put<DoctorDto>(`${this.apiUrl}/${id}/valider`, {}, { headers }).pipe(
      map(doctor=>new Doctor(doctor)),
      catchError(error=>{
        console.log(error);
        console.error('error lors du changement de statut du medecin ');
        return throwError(()=>new Error('Erreur lors du changement de statut du medecin'));
      })
    )
  }

  rejetedDoctor(id: string, motif_refus: string | null): Observable<Doctor> {
    const headers = this.header
    return this.http.put<DoctorDto>(`${this.apiUrl}/${id}/refuser`, {motif_refus},{ headers }).pipe(
      map(doctor=>new Doctor(doctor)),
      catchError(error=>{
        console.log(error);
        console.error('error lors du changement de statut du medecin ');
        return throwError(()=>new Error('Erreur lors du changement de statut du medecin'));
      })
    )
  }

  pendindDoctor(id:string): Observable<Doctor> {
    const headers = this.header
    return this.http.put<DoctorDto>(`${this.apiUrl}/${id}/annuler`, {}, { headers }).pipe(
      map(doctor=>new Doctor(doctor)),
      catchError(error=>{
        console.log(error);
        console.error('error lors du changement de statut du medecin ');
        return throwError(()=>new Error('Erreur lors du changement de statut du medecin'));
      })
    )
  }

}
