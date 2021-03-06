# Untuk Konfigurasi Menggunakan AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

# Optional untuk menentukan versi terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
