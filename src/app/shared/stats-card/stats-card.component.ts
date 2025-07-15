import { Component, Input } from "@angular/core"
import {StatCard} from '../../model/dashboard.model';

@Component({
  selector: "app-stats-card",
  templateUrl: "./stats-card.component.html",
  styleUrls: ["./stats-card.component.scss"],
  standalone:false
})
export class StatsCardComponent {
  @Input() stat!: StatCard

  getChangeClass(): string {
    switch (this.stat.changeType) {
      case "positive":
        return "change-positive"
      case "negative":
        return "change-negative"
      default:
        return "change-neutral"
    }
  }
}
