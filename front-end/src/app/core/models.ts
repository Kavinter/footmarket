export interface TransferDTO {
  playerName: string;
  fromClubName: string;
  toClubName: string;
  season: string;          
  transferDate: string;    
  transferFee: number;     
}
export interface ClubDTO {
  id: number;
  name: string;
  country: string;
  foundedYear: number;
}
export interface PlayerDTO {
  id: number;
  name: string;
  age: number;
  position: 'GK' | 'DF' | 'MF' | 'FW' | string;
  clubName: string;
  clubId: number;       
  marketValue: number;    
}
