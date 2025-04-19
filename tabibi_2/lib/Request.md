# Tabibi API Request Documentation

This document provides a comprehensive list of all HTTP requests available in the Tabibi healthcare application.

## Table of Contents
- [Authentication](#authentication)
- [Users](#users)
- [Patients](#patients)
- [Doctors](#doctors)
- [Appointments](#appointments)
- [Medical Records](#medical-records)
- [Prescriptions](#prescriptions)
- [Payments](#payments)
- [Notifications](#notifications)
- [Settings](#settings)

## Authentication

### Login
```http
POST /api/auth/login HTTP/1.1
Host: api.tabibi.com
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

### Register
```http
POST /api/auth/register HTTP/1.1
Host: api.tabibi.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "securePassword123",
  "role": "patient"
}
```

### Refresh Token
```http
POST /api/auth/refresh-token HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <refresh_token>
```

### Logout
```http
POST /api/auth/logout HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Reset Password Request
```http
POST /api/auth/reset-password HTTP/1.1
Host: api.tabibi.com
Content-Type: application/json

{
  "email": "user@example.com"
}
```

### Confirm Reset Password
```http
PUT /api/auth/reset-password HTTP/1.1
Host: api.tabibi.com
Content-Type: application/json

{
  "token": "reset_token",
  "password": "newSecurePassword123"
}
```

## Users

### Get All Users (Admin)
```http
GET /api/users HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

### Get User Profile
```http
GET /api/users/profile HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Update User Profile
```http
PUT /api/users/profile HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "John Smith",
  "phone": "123-456-7890",
  "address": "123 Main St",
  "profilePicture": "base64encodedimage"
}
```

### Change Password
```http
PUT /api/users/change-password HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "currentPassword": "oldPassword123",
  "newPassword": "newSecurePassword456"
}
```

### Delete User (Admin)
```http
DELETE /api/users/{userId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

## Patients

### Get All Patients
```http
GET /api/patients HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Patient by ID
```http
GET /api/patients/{patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Patient
```http
POST /api/patients HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Jane Smith",
  "dateOfBirth": "1985-05-15",
  "gender": "female",
  "bloodType": "A+",
  "allergies": ["penicillin", "peanuts"],
  "contactPhone": "123-456-7890",
  "emergencyContact": {
    "name": "John Smith",
    "relationship": "husband",
    "phone": "987-654-3210"
  },
  "address": {
    "street": "456 Oak Avenue",
    "city": "Metropolis",
    "state": "NY",
    "zipCode": "10001",
    "country": "USA"
  },
  "insuranceInfo": {
    "provider": "Health Shield",
    "policyNumber": "HS12345678",
    "groupNumber": "GRP999"
  }
}
```

### Update Patient
```http
PUT /api/patients/{patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Jane Smith",
  "dateOfBirth": "1985-05-15",
  "gender": "female",
  "bloodType": "A+",
  "allergies": ["penicillin", "peanuts", "shellfish"],
  "contactPhone": "123-456-7890",
  "emergencyContact": {
    "name": "John Smith",
    "relationship": "husband",
    "phone": "987-654-3210"
  },
  "address": {
    "street": "456 Oak Avenue",
    "city": "Metropolis",
    "state": "NY",
    "zipCode": "10001",
    "country": "USA"
  },
  "insuranceInfo": {
    "provider": "Health Shield",
    "policyNumber": "HS12345678",
    "groupNumber": "GRP999"
  }
}
```

### Update Patient Partial
```http
PATCH /api/patients/{patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "allergies": ["penicillin", "peanuts", "shellfish", "latex"]
}
```

### Delete Patient
```http
DELETE /api/patients/{patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

## Doctors

### Get All Doctors
```http
GET /api/doctors HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Doctors by Specialty
```http
GET /api/doctors?specialty=cardiology HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Doctor by ID
```http
GET /api/doctors/{doctorId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Doctor (Admin)
```http
POST /api/doctors HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "userId": "user123",
  "name": "Dr. Sarah Johnson",
  "specialty": "Cardiology",
  "qualifications": [
    {
      "degree": "MD",
      "institution": "Harvard Medical School",
      "year": 2010
    },
    {
      "degree": "Cardiology Fellowship",
      "institution": "Mayo Clinic",
      "year": 2015
    }
  ],
  "licenseNumber": "MED123456",
  "schedule": {
    "monday": ["09:00-12:00", "13:00-17:00"],
    "tuesday": ["09:00-12:00", "13:00-17:00"],
    "wednesday": ["09:00-12:00"],
    "thursday": ["09:00-12:00", "13:00-17:00"],
    "friday": ["09:00-12:00", "13:00-15:00"]
  },
  "languages": ["English", "Spanish"],
  "bio": "Dr. Johnson specializes in cardiovascular disease prevention and treatment.",
  "contactInfo": {
    "email": "dr.johnson@tabibi.com",
    "phone": "555-123-4567"
  }
}
```

### Update Doctor
```http
PUT /api/doctors/{doctorId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "specialty": "Cardiology",
  "qualifications": [
    {
      "degree": "MD",
      "institution": "Harvard Medical School",
      "year": 2010
    },
    {
      "degree": "Cardiology Fellowship",
      "institution": "Mayo Clinic",
      "year": 2015
    },
    {
      "degree": "Advanced Cardiac Imaging",
      "institution": "Johns Hopkins",
      "year": 2017
    }
  ],
  "schedule": {
    "monday": ["09:00-12:00", "13:00-17:00"],
    "tuesday": ["09:00-12:00", "13:00-17:00"],
    "wednesday": ["09:00-12:00"],
    "thursday": ["09:00-12:00", "13:00-17:00"],
    "friday": ["09:00-15:00"]
  },
  "languages": ["English", "Spanish", "French"],
  "bio": "Dr. Johnson specializes in cardiovascular disease prevention, treatment, and advanced cardiac imaging.",
  "contactInfo": {
    "email": "dr.johnson@tabibi.com",
    "phone": "555-123-4567"
  }
}
```

### Update Doctor Availability
```http
PATCH /api/doctors/{doctorId}/availability HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "schedule": {
    "friday": ["09:00-13:00"]
  }
}
```

### Delete Doctor
```http
DELETE /api/doctors/{doctorId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

## Appointments

### Get All Appointments
```http
GET /api/appointments HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Appointments by Patient
```http
GET /api/appointments?patientId={patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Appointments by Doctor
```http
GET /api/appointments?doctorId={doctorId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Appointment by ID
```http
GET /api/appointments/{appointmentId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Appointment
```http
POST /api/appointments HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "patientId": "patient123",
  "doctorId": "doctor456",
  "dateTime": "2023-06-15T14:30:00Z",
  "duration": 30,
  "type": "check-up",
  "reason": "Annual physical examination",
  "notes": "Patient has reported mild headaches",
  "status": "scheduled",
  "location": {
    "type": "office",
    "address": "123 Medical Plaza, Suite 500, Metropolis, NY 10001"
  }
}
```

### Update Appointment
```http
PUT /api/appointments/{appointmentId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "dateTime": "2023-06-16T10:00:00Z",
  "duration": 45,
  "type": "check-up",
  "reason": "Annual physical examination with additional blood tests",
  "notes": "Patient has reported mild headaches and dizziness",
  "status": "rescheduled",
  "location": {
    "type": "office",
    "address": "123 Medical Plaza, Suite 500, Metropolis, NY 10001"
  }
}
```

### Update Appointment Status
```http
PATCH /api/appointments/{appointmentId}/status HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "status": "completed"
}
```

### Cancel Appointment
```http
DELETE /api/appointments/{appointmentId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

## Medical Records

### Get Patient Medical Records
```http
GET /api/medical-records?patientId={patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Medical Record by ID
```http
GET /api/medical-records/{recordId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Medical Record
```http
POST /api/medical-records HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: application/json

{
  "patientId": "patient123",
  "doctorId": "doctor456",
  "appointmentId": "appointment789",
  "date": "2023-06-15T15:00:00Z",
  "diagnosis": [
    {
      "code": "J45.901",
      "description": "Unspecified asthma"
    }
  ],
  "symptoms": ["wheezing", "shortness of breath", "chest tightness"],
  "vitalSigns": {
    "temperature": 98.6,
    "heartRate": 75,
    "bloodPressure": "120/80",
    "respiratoryRate": 16,
    "oxygenSaturation": 98
  },
  "notes": "Patient experiencing mild asthma symptoms. Recommended inhaler and follow-up in 3 months.",
  "treatments": [
    {
      "type": "medication",
      "name": "Albuterol",
      "instructions": "Two puffs as needed for shortness of breath"
    }
  ],
  "labResults": [],
  "attachments": []
}
```

### Update Medical Record
```http
PUT /api/medical-records/{recordId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: application/json

{
  "diagnosis": [
    {
      "code": "J45.901",
      "description": "Unspecified asthma"
    },
    {
      "code": "J30.9",
      "description": "Allergic rhinitis"
    }
  ],
  "symptoms": ["wheezing", "shortness of breath", "chest tightness", "nasal congestion"],
  "vitalSigns": {
    "temperature": 98.6,
    "heartRate": 75,
    "bloodPressure": "120/80",
    "respiratoryRate": 16,
    "oxygenSaturation": 98
  },
  "notes": "Patient experiencing mild asthma symptoms and seasonal allergies. Recommended inhaler and antihistamine.",
  "treatments": [
    {
      "type": "medication",
      "name": "Albuterol",
      "instructions": "Two puffs as needed for shortness of breath"
    },
    {
      "type": "medication",
      "name": "Cetirizine",
      "instructions": "10mg once daily for allergies"
    }
  ],
  "labResults": [],
  "attachments": []
}
```

### Add Lab Result to Medical Record
```http
PATCH /api/medical-records/{recordId}/lab-results HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: application/json

{
  "labResults": [
    {
      "type": "Blood Test",
      "date": "2023-06-16T09:00:00Z",
      "results": {
        "WBC": "7.5 x10^9/L",
        "RBC": "5.2 x10^12/L",
        "Hemoglobin": "14.2 g/dL",
        "Hematocrit": "42%",
        "Platelets": "250 x10^9/L"
      },
      "notes": "Results within normal range",
      "labName": "Central Diagnostics Lab"
    }
  ]
}
```

### Add Attachment to Medical Record
```http
POST /api/medical-records/{recordId}/attachments HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: multipart/form-data

Content-Disposition: form-data; name="file"; filename="xray.jpg"
Content-Type: image/jpeg

[Binary file content]

Content-Disposition: form-data; name="description"

Chest X-Ray June 15, 2023
```

### Delete Medical Record (Admin)
```http
DELETE /api/medical-records/{recordId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

## Prescriptions

### Get Prescriptions by Patient
```http
GET /api/prescriptions?patientId={patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Prescription by ID
```http
GET /api/prescriptions/{prescriptionId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Prescription
```http
POST /api/prescriptions HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: application/json

{
  "patientId": "patient123",
  "doctorId": "doctor456",
  "medications": [
    {
      "name": "Amoxicillin",
      "dosage": "500 mg",
      "frequency": "Every 8 hours",
      "duration": "10 days",
      "quantity": 30,
      "instructions": "Take with food"
    }
  ],
  "issueDate": "2023-06-15T15:30:00Z",
  "expiryDate": "2023-09-15T15:30:00Z",
  "notes": "Finish the entire course even if feeling better"
}
```

### Update Prescription
```http
PUT /api/prescriptions/{prescriptionId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
Content-Type: application/json

{
  "medications": [
    {
      "name": "Amoxicillin",
      "dosage": "500 mg",
      "frequency": "Every 12 hours",
      "duration": "7 days",
      "quantity": 14,
      "instructions": "Take with food"
    }
  ],
  "expiryDate": "2023-09-15T15:30:00Z",
  "notes": "Reduced frequency due to side effects. Finish the entire course even if feeling better"
}
```

### Mark Prescription as Filled
```http
PATCH /api/prescriptions/{prescriptionId}/status HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <pharmacy_token>
Content-Type: application/json

{
  "status": "filled",
  "filledDate": "2023-06-15T17:45:00Z",
  "filledBy": "Metro Pharmacy",
  "notes": "Patient picked up medication"
}
```

### Cancel Prescription
```http
DELETE /api/prescriptions/{prescriptionId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <doctor_token>
```

## Payments

### Get Patient Billing History
```http
GET /api/payments?patientId={patientId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Payment by ID
```http
GET /api/payments/{paymentId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Invoice
```http
POST /api/payments/invoice HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <staff_token>
Content-Type: application/json

{
  "patientId": "patient123",
  "appointmentId": "appointment789",
  "items": [
    {
      "description": "General consultation",
      "amount": 150.00,
      "code": "99213"
    },
    {
      "description": "Blood test",
      "amount": 75.00,
      "code": "80053"
    }
  ],
  "subtotal": 225.00,
  "tax": 0,
  "total": 225.00,
  "insuranceCoverage": {
    "provider": "Health Shield",
    "policyNumber": "HS12345678",
    "coverageAmount": 180.00
  },
  "patientResponsibility": 45.00,
  "dueDate": "2023-07-15T00:00:00Z",
  "notes": "Please pay within 30 days"
}
```

### Process Payment
```http
POST /api/payments HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "invoiceId": "invoice123",
  "amount": 45.00,
  "method": "credit_card",
  "paymentDetails": {
    "cardNumber": "************4242",
    "expirationMonth": 12,
    "expirationYear": 2025,
    "cardholderName": "Jane Smith"
  },
  "paymentDate": "2023-06-16T10:15:00Z"
}
```

### Update Payment Status
```http
PATCH /api/payments/{paymentId}/status HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <staff_token>
Content-Type: application/json

{
  "status": "completed",
  "transactionId": "txn_123456789"
}
```

### Request Refund
```http
POST /api/payments/{paymentId}/refund HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <staff_token>
Content-Type: application/json

{
  "amount": 45.00,
  "reason": "Service not rendered",
  "notes": "Patient unable to attend appointment due to emergency"
}
```

## Notifications

### Get User Notifications
```http
GET /api/notifications HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Get Notification by ID
```http
GET /api/notifications/{notificationId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Create Notification
```http
POST /api/notifications HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <staff_token>
Content-Type: application/json

{
  "recipientId": "user123",
  "type": "appointment_reminder",
  "title": "Appointment Reminder",
  "message": "You have an appointment with Dr. Johnson tomorrow at 2:30 PM",
  "data": {
    "appointmentId": "appointment789",
    "dateTime": "2023-06-16T14:30:00Z",
    "doctorName": "Dr. Sarah Johnson"
  },
  "channel": ["app", "email", "sms"],
  "priority": "normal",
  "scheduledAt": "2023-06-15T14:30:00Z"
}
```

### Mark Notification as Read
```http
PATCH /api/notifications/{notificationId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "read": true
}
```

### Delete Notification
```http
DELETE /api/notifications/{notificationId} HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

## Settings

### Get Application Settings
```http
GET /api/settings HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
```

### Update Application Settings
```http
PUT /api/settings HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "appointmentDuration": 30,
  "workingHours": {
    "start": "08:00",
    "end": "18:00"
  },
  "supportEmail": "support@tabibi.com",
  "supportPhone": "1-800-TABIBI",
  "allowPatientRegistration": true,
  "requireEmailVerification": true,
  "automaticReminders": {
    "enabled": true,
    "timing": [24, 2],
    "channels": ["email", "sms"]
  }
}
```

### Get User Settings
```http
GET /api/settings/user HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
```

### Update User Settings
```http
PUT /api/settings/user HTTP/1.1
Host: api.tabibi.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "notificationPreferences": {
    "appointmentReminders": ["email", "app"],
    "prescriptionReminders": ["email", "sms", "app"],
    "billingAlerts": ["email"],
    "newsletters": false
  },
  "language": "en",
  "timezone": "America/New_York",
  "darkMode": true
}
```