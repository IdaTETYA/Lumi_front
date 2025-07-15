import { Component, Input, Output, EventEmitter, OnInit, OnChanges, SimpleChanges } from '@angular/core';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { debounceTime, distinctUntilChanged } from 'rxjs/operators';
import { DatePipe, NgClass, NgForOf, NgIf, NgStyle, NgSwitch, NgSwitchCase, NgSwitchDefault } from '@angular/common';
import { FaIconComponent, FaIconLibrary } from '@fortawesome/angular-fontawesome';
import { faTimes, faEye, faDownload, faCheck, faTimesCircle, faArrowLeft, faArrowRight, faSync, faPlus } from '@fortawesome/free-solid-svg-icons';

export interface TableColumn {
  key: string;
  label: string;
  type?: 'text' | 'status' | 'date' | 'action';
  sortable?: boolean;
  width?: string;
}

export interface FilterButton {
  key: string;
  label: string;
  value: any;
  color?: string;
}

export interface ActionButton {
  key: string;
  label: string;
  faIcon?: any;
  color?: string;
  action: (item: any) => void;
  isVisible?: boolean | ((item: any) => boolean); // Peut être un boolean ou une fonction
}

export interface StatusConfig {
  [key: string]: {
    label: string;
    class: string;
  };
}

export interface TableConfig {
  title?: string;
  subtitle?: string;
  showSearch?: boolean;
  searchPlaceholder?: string;
  showFilters?: boolean;
  showPagination?: boolean;
  showAddButton?: boolean;
  addButtonText?: string;
  addButtonRoute?: string;
  pageSize?: number;
  pageSizeOptions?: number[];
  colors?: {
    primary?: string;
    secondary?: string;
    success?: string;
    warning?: string;
    danger?: string;
    background?: string;
    text?: string;
  };
}

@Component({
  selector: 'app-reusable-table',
  templateUrl: './reusable-table.component.html',
  imports: [
    ReactiveFormsModule,
    NgSwitch,
    NgSwitchCase,
    NgClass,
    DatePipe,
    NgStyle,
    NgIf,
    NgForOf,
    NgSwitchDefault,
    FaIconComponent,
  ],
  styleUrls: ['./reusable-table.component.scss'],
})
export class ReusableTableComponent implements OnInit, OnChanges {
  @Input() data: any[] = [];
  @Input() columns: TableColumn[] = [];
  @Input() config: TableConfig = {};
  @Input() filterButtons: FilterButton[] = [];
  @Input() actionButtons: ActionButton[] = [];
  @Input() statusConfig: StatusConfig = {};
  @Input() searchFields: string[] = [];
  @Input() isLoading: boolean = false;
  @Input() getActions?: (item: any) => ActionButton[]; // Fonction pour personnaliser les actions

  @Output() itemClick = new EventEmitter<any>();
  @Output() actionClick = new EventEmitter<{ action: string, item: any }>();
  @Output() addClick = new EventEmitter<void>();
  @Output() filterChange = new EventEmitter<{ type: string, value: any }>();

  searchControl = new FormControl('');
  statusFilterControl = new FormControl('all');
  itemsPerPageControl = new FormControl<number>(10);

  filteredData: any[] = [];
  dataSource: any[] = [];
  currentPage = 0;
  Math = Math;

  defaultConfig: TableConfig = {
    title: 'Données',
    subtitle: 'Liste des éléments',
    showSearch: true,
    searchPlaceholder: 'Rechercher...',
    showFilters: true,
    showPagination: true,
    showAddButton: true,
    addButtonText: 'Ajouter',
    pageSize: 10,
    pageSizeOptions: [5, 10, 15, 20],
    colors: {
      primary: 'teal',
      secondary: '#6c757d',
      success: '#28a745',
      warning: '#ffc107',
      danger: '#dc3545',
      background: '#ffffff',
      text: '#333333',
    },
  };

  constructor(private library: FaIconLibrary) {
    this.library.addIcons(
      faTimes,
      faEye,
      faDownload,
      faCheck,
      faTimesCircle,
      faArrowLeft,
      faArrowRight,
      faSync,
      faPlus
    );
  }

