variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "databyschroeder.com"
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID for the domain"
  type        = string
  default     = "Z09893263J9CSFP2KPZ5P"
}

provider "aws" {
  region = "us-east-1"
}
