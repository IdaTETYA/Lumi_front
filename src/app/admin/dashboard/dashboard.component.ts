import {Component, OnInit} from '@angular/core';
import {DashboardService} from "../../service/DashboardService";

@Component({
  selector: 'app-dashboard-admin',
  standalone: false,
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss',
})
export class DashboardComponentAdmin implements OnInit {

  // Statistiques principales
  stats = [
    {
      title: 'Médecins Actifs',
      value: 156,
      icon: 'user-md',
      subtitle: 'Médecins validés et actifs',
      growth: '+12% ce mois',
      color: 'blue'
    },
    {
      title: 'Consultations',
      value: '2,847',
      icon: 'heartbeat',
      subtitle: 'Consultations ce mois',
      growth: '+23% ce mois',
      color: 'green'
    },
    {
      title: 'Nouveaux Patients',
      value: '1,247',
      icon: 'user-plus',
      subtitle: 'Inscriptions ce mois',
      growth: '+8% ce mois',
      color: 'purple'
    },
    {
      title: 'Taux de Satisfaction',
      value: '98.5%',
      icon: 'star',
      subtitle: 'Satisfaction moyenne',
      growth: '+2.1% ce mois',
      color: 'orange'
    }
  ];

  // Activités récentes
  recentActivities = [
    {
      id: 1,
      title: 'Dr. Paul Durand a été validé',
      time: 'Il y a 2 heures',
      icon: 'check',
      color: 'green'
    },
    {
      id: 2,
      title: 'Nouvel article publié: \'Prévention COVID-19\'',
      time: 'Il y a 4 heures',
      icon: 'file-alt',
      color: 'blue'
    },
    {
      id: 3,
      title: '247 nouveaux patients inscrits aujourd\'hui',
      time: 'Il y a 6 heures',
      icon: 'users',
      color: 'purple'
    },
    {
      id: 4,
      title: 'Article signalé nécessite une modération',
      time: 'Il y a 8 heures',
      icon: 'exclamation-triangle',
      color: 'orange'
    }
  ];

  // Actions rapides
  quickActions = [
    {
      id: 1,
      title: 'Valider Médecins',
      icon: 'user-check',
      primary: true,
      action: 'validateDoctors'
    },
    {
      id: 2,
      title: 'Gérer Utilisateurs',
      icon: 'users-cog',
      primary: false,
      action: 'manageUsers'
    },
    {
      id: 3,
      title: 'Modérer Contenu',
      icon: 'edit',
      primary: false,
      action: 'moderateContent'
    }
  ];

  // Statut du système
  systemStatus = {
    status: 'operational',
    uptime: '99.9%',
    responseTime: '45ms',
    message: 'Tous les services fonctionnent normalement'
  };

  constructor(private dashboardService: DashboardService) {
  }

  ngOnInit(): void {
    // Initialiser les données du dashboard
    this.loadDashboardData();
  }

  private loadDashboardData(): void {
    // Charger les données depuis le service
    // Cette méthode peut être étendue pour récupérer les données depuis l'API
    console.log('Chargement des données du dashboard médical...');
  }

  // Méthodes pour les actions rapides
  validateDoctors(): void {
    console.log('Redirection vers la validation des médecins');
    // Implémenter la logique de navigation
  }

  manageUsers(): void {
    console.log('Redirection vers la gestion des utilisateurs');
    // Implémenter la logique de navigation
  }

  moderateContent(): void {
    console.log('Redirection vers la modération de contenu');
    // Implémenter la logique de navigation
  }

  // Méthode pour rafraîchir les données
  refreshData(): void {
    this.loadDashboardData();
  }

  // Méthode pour obtenir la classe CSS selon la couleur
  getColorClass(color: string): string {
    const colorClasses: { [key: string]: string } = {
      'blue': 'text-blue-600',
      'green': 'text-green-600',
      'purple': 'text-purple-600',
      'orange': 'text-orange-600'
    };
    return colorClasses[color] || 'text-gray-600';
  }

  // Méthode pour obtenir la classe de fond selon la couleur
  getBgColorClass(color: string): string {
    const bgColorClasses: { [key: string]: string } = {
      'blue': 'bg-blue-100',
      'green': 'bg-green-100',
      'purple': 'bg-purple-100',
      'orange': 'bg-orange-100'
    };
    return bgColorClasses[color] || 'bg-gray-100';
  }
}
