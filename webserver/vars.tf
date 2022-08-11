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

variable "server_text" {
  description = "The text that will be displayed by the web server"
  type        = string
  default     = "Hello World!"
}

variable "ec2_access_key_name" {
  description = "The name of the access key for ec2 instance"
  type        = string
}