# AWS keys
variable "access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

# Other variables
variable "provider_region" {
  description  = "Main infrastructure region"
  type        = string
  default     = "eu-central-1"
}