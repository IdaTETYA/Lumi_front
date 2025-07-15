import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators, ReactiveFormsModule} from '@angular/forms';
import {Router} from '@angular/router';
import {LoginService} from '../../service/login-service.service';
import {NgIf} from '@angular/common';
import {MatSnackBar} from '@angular/material/snack-bar';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatInputModule} from '@angular/material/input';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import {MatIcon} from '@angular/material/icon';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
  standalone: true,
  imports: [
    ReactiveFormsModule,
    NgIf,
    MatFormFieldModule,
    MatInputModule,
    MatProgressSpinnerModule,
    MatIcon,
    MatIcon
  ]
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  isLoading: boolean = false;

  constructor(
    private fb: FormBuilder,
    private apiService: LoginService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
    });
  }

  onSubmit(): void {
    if (this.loginForm.valid) {
      this.isLoading = true;

      const {email, password} = this.loginForm.value;
      this.apiService.login(email, password).subscribe({
        next: (user) => {
          this.isLoading = false;
          if (user.role === 'admin') {
            this.router.navigate(['/admin/dashboard']);
            this.snackBar.open('Login successful', 'Close', {duration: 2000, panelClass: 'success-snackbar'});
          } else {
            this.snackBar.open('Access reserved for admin', 'Close', {duration: 3000, panelClass: 'error-snackbar'});
          }
        },
        error: (err) => {
          this.isLoading = false;
          this.snackBar.open('Email or password incorrect', 'Close', {duration: 3000, panelClass: 'error-snackbar'});
        }
      });
    }
  }

  ngOnInit(): void {
  }
}
