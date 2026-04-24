# Terraform Lab - Oracle Cloud Infrastructure (OCI)

This repository contains Terraform configurations for provisioning and managing infrastructure on Oracle Cloud Infrastructure (OCI). It is designed as a learning lab to practice Infrastructure as Code (IaC) using modular Terraform code.

## Overview

This project demonstrates how to:
- Configure Terraform for OCI
- Use reusable Terraform modules
- Separate root configuration from modules
- Provision network infrastructure using OCI

## Project Structure

.
├── main.tf              # Root configuration (calls modules)
├── variables.tf        # Root input variables
├── outputs.tf         # Root outputs
├── terraform.tfvars    # Variable values
├── versions.tf         # Terraform and provider versions
└── modules/
    └── network/
        ├── main.tf     # Network resources (VCN, subnets, etc.)
        ├── variables.tf
        ├── outputs.tf

## Technologies Used

- Terraform
- Oracle Cloud Infrastructure (OCI)
- HCL (HashiCorp Configuration Language)

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/your-username/terraform-lab.git
cd terraform-lab
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Validate configuration
```bash
terraform validate
```

### 4. Create execution plan
```bash
terraform plan
```

### 5. Apply configuration
```bash
terraform apply
```

## Module: Network

The `network` module manages core networking components in OCI such as:
- Virtual Cloud Network (VCN)
- Subnets
- Routing configuration

The module is designed to be reusable across environments.
