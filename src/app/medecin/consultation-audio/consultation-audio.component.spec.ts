import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultationAudioComponent } from './consultation-audio.component';

describe('ConsultationAudioComponent', () => {
  let component: ConsultationAudioComponent;
  let fixture: ComponentFixture<ConsultationAudioComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ConsultationAudioComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ConsultationAudioComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
