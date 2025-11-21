import { Component, inject } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ClubService } from './club.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-add-club',
  imports: [CommonModule, ReactiveFormsModule, NgIf, RouterLink, BackHomeComponent],
  templateUrl: './add-club.component.html'
})
export class AddClubComponent {
  private fb = inject(FormBuilder);
  private clubs = inject(ClubService);

  serverError = '';
  successMsg = '';

  fg = this.fb.group({
    name: ['', [Validators.required]],
    country: ['', [Validators.required, Validators.pattern(/^[^0-9]*$/)]],
    foundedYear: [0, [Validators.required, Validators.min(1)]],
  });

  submit() {
    this.serverError = '';
    this.successMsg = '';

    if (this.fg.invalid) return;

    const { name, country, foundedYear } = this.fg.getRawValue();
    this.clubs.create({
      name: name!,
      country: country!,
      foundedYear: foundedYear!
    }).subscribe({
      next: () => {
        this.successMsg = 'Klub je uspešno dodat.';
      },
      error: (err) => {
        const msg = err?.error?.error || 'Greška pri dodavanju kluba.';
        this.serverError = msg;
      }
    });
  }
}
