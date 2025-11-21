import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ClubDTO } from '../../core/models';

@Component({
  standalone: true,
  selector: 'tr[app-club-row]',
  imports: [CommonModule],
  templateUrl: './club-row.component.html',
  host: {
    '(click)': 'onRowClick()',
  },
})
export class ClubRowComponent {
  @Input() club!: ClubDTO;
  @Output() selectClub = new EventEmitter<ClubDTO>();

  onRowClick() {
    this.selectClub.emit(this.club);
  }
}
