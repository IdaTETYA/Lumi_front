import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

import { RouterModule } from '@angular/router';

// Angular Material imports
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatMenuModule } from '@angular/material/menu';
import { MatDividerModule } from '@angular/material/divider';
import { MatBadgeModule } from '@angular/material/badge';
import { MatToolbarModule } from '@angular/material/toolbar';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {MatCard, MatCardContent, MatCardHeader, MatCardSubtitle} from '@angular/material/card';
import {ReactiveFormsModule} from '@angular/forms';
import {MatFormField} from '@angular/material/form-field';
import {MatInput} from '@angular/material/input';
import {MatButton, MatIconButton} from '@angular/material/button';
import {LoginComponent} from './admin/login/login.component';
import {MatProgressSpinner} from '@angular/material/progress-spinner';
import {LoginService} from './service/login-service.service';
import { HttpClientModule } from '@angular/common/http';
import { SidebarComponent } from './shared/sidebar/sidebar.component';
import { TopbarComponent } from './shared/topbar/topbar.component';
import {MatSidenav, MatSidenavContainer, MatSidenavContent, MatSidenavModule} from '@angular/material/sidenav';
import {MatListItem, MatNavList} from '@angular/material/list';
import {MatIcon} from '@angular/material/icon';
import {MatToolbar} from '@angular/material/toolbar';
import { PatientsComponent } from './admin/patients/patients.component';
import { UsersComponent } from './admin/users/users.component';
import { AdminLayoutComponent } from './admin/admin-layout/admin-layout.component';
import {MatExpansionPanel, MatExpansionPanelHeader, MatExpansionPanelTitle} from '@angular/material/expansion';

import { LoginHistoryComponent } from './admin/login-history/login-history.component';
import { NotificationsComponent } from './admin/notifications/notifications.component';
import { ProfileComponent } from './admin/profile/profile.component';

import {CommonModule, NgOptimizedImage} from '@angular/common';
import {
  MatCell,
  MatCellDef,
  MatColumnDef,
  MatHeaderCell,
  MatHeaderRow,
  MatRow,
  MatTable,


} from '@angular/material/table';
import { DoctorDetailsComponent } from './admin/doctor-details/doctor-details.component';
import {RejectReasonModalComponent} from './shared/reject-reason-modal/reject-reason-modal.component';
import {DoctorsComponent} from './admin/doctors/doctors.component';
import { MedecinLayoutComponent } from './medecin/medecin-layout/medecin-layout.component';
import {MatTooltip} from '@angular/material/tooltip';
import { ReusableTableComponent } from './shared/reusable-table/reusable-table.component';
import { DocumentMedecinComponent } from './admin/document-medecin/document-medecin.component';
import { StatsCardComponent } from './shared/stats-card/stats-card.component';
import { DashboardComponentAdmin} from './admin/dashboard/dashboard.component';
import {DashboardComponent} from './shared/dashboard/dashboard.component';
import { DashboardMedecinComponent } from './medecin/dashboard-medecin/dashboard-medecin.component';
import { ConsultationVideoComponent } from './medecin/consultation-video/consultation-video.component';
import { ConsultationAudioComponent } from './medecin/consultation-audio/consultation-audio.component';
@NgModule({
  declarations: [
    AppComponent,
    PatientsComponent,
    UsersComponent,
    LoginHistoryComponent,
    NotificationsComponent,
    ProfileComponent,

    MedecinLayoutComponent,
    SidebarComponent,
    AdminLayoutComponent,
    DocumentMedecinComponent,
    StatsCardComponent,
    DashboardComponentAdmin,
    DashboardMedecinComponent,
    ConsultationVideoComponent,
    ConsultationAudioComponent,

  ],
  imports: [
    FontAwesomeModule,
    BrowserModule,
    AppRoutingModule,
    MatCard,
    MatCardHeader,
    MatCardContent,
    ReactiveFormsModule,
    MatFormField,
    MatSidenav,
    MatSidenavContent,
    MatInput,
    MatExpansionPanel,
    MatExpansionPanelTitle,
    MatExpansionPanelHeader,
    MatButton,
    MatProgressSpinner,
    CommonModule,
    RouterModule,
    MatSidenavModule,
    MatListModule,
    MatIconModule,
    MatButtonModule,
    MatMenuModule,
    MatDividerModule,
    MatBadgeModule,
    MatToolbarModule,
    LoginComponent,
    HttpClientModule,
    MatSidenavContainer,
    MatNavList,
    MatListItem,
    MatSidenav,
    MatIcon,
    MatToolbar,
    MatIconButton,
    TopbarComponent,
    MatExpansionPanel,
    MatExpansionPanelTitle,
    NgOptimizedImage,
    MatCardSubtitle,
    MatTable,
    MatColumnDef,
    MatHeaderCell,
    MatCell,
    MatCellDef,
    MatHeaderRow,
    MatRow,
    DoctorDetailsComponent,
    MatSidenavContent,
    MatIcon,
    MatExpansionPanel,
    MatExpansionPanelTitle,
    MatExpansionPanelHeader,
    RejectReasonModalComponent,
    CommonModule,
    DoctorsComponent,
    MatTooltip,
    ReusableTableComponent,
    TopbarComponent,
    DashboardComponent,
    DashboardComponent,

  ],
  providers: [LoginService],
  exports: [
    SidebarComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
