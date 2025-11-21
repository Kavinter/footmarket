import { Injectable, inject } from '@angular/core';
import { ApiService } from '../../core/services/api.service';
import { TransferDTO } from '../../core/models';
import { HttpParams } from '@angular/common/http';

@Injectable({ providedIn: 'root' })
export class TransferService {
  private api = inject(ApiService);

  list(params?: { playerName?: string; clubId?: number; season?: string }) {
    const qp: Record<string, any> = {};
    if (params?.playerName) qp['playerName'] = params.playerName;
    if (params?.clubId != null) qp['clubId'] = params.clubId;
    if (params?.season) qp['season'] = params.season;
    return this.api.get<TransferDTO[]>('/transfers', qp);
  }

  create(dto: TransferDTO) {
    return this.api.post<TransferDTO>('/transfers', dto);
  }

  deleteByPlayerAndDate(playerName: string, dateISO: string) {
    const params = new HttpParams({ fromObject: { playerName, date: dateISO } });
    return this.api.delete<void>(`/transfers/by-player-and-date?playerName=${encodeURIComponent(playerName)}&date=${encodeURIComponent(dateISO)}`);
  }

  getSeasonReport(season: string) {
    return this.api.getBlob('/transfers/report', { season });
  }
}
