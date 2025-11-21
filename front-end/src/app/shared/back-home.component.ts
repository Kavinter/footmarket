import { Component, inject, Input } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthService } from '../core/services/auth.service';

@Component({
  standalone: true,
  selector: 'app-back-home',
  imports: [CommonModule],
  templateUrl: './back-home.component.html'
})
export class BackHomeComponent {
  private router = inject(Router);
  private auth = inject(AuthService);

  @Input() label = 'Nazad na početnu';

  go() {
    const path = this.auth.homePath();
    this.router.navigateByUrl(path);
  }
}
