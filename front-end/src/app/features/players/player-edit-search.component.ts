import { Component, inject } from '@angular/core';
import { CommonModule, NgIf, NgFor } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { PlayerService } from './player.service';
import { ClubService } from '../clubs/club.service';
import { AuthService } from '../../core/services/auth.service';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubDTO, PlayerDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'app-player-edit-search',
  imports: [CommonModule, ReactiveFormsModule, NgIf, NgFor, RouterLink, BackHomeComponent],
  templateUrl: './player-edit-search.component.html'
})
export class PlayerEditSearchComponent {
  private fb = inject(FormBuilder);
  private players = inject(PlayerService);
  private clubsApi = inject(ClubService);
  private router = inject(Router);
  private auth = inject(AuthService);

  positions: Array<'GK'|'DF'|'MF'|'FW'> = ['GK','DF','MF','FW'];
  clubs: ClubDTO[] = [];

  serverError = '';

  fg = this.fb.group({
    name: ['', [Validators.required]],
    position: ['', [Validators.required]],
    clubId: [null as number | null, [Validators.required]],
  });

  ngOnInit() {
    this.clubsApi.list().subscribe({
      next: list => this.clubs = list,
      error: () => {}
    });
  }

  canEdit() {
    return this.auth.hasRole('ADMIN') || this.auth.hasRole('MANAGER');
  }

  submit() {
    this.serverError = '';
    if (this.fg.invalid) return;

    const raw = this.fg.getRawValue();
    const club = this.clubs.find(c => c.id === raw.clubId!);
    if (!club) {
        this.serverError = 'Nepoznat klub.';
        return;
    }

    this.players.list({
        name: raw.name || undefined,
        position: raw.position || undefined,
        club: club.name
    }).subscribe({
        next: (list: PlayerDTO[]) => {
        const filtered = (list || []).filter(p =>
            p.name.trim().toLowerCase() === (raw.name || '').trim().toLowerCase() &&
            p.position === raw.position &&
            p.clubName === club.name
        );

        if (filtered.length === 0) {
            this.serverError = 'Nije pronađen nijedan igrač za zadate kriterijume.';
            return;
        }

        if (filtered.length > 1) {
            this.serverError = 'Pronađeno je više igrača, suzi kriterijume.';
            return;
        }

        const player = filtered[0];
        this.router.navigate(['/players', player.id, 'edit']);
        },
        error: () => {
            this.serverError = 'Greška pri pretrazi igrača.';
        }
    });
  }

}
