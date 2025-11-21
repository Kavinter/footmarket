import { Component, inject } from '@angular/core';
import { CommonModule, NgIf, NgFor } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { TransferService } from './transfers.service';
import { ClubService } from '../clubs/club.service';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubDTO, TransferDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'app-transfer-form',
  imports: [CommonModule, ReactiveFormsModule, NgIf, NgFor, RouterLink, BackHomeComponent],
  templateUrl: './transfers-form.component.html'
})
export class TransferFormComponent {
  private fb = inject(FormBuilder);
  private api = inject(TransferService);
  private clubsApi = inject(ClubService);

  clubs: ClubDTO[] = [];
  showFromClub = false;

  serverError = '';
  successMsg = '';

  playerNameError = '';
  dateError = '';
  seasonError = '';

  fg = this.fb.group({
    playerName: ['', Validators.required],
    fromClubName: [''],
    toClubName: ['', Validators.required],
    transferFee: [0, [Validators.required, Validators.min(0)]],
    transferDate: ['', Validators.required],       // yyyy-MM-dd
    season: ['', [Validators.required, Validators.pattern(/^\d{2}\/\d{2}$/)]],
  });

  ngOnInit() {
    this.clubsApi.list().subscribe({
      next: list => this.clubs = list,
      error: () => {}
    });
  }

  onDateChange() {
    const ctrl = this.fg.controls.transferDate;
    const val = ctrl.value;
    this.dateError = '';

    if (!val) {
      this.showFromClub = false;
      this.clearFromClubValidators();
      return;
    }

    const selected = new Date(val);
    const today = new Date();
    today.setHours(0,0,0,0);
    selected.setHours(0,0,0,0);

    if (selected < today) {
      this.showFromClub = true;
      this.setFromClubRequired();
    } else {
      this.showFromClub = false;
      this.clearFromClubValidators();
      this.fg.controls.fromClubName.setValue('');
    }
  }

  private setFromClubRequired() {
    this.fg.controls.fromClubName.setValidators([Validators.required]);
    this.fg.controls.fromClubName.updateValueAndValidity();
  }

  private clearFromClubValidators() {
    this.fg.controls.fromClubName.clearValidators();
    this.fg.controls.fromClubName.updateValueAndValidity();
  }

  save() {
    this.serverError = '';
    this.successMsg = '';
    this.playerNameError = '';
    this.dateError = '';
    this.seasonError = '';

    if (this.fg.invalid) return;

    const raw = this.fg.getRawValue();

    const today = new Date();
    today.setHours(0,0,0,0);
    const selected = new Date(raw.transferDate as string);
    selected.setHours(0,0,0,0);

    if (selected.getTime() === today.getTime()) {
      this.dateError = 'Transfer se ne može uneti za današnji dan. Odaberite datum u prošlosti ili budućnosti.';
      return;
    }

    const dto: TransferDTO = {
      playerName: raw.playerName!,
      fromClubName: this.showFromClub ? (raw.fromClubName || '')! : '',
      toClubName: raw.toClubName!,
      transferFee: Number(raw.transferFee),
      transferDate: raw.transferDate as string,
      season: raw.season!
    };

    this.api.create(dto).subscribe({
      next: () => {
        this.successMsg = 'Transfer je uspešno sačuvan.';
        this.fg.reset({
          playerName: '',
          fromClubName: '',
          toClubName: '',
          transferFee: 0,
          transferDate: '',
          season: ''
        });
        this.showFromClub = false;
      },
      error: (err) => {
        const field = err?.error?.field;
        const msg = err?.error?.message || err?.error?.error || 'Greška pri čuvanju transfera.';

        if (field === 'playerName') {
          this.playerNameError = msg;
        } else if (field === 'transferDate') {
          this.dateError = msg;
        } else if (field === 'season') {
          this.seasonError = msg;
        } else {
          this.serverError = msg;
        }
      }
    });
  }
}
