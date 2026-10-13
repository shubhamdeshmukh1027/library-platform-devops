# Enterprise Smart Library Management Platform: DevOps Hands-On Lab

![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)
![Ansible](https://img.shields.io/badge/Config-Ansible-EE0000?logo=ansible&logoColor=white)
![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%20(WSL)-E95420?logo=ubuntu&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Progress-blue)

A hands-on DevOps lab that builds the infrastructure for a Smart Library Management Platform on AWS, using the AWS CLI, Terraform and Ansible. Each chapter is a self-contained, reproducible stage, with a written report.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Workflow](#workflow)
4. [Repository Structure](#repository-structure)
5. [Tools and Prerequisites](#tools-and-prerequisites)
6. [Chapter Status](#chapter-status)
7. [Chapter 2: Prerequisites and AWS Environment Setup](#chapter-2-prerequisites-and-aws-environment-setup)
8. [Chapter 3: Infrastructure as Code with Terraform](#chapter-3-infrastructure-as-code-with-terraform)
9. [Security Practices](#security-practices)
10. [Cost Control](#cost-control)
11. [Roadmap](#roadmap)

---

## Project Overview

| Item | Detail |
|---|---|
| Goal | Provision and configure cloud infrastructure for a library platform using DevOps practices |
| Cloud | Amazon Web Services (AWS) |
| IaC | Terraform |
| Configuration Management | Ansible (upcoming) |
| Dev Environment | Ubuntu on WSL2 (Windows) |
| Approach | Chapter-wise labs: setup, provision, configure, verify, destroy |

---

## Architecture

Target infrastructure provisioned in Chapter 3:

```mermaid
flowchart TB
    User([Developer / Admin])

    subgraph Local["Local Workstation (Ubuntu on WSL)"]
        TF[Terraform]
        CLI[AWS CLI]
        SSH[SSH Client]
    end

    subgraph AWS["AWS Cloud"]
        IAM[IAM User and Access Keys]

        subgraph VPC["VPC"]
            IGW[Internet Gateway]
            subgraph Subnet["Public Subnet"]
                EC2["EC2 Instance<br/>(Library App Server)"]
            end
            SG{{"Security Group<br/>SSH / HTTP"}}
        end

        S3[("S3 Bucket<br/>Library Assets")]
    end

    User --> TF
    User --> CLI
    TF -->|authenticates| IAM
    CLI -->|authenticates| IAM
    IAM -->|provisions| VPC
    IAM -->|provisions| S3
    SSH -->|port 22| SG
    SG --> EC2
    EC2 --- IGW
    EC2 -.->|reads / writes| S3
```

---

## Workflow

End-to-end lab lifecycle followed in every chapter:

```mermaid
flowchart LR
    A[Install Tools] --> B[Configure AWS Credentials]
    B --> C[Write Terraform Code]
    C --> D[terraform init]
    D --> E[terraform plan]
    E --> F{Plan OK?}
    F -- No --> C
    F -- Yes --> G[terraform apply]
    G --> H[Verify Resources]
    H --> I[SSH into EC2]
    I --> J[Capture Evidence]
    J --> K[terraform destroy]
    K --> L[Commit to GitHub]
```

### Terraform Execution Sequence

```mermaid
sequenceDiagram
    actor Dev as Developer
    participant TF as Terraform
    participant AWS as AWS API
    participant EC2 as EC2 Instance

    Dev->>TF: terraform init
    TF-->>Dev: Providers downloaded
    Dev->>TF: terraform plan
    TF->>AWS: Read current state
    AWS-->>TF: Existing resources
    TF-->>Dev: Execution plan
    Dev->>TF: terraform apply
    TF->>AWS: Create VPC, networking, SG, EC2, S3
    AWS-->>TF: Resource IDs
    TF-->>Dev: Outputs (public IP, bucket name)
    Dev->>EC2: ssh -i key.pem ubuntu@public-ip
    EC2-->>Dev: Shell access
    Dev->>TF: terraform destroy
    TF->>AWS: Delete all resources
```

### CI/Version Control Flow

```mermaid
flowchart LR
    W[Local Changes] --> S[git add]
    S --> C[git commit]
    C --> P[git push origin main]
    P --> R[(GitHub Repository)]
    G[.gitignore] -.->|blocks tfstate, keys, .terraform/| S
```

---

## Repository Structure

```text
library-platform-devops/
├── README.md
├── .gitignore
├── Unit 4 Document 1/
│   ├── screenshots/
│   └── Chapter-2-Professional-Report.docx
└── Unit 4 Document 2/
    ├── screenshots/
    ├── terraform/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   └── .terraform.lock.hcl
    └── Chapter-3-Terraform-Report.docx
```

> Adjust file names above if your `.tf` files are named differently.

---

## Tools and Prerequisites

| Tool | Purpose |
|---|---|
| AWS CLI | Authenticate and interact with AWS from the terminal |
| Terraform | Declarative infrastructure provisioning |
| Ansible | Configuration management (Chapter 4) |
| Git and GitHub | Version control and proof of work |
| Ubuntu (WSL2) | Linux development environment |
| SSH key pair | Secure access to EC2 |

Verify installations:

```bash
aws --version
terraform -version
ansible --version
git --version
```

---

## Chapter Status

```mermaid
flowchart LR
    C1["Chapter 1<br/>Introduction"]:::done --> C2["Chapter 2<br/>AWS Environment Setup"]:::done
    C2 --> C3["Chapter 3<br/>Terraform Provisioning"]:::done
    C3 --> C4["Chapter 4<br/>Ansible Configuration"]:::next
    C4 --> C5["Further Chapters"]:::future

    classDef done fill:#2da44e,color:#fff,stroke:#1a7f37
    classDef next fill:#0969da,color:#fff,stroke:#0550ae
    classDef future fill:#8c959f,color:#fff,stroke:#6e7781
```

| Chapter | Topic | Status |
|---|---|---|
| 2 | Prerequisites and AWS Environment Setup | Completed |
| 3 | Infrastructure as Code with Terraform | Completed |
| 4 | Configuration Management with Ansible | Planned |

---

## Chapter 2: Prerequisites and AWS Environment Setup

```mermaid
flowchart TD
    A[Install Git, AWS CLI, Terraform, Ansible] --> B[Create IAM User]
    B --> C[Generate Access Keys]
    C --> D[aws configure]
    D --> E[Create SSH Key Pair]
    E --> F[Verify: aws sts get-caller-identity]
    F --> G{All tools working?}
    G -- No --> H[Troubleshoot]
    H --> F
    G -- Yes --> I[Push Proof of Work to GitHub]
```

**Outcomes**

- Required tooling installed and verified
- IAM user created with programmatic access
- AWS CLI configured and tested
- SSH key pair created for EC2 access
- `.gitignore` configured to protect secrets

---

## Chapter 3: Infrastructure as Code with Terraform

Provisions the base infrastructure for the platform using Terraform.

```mermaid
flowchart TD
    TF[Terraform Configuration] --> NET[Networking]
    TF --> SEC[Security]
    TF --> CMP[Compute]
    TF --> STO[Storage]

    NET --> VPC[VPC]
    NET --> SUB[Subnet]
    NET --> IGW[Internet Gateway]
    NET --> RT[Route Table]

    SEC --> SG[Security Group]

    CMP --> EC2[EC2 Instance]

    STO --> S3[S3 Bucket]
```

> Keep this diagram in sync with your actual `main.tf` (add or remove nodes as needed).

### Run the Lab

```bash
cd "Unit 4 Document 2/terraform"

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Read outputs and connect:

```bash
terraform output
ssh -i ~/.ssh/<your-key>.pem ubuntu@<public-ip>
```

Clean up when finished:

```bash
terraform destroy
```

### Variables

| Variable | Description |
|---|---|
| `region` | AWS region for deployment |
| `instance_type` | EC2 instance size |
| `key_name` | Name of the SSH key pair |
| `bucket_name` | Globally unique S3 bucket name |

> Update this table to match your `variables.tf`.

---

## Security Practices

```mermaid
flowchart LR
    A[Secrets] --> B[Never committed]
    B --> C[".gitignore blocks:<br/>*.tfstate, *.pem, .terraform/, credentials"]
    D[Network] --> E[Restrict SSH to your IP]
    F[Access] --> G[Least-privilege IAM user]
```

- `terraform.tfstate` and `*.pem` files are excluded via `.gitignore`
- Access keys are never stored in the repository
- SSH access should be limited to a known IP range
- IAM permissions follow least privilege
- No personal details are published in this public repository

---

## Cost Control

```mermaid
flowchart LR
    A[terraform apply] --> B[Capture evidence]
    B --> C[terraform destroy]
    C --> D[Check AWS Console]
    D --> E{Any EC2 / S3 left?}
    E -- Yes --> F[Delete manually]
    E -- No --> G[No unexpected bill]
```

Always run `terraform destroy` after finishing a lab and confirm in the AWS Console that no EC2 instances or S3 buckets remain.

---

## Roadmap

```mermaid
gantt
    title Project Roadmap
    dateFormat  YYYY-MM-DD
    axisFormat  %b
    section Completed
    Chapter 2 - AWS Setup        :done, c2, 2026-09-01, 10d
    Chapter 3 - Terraform        :done, c3, after c2, 10d
    section Upcoming
    Chapter 4 - Ansible          :active, c4, after c3, 10d
    Chapter 5 - Application Deploy :c5, after c4, 10d
```

> Adjust dates to your real timeline, or delete the Gantt block if not needed.

- [x] Chapter 2: AWS environment setup
- [x] Chapter 3: Terraform infrastructure
- [ ] Chapter 4: Ansible configuration management
- [ ] Chapter 5: Application deployment

---

## Reports

Detailed written reports for each chapter are available in their respective chapter folders.

---

## License

This project is for educational purposes.
