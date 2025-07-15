import { Component, OnInit } from '@angular/core';
import { Doctor } from '../../model/User';
import { ActivatedRoute, Router } from '@angular/router';
import { DoctorService } from '../../service/doctor.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { DatePipe, NgClass, NgIf, NgFor, CommonModule } from '@angular/common';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { Document } from '../../model/Document';
import { MatChip, MatChipListbox } from '@angular/material/chips';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDividerModule } from '@angular/material/divider';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { RejectReasonModalComponent } from '../../shared/reject-reason-modal/reject-reason-modal.component';
import { MatProgressSpinner } from '@angular/material/progress-spinner';
import { DocumentService } from '../../service/document.service';

@Component({
  selector: 'app-doctor-details',
  templateUrl: './doctor-details.component.html',
  styleUrls: ['./doctor-details.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    NgIf,
    NgFor,
    MatProgressBarModule,
    MatChip,
    NgClass,
    MatChipListbox,
    MatTabsModule,
    MatDividerModule,
    DatePipe,
    MatDialogModule,
    MatProgressSpinner,
  ],
})
export class DoctorDetailsComponent implements OnInit {
  doctor: Doctor | null = null;
  documents: Document[] = [];
  total: number = 0;
  verified: number = 0;
  status: string | null = null;
  isMenuOpen = false;
  motif_refus: string | null = null;
  activeSection: 'profile' | 'documents' = 'profile';
  selectedTabIndex: number = 0;
  isLoading: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private doctorService: DoctorService,
    private documentService: DocumentService,
    private snackBar: MatSnackBar,
    private dialog: MatDialog // Injecter MatDialog
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isLoading = true; // Activer le chargement
      this.loadDoctor(id);
      this.loadDocument(id);
    }
    this.selectedTabIndex = this.activeSection === 'profile' ? 0 : 1;
    console.log(localStorage.getItem('token'));
  }

  loadDoctor(id: string): void {
    this.doctorService.getDoctorById(id).subscribe({
      next: (doctor: Doctor) => {
        this.doctor = doctor;
        this.status = doctor.status;
        this.isLoading = false; // Désactiver le chargement une fois chargé
        console.log(this.doctor.motifRefus);
      },
      error: () => {
        this.snackBar.open('Erreur lors du chargement du médecin', 'Fermer', { duration: 3000 });
        this.router.navigate(['/admin/doctors']);
        this.isLoading = false; // Désactiver en cas d'erreur
      },
    });
  }

  loadDocument(id: string): void {
    this.isLoading = true; // Activer le chargement
    this.doctorService.getDoctorDocument(id).subscribe({
      next: (response: { documents: Document[]; total: number; verified: number }) => {
        this.documents = response.documents;
        this.total = response.total;
        this.verified = response.verified;
        this.isLoading = false; // Désactiver le chargement
        console.log(this.documents);
      },
      error: () => {
        this.snackBar.open('Erreur lors du chargement des documents', 'Fermer', { duration: 3000 });
        this.isLoading = false; // Désactiver en cas d'erreur
      },
    });
  }

  validateDoctor(): void {
    if (this.doctor) {
      this.doctorService.validedDoctor(this.doctor.id).subscribe({
        next: (updatedDoctor: Doctor) => {
          this.doctor = updatedDoctor;
          this.status = updatedDoctor.status;
          this.snackBar.open('Compte validé avec succès', 'Fermer', { duration: 3000 });
        },
        error: () => {
          this.snackBar.open('Erreur lors de la validation', 'Fermer', { duration: 3000 });
        },
      });
    }
  }

  rejectDoctor(): void {
    if (this.doctor) {
      const dialogRef = this.dialog.open(RejectReasonModalComponent, {
        width: '400px',
        data: { doctorName: this.doctor.fullName },
      });

      dialogRef.afterClosed().subscribe((reason) => {
        if (reason) {
          this.doctorService.rejetedDoctor(this.doctor!.id, reason).subscribe({
            next: (updatedDoctor: Doctor) => {
              this.doctor = updatedDoctor;
              this.status = updatedDoctor.status;
              this.motif_refus = reason;
              this.snackBar.open('Compte rejeté avec succès', 'Fermer', { duration: 3000 });
              this.loadDoctor(this.doctor!.id);
              this.loadDocument(this.doctor!.id);
            },
            error: () => {
              this.snackBar.open('Erreur lors du rejet', 'Fermer', { duration: 3000 });
            },
          });
        }
      });
    }
  }

  viewOnMap(): void {
    if (this.doctor) {
      const url = `https://www.google.com/maps?q=${this.doctor.latitude},${this.doctor.longitude}`;
      window.open(url, '_blank');
    }
  }

  goBack(): void {
    this.router.navigate(['/admin/doctors']);
  }

  toggleMenu(): void {
    this.isMenuOpen = !this.isMenuOpen;
  }

  getInitials(fullName: string): string {
    const names = fullName.split(' ');
    return names.map((name) => name.charAt(0)).join('').toUpperCase();
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'validated':
        return 'status-validated';
      case 'pending':
        return 'status-pending';
      case 'rejected':
        return 'status-rejected';
      default:
        return '';
    }
  }

  getFileIcon(type: string): string {
    switch (type.toLowerCase()) {
      case 'pdf':
        return 'picture_as_pdf';
      case 'doc':
      case 'docx':
        return 'description';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'image';
      default:
        return 'insert_drive_file';
    }
  }

  getFileIconColor(type: string): string {
    switch (type.toLowerCase()) {
      case 'pdf':
        return 'text-red';
      case 'doc':
      case 'docx':
        return 'text-blue';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'text-gray';
      default:
        return 'text-gray';
    }
  }

  get verifiedDocuments(): number {
    return this.documents.filter((doc) => doc.status === 'validated').length;
  }

  onTabChange(index: number): void {
    this.selectedTabIndex = index;
    this.activeSection = index === 0 ? 'profile' : 'documents';
    console.log('Tab changed to:', this.activeSection); // Débogage
  }

  isValidDate(date: any): boolean {
    return date && !isNaN(new Date(date).getTime());
  }

  validateDocument(id: string) {
    this.documentService.validateDocument(id).subscribe({
      next: (response) => {
        console.log(response);
        const idDoctor = this.route.snapshot.paramMap.get('id');
        this.loadDocument(idDoctor!);
      },
      error: (error) => {
        console.log(id);
        console.log(error);
        console.error('Erreur lors du changement de statut du document', error.error?.message);
        this.snackBar.open('Erreur lors du changement de statut du document', 'Fermer', { duration: 3000 });
      },
    });
  }

  rejectDocument(id: string) {
    const dialogRef = this.dialog.open(RejectReasonModalComponent, {
      width: '400px',
      data: { doctorName: this.doctor?.fullName || 'Médecin' }, // Correction ici
    });

    dialogRef.afterClosed().subscribe((reason) => {
      if (reason) {
        this.documentService.rejectDocument(id, reason).subscribe({
          next: (response) => {
            console.log(response);
            const idDoctor = this.route.snapshot.paramMap.get('id');
            this.loadDocument(idDoctor!);
          },
          error: (error) => {
            console.log(id);
            console.log(error);
            console.error('Erreur lors du changement de statut du document', error.error?.message);
            this.snackBar.open('Erreur lors du changement de statut du document', 'Fermer', { duration: 3000 });
          },
        });
      }
    });
  }
}
