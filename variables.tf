variable "project_id" {
  description = "GCP project ID to deploy into. Required: there is deliberately no default."
  type        = string
}

variable "region" {
  description = "GCP region for the Composer environment and its subnet."
  type        = string
  default     = "europe-west2"
}

variable "environment_name" {
  description = "Name of the Composer environment (e.g. sandbox, dev, prod). Also exposed to DAGs as the ENVIRONMENT variable."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,62}[a-z0-9])?$", var.environment_name))
    error_message = "environment_name must start with a lowercase letter and contain only lowercase letters, digits and hyphens (max 64 characters)."
  }
}

variable "resource_prefix" {
  description = "Prefix for the VPC, subnet and service account names. Change it to run more than one environment in the same project."
  type        = string
  default     = "composer3"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9]{2,20}$", var.resource_prefix))
    error_message = "resource_prefix must be 3-21 characters: lowercase letters, digits and hyphens, starting with a letter."
  }
}

variable "subnet_cidr" {
  description = "Primary IP range for the Composer subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "enable_private_environment" {
  description = "If true, Composer 3 runs without public IPs on its workloads (Cloud Composer 3 only)."
  type        = bool
  default     = false
}

variable "pypi_packages" {
  description = "PyPI packages to install in the environment, as name => version specifier."
  type        = map(string)
  default = {
    pymssql = "==2.3.2"
    pandas  = "==2.2.3"
  }
}

variable "worker_min_count" {
  description = "Minimum number of Airflow workers."
  type        = number
  default     = 1
}

variable "worker_max_count" {
  description = "Maximum number of Airflow workers (autoscaling ceiling)."
  type        = number
  default     = 3

  validation {
    condition     = var.worker_max_count >= 1
    error_message = "worker_max_count must be at least 1."
  }
}

variable "labels" {
  description = "Labels applied to the Composer environment."
  type        = map(string)
  default     = {}
}
