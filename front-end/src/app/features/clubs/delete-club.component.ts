import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubService } from './club.service';

@Component({
  standalone: true,
  selector: 'app-delete-club',
  imports: [CommonModule, ReactiveFormsModule, BackHomeComponent],
  templateUrl: './delete-club.component.html'
})
export class DeleteClubComponent {
  private fb = inject(FormBuilder);
  private clubs = inject(ClubService);

  serverError = '';
  successMsg = '';

  fg = this.fb.group({
    name: ['', [Validators.required]]
  });

  submit() {
    this.serverError = '';
    this.successMsg = '';

    if (this.fg.invalid) return;

    const { name } = this.fg.getRawValue();
    if (!name) return;

    this.clubs.removeByName(name).subscribe({
      next: () => {
        this.successMsg = 'Klub je uspešno obrisan.';
        this.fg.reset();
      },
      error: (err) => {
        if (err.status === 404) {
          this.serverError = 'Klub sa tim imenom nije pronađen.';
        } else {
          this.serverError = 'Greška pri brisanju kluba.';
        }
      }
    });
  }
}
