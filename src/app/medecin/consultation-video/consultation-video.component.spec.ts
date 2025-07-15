import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultationVideoComponent } from './consultation-video.component';

describe('ConsultationVideoComponent', () => {
  let component: ConsultationVideoComponent;
  let fixture: ComponentFixture<ConsultationVideoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ConsultationVideoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ConsultationVideoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
