export interface ServiceJourneyRule {
  id: number;
  machine_name: SJR;
  name: string;
  date_created: string;
  date_updated: string;
}

export enum SJR {
  MESSAGES = 'gp_messages',
  HEALTH_RECORD = 'gp_record_access',
}