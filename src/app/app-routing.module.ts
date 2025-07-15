import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminLayoutComponent } from './admin/admin-layout/admin-layout.component';
import { DoctorsComponent } from './admin/doctors/doctors.component';
import { PatientsComponent } from './admin/patients/patients.component';
import { UsersComponent } from './admin/users/users.component';
import { LoginHistoryComponent } from './admin/login-history/login-history.component';
import { NotificationsComponent } from './admin/notifications/notifications.component';
import { ProfileComponent } from './admin/profile/profile.component';
import {LoginComponent} from './admin/login/login.component';
import {AuthGuard} from './service/auth-guard.service';
import {DoctorDetailsComponent} from './admin/doctor-details/doctor-details.component';
import {DocumentMedecinComponent} from './admin/document-medecin/document-medecin.component';
import {DashboardComponentAdmin} from './admin/dashboard/dashboard.component';
import {DashboardMedecinComponent} from './medecin/dashboard-medecin/dashboard-medecin.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  {
    path: 'admin',
    component: AdminLayoutComponent,
    canActivate: [AuthGuard],
    children: [
      { path: 'doctors', component: DoctorsComponent },
      { path: 'documents', component: DocumentMedecinComponent },
      { path: 'doctors/:id', component: DoctorDetailsComponent },
      { path: 'patients', component: PatientsComponent },
      { path: 'users', component: UsersComponent },
      { path: 'login-history', component: LoginHistoryComponent },
      { path: 'notifications', component: NotificationsComponent },
      { path: 'profile', component: ProfileComponent },
      { path: 'dashboard', component: DashboardComponentAdmin },

      { path: 'dashbordMedecin', component: DashboardMedecinComponent },

      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
    ],
  },
  { path: '', redirectTo: '/login', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
