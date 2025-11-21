import { Component, inject, signal } from '@angular/core';
import { CommonModule, NgFor, NgIf } from '@angular/common';
import { RouterLink } from '@angular/router';
import { WatchlistService } from './watchlist.service';
import { AuthService } from '../../core/services/auth.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-watchlist-page',
  imports: [CommonModule, NgIf, NgFor, RouterLink, BackHomeComponent],
  templateUrl: './watchlist-page.component.html'
})
export class WatchlistPageComponent {
  private api = inject(WatchlistService);
  private auth = inject(AuthService);

  items = signal<Array<{ player: any }>>([]);

  ngOnInit() { this.load(); }

  isManager() { return this.auth.hasRole('MANAGER'); }

  load() {
    this.api.getMine().subscribe({
      next: xs => this.items.set(xs),
      error: () => this.items.set([])
    });
  }

  remove(playerId: number) {
    this.api.remove(playerId).subscribe({
      next: () => this.load(),
      error: () => {}
    });
  }
}
