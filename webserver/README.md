# Webserver in a separate network with terraform
This example projects implements terraform and IaC with AWS provider to achieve automatic deployment of a virtual network and an ubuntu server with a webserver (apache2) inside it. 

# Structure
We have a few files in here, let's dissect them in order.
1. `main.tf` - It contains the declaration of the ec2 instance and the installation script of the webserver.
2. `network.tf` - It contains the declaration of all networking services, including:
    
    * Virtual Private Cloud (VPC)
    * Gateway
    * Subnet
    * Network interface
    * Security group for web traffic and ssh
    * Network interface for ec2 instance
    * Elastic IP given to ec2 instance<br>
<br>

3. `providers.tf` - The prime purpose of this file is to connect Terraform to AWS by creating a provider block and supplying the region name and authorization keys.

4. `vars.tf` - This file contains declarations of all used variables.

5. `outputs.tf` - File that contains output values, specifically the public ip of initialized instance.

6. `terraform.tfvars` - This file may be used to further configurate this terraform script up to your specific situation.

# Configure
To properly run this project - you first a vol need to configure it. All configurations happen in the `terraform.tfvars` file. Let's go through them.

1. `provider_region` - Required. Specifies main region.
2. `access_key` and `secret_key` - They are required in order to communicate with AWS. 
    * Can be generated in Profile name in the top right corner ->
    * Security credentials ->
    * Access keys (access key ID and secret access key) ->
    * Create New Access Key
2. `server_text` - The text that will be displayed by the webserver.
3. `ec2_access_key_name` - The name of the `AWS Key Pair` to attach to the server. It has to be created before the start.

# Run
After configuring the `terraform.tfvars` - You should be clear to get everything up and running.

1. Initialize terraform and install provider package
```bash
$ terraform init
```

2. Terraform plan to provision and check if everything is fine.
```bash
$ terraform plan
```

3. Apply the script
```bash
$ terraform apply
```
