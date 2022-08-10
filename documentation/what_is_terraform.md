# What the hell is Terraform?
[Terraform](https://www.terraform.io/) is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Configuration files describe to Terraform the components of your infrastructure (e.g. compute instances, networking, load balancers, DNS entries). Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.

The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.

# Alternatives to Terraform
1. [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
2. [Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview)
3. [Google Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs)
4. [Pulumi](https://www.pulumi.com/)