  ngOnInit() {
    this.initializeConfig();
    this.setupControls();
    this.applyFilters();
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes['data'] || changes['config']) {
      this.applyFilters();
    }
  }

  private initializeConfig() {
    this.config = { ...this.defaultConfig, ...this.config };
    this.itemsPerPageControl.setValue(this.config.pageSize || 10);
  }

  private setupControls() {
    this.searchControl.valueChanges
      .pipe(debounceTime(300), distinctUntilChanged())
      .subscribe(() => {
        this.currentPage = 0;
        this.applyFilters();
      });

    this.statusFilterControl.valueChanges.subscribe(() => {
      this.currentPage = 0;
      this.applyFilters();
    });

    this.itemsPerPageControl.valueChanges.subscribe(() => {
      this.currentPage = 0;
      this.applyFilters();
    });
  }

  private applyFilters() {
    let filtered = [...this.data];

    if (this.searchControl.value && this.searchFields.length > 0) {
      const searchTerm = this.searchControl.value.toLowerCase();
      filtered = filtered.filter(item =>
        this.searchFields.some(field =>
          item[field]?.toString().toLowerCase().includes(searchTerm)
        )
      );
    }

    if (this.statusFilterControl.value !== 'all') {
      filtered = filtered.filter(item => item.status === this.statusFilterControl.value);
    }

    this.filteredData = filtered;
    this.updateDataSource();
  }

  private updateDataSource() {
    const pageSize = this.itemsPerPageControl.value ?? 10;
    const start = this.currentPage * pageSize;
    const end = start + pageSize;
    this.dataSource = this.filteredData.slice(start, end);
  }

  // Nouvelle méthode pour obtenir les actions visibles pour un élément
  getVisibleActions(item: any): ActionButton[] {
    if (this.getActions) {
      return this.getActions(item);
    }

    return this.actionButtons.filter(action => {
      if (action.isVisible === undefined) {
        return true; // Visible par défaut
      }
      if (typeof action.isVisible === 'boolean') {
        return action.isVisible;
      }
      if (typeof action.isVisible === 'function') {
        return action.isVisible(item);
      }
      return true;
    });
  }

  prevPage() {
    if (this.currentPage > 0) {
      this.currentPage--;
      this.updateDataSource();
    }
  }

  nextPage() {
    const pageSize = this.itemsPerPageControl.value ?? 10;
    const totalPages = Math.ceil(this.filteredData.length / pageSize);
    if (this.currentPage < totalPages - 1) {
      this.currentPage++;
      this.updateDataSource();
    }
  }

  selectStatus(status: string) {
    this.statusFilterControl.setValue(status);
    this.filterChange.emit({ type: 'status', value: status });
  }

  clearSearch() {
    this.searchControl.setValue('');
    this.statusFilterControl.setValue('all');
    this.currentPage = 0;
    this.applyFilters();
  }

  onItemClick(item: any) {
    this.itemClick.emit(item);
  }

  onActionClick(action: string, item: any) {
    this.actionClick.emit({ action, item });
  }

  onAddClick() {
    this.addClick.emit();
  }

  getCellValue(item: any, column: TableColumn): any {
    return item[column.key];
  }

  getStatusLabel(status: string): string {
    return this.statusConfig[status]?.label || status;
  }

  getStatusClass(status: string): string {
    return this.statusConfig[status]?.class || '';
  }

  getTotalPages(): number {
    const pageSize = this.itemsPerPageControl.value ?? 10;
    return Math.ceil(this.filteredData.length / pageSize);
  }

  getCSSVariables(): any {
    const colors = this.config.colors || {};
    return {
      '--table-primary': colors.primary || 'teal',
      '--table-secondary': colors.secondary || '#6c757d',
      '--table-success': colors.success || '#28a745',
      '--table-warning': colors.warning || '#ffc107',
      '--table-danger': colors.danger || '#dc3545',
      '--table-background': colors.background || '#ffffff',
      '--table-text': colors.text || '#333333',
    };
  }

  protected readonly faTimes = faTimes;
  protected readonly faSync = faSync;
  protected readonly faArrowLeft = faArrowLeft;
  protected readonly faArrowRight = faArrowRight;
  protected readonly faPlus = faPlus;
}
