import { Component, inject, signal } from '@angular/core';
import { CommonModule, NgIf, CurrencyPipe } from '@angular/common';
import { FavoriteService } from './favorite.service';
import { PlayerService } from '../players/player.service';
import { AuthService } from '../../core/services/auth.service';
import { BackHomeComponent } from '../../shared/back-home.component';
import { PlayerDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'app-favorite-page',
  imports: [CommonModule, NgIf, CurrencyPipe, BackHomeComponent],
  templateUrl: './favorite-page.component.html'
})
export class FavoritePageComponent {
  private favoriteApi = inject(FavoriteService);
  private playersApi  = inject(PlayerService);
  private auth        = inject(AuthService);

  private _fav = signal<PlayerDTO | null>(null);
  fav = () => this._fav();

  message = '';
  error = '';

  ngOnInit() { this.load(); }

  isManager() { return this.auth.hasRole('MANAGER'); }

  private load() {
    this.favoriteApi.getMine().subscribe({
      next: (fav) => {
        if (!fav) {
          this._fav.set(null);
          this.message = '';
          this.error = '';
          return;
        }
        this.playersApi.getById(fav.playerId).subscribe({
          next: (player) => { this._fav.set(player); this.message = ''; this.error = ''; },
          error: () => { this._fav.set(null); this.error = 'Neuspešno učitavanje detalja igrača.'; }
        });
      },
      error: () => { this._fav.set(null); this.error = 'Neuspešno učitavanje omiljenog igrača.'; }
    });
  }

  remove() {
    this.favoriteApi.remove().subscribe({
      next: () => {
        this._fav.set(null);
        this.message = 'Omiljeni igrač je uklonjen.';
        this.error = '';
      },
      error: () => { this.error = 'Greška pri uklanjanju.'; }
    });
  }
}
