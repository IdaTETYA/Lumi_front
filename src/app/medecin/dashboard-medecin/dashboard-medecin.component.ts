import {Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-dashboard-medecin',
  standalone: false,
  templateUrl: './dashboard-medecin.component.html',
  styleUrl: './dashboard-medecin.component.scss'
})
export class DashboardMedecinComponent implements OnInit {

  // Informations du médecin
  doctorInfo = {
    name: 'Dr. Dubois',
    title: 'Médecin',
    status: 'Disponible',
    isOnline: true,
    todayConsultations: 4
  };

  // Statistiques principales
  stats = [
    {
      title: 'Consultations Aujourd\'hui',
      value: 12,
      icon: 'calendar-day',
      subtitle: 'Rendez-vous programmés',
      growth: '+3 vs hier',
      color: 'blue'
    },
    {
      title: 'Patients ce Mois',
      value: 247,
      icon: 'users',
      subtitle: 'Patients uniques consultés',
      growth: '+18% ce mois',
      color: 'green'
    },
    {
      title: 'Note Moyenne',
      value: '4.9',
      icon: 'star',
      subtitle: 'Sur 5 étoiles',
      growth: '+0.2 ce mois',
      color: 'orange'
    },
    {
      title: 'Articles Publiés',
      value: 23,
      icon: 'file-alt',
      subtitle: 'Articles médicaux',
      growth: '+5 ce mois',
      color: 'purple'
    }
  ];

  // Rendez-vous du jour
  todayAppointments = [
    {
      id: 1,
      patientName: 'Marie Dupont',
      patientInitials: 'MD',
      time: '09:00',
      type: 'Consultation',
      typeColor: 'blue',
      description: 'Contrôle de routine',
      avatarColor: 'blue',
      status: 'upcoming'
    },
    {
      id: 2,
      patientName: 'Jean Martin',
      patientInitials: 'JM',
      time: '10:30',
      type: 'Téléconsultation',
      typeColor: 'green',
      description: 'Suivi post-opératoire',
      avatarColor: 'green',
      status: 'upcoming'
    },
    {
      id: 3,
      patientName: 'Sophie Laurent',
      patientInitials: 'SL',
      time: '14:00',
      type: 'Consultation',
      typeColor: 'blue',
      description: 'Première consultation',
      avatarColor: 'purple',
      status: 'upcoming'
    },
    {
      id: 4,
      patientName: 'Pierre Durand',
      patientInitials: 'PD',
      time: '15:30',
      type: 'Téléconsultation',
      typeColor: 'green',
      description: 'Résultats d\'analyses',
      avatarColor: 'orange',
      status: 'upcoming'
    }
  ];

  // Métriques de performance
  performanceMetrics = {
    satisfactionRate: 98,
    monthlyConsultations: 247,
    averageConsultationTime: '28min'
  };

  // Avis récents
  recentReviews = [
    {
      id: 1,
      patientName: 'Marie D.',
      patientInitials: 'MD',
      rating: 5,
      comment: 'Excellent médecin, très à l\'écoute et professionnel. Je recommande vivement!',
      timeAgo: 'Il y a 2 heures',
      avatarColor: 'orange'
    },
    {
      id: 2,
      patientName: 'Jean M.',
      patientInitials: 'JM',
      rating: 5,
      comment: 'Consultation très professionnelle, explications claires et rassurantes.',
      timeAgo: 'Il y a 1 jour',
      avatarColor: 'green'
    }
  ];

  // Notifications
  notifications = 3;

  // Date actuelle
  currentDate = 'dimanche 13 juillet 2025';

  constructor() {}

  ngOnInit(): void {
    this.loadDashboardData();
  }

  private loadDashboardData(): void {
    // Simuler le chargement des données
    console.log('Chargement des données du dashboard médecin...');
    // Ici vous pouvez ajouter des appels API pour récupérer les vraies données
  }

  // Méthodes pour les actions
  startConsultation(appointmentId: number): void {
    console.log(`Démarrage de la consultation pour l'ID: ${appointmentId}`);
    // Logique pour démarrer la consultation
  }

  toggleOnlineStatus(): void {
    this.doctorInfo.isOnline = !this.doctorInfo.isOnline;
    this.doctorInfo.status = this.doctorInfo.isOnline ? 'Disponible' : 'Hors ligne';
  }

  openNotifications(): void {
    console.log('Ouverture des notifications');
    // Logique pour ouvrir le panneau des notifications
  }

  // Méthodes pour les classes CSS
  getColorClass(color: string): string {
    const colorClasses: { [key: string]: string } = {
      'blue': 'text-blue-600',
      'green': 'text-green-600',
      'purple': 'text-purple-600',
      'orange': 'text-orange-600'
    };
    return colorClasses[color] || 'text-gray-600';
  }

  getBgColorClass(color: string): string {
    const bgColorClasses: { [key: string]: string } = {
      'blue': 'bg-blue-100',
      'green': 'bg-green-100',
      'purple': 'bg-purple-100',
      'orange': 'bg-orange-100'
    };
    return bgColorClasses[color] || 'bg-gray-100';
  }

  getAvatarColorClass(color: string): string {
    const avatarColorClasses: { [key: string]: string } = {
      'blue': 'bg-blue-600',
      'green': 'bg-green-600',
      'purple': 'bg-purple-600',
      'orange': 'bg-orange-600'
    };
    return avatarColorClasses[color] || 'bg-gray-600';
  }

  getTypeColorClass(color: string): string {
    const typeColorClasses: { [key: string]: string } = {
      'blue': 'bg-blue-100 text-blue-800',
      'green': 'bg-green-100 text-green-800',
      'purple': 'bg-purple-100 text-purple-800',
      'orange': 'bg-orange-100 text-orange-800'
    };
    return typeColorClasses[color] || 'bg-gray-100 text-gray-800';
  }

  // Méthode pour générer un tableau d'étoiles
  getStarArray(rating: number): number[] {
    return Array(5).fill(0).map((_, i) => i < rating ? 1 : 0);
  }

  // Méthode pour formater la date
  formatDate(date: string): string {
    return date;
  }

  // Méthode pour rafraîchir les données
  refreshData(): void {
    this.loadDashboardData();
  }
}
