// src/app/features/transfers/transfers-page.component.ts
import { Component, inject, signal } from '@angular/core';
import { CommonModule, DatePipe, NgFor, NgIf } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { TransferService } from './transfers.service';
import { TransferDTO, ClubDTO } from '../../core/models';
import { ClubService } from '../clubs/club.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-transfers-page',
  imports: [CommonModule, FormsModule, NgFor, NgIf, DatePipe, RouterLink, BackHomeComponent],
  templateUrl: './transfers-page.component.html'
})
export class TransfersPageComponent {
  private api = inject(TransferService);
  private clubsApi = inject(ClubService);

  transfers = signal<TransferDTO[]>([]);
  clubs = signal<ClubDTO[]>([]);

  playerName = '';
  season = '';
  clubId: number | undefined = undefined;

  constructor() {
    this.clubsApi.list().subscribe(cs => this.clubs.set(cs));
    this.search();
  }

  search() {
    this.api.list({
      playerName: this.playerName || undefined,
      season: this.season || undefined,
      clubId: this.clubId ?? undefined
    }).subscribe(list => this.transfers.set(list));
  }

  reset() {
    this.playerName = '';
    this.season = '';
    this.clubId = undefined;
    this.search();
  }
}
