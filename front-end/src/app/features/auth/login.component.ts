import { Component, inject } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-login',
  imports: [ReactiveFormsModule, CommonModule, RouterLink, BackHomeComponent],
  templateUrl: './login.component.html'
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  private auth = inject(AuthService);
  private router = inject(Router);

  error = '';

  fg = this.fb.group({
    username: ['', Validators.required],
    password: ['', Validators.required],
  });

  submit() {
  if (this.fg.invalid) return;
  const { username, password } = this.fg.getRawValue();

  this.auth.login(username!, password!).subscribe({
    next: () => {
      const roles = this.auth.getRoles().map(r => r.toUpperCase());
      if (roles.includes('ROLE_ADMIN') || roles.includes('ADMIN')) {
        this.router.navigateByUrl('/admin/home');
      } else if (roles.includes('ROLE_MANAGER') || roles.includes('MANAGER')) {
        this.router.navigateByUrl('/manager/home');
      } else {
        this.router.navigateByUrl('/');
      }
    },
    error: () => this.error = 'Neuspešna prijava!'
  });
}
}
