import { Injectable } from "@angular/core"
import { BehaviorSubject } from "rxjs"
import {DashboardConfig, Patient,Doctor} from '../model/dashboard.model';

@Injectable({
  providedIn: "root",
})
export class DashboardService {
  private activeTabSubject = new BehaviorSubject<string>("dashboard")
  public activeTab$ = this.activeTabSubject.asObservable()

  constructor() {}

  setActiveTab(tab: string): void {
    this.activeTabSubject.next(tab)
  }

  getAdminConfig(): DashboardConfig {
    return {
      userType: "admin",
      userName: "Admin User",
      userRole: "Administrateur",
      sidebarItems: [
        { id: "dashboard", label: "Overview", icon: "chart-line", gradient: "from-teal-500 to-cyan-500" },
        { id: "doctors", label: "Médecins", icon: "user-md", gradient: "from-teal-500 to-turquoise-500" },
        {
          id: "users",
          label: "Utilisateurs",
          icon: "users",
          badge: "247",
          gradient: "from-teal-600 to-cyan-600",
        },
        { id: "content", label: "Contenu", icon: "file-alt", gradient: "from-teal-700 to-cyan-700" },
        { id: "analytics", label: "Analytics", icon: "chart-bar", gradient: "from-teal-800 to-cyan-800" },
      ],
      stats: [
        {
          title: "Médecins Actifs",
          value: "156",
          change: "+12% ce mois",
          changeType: "positive",
          icon: "users",
          gradient: "from-teal-500 to-cyan-500",
          description: "Médecins validés et actifs",
        },
        {
          title: "Consultations",
          value: "2,847",
          change: "+23% ce mois",
          changeType: "positive",
          icon: "heartbeat",
          gradient: "from-teal-600 to-cyan-600",
          description: "Consultations ce mois",
        },
        {
          title: "Nouveaux Patients",
          value: "1,247",
          change: "+8% ce mois",
          changeType: "positive",
          icon: "user-plus",
          gradient: "from-teal-700 to-cyan-700",
          description: "Inscriptions ce mois",
        },
        {
          title: "Taux de Satisfaction",
          value: "98.5%",
          change: "+2.1% ce mois",
          changeType: "positive",
          icon: "chart-line",
          gradient: "from-teal-800 to-cyan-800",
          description: "Satisfaction moyenne",
        },
      ],
      mainContent: [],
    }
  }

  getDoctorConfig(): DashboardConfig {
    return {
      userType: "doctor",
      userName: "Dr. Marie Dubois",
      userRole: "Cardiologue",
      sidebarItems: [
        { id: "dashboard", label: "Overview", icon: "chart-line", gradient: "from-teal-500 to-cyan-500" },
        {
          id: "appointments",
          label: "Rendez-vous",
          icon: "calendar-alt",
          gradient: "from-teal-600 to-cyan-600",
        },
        {
          id: "consultations",
          label: "Consultations",
          icon: "stethoscope",
          gradient: "from-teal-700 to-cyan-700",
        },
        { id: "articles", label: "Articles", icon: "file-alt", gradient: "from-teal-800 to-cyan-800" },
        { id: "schedule", label: "Planning", icon: "clock", gradient: "from-teal-500 to-turquoise-500" },
        { id: "reviews", label: "Avis", icon: "star", gradient: "from-teal-600 to-turquoise-600" },
      ],
      stats: [
        {
          title: "Consultations Aujourd'hui",
          value: "12",
          change: "+3 vs hier",
          changeType: "positive",
          icon: "calendar-day",
          gradient: "from-teal-500 to-cyan-500",
          description: "Rendez-vous programmés",
        },
        {
          title: "Patients ce Mois",
          value: "247",
          change: "+18% ce mois",
          changeType: "positive",
          icon: "users",
          gradient: "from-teal-600 to-cyan-600",
          description: "Patients uniques consultés",
        },
        {
          title: "Note Moyenne",
          value: "4.9",
          change: "+0.2 ce mois",
          changeType: "positive",
          icon: "star",
          gradient: "from-teal-700 to-cyan-700",
          description: "Sur 5 étoiles",
        },
        {
          title: "Articles Publiés",
          value: "23",
          change: "+5 ce mois",
          changeType: "positive",
          icon: "file-alt",
          gradient: "from-teal-800 to-cyan-800",
          description: "Articles médicaux",
        },
      ],
      mainContent: [],
    }
  }

  getPendingDoctors(): Doctor[] {
    return [
      {
        id: 1,
        name: "Dr. Marie Dubois",
        email: "marie.dubois@email.com",
        specialty: "Cardiologie",
        matricule: "MAT123456",
        submittedAt: "2024-01-15",
        status: "pending",
        experience: "8 ans",
        hospital: "CHU de Paris",
      },
      {
        id: 2,
        name: "Dr. Jean Martin",
        email: "jean.martin@email.com",
        specialty: "Dermatologie",
        matricule: "MAT789012",
        submittedAt: "2024-01-14",
        status: "pending",
        experience: "12 ans",
        hospital: "Hôpital Saint-Louis",
      },
    ]
  }

  getPendingConsultations(): Patient[] {
    return [
      {
        id: 1,
        name: "Lucie Bernard",
        email: "lucie.bernard@email.com",
        avatar: "LB",
        time: "09:15",
        type: "Consultation",
        status: "En attente",
        reason: "Douleurs abdominales",
      },
      {
        id: 2,
        name: "Robert Garcia",
        email: "robert.garcia@email.com",
        avatar: "RG",
        time: "10:00",
        type: "Téléconsultation",
        status: "Urgent",
        reason: "Forte fièvre",
      },
      {
        id: 3,
        name: "Isabelle Lefevre",
        email: "isabelle.lefevre@email.com",
        avatar: "IL",
        time: "11:30",
        type: "Consultation",
        status: "Prioritaire",
        reason: "Problèmes cardiaques",
      },
    ]
  }
}
