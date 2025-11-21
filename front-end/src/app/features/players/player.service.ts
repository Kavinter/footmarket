import { Injectable, inject } from '@angular/core';
import { ApiService } from '../../core/services/api.service';
import { PlayerDTO } from '../../core/models';

@Injectable({ providedIn: 'root' })
export class PlayerService {
  private api = inject(ApiService);

  list(params?: { name?: string; club?: string; position?: string }) {
    const qp: Record<string, any> = {};
    if (params?.name) qp['name'] = params.name;
    if (params?.club) qp['club'] = params.club;
    if (params?.position) qp['position'] = params.position;
    return this.api.get<PlayerDTO[]>('/players', qp);
  }

  getById(id: number) {
    return this.api.get<PlayerDTO>(`/players/${id}`);
  }

  create(dto: {
    name: string;
    age: number;
    position: 'GK' | 'DF' | 'MF' | 'FW';
    clubId: number;
    marketValue: number;
  }) {
    return this.api.post<PlayerDTO>('/players', dto);
  }

  update(id: number, dto: Partial<PlayerDTO>) {
    return this.api.put<PlayerDTO>(`/players/${id}`, dto);
  }

  deleteByName(name: string, club: string) {
    const q = `?name=${encodeURIComponent(name)}&club=${encodeURIComponent(club)}`;
    return this.api.delete<void>(`/players/by-name${q}`);
  }
}
