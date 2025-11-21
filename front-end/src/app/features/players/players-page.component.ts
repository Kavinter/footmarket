import { Component, inject, signal } from '@angular/core';
import { CommonModule, NgFor, NgIf, CurrencyPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { PlayerService } from './player.service';
import { FavoriteService } from '../favorite/favorite.service';
import { WatchlistService } from '../watchlist/watchlist.service';
import { AuthService } from '../../core/services/auth.service';
import { PlayerDTO } from '../../core/models';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-players-page',
  imports: [CommonModule, FormsModule, NgFor, NgIf, RouterLink, CurrencyPipe, BackHomeComponent],
  templateUrl: './players-page.component.html'
})
export class PlayersPageComponent {
  private playersApi = inject(PlayerService);
  private favApi = inject(FavoriteService);
  private wlApi = inject(WatchlistService);
  private auth = inject(AuthService);

  players = signal<PlayerDTO[]>([]);
  favoriteId = signal<number | null>(null);
  watchIds = signal<Set<number>>(new Set<number>());
  message = signal<string>('');
  error = signal<string>('');

  name = '';
  club = '';
  position = '';

  ngOnInit() {
    this.search();
    if (this.isManager()) {
      this.favApi.getMine().subscribe({
        next: (fav) => this.favoriteId.set(fav?.playerId ?? null),
        error: () => this.favoriteId.set(null)
      });
      this.wlApi.getMine().subscribe({
        next: (items) => this.watchIds.set(new Set((items ?? []).map(x => x.player.id))),
        error: () => this.watchIds.set(new Set())
      });
    }
  }

  isManager() { return this.auth.isManager(); }


  search() {
    this.playersApi.list({
      name: this.name || undefined,
      club: this.club || undefined,
      position: this.position || undefined
    }).subscribe({
      next: list => this.players.set(list),
      error: () => this.error.set('Greška pri učitavanju igrača.')
    });
  }

  reset() {
    this.name = ''; this.club = ''; this.position = '';
    this.search();
  }

  inWatchlist(p: PlayerDTO) {
    return this.watchIds().has(p.id);
  }

  addFavorite(p: PlayerDTO) {
    if (!this.isManager()) return;
    this.message.set(''); this.error.set('');
    this.favApi.set(p.id).subscribe({
      next: (status) => {
        if (status === 208) {
          this.error.set('Ovaj igrač je već vaš omiljeni.');
        } else {
          this.favoriteId.set(p.id);
          this.message.set('Omiljeni igrač je postavljen.');
        }
      },
      error: () => this.error.set('Greška pri postavljanju omiljenog igrača.')
    });
  }

  addToWatchlist(p: PlayerDTO) {
    if (!this.isManager()) return;
    this.message.set(''); this.error.set('');
    this.wlApi.add(p.id).subscribe({
      next: (status) => {
        if (status === 208) {
          this.error.set('Igrač je već na watchlisti.');
        } else {
          const next = new Set(this.watchIds());
          next.add(p.id);
          this.watchIds.set(next);
          this.message.set('Igrač dodat na watchlistu.');
        }
      },
      error: () => this.error.set('Greška pri dodavanju na watchlistu.')
    });
  }
}
