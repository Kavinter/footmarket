import { Component, OnInit, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators, AbstractControl, AsyncValidatorFn, ValidationErrors } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';
import { debounceTime, distinctUntilChanged, first, switchMap, map, catchError, of } from 'rxjs';
import { BackHomeComponent } from '../../shared/back-home.component';

@Component({
  standalone: true,
  selector: 'app-register',
  imports: [CommonModule, ReactiveFormsModule, RouterLink, BackHomeComponent],
  templateUrl: './register.component.html'
})
export class RegisterComponent implements OnInit {
  private fb = inject(FormBuilder);
  private auth = inject(AuthService);
  private router = inject(Router);

  roles = signal<Array<{id:number; name:string}>>([]);
  loading = signal<boolean>(false);
  okMsg = signal<string>('');
  errMsg = signal<string>('');

  fg = this.fb.group({
    username: this.fb.control('', {
      validators: [Validators.required, Validators.minLength(3)],
      asyncValidators: [this.usernameTakenValidator()],
      updateOn: 'blur'
    }),
    email: this.fb.control('', {
      validators: [Validators.required, Validators.email],
      asyncValidators: [this.emailTakenValidator()],
      updateOn: 'blur'
    }),
    password: this.fb.control('', [Validators.required, Validators.minLength(6)]),
    roleId: this.fb.control<number | null>(null, [Validators.required])
  });

  get fc() { return this.fg.controls; }

  ngOnInit(): void {
    this.auth.listRoles().subscribe({
        next: list => this.roles.set(list),
        error: _ => this.errMsg.set('Ne mogu da učitam uloge.')
    });
  }

  private usernameTakenValidator(): AsyncValidatorFn {
    return (ctrl: AbstractControl) => {
      return of(ctrl.value).pipe(
        debounceTime(300),
        distinctUntilChanged(),
        switchMap(val => this.auth.checkUsername(val || '')),
        map(taken => taken ? ({ usernameTaken: true } as ValidationErrors) : null),
        catchError(() => of(null)),
        first()
      );
    };
  }

  private emailTakenValidator(): AsyncValidatorFn {
    return (ctrl: AbstractControl) => {
      return of(ctrl.value).pipe(
        debounceTime(300),
        distinctUntilChanged(),
        switchMap(val => this.auth.checkEmail(val || '')),
        map(taken => taken ? ({ emailTaken: true } as ValidationErrors) : null),
        catchError(() => of(null)),
        first()
      );
    };
  }

  submit() {
    this.okMsg.set(''); this.errMsg.set('');
    if (this.fg.invalid) return;

    const payload = {
      username: this.fc.username.value!.trim(),
      email: this.fc.email.value!.trim(),
      password: this.fc.password.value!,
      roleId: Number(this.fc.roleId.value)
    };

    this.loading.set(true);
    this.auth.register(payload).subscribe({
      next: (res) => {
        this.loading.set(false);
        if (res.status === 201) {
          this.okMsg.set('Uspešna registracija. Preusmeravam na prijavu...');
          setTimeout(() => this.router.navigateByUrl('/login'), 800);
        } else {
          this.errMsg.set('Neočekivan odgovor servera.');
        }
      },
      error: (e) => {
        this.loading.set(false);
        if (e.status === 409 && e.error) {
          const firstKey = Object.keys(e.error)[0];
          this.errMsg.set(e.error[firstKey] ?? 'Korisničko ime ili email već postoji.');
        } else if (e.status === 400 && e.error) {
          const firstKey = Object.keys(e.error)[0];
          this.errMsg.set(e.error[firstKey] ?? 'Validacija neuspešna.');
        } else {
          this.errMsg.set('Greška pri registraciji.');
        }
      }
    });
  }
}
