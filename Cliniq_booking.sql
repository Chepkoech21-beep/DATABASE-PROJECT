-- Create the database
CREATE DATABASE IF NOT EXISTS ClinicDB;
USE ClinicDB;

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20)
);

-- Appointments Table (Many-to-One with Doctors and Patients)
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Treatments Table (One-to-One with Appointments)
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,
    Diagnosis TEXT,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Prescriptions Table (One-to-Many with Treatments)
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    TreatmentID INT NOT NULL,
    MedicineName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50),
    Duration VARCHAR(50),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);
