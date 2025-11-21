import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private http = inject(HttpClient);
  private base = environment.apiBaseUrl;

  get<T>(url: string, params?: Record<string, any>) {
    const httpParams = new HttpParams({ fromObject: params ?? {} });
    return this.http.get<T>(`${this.base}${url}`, { params: httpParams });
  }

  post<T>(url: string, body: any, headers?: Record<string, string>) {
    const httpHeaders = new HttpHeaders(headers ?? {});
    return this.http.post<T>(`${this.base}${url}`, body, { headers: httpHeaders });
  }

  put<T>(url: string, body: any) {
    return this.http.put<T>(`${this.base}${url}`, body);
  }

  patch<T>(url: string, body: any) {
    return this.http.patch<T>(`${this.base}${url}`, body);
  }

  delete<T>(url: string) {
    return this.http.delete<T>(`${this.base}${url}`);
  }

  getBlob(url: string, params?: Record<string, any>) {
    const httpParams = new HttpParams({ fromObject: params ?? {} });
    return this.http.get(`${this.base}${url}`, {
      params: httpParams,
      responseType: 'blob',
    });
  }
}
