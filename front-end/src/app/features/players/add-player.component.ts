import { Component, inject, OnInit } from '@angular/core';
import { CommonModule, NgFor, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { PlayerService } from './player.service';
import { ClubService } from '../clubs/club.service';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'app-add-player',
  imports: [CommonModule, ReactiveFormsModule, NgIf, NgFor, RouterLink, BackHomeComponent],
  templateUrl: './add-player.component.html'
})
export class AddPlayerComponent implements OnInit {
  private fb = inject(FormBuilder);
  private playerApi = inject(PlayerService);
  private clubApi = inject(ClubService);

  clubs: ClubDTO[] = [];

  serverError = '';
  successMsg = '';

  fg = this.fb.group({
    name: ['', [Validators.required]],
    age: [0, [Validators.required, Validators.min(1)]],
    position: ['', [Validators.required]],
    clubId: ['', [Validators.required]],
    marketValue: [0, [Validators.required, Validators.min(0)]],
  });

  ngOnInit(): void {
    this.clubApi.list().subscribe({
      next: list => this.clubs = list,
      error: () => { this.serverError = 'Greška pri učitavanju klubova.'; }
    });
  }

  submit() {
    this.serverError = '';
    this.successMsg = '';

    if (this.fg.invalid) return;

    const raw = this.fg.getRawValue();
    this.playerApi.create({
      name: raw.name!,
      age: Number(raw.age),
      position: raw.position as 'GK' | 'DF' | 'MF' | 'FW',
      clubId: Number(raw.clubId),
      marketValue: Number(raw.marketValue)
    }).subscribe({
      next: () => {
        this.successMsg = 'Igrač je uspešno dodat.';
      },
      error: (err) => {
        const msg = err?.error?.error || 'Greška pri dodavanju igrača.';
        this.serverError = msg;
      }
    });
  }
}
