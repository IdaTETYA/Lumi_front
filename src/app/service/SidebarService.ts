import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SidebarService {
  private isSidebarExpandedSubject = new BehaviorSubject<boolean>(true);
  isSidebarExpanded$ = this.isSidebarExpandedSubject.asObservable();

  setSidebarExpanded(expanded: boolean): void {
    this.isSidebarExpandedSubject.next(expanded);
  }

  toggleSidebar(): void {
    this.isSidebarExpandedSubject.next(!this.isSidebarExpandedSubject.value);
  }

  getIsSidebarExpanded(): boolean {
    return this.isSidebarExpandedSubject.value;
  }
}
