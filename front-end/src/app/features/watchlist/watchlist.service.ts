import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { PlayerService } from '../players/player.service';
import { forkJoin, of } from 'rxjs';
import { map, switchMap, catchError } from 'rxjs/operators';

@Injectable({ providedIn: 'root' })
export class WatchlistService {
  private http = inject(HttpClient);
  private playersApi = inject(PlayerService);
  private base = `${environment.apiBaseUrl}/watchlist`;

  /**
   * Vraća listu u formatu: [{ player: FullPlayer }, ...]
   * Servis sam zove /watchlist/me (light) pa dohvaća pune igrače.
   */
  getMine() {
    return this.http.get<Array<{ playerId: number }>>(`${this.base}/me`).pipe(
      switchMap(light =>
        !light || light.length === 0
          ? of([] as Array<{ player: any }>)
          : forkJoin(
              light
                .filter(x => !!x.playerId)
                .map(x =>
                  this.playersApi.getById(x.playerId).pipe(
                    map(p => ({ player: p } as { player: any })),
                    catchError(() => of(null)) // ako neki više ne postoji, preskoči
                  )
                )
            ).pipe(
              map(arr => arr.filter((v): v is { player: any } => !!v))
            )
      )
    );
  }

  /** POST /watchlist { playerId } → status 200 (ok) ili 208 (već postoji) */
  add(playerId: number) {
    return this.http.post(`${this.base}`, { playerId }, { observe: 'response' })
      .pipe(map((res: HttpResponse<any>) => res.status));
  }

  /** DELETE /watchlist/{playerId} */
  remove(playerId: number) {
    return this.http.delete<void>(`${this.base}/${playerId}`);
  }
}
