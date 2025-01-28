export interface Message {
  id: string;
  status: "published" | "draft"
  date_created: string;
  date_updated: string;
  content: string;
  to: string;
  subject: string;
}