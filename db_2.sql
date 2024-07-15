-- Create the database
CREATE DATABASE IF NOT EXISTS ApartmentRentalManagement;

-- Use the database
USE ApartmentRentalManagement;

-- Create the Roles table
CREATE TABLE IF NOT EXISTS Roles(
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR(255) NOT NULL
);

-- Create the Users table
CREATE TABLE IF NOT EXISTS Users(
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Create the Landlords table
CREATE TABLE IF NOT EXISTS Landlords (
    landlord_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create the Tenants table
CREATE TABLE IF NOT EXISTS Tenants (
    tenant_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create the Apartments table
CREATE TABLE IF NOT EXISTS Apartments (
    apartment_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    landlord_id INT NOT NULL,
    tenant_id INT,
    tenant_phone VARCHAR(255), 
    contract_start_date DATE,
    contract_end_date DATE,
    status ENUM('vacant', 'rented') NOT NULL DEFAULT 'vacant',  -- New column to indicate apartment status
    FOREIGN KEY (landlord_id) REFERENCES Landlords(landlord_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

-- Create the Professionals table
CREATE TABLE IF NOT EXISTS Professionals (
    professional_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    specialization ENUM('plumbing', 'electricity', 'carpentry', 'telephone', 'other') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Create the UtilityRates table
CREATE TABLE IF NOT EXISTS UtilityRates (
    rate_id INT AUTO_INCREMENT PRIMARY KEY,
    landlord_id INT NOT NULL,
    water_rate DECIMAL(10, 2) NOT NULL,
    gas_rate DECIMAL(10, 2) NOT NULL,
    electricity_rate DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (landlord_id) REFERENCES Landlords(landlord_id)
);

-- Create the UtilityUsage table
CREATE TABLE IF NOT EXISTS UtilityUsage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id INT NOT NULL,
    water_usage DECIMAL(10, 2) NOT NULL,
    gas_usage DECIMAL(10, 2) NOT NULL,
    electricity_usage DECIMAL(10, 2) NOT NULL,
    usage_date DATE NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

-- Create the UtilityPayments table
CREATE TABLE IF NOT EXISTS UtilityPayments (
    utility_payment_id INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    paid BOOLEAN NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

-- Create the Faults table
CREATE TABLE IF NOT EXISTS Faults (
    fault_id INT AUTO_INCREMENT PRIMARY KEY,
    apartment_id INT NOT NULL,
    tenant_id INT NOT NULL,
    description TEXT NOT NULL,
    reported_date DATE NOT NULL,
    status ENUM('reported', 'in_progress', 'resolved') NOT NULL,
    assigned_professional VARCHAR(255),
    professional_email VARCHAR(255),
    FOREIGN KEY (apartment_id) REFERENCES Apartments(apartment_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

-- Create the FaultPayments table
CREATE TABLE IF NOT EXISTS FaultPayments (
    fault_payment_id INT AUTO_INCREMENT PRIMARY KEY,
    fault_id INT NOT NULL,
    landlord_id INT NOT NULL,
    professional_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    paid BOOLEAN NOT NULL,
    FOREIGN KEY (fault_id) REFERENCES Faults(fault_id),
    FOREIGN KEY (landlord_id) REFERENCES Landlords(landlord_id),
    FOREIGN KEY (professional_id) REFERENCES Professionals(professional_id)
);

-- Create the Payments table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    apartment_id INT NOT NULL,
    tenant_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    paid BOOLEAN NOT NULL,
    FOREIGN KEY (apartment_id) REFERENCES Apartments(apartment_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);
