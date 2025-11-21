import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

export function roleGuard(requiredRole: 'ADMIN' | 'MANAGER'): CanActivateFn {
  return () => {
    const auth = inject(AuthService);
    const router = inject(Router);
    const roles = auth.getRoles().map((r) => r.toUpperCase());
    const ok = roles.includes(requiredRole) || roles.includes('ROLE_' + requiredRole);
    if (!ok) router.navigateByUrl('/login');
    return ok;
  };
}
