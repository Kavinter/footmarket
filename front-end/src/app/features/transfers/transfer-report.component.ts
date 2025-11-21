import { Component, inject } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { BackHomeComponent } from '../../shared/back-home.component';
import { TransferService } from '../transfers/transfers.service';

@Component({
  standalone: true,
  selector: 'app-transfer-report',
  imports: [CommonModule, ReactiveFormsModule, NgIf, RouterLink, BackHomeComponent],
  templateUrl: './transfer-report.component.html'
})
export class TransferReportComponent {
  private fb = inject(FormBuilder);
  private transferService = inject(TransferService);

  fg = this.fb.group({
    season: ['', [Validators.required, Validators.pattern(/^\d{2}\/\d{2}$/)]],
  });

  errorMsg = '';

  openReport() {
    this.errorMsg = '';

    if (this.fg.invalid) {
      this.fg.markAllAsTouched();
      return;
    }

    const season = this.fg.getRawValue().season!;

    this.transferService.getSeasonReport(season).subscribe({
      next: (blob) => {
        const fileURL = URL.createObjectURL(blob);
        window.open(fileURL, '_blank');
      },
      error: (err) => {
        console.error(err);
        if (err.status === 401 || err.status === 403) {
          this.errorMsg = 'Nemaš dozvolu da pristupiš ovom izveštaju.';
        } else {
          this.errorMsg = 'Greška pri generisanju izveštaja.';
        }
      }
    });
  }
}
