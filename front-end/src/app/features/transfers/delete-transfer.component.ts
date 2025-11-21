import { Component, inject } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { TransferService } from './transfers.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-delete-transfer',
  imports: [CommonModule, ReactiveFormsModule, NgIf, RouterLink, BackHomeComponent],
  templateUrl: './delete-transfer.component.html'
})
export class DeleteTransferComponent {
  private fb = inject(FormBuilder);
  private api = inject(TransferService);

  fg = this.fb.group({
    playerName: ['', [Validators.required]],
    transferDate: ['', [Validators.required]],
  });

  successMsg = '';
  errorMsg = '';

  submit() {
    this.successMsg = '';
    this.errorMsg = '';

    if (this.fg.invalid) return;

    const { playerName, transferDate } = this.fg.getRawValue();
    const name = (playerName || '').trim();
    const dateISO = transferDate!;

    if (!name || !dateISO) return;

    this.api.deleteByPlayerAndDate(name, dateISO).subscribe({
      next: () => {
        this.successMsg = 'Transfer je uspešno obrisan.';
        this.errorMsg = '';
      },
      error: (err) => {
        if (err?.status === 404) {
          this.errorMsg = 'Nije pronađen transfer za ovog igrača na zadati datum.';
        } else if (err?.status === 400) {
          this.errorMsg = 'Neispravan datum ili podaci za brisanje transfera.';
        } else {
          this.errorMsg = 'Greška pri brisanju transfera.';
        }
        this.successMsg = '';
      }
    });
  }
}
