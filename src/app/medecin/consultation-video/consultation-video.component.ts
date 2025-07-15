import { Component } from '@angular/core';

@Component({
  selector: 'app-consultation-video',
  standalone: false,
  templateUrl: './consultation-video.component.html',
  styleUrl: './consultation-video.component.scss'
})
export class ConsultationVideoComponent {
  title = 'Consultation Vidéo avec Nouveau Patient';
  status = 'En direct';
  patient = {
    initials: 'NP',
    name: 'Nouveau Patient',
    status: 'Patient en ligne'
  };

}
