import { Component, inject } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { PlayerService } from './player.service';
import { ClubService } from '../clubs/club.service';
import { AuthService } from '../../core/services/auth.service';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubDTO, PlayerDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'app-player-edit',
  imports: [CommonModule, ReactiveFormsModule, NgIf, RouterLink, BackHomeComponent],
  templateUrl: './player-edit.component.html'
})
export class PlayerEditComponent {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private players = inject(PlayerService);
  private clubsApi = inject(ClubService);
  private auth = inject(AuthService);

  fg = this.fb.group({
    name: ['', [Validators.required]],
    position: ['', [Validators.required]],
    clubId: [null as number | null],
    age: [null as number | null, [Validators.min(15), Validators.max(50)]],
    marketValue: [null as number | null, [Validators.min(0)]],
  });

  playerId: number | null = null;
  loaded = false;
  clubs: ClubDTO[] = [];

  serverError = '';
  successMsg = '';

  ngOnInit() {
    const idParam = this.route.snapshot.paramMap.get('id');
    this.playerId = idParam ? +idParam : null;
    if (!this.playerId) {
      this.serverError = 'Nevažeći ID igrača.';
      return;
    }

    this.clubsApi.list().subscribe({
      next: list => this.clubs = list,
      error: () => {}
    });

    this.players.getById(this.playerId).subscribe({
      next: (p: PlayerDTO) => {
        this.fg.patchValue({
          name: p.name,
          position: p.position,
          clubId: p.clubId ?? null,
          age: p.age ?? null,
          marketValue: p.marketValue ?? null
        });
        this.loaded = true;
      },
      error: () => {
        this.serverError = 'Ne mogu da učitam igrača.';
        this.loaded = true;
      }
    });
  }

  isAdmin() {
    return this.auth.hasRole('ADMIN');
  }

  submit() {
    this.serverError = '';
    this.successMsg = '';

    if (!this.playerId || this.fg.invalid) return;

    const raw = this.fg.getRawValue();

    let payload: any = {
      name: raw.name!,
      position: raw.position!
    };

    if (this.isAdmin()) {
      payload = {
        ...payload,
        clubId: raw.clubId ?? null,
        age: raw.age ?? null,
        marketValue: raw.marketValue ?? null
      };
    }

    this.players.update(this.playerId, payload).subscribe({
      next: () => {
        this.successMsg = 'Izmene su sačuvane.';
      },
      error: () => {
        this.serverError = 'Greška pri čuvanju izmena.';
      }
    });
  }
}
