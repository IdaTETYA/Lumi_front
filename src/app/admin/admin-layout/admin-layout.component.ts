import { Component } from '@angular/core';
import {SidebarService} from '../../service/SidebarService';


@Component({
  selector: 'app-root',
  standalone: false,
  templateUrl: './admin-layout.component.html',
  styleUrls: ['./admin-layout.component.scss']
})
export class AdminLayoutComponent {
  isSidebarExpanded: boolean = true;

  constructor(private sidebarService: SidebarService) {}

  onSidebarToggle(expanded: boolean): void {
    this.isSidebarExpanded = expanded;
    this.sidebarService.setSidebarExpanded(expanded);
  }
}
