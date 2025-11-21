import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubService } from './club.service';
import { FormsModule } from '@angular/forms';

@Component({
  standalone: true,
  selector: 'app-edit-club',
  imports: [CommonModule, ReactiveFormsModule, BackHomeComponent, FormsModule],
  templateUrl: './edit-club.component.html'
})
export class EditClubComponent {
  private fb = inject(FormBuilder);
  private clubs = inject(ClubService);

  searchName = '';
  searchError = '';

  private currentId: number | null = null;

  fg = this.fb.group({
    name: ['', [Validators.required]],
    country: ['', [Validators.required, Validators.pattern(/^[^0-9]*$/)]],
    foundedYear: [0, [Validators.required, Validators.min(1)]],
  });

  loaded = false;
  saveMsg = '';
  saveError = '';

  search() {
    this.searchError = '';
    this.saveMsg = '';
    this.saveError = '';
    this.loaded = false;
    this.currentId = null;

    const name = this.searchName.trim();
    if (!name) {
      this.searchError = 'Ime kluba je obavezno.';
      return;
    }

    this.clubs.findByName(name).subscribe({
      next: dto => {
        this.currentId = dto.id;
        this.loaded = true;
        this.fg.setValue({
          name: dto.name,
          country: dto.country,
          foundedYear: dto.foundedYear
        });
      },
      error: err => {
        if (err.status === 404) {
          this.searchError = 'Klub sa tim imenom nije pronađen.';
        } else {
          this.searchError = 'Greška pri pretrazi kluba.';
        }
      }
    });
  }

  submit() {
    this.saveMsg = '';
    this.saveError = '';

    if (!this.loaded || this.currentId == null || this.fg.invalid) return;

    const { name, country, foundedYear } = this.fg.getRawValue();
    this.clubs.update(this.currentId, {
      name: name!,
      country: country!,
      foundedYear: foundedYear!
    }).subscribe({
      next: () => {
        this.saveMsg = 'Izmene su uspešno sačuvane.';
      },
      error: () => {
        this.saveError = 'Greška pri čuvanju izmena.';
      }
    });
  }
}
