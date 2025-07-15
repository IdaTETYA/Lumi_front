import { Component, OnInit } from '@angular/core';
import { TableColumn, FilterButton, ActionButton, StatusConfig, TableConfig } from '../../shared/reusable-table/reusable-table.component';
import { Router } from '@angular/router';
import { faEye, faDownload, faCheck, faTimesCircle } from '@fortawesome/free-solid-svg-icons';
import { DocumentService } from '../../service/document.service';
import { Document } from '../../model/Document';
import { RejectReasonModalComponent } from '../../shared/reject-reason-modal/reject-reason-modal.component';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-document-medecin',
  templateUrl: './document-medecin.component.html',
  standalone: false,
})
export class DocumentMedecinComponent implements OnInit {
  documents: Document[] = [];
  columns: TableColumn[] = [
    { key: 'titre', label: 'Titre', type: 'text' },
    { key: 'type', label: 'Type', type: 'text' },
    { key: 'createdAt', label: 'Jours envoyés', type: 'date' },
    { key: 'status', label: 'Statut', type: 'status' },
    { key: 'nom', label: 'Nom', type: 'text' },
    { key: 'specialite', label: 'Spécialité', type: 'text' },
    { key: 'email', label: 'Email', type: 'text' },
    { key: 'action', label: 'Action', type: 'action' },
  ];

  filterButtons: FilterButton[] = [
    { key: 'all', label: 'Tous', value: 'all' },
    { key: 'pending', label: 'En attente', value: 'pending' },
    { key: 'validated', label: 'Validé', value: 'validated' },
    { key: 'rejected', label: 'Rejeté', value: 'rejected' },
  ];

  actionButtons: ActionButton[] = [
    {
      key: 'view',
      label: 'Voir',
      faIcon: faEye,
      color: 'text-color',
      action: this.viewDocument.bind(this),
      isVisible: true // Toujours visible
    },
    {
      key: 'download',
      label: 'Télécharger',
      faIcon: faDownload,
      color: 'secondary',
      action: this.downloadDocument.bind(this),
      isVisible: true // Toujours visible
    },
    {
      key: 'validate',
      label: 'Valider',
      faIcon: faCheck,
      color: 'success',
      action: this.validateDocument.bind(this),
      isVisible: (item: Document) => item.status === 'pending' || (item as any).statut === 0
    },
    {
      key: 'reject',
      label: 'Rejeter',
      faIcon: faTimesCircle,
      color: 'danger',
      action: this.rejectDocument.bind(this),
      isVisible: (item: Document) => item.status === 'pending' || (item as any).statut === 0
    },
  ];

  statusConfig: StatusConfig = {
    pending: { label: 'En attente', class: 'pending' },
    validated: { label: 'Validé', class: 'validated' },
    rejected: { label: 'Rejeté', class: 'rejected' },
  };

  config: TableConfig = {
    title: 'Documents des Médecins',
    subtitle: 'Liste des documents soumis par les médecins et propriétaires',
    showSearch: true,
    searchPlaceholder: 'Rechercher par titre, type ou statut...',
    showFilters: true,
    showPagination: true,
    showAddButton: false,
    pageSize: 10,
    pageSizeOptions: [5, 10, 15, 20],
  };

  searchFields: string[] = ['titre', 'type', 'status', 'medecinNom', 'medecinPrenom', 'medecinSpecialite', 'medecinEmail', 'medecinTelephone'];
  currentPage = 1;
  totalPages = 0;
  isLoading: boolean = false;
  document?: Document | null;

  constructor(
    private documentService: DocumentService,
    private snackBar: MatSnackBar,
    private router: Router,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.isLoading = true;
    this.loadDocuments();
  }

  loadDocuments(): void {
    setTimeout(() => {
      this.documentService.getDocuments(this.currentPage, this.config.pageSize).subscribe({
        next: (response) => {
          this.documents = response.data;
          this.totalPages = response.pagination.last_page || 1;
          this.isLoading = false;
        },
        error: (err) => {
          console.error('Erreur lors du chargement des documents :', err);
          this.isLoading = false;
        },
      });
    }, 900);
  }

  prevPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.loadDocuments();
    }
  }

  nextPage() {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
      this.loadDocuments();
    }
  }

  viewDocument(document: Document): void {
    this.documentService.viewDocument(+document.id).subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        window.open(url, '_blank');
      },
      error: (err) => console.error('Erreur lors de la visualisation :', err),
    });
  }

  downloadDocument(document: Document): void {
    this.documentService.downloadDocument(+document.id).subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        // a.href = url;
        // a.download = document.titre || `document_${document.id}.pdf`;
        // document.body.appendChild(a);
        // a.click();
        // document.body.removeChild(a);
        window.URL.revokeObjectURL(url);
      },
      error: (err) => {
        console.error('Erreur lors du téléchargement :', err);
        if (err.status === 404) {
          console.error('Document non trouvé ou inaccessible.');
        } else if (err.status === 500) {
          console.error('Erreur serveur lors du téléchargement.');
        }
      },
    });
  }

  validateDocument(document: Document): void {
    this.documentService.validateDocument(document.id).subscribe({
      next: () => {
        this.snackBar.open('Document validé avec succès', 'Fermer', { duration: 3000 });
        this.loadDocuments();
      },
      error: (err) => {
        console.error('Erreur lors de la validation :', err);
        this.snackBar.open('Erreur lors de la validation', 'Fermer', { duration: 3000 });
      },
    });
  }

  rejectDocument(document: Document): void {
    if (document) {
      const dialogRef = this.dialog.open(RejectReasonModalComponent, {
        width: '400px',
        data: { documentTitle: document.titre },
      });

      dialogRef.afterClosed().subscribe((reason) => {
        if (reason) {
          this.documentService.rejectDocument(document.id, reason).subscribe({
            next: (updatedDocument: Document) => {
              const index = this.documents.findIndex(d => d.id === document.id);
              if (index !== -1) {
                this.documents[index] = updatedDocument;
              }
              this.snackBar.open('Document rejeté avec succès', 'Fermer', { duration: 3000 });
              this.loadDocuments();
            },
            error: () => {
              this.snackBar.open('Erreur lors du rejet', 'Fermer', { duration: 3000 });
            },
          });
        }
      });
    }
  }

  onItemClick(item: Document): void {
    this.router.navigate(['/admin/documents', item.id]);
  }

  onActionClick(action: string, item: Document): void {
    const actionMap: { [key: string]: () => void } = {
      view: () => this.viewDocument(item),
      download: () => this.downloadDocument(item),
      validate: () => this.validateDocument(item),
      reject: () => this.rejectDocument(item),
    };
    actionMap[action]?.();
  }

  onAddClick(): void {
    // Non implémenté ici
  }

  onFilterChange(event: { type: string, value: any }): void {
    // Gérer les changements de filtre si nécessaire
  }
}
