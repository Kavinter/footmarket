import { Component, inject } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { PlayerService } from './player.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-delete-player',
  imports: [CommonModule, ReactiveFormsModule, NgIf, BackHomeComponent],
  templateUrl: './delete-player.component.html'
})
export class DeletePlayerComponent {
  private fb = inject(FormBuilder);
  private players = inject(PlayerService);

  msg = '';
  err = '';

  fg = this.fb.group({
    name: ['', Validators.required],
    club: ['', Validators.required],
  });

  submit() {
    this.msg = '';
    this.err = '';

    if (this.fg.invalid) return;

    const { name, club } = this.fg.value;

    this.players.deleteByName(name!, club!).subscribe({
      next: () => {
        this.msg = 'Igrač je uspešno obrisan.';
      },
      error: () => {
        this.err = 'Igrač nije pronađen ili nije mogao biti obrisan.';
      }
    });
  }
}
