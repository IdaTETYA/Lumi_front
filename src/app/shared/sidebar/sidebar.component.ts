import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { Router } from '@angular/router';
import { trigger, transition, style, animate } from '@angular/animations';
import { faBars, faDashboard, faBox, faCalendarAlt, faTasks, faChartBar, faUser, faEnvelope, faFileAlt, faBell, faComments, faQuestionCircle, faSignOutAlt, faUserPlus } from '@fortawesome/free-solid-svg-icons';
import { SidebarService } from '../../service/SidebarService';

@Component({
  selector: 'app-sidebar',
  standalone: false,
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss'],
  animations: [
    trigger('fadeInOut', [
      transition(':enter', [
        style({ opacity: 0 }),
        animate('0.2s ease-in', style({ opacity: 1 })),
      ]),
      transition(':leave', [
        animate('0.2s ease-out', style({ opacity: 0 })),
      ]),
    ]),
  ],
})
export class SidebarComponent implements OnInit {
  role: string = 'admin';
  isSidebarExpanded: boolean = true;
  userName: string = 'Dianne Russell';
  userEmail: string = 'dianne.rus@gmail.com';
  showDropdown: boolean = false;

  // FontAwesome icons
  faBars = faBars;
  faDashboard = faDashboard;
  faBox = faBox;
  faCalendarAlt = faCalendarAlt;
  faTasks = faTasks;
  faChartBar = faChartBar;
  faUser = faUser;
  faBell = faBell;
  faComments = faComments;
  faQuestionCircle = faQuestionCircle;

  @Output() sidebarToggled = new EventEmitter<boolean>();

  constructor(protected router: Router, private sidebarService: SidebarService) {}

  ngOnInit(): void {
    this.role = localStorage.getItem('role') || 'user';
    const userInfo = localStorage.getItem('currentUser');
    if (userInfo) {
      const user = JSON.parse(userInfo);
      this.userName = user.nom || 'user';
      this.userEmail = user.email || 'none';
    }
    this.sidebarService.isSidebarExpanded$.subscribe(expanded => {
      this.isSidebarExpanded = expanded;
    });
  }

  toggleSidebar(): void {
    this.isSidebarExpanded = !this.isSidebarExpanded;
    this.sidebarService.setSidebarExpanded(this.isSidebarExpanded);
    this.sidebarToggled.emit(this.isSidebarExpanded); // Émet l'état au parent
    this.showDropdown = false;
  }

  onUserProfileClick(): void {
    if (this.isSidebarExpanded) {
      this.showDropdown = !this.showDropdown;
    }
  }

  onLogout(): void {
    localStorage.removeItem('authToken');
    localStorage.removeItem('userInfo');
    localStorage.removeItem('role');
    this.router.navigate(['/login']);
    this.showDropdown = false;
  }

  navigateTo(route: string): void {
    this.router.navigate([route]);
    this.showDropdown = false;
  }

  isAdmin(): boolean {
    return this.role === 'admin';
  }

  getNotificationCount(): number {
    return 4;
  }

  getMessageCount(): number {
    return 8;
  }
}
