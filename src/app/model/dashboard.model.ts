export interface DashboardConfig {
  userType: "admin" | "doctor"
  userName: string
  userRole: string
  sidebarItems: SidebarItem[]
  stats: StatCard[]
  mainContent: DashboardSection[]
}

export interface SidebarItem {
  id: string
  label: string
  icon: string // Just the icon name, e.g., "chart-line"
  gradient: string
  badge?: string
}

export interface StatCard {
  title: string
  value: string
  change?: string
  changeType?: "positive" | "negative" | "neutral"
  icon: string // Just the icon name, e.g., "users"
  gradient: string
  description?: string
}

export interface DashboardSection {
  id: string
  title: string
  description?: string
  component: string
  data?: any
}

export interface Patient {
  id: number
  name: string
  email: string
  avatar: string
  time?: string
  type?: string
  status?: string
  reason?: string
}

export interface Doctor {
  id: number
  name: string
  email: string
  specialty: string
  matricule: string
  submittedAt: string
  status: string
  experience: string
  hospital: string
}
