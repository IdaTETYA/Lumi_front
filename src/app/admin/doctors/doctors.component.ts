import { Component, OnInit } from '@angular/core';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router, RouterLink } from '@angular/router';
import { Doctor } from '../../model/User';
import { DoctorService } from '../../service/doctor.service';
import { debounceTime, distinctUntilChanged } from 'rxjs/operators';
import {DatePipe, NgClass, NgForOf, NgIf, NgSwitch, NgSwitchCase} from '@angular/common';

import {FaIconComponent} from '@fortawesome/angular-fontawesome';
import {faCross, faDeleteLeft, faEye, faTimes} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-doctors',
  templateUrl: './doctors.component.html',
  imports: [
    ReactiveFormsModule,
    RouterLink,
    NgClass,
    NgSwitch,
    NgForOf,
    NgSwitchCase,
    NgIf,
    DatePipe,
    FaIconComponent

  ],
  styleUrls: ['./doctors.component.scss'],
  standalone: true,
})
export class DoctorsComponent implements OnInit {
  displayedColumns: string[] = ['Numero ONMC','name', 'specialty', 'email', 'phone', 'status', 'Envoyé le','Action'];
  doctors: Doctor[] = [];
  dataSource: Doctor[] = [];

  searchControl = new FormControl('');
  statusFilterControl = new FormControl('all');
  isFilterDropdownOpen = false;
  itemsPerPageControl = new FormControl(5); // Par défaut 10 éléments par page
  currentPage = 0;

  constructor(
    private doctorService: DoctorService,
    private snackBar: MatSnackBar,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadDoctors();
    this.searchControl.valueChanges
      .pipe(debounceTime(300), distinctUntilChanged())
      .subscribe(searchTerm => {
        this.applyFilters(searchTerm || '', this.statusFilterControl.value);
      });

    this.statusFilterControl.valueChanges.subscribe(status => {
      this.applyFilters(this.searchControl.value || '', status);
    });
    console.log("premier token", localStorage.getItem('token'));
  }

  loadDoctors(): void {
    this.doctorService.getDoctors().subscribe({
      next: (doctors: Doctor[]) => {
        this.doctors = doctors;
        this.dataSource = [...doctors];
      },
      error: () => {
        this.snackBar.open('Erreur lors du chargement des médecins', 'Fermer', { duration: 3000 });
      },
    });
  }

  applyFilters(searchTerm: string, status: string | null): void {
    let filteredDoctors = [...this.doctors];

    if (searchTerm) {
      searchTerm = searchTerm.toLowerCase().trim();
      filteredDoctors = filteredDoctors.filter(
        doctor =>
          doctor.nom.toLowerCase().includes(searchTerm) ||
          doctor.specialite.toLowerCase().includes(searchTerm) ||
          doctor.email.toLowerCase().includes(searchTerm)
      );
    }

    if (status !== 'all') {
      filteredDoctors = filteredDoctors.filter(doctor => doctor.status === status);
    }

    const itemsPerPage = this.itemsPerPageControl.value || 10;
    const startIndex = this.currentPage * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    this.dataSource = filteredDoctors.slice(startIndex, endIndex);
  }

  toggleFilterDropdown(): void {
    this.isFilterDropdownOpen = !this.isFilterDropdownOpen;
  }

  selectStatus(status: string): void {
    this.statusFilterControl.setValue(status);
    this.isFilterDropdownOpen = false;
  }

  clearSearch(): void {
    this.searchControl.setValue('');
    this.applyFilters('', this.statusFilterControl.value);
  }

  editDoctor(doctor: Doctor): void {
    console.log('Modifier médecin:', doctor);
  }

  deleteDoctor(doctor: Doctor): void {
    console.log('Supprimer médecin:', doctor);
  }

  viewDoctor(doctor: Doctor): void {
    this.router.navigate(['/admin/doctors', doctor.id]);
  }

  nextPage(): void {
    const totalPages = Math.ceil(this.doctors.length / (this.itemsPerPageControl.value || 10));
    if (this.currentPage < totalPages - 1) {
      this.currentPage++;
      this.applyFilters(this.searchControl.value || '', this.statusFilterControl.value);
    }
  }

  prevPage(): void {
    if (this.currentPage > 0) {
      this.currentPage--;
      this.applyFilters(this.searchControl.value || '', this.statusFilterControl.value);
    }
  }

  protected readonly Math = Math;
  protected readonly faEye = faEye;
  protected readonly faCross = faCross;
  protected readonly faDeleteLeft = faDeleteLeft;
  protected readonly faTimes = faTimes;
}
