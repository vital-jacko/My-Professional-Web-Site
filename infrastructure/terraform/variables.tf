variable "domain_name" {
  description = "Root domain name (e.g. yourdomain.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID for the domain"
  type        = string
}

provider "aws" {
  region = "us-east-1"
}
