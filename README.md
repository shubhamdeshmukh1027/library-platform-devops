# Enterprise Smart Library Platform: DevOps Hands-On Lab

Unit 4: Infrastructure Automation (Cloud DevOps Engineering Series, Careertiq)


## About

Hands-on lab for the Enterprise Smart Library Management Platform. The platform is provisioned on AWS with Terraform and configured with Ansible.

## Tools Used

| Tool | Version | Purpose |
|---|---|---|
| AWS CLI v2 | 2.37.12 | Manage AWS services and authenticate |
| Terraform | v1.16.5 | Infrastructure as Code (VPC, EC2, S3) |
| Ansible Core | 2.17.14 | Configuration management (Docker, Nginx) |

**Environment:** Windows 11 + WSL2, Ubuntu 22.04 LTS, AWS region us-east-1

## Repository Structure

    library-platform-devops/
    ├── README.md
    ├── .gitignore
    ├── chapter-2/
    │   └── screenshots/    Chapter 2 proof screenshots
    └── chapter-3/
        └── terraform/      Terraform code (coming soon)

## Chapter 2: Prerequisites & AWS Environment Setup

| Step | Section | Status |
|---|---|---|
| 1 | Workstation baseline utilities | Done |
| 2 | AWS CLI v2 installation | Done |
| 3 | Terraform installation | Done |
| 4 | Ansible Core installation + collections | Done |
| 5 | IAM user and access key creation | Done |
| 6 | AWS CLI configuration and STS verification | Done |
| 7 | SSH key pair generation (RSA 4096) | Done |
| 8 | Public key import into AWS EC2 | Done |
| 9 | Final toolchain verification | Done |

Screenshots are available in the `chapter-2/screenshots/` folder.

## Chapter 3: Terraform Infrastructure as Code

In progress. Will provision VPC, Subnet, Security Group, EC2 instance and S3 backup bucket.

## Security Notes

- No AWS access keys, private SSH keys or GitHub tokens are stored in this repository.
- `.gitignore` excludes `*.pem`, `*.key`, `library-aws-key*`, `.aws/`, `*.tfstate` and `.terraform/`.
