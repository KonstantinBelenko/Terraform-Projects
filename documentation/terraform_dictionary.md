# Terraform dictionary

These are basic concepts the knowledge of which is required to work with terraform.

# What is HCL?
HCL or "HashiCorp Configuration Language" is a configuration language designed by [HashiCorp](https://www.hashicorp.com/). It often goes with other hashicorp products, but most of all is used by Terraform. It was created to replace JSON or YAML, to be more human-readable.

# Terraform concepts and terminology
* Immutable: A resourse that cannot be changed after creation, only replaced/re-created.

* Mutable: A resourse that can be changed after creation.

<hr>

* Provider: System that supplies control over resourses to terraform (AWS, Azure, Cloudflare, GCP, etc.) at the low level via API calls.

* Module: Module is a collection of Terraform configuration files that are used to create a specific infrastructure resource. Modules can be used to create reusable components, or to organized Terraform configuration files. 

* State: The tfstate is cached metadata about the configurations that are created/replaced/updated/delete in a Terraform module. State is used to store the current state of your infrastructure. This state is used by Terraform to plan and apply changes to your infrastructure.

* Data Source: Data source is used to fetch information about a remote resource. This can be used to fetch things like IP addresses, AMIs, security groups, and more.

* Output Values: Values returned after creating resources via Terraform. When Terraform runs, it will output any data that is marked as important. This lets you inspect or even manipulate this data after a Terraform run.

* Backend: Backend is a type of Terraform state storage that keeps track of your Terraform state and state history. Backends can be local or remote. A remote backend can be used to store your Terraform state in a central location, such as an S3 bucket, and can be used to share your state with others.

* Resourse: A terraform resource is a component of your infrastructure. For example, a web server, database server, or load balancer.<br>

    **Example of a resourse:**
    ```bash
    resource "aws_s3_bucket" "prod-bucket-1" {
    # Configuration
    }
    ```

# Most used Terraform commands
* `$ terraform init` - Init sets up required files for terraform to work. Init also downloads the Provider and stores it in the Terraform module.

* `$ terraform plan` - Determines what needs to be created/replaced/updated/deleted to move to the desired state.

* `$ terraform apply` - Creates/replaces/updates/deletes the resources.

* `$ terraform destroy` - Deletes previously created resourses.