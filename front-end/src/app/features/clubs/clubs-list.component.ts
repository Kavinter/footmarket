import { Component, inject, signal } from '@angular/core';
import { CommonModule, NgFor, NgIf } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ClubService } from './club.service';
import { ClubDTO } from '../../core/models';
import { RouterLink } from '@angular/router';
import { BackHomeComponent } from '../../shared/back-home.component';
import { ClubRowComponent } from './club-row.component';

@Component({
  standalone: true,
  selector: 'app-clubs-list',
  imports: [
    CommonModule,
    FormsModule,
    NgFor,
    NgIf,
    RouterLink,
    BackHomeComponent,
    ClubRowComponent,
  ],
  templateUrl: './clubs-list.component.html',
})
export class ClubsListComponent {
  private api = inject(ClubService);

  clubs = signal<ClubDTO[]>([]);
  country = '';
  foundedYear?: number;

  selectedClub = signal<ClubDTO | null>(null);

  private lastRequested = { country: '', foundedYear: undefined as number | undefined };

  ngOnInit() {
    this.search();
  }

  search() {
    this.lastRequested = { country: this.country || '', foundedYear: this.foundedYear };
    this.api
      .list({
        country: this.country || undefined,
        foundedYear: this.foundedYear ?? undefined,
      })
      .subscribe((list) => {
        this.clubs.set(list);
        this.selectedClub.set(null);
      });
  }

  reset() {
    this.country = '';
    this.foundedYear = undefined;
    this.search();
  }

  isFallback() {
    return false;
  }

  onSelectClub(c: ClubDTO) {
    this.selectedClub.set(c);
  }
}
