# 🚀 Terraform AWS EC2 Infrastructure (Modular Setup)

Straight talk: this repo is a **clean, scalable, production‑style Terraform setup** using **modules**. If you understand this structure, you’re already thinking like a real DevOps engineer — not a tutorial zombie.

---

## 📌 What This Project Does

* Provisions **AWS EC2 infrastructure** using Terraform
* Uses **Terraform Modules** (industry standard, reusable, DRY)
* Separates **environment config (dev)** from **resource logic (modules)**
* Ready to scale for multiple environments (dev / stage / prod)

---

## 🧠 Terraform Modules – Full Concept (No Fluff)

A **module** in Terraform is just a **folder containing Terraform code** that performs a specific job.

Think like this:

> 🔁 *"Write once, reuse everywhere"*

### Why Modules Matter (Real Reasons)

* ♻️ **Reusability** – same EC2 logic for dev, stage, prod
* 🧹 **Clean code** – no 500‑line `main.tf`
* 🧠 **Abstraction** – environment passes values, module executes
* 📈 **Scalability** – add more resources without chaos

### How Modules Work

1. **Module defines logic** (EC2 creation)
2. **Environment (dev)** calls the module
3. **Variables flow downward**
4. **Outputs flow upward**

Simple hierarchy:

```
ENVIRONMENT → MODULE → AWS
```

---

## 📁 Project Structure Explained (Line by Line)

```
.
├── dev/
│   ├── .terraform/              # Terraform internal cache (auto-generated)
│   ├── .terraform.lock.hcl       # Provider version lock file
│   ├── main.tf                   # Entry point – calls modules
│   ├── providers.tf              # AWS provider configuration
│   ├── variables.tf              # Input variables for dev environment
│   ├── terraform.tfvars          # Actual values for variables
│   ├── outputs.tf                # Outputs exposed from dev
│   ├── terraform.tfstate         # Terraform state (DO NOT COMMIT)
│   └── terraform.tfstate.backup  # State backup
│
├── modules/
│   └── EC2/
│       ├── main.tf               # EC2 resource logic
│       ├── variables.tf          # Variables expected by EC2 module
│       └── outputs.tf             # Outputs from EC2 module
│
└── .gitignore                     # Ignores state & cache files
```

---

## 🔍 Folder Responsibility (Crystal Clear)

### 🧩 `modules/EC2/`

This is **pure infrastructure logic**.

* No environment details
* No hardcoded values
* Fully reusable

**Contains:**

* `aws_instance`
* Security groups
* Key pair reference
* AMI, instance type, tags (via variables)

---

### 🌱 `dev/` (Environment Layer)

This is **where decisions are made**.

* Which module to use
* What values to pass
* AWS region
* Instance size
* Key pair name

Dev folder answers:

> *"WHAT do we want?"*

Module answers:

> *"HOW is it created?"*

---

## 🔗 How Module Is Called (Conceptually)

Inside `dev/main.tf`:

```hcl
module "ec2" {
  source = "../modules/EC2"

  instance_type = var.instance_type
  ami_id         = var.ami_id
  key_name       = var.key_name
}
```

This is the **handshake** between environment and module.

---

## 📥 Variables Flow (Important)

### 1️⃣ Module Variables (`modules/EC2/variables.tf`)

These are **requirements**:

```hcl
variable "instance_type" {}
variable "ami_id" {}
variable "key_name" {}
```

### 2️⃣ Dev Variables (`dev/variables.tf`)

These **declare** what dev needs:

```hcl
variable "instance_type" {}
variable "ami_id" {}
variable "key_name" {}
```

### 3️⃣ Dev tfvars (`dev/terraform.tfvars`)

These **assign real values**:

```hcl
instance_type = "t2.micro"
ami_id        = "ami-0abcdef123456"
key_name      = "dev-key"
```

📌 **Rule:**

> tfvars → variables.tf → module → AWS

---

## 🏃 How To Run This Project (Step‑By‑Step)

### ✅ Prerequisites

* Terraform installed (`terraform -v`)
* AWS CLI configured

```bash
aws configure
```

---

### ▶️ Step 1: Go to Environment

```bash
cd dev
```

---

### ▶️ Step 2: Initialize Terraform

```bash
terraform init
```

What this does:

* Downloads AWS provider
* Sets up backend
* Initializes modules

---

### ▶️ Step 3: Validate Code

```bash
terraform validate
```

Checks syntax & logic.
No mercy. Either clean or fail.

---

### ▶️ Step 4: See Execution Plan

```bash
terraform plan
```

This is your **preview before destruction or glory**.
Always check this.

---

### ▶️ Step 5: Apply Infrastructure

```bash
terraform apply
```

Type `yes` and let Terraform cook.

---

### 🧨 Destroy Everything (When Needed)

```bash
terraform destroy
```

Because real engineers clean up.

---

## 📤 Outputs

Outputs defined in:

* `modules/EC2/outputs.tf`
* Re‑exposed in `dev/outputs.tf`

Example:

```hcl
output "ec2_public_ip" {
  value = module.ec2.public_ip
}
```

Use outputs for:

* SSH
* Load balancers
* Monitoring

---

## 🚫 Files You Should NEVER Commit

Handled via `.gitignore`:

```
.terraform/
terraform.tfstate
terraform.tfstate.backup
```

State files contain sensitive data.
Commit that and your DevOps card is revoked.

---

## 🧠 Best Practices Followed Here

* ✅ Modular architecture
* ✅ Environment isolation
* ✅ No hardcoded values
* ✅ Version locking
* ✅ Clean separation of concerns

This is **resume‑worthy Terraform**, not demo junk.

---

## 🧩 How To Extend This Project

* Add `stage/` and `prod/` folders
* Create more modules:

  * VPC
  * S3
  * IAM
* Add remote backend (S3 + DynamoDB)

---

## 🏁 Final Words

If you understand this repo:

> You’re no longer *learning Terraform* — you’re **using it professionally**.

Copy. Paste. Ship. 🚀
