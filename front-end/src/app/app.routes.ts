import { Routes } from '@angular/router';
import { roleGuard } from './core/guards/role.guard';

export const routes: Routes = [
  {
    path: '',
    loadComponent: () => import('./features/home/home.component').then((m) => m.HomeComponent),
  },
  {
    path: 'clubs',
    loadComponent: () =>
      import('./features/clubs/clubs-list.component').then((m) => m.ClubsListComponent),
  },
  {
    path: 'clubs/add',
    loadComponent: () =>
      import('./features/clubs/add-club.component').then((m) => m.AddClubComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'clubs/delete',
    loadComponent: () =>
      import('./features/clubs/delete-club.component').then((m) => m.DeleteClubComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'clubs/edit',
    loadComponent: () =>
      import('./features/clubs/edit-club.component').then((m) => m.EditClubComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'transfers',
    loadComponent: () =>
      import('./features/transfers/transfers-page.component').then((m) => m.TransfersPageComponent),
  },
  {
    path: 'transfers/new',
    loadComponent: () =>
      import('./features/transfers/transfers-form.component').then((m) => m.TransferFormComponent),
  },
  {
    path: 'transfers/delete',
    loadComponent: () =>
      import('./features/transfers/delete-transfer.component').then(
        (m) => m.DeleteTransferComponent
      ),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'transfers/report',
    loadComponent: () =>
      import('./features/transfers/transfer-report.component').then(
        (m) => m.TransferReportComponent
      ),
  },
  {
    path: 'login',
    loadComponent: () => import('./features/auth/login.component').then((m) => m.LoginComponent),
  },
  {
    path: 'register',
    loadComponent: () =>
      import('./features/auth/register.component').then((m) => m.RegisterComponent),
  },
  {
    path: 'players',
    loadComponent: () =>
      import('./features/players/players-page.component').then((m) => m.PlayersPageComponent),
  },
  {
    path: 'players/add',
    loadComponent: () =>
      import('./features/players/add-player.component').then((m) => m.AddPlayerComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'players/delete',
    loadComponent: () =>
      import('./features/players/delete-player.component').then((m) => m.DeletePlayerComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'players/edit-search',
    loadComponent: () =>
      import('./features/players/player-edit-search.component').then(
        (m) => m.PlayerEditSearchComponent
      ),
  },
  {
    path: 'players/:id/edit',
    loadComponent: () =>
      import('./features/players/player-edit.component').then((m) => m.PlayerEditComponent),
  },
  {
    path: 'admin/home',
    loadComponent: () =>
      import('./features/home/admin-home.component').then((m) => m.AdminHomeComponent),
    canActivate: [roleGuard('ADMIN')],
  },
  {
    path: 'manager/home',
    loadComponent: () =>
      import('./features/home/manager-home.component').then((m) => m.ManagerHomeComponent),
    canActivate: [roleGuard('MANAGER')],
  },
  {
    path: 'favorite',
    loadComponent: () =>
      import('./features/favorite/favorite-page.component').then((m) => m.FavoritePageComponent),
  },
  {
    path: 'watchlist',
    loadComponent: () =>
      import('./features/watchlist/watchlist-page.component').then((m) => m.WatchlistPageComponent),
  },

  { path: '**', redirectTo: '' },
];
