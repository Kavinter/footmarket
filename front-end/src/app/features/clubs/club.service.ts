import { Injectable, inject } from '@angular/core';
import { ApiService } from '../../core/services/api.service';
import { ClubDTO } from '../../core/models';

@Injectable({ providedIn: 'root' })
export class ClubService {
  private api = inject(ApiService);

  list(params?: { country?: string; foundedYear?: number }) {
    const qp: Record<string, any> = {};
    if (params?.country) qp['country'] = params.country;
    if (params?.foundedYear != null) qp['foundedYear'] = params.foundedYear;
    return this.api.get<ClubDTO[]>('/clubs', qp);
  }

  find(id: number) {
    return this.api.get<ClubDTO>(`/clubs/${id}`);
  }

  findByName(name: string) {
    const q = encodeURIComponent(name);
    return this.api.get<ClubDTO>(`/clubs/by-name?name=${q}`);
  }

  create(dto: { name: string; country: string; foundedYear: number }) {
    return this.api.post<ClubDTO>('/clubs', dto);
  }

  update(id: number, dto: Partial<ClubDTO>) {
    return this.api.put<ClubDTO>(`/clubs/${id}`, dto);
  }

  remove(id: number) {
    return this.api.delete<void>(`/clubs/${id}`);
  }

  removeByName(name: string) {
    const q = encodeURIComponent(name);
    return this.api.delete<void>(`/clubs/by-name?name=${q}`);
  }
}
