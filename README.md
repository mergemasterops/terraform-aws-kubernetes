# Terraform AWS Kubernetes Setup

This repository contains a Terraform configuration and helper script for provisioning a Kubernetes environment on AWS.

## Files

- `resource.tf` - Main Terraform resources
- `variables.tf` - Input variables
- `install-kubernetes.sh` - Script for installing and configuring Kubernetes components
- `.gitignore` - Ignores sensitive and local files

## Prerequisites

- Terraform installed
- AWS CLI configured with valid credentials
- SSH key available for EC2 access

## Usage

1. Review and update variables in `variables.tf` if needed.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Preview the plan:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Notes

- Do not commit sensitive files such as PEM keys or Terraform state files.
- The script in `install-kubernetes.sh` is intended for provisioning Kubernetes on the created instance.
