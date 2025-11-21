import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { map } from 'rxjs/operators';

@Injectable({ providedIn: 'root' })
export class FavoriteService {
  private http = inject(HttpClient);
  private base = environment.apiBaseUrl;

  /** GET /favorite/me → vrati null ako je 204, u suprotnom telo { playerId, playerName, clubName } */
  getMine() {
    return this.http.get<{ playerId: number; playerName: string; clubName: string }>(
      `${this.base}/favorite/me`,
      { observe: 'response' }
    ).pipe(
      map(res => (res.status === 204 ? null : res.body!))
    );
  }

  /** POST /favorite body: { playerId } → vraća HTTP status (200 ili 208) */
  set(playerId: number) {
    return this.http.post(`${this.base}/favorite`, { playerId }, { observe: 'response' })
      .pipe(map(res => res.status));
  }

  remove() {
    return this.http.delete(`${this.base}/favorite`);
  }
}
