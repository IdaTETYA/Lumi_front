import {Injectable} from '@angular/core';
import {environment} from '../../environments/environment';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Document, DocumentDto} from '../model/Document';
import {catchError, map} from 'rxjs/operators';
import {Observable, throwError} from 'rxjs';
import {LoginService} from './login-service.service';

@Injectable({
  providedIn: 'root'
})
export class DocumentService {
  private  apiUrl = environment.hostUrl+`/api/documents`;
  private  loginService?: LoginService;
  header = { Authorization: `Bearer ${localStorage.getItem('token')}` };
  constructor(private http:HttpClient, loginService: LoginService ) {
    this.loginService = loginService;

  }


  validateDocument(id: string) {
    const statut= 1
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
    });
     const valide_par_id = this.loginService?.getCurrentUser()?.id_user
    return this.http.put<DocumentDto>(`${this.apiUrl}/${id}/valider`, {statut,valide_par_id}, {headers}).pipe(
      map(
        response => {
          return new Document(response);
        },
        catchError( error => {
          console.log(error);
          console.error('error lors du changement de statut du document');
          return throwError(()=>new Error('Erreur lors du changement de statut du document'));
        }),
      )
    );
  }

  rejectDocument(id: string, motif_refus: string | null) {
    const statut = -1;
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
    });
    const valide_par_id = this.loginService?.getCurrentUser()?.id_user;
    return this.http.put<DocumentDto>(`${this.apiUrl}/${id}/valider`, { statut, valide_par_id, motif_refus }, { headers }).pipe(
      map(response => new Document(response)),
      catchError(error => {
        console.log(error);
        console.error('Erreur lors du changement de statut du document');
        return throwError(() => new Error('Erreur lors du changement de statut du document'));
      })
    );
  }


  downloadDocument(id: number): Observable<Blob> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
    });
    return this.http.get(`${this.apiUrl}/download/${id}`, {
      responseType: 'blob',
      headers,
    }).pipe(
      catchError(error => {
        console.error('Erreur lors du téléchargement :', error);
        return throwError(() => new Error('Erreur lors du téléchargement du document'));
      })
    );
  }

  viewDocument(id: number): Observable<Blob> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
    });
    return this.http.get(`${this.apiUrl}/view/${id}`, {
      responseType: 'blob',
      headers,
    }).pipe(
      catchError(error => {
        console.error('Erreur lors de la visualisation :', error);
        return throwError(() => new Error('Erreur lors de la visualisation du document'));
      })
    );
  }

  getDocuments(page: number = 1, perPage: number = 10): Observable<{ data: Document[], pagination: any }> {
    const headers = { Authorization: `Bearer ${localStorage.getItem('token')}` };
    return this.http.get<any>(`${this.apiUrl}?page=${page}&per_page=${perPage}`, { headers }).pipe(
      map(response => {
        console.log('Réponse API :', response); // Ajout pour débogage
        if (response && response.status === 'success' && Array.isArray(response.data)) {
          const documents = response.data.map((document: DocumentDto) => new Document(document));
          return { data: documents, pagination: response.pagination };
        } else {
          throw new Error('Réponse de l\'API inattendue : aucun tableau de documents trouvé dans "data"');
        }
      }),
      catchError(e => {
        console.error('Erreur HTTP :', e);
        console.error('Erreur lors de la récupération des documents:', e.message || e);
        return throwError(() => new Error('Échec de la récupération des données'));
      })
    );
  }

}
