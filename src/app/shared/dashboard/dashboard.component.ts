import { Component, Input, type OnInit } from "@angular/core"
import {DashboardService} from '../../service/DashboardService';
import {DashboardConfig} from '../../model/dashboard.model';

@Component({
  selector: "app-dashboard",
  templateUrl: "./dashboard.component.html",
  styleUrls: ["./dashboard.component.scss"]
})
export class DashboardComponent implements OnInit {
  @Input() config!: DashboardConfig

  activeTab = "dashboard"

  constructor(private dashboardService: DashboardService) {}

  ngOnInit(): void {
    this.dashboardService.activeTab$.subscribe((tab) => {
      this.activeTab = tab
    })
  }

  onTabChange(tab: string): void {
    this.dashboardService.setActiveTab(tab)
  }
}
