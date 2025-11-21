import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { tap, map } from 'rxjs/operators';
import { Observable, of } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private http = inject(HttpClient);
  private base = environment.apiBaseUrl;

  login(username: string, password: string) {
    return this.http
      .post<{ token: string; username: string }>(`${this.base}/auth/login`, { username, password })
      .pipe(
        tap((res) => {
          localStorage.setItem('token', res.token);
          localStorage.setItem('username', res.username);
        })
      );
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('username');
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }

  private decodePayload(): any | null {
    const token = this.getToken();
    if (!token) return null;
    try {
      const base64 = token.split('.')[1];
      const json = atob(base64.replace(/-/g, '+').replace(/_/g, '/'));
      return JSON.parse(json);
    } catch {
      return null;
    }
  }

  getRoles(): string[] {
    const p = this.decodePayload();
    const raw = p?.roles ?? p?.role ?? p?.authorities ?? [];
    if (Array.isArray(raw)) return raw.map(String);
    if (typeof raw === 'string') return raw.split(',').map((s) => s.trim());
    return [];
  }

  hasRole(role: string): boolean {
    const roles = this.getRoles().map((r) => r.toUpperCase());
    return roles.includes(role.toUpperCase()) || roles.includes('ROLE_' + role.toUpperCase());
  }

  isManager(): boolean {
    return this.hasRole('MANAGER');
  }

  register(data: { username: string; email: string; password: string; roleId: number }) {
    return this.http.post(`${environment.apiBaseUrl}/auth/register`, data, { observe: 'response' });
  }

  checkUsername(username: string): Observable<boolean> {
    if (!username || username.trim().length < 3) return of(false);
    return this.http
      .get<{ username: string; taken: boolean }>(`${this.base}/auth/check-username`, {
        params: { u: username },
      })
      .pipe(map((r) => r.taken));
  }

  checkEmail(email: string): Observable<boolean> {
    if (!email) return of(false);
    return this.http
      .get<{ email: string; taken: boolean }>(`${this.base}/auth/check-email`, {
        params: { e: email },
      })
      .pipe(map((r) => r.taken));
  }

  listRoles() {
    return this.http.get<Array<{ id: number; name: string }>>(`${this.base}/auth/roles`);
  }

  homePath(): string {
    if (!this.isLoggedIn()) return '/';
    if (this.hasRole('ADMIN')) return '/admin/home';
    if (this.hasRole('MANAGER')) return '/manager/home';
    return '/';
  }
}
