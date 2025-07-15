import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd, RouterLink } from '@angular/router';
import { filter } from 'rxjs/operators';
import {DatePipe, NgForOf, NgIf} from '@angular/common';
import { LoginService } from '../../service/login-service.service';
import {FaIconLibrary, FontAwesomeModule} from '@fortawesome/angular-fontawesome';
import { faBell, faCaretDown, faSignOutAlt } from '@fortawesome/free-solid-svg-icons';

interface Breadcrumb {
  label: string;
  url: string;
}

interface User {
  email?: string;
  image?: string;
}

@Component({
  selector: 'app-topbar',
  templateUrl: './topbar.component.html',
  styleUrls: ['./topbar.component.scss'],
  imports: [
    RouterLink,
    NgForOf,
    NgIf,
    FontAwesomeModule,
    DatePipe
  ],
  standalone: true,
})
export class TopbarComponent implements OnInit {
  breadcrumbs: Breadcrumb[] = [];
  isProfileMenuOpen = false;
  isNotificationPanelOpen = false;
  profileOptions = ['Profil', 'Paramètres', 'Déconnexion'];
  user: User | null | undefined ;
  userInitials: string = '';

  private loginService: LoginService | undefined;

  constructor(private router: Router, loginService: LoginService, private library: FaIconLibrary) {
    this.loginService = loginService;
    library.addIcons(faBell, faCaretDown, faSignOutAlt);
  }

  ngOnInit(): void {
    this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd))
      .subscribe(() => {
        this.breadcrumbs = this.createBreadcrumbs();
      });
    this.user = this.loginService?.getCurrentUser();
    this.setUserInitials();
  }

  private createBreadcrumbs(): Breadcrumb[] {
    const breadcrumbs: Breadcrumb[] = [{ label: 'Admin', url: '/admin' }];
    const urlSegments = this.router.url.split('/').filter((segment) => segment);

    if (urlSegments.length > 1) {
      const section = urlSegments[1].charAt(0).toUpperCase() + urlSegments[1].slice(1);
      breadcrumbs.push({ label: section, url: this.router.url });
    }

    return breadcrumbs;
  }

  private setUserInitials(): void {
    if (this.user?.email) {
      const nameParts = this.user.email.split('@')[0].split('.');
      this.userInitials = nameParts.map(part => part[0].toUpperCase()).join('');
    }
  }

  toggleProfileMenu(): void {
    this.isProfileMenuOpen = !this.isProfileMenuOpen;
  }

  toggleNotificationPanel(): void {
    this.isNotificationPanelOpen = !this.isNotificationPanelOpen;
  }

  logout(): void {
    console.log('Déconnexion');
    this.isProfileMenuOpen = false;
  }
}
