import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject, of } from 'rxjs';
import {tap, catchError, map} from 'rxjs/operators';
import {LoginResponse, User} from '../model/User';


@Injectable({
  providedIn: 'root'
})
export class LoginService {
  private apiUrl = 'http://localhost:8000/api';
  private currentUserSubject = new BehaviorSubject<User | null>(null);
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient) {
    const storedUser = localStorage.getItem('currentUser');
    if (storedUser) {
      try {
        this.currentUserSubject.next(JSON.parse(storedUser));
      } catch (error) {
        console.error('Failed to parse stored user:', error);
        localStorage.removeItem('currentUser');
        this.currentUserSubject.next(null);
      }
    }
  }

  // Login method
  login(email: string, password: string): Observable<User> {
    return this.http
      .post<LoginResponse>(
        `${this.apiUrl}/login`,
        { email, password },
        { headers: { 'Content-Type': 'application/json','Accept': 'application/json',} }
      )
      .pipe(
        map(response => {
          console.log(response);
          const user = response.user;
          const token = response.token;

          if (!user || !token) {
            throw new Error('Invalid login response: user or token missing');
          }

          localStorage.setItem('currentUser', JSON.stringify(user));
          localStorage.setItem('token', token);
          this.currentUserSubject.next(user);

          return user;
        }),
        catchError(error => {
          console.error('Login failed:', error);
          throw error;
        })
      );
  }

  get token(): string | null {
    return localStorage.getItem('token');
  }

  getCurrentUser(): User | null {
    return this.currentUserSubject.value;
  }

  logout(): void {
    localStorage.removeItem('currentUser');
    localStorage.removeItem('token'); // Supprimer également le token
    this.currentUserSubject.next(null);
  }

  isAuthenticated(): boolean {
    return !!this.currentUserSubject.value && !!this.token;
  }

  getRole(): string | null {
    return this.currentUserSubject.value?.role || null;
  }
}
