# Get organization information
data "aws_organizations_organization" "main" {
  provider = aws.management_account
}

# Get Non-Production OU
data "aws_organizations_organizational_unit" "nonprod" {
  provider = aws.management_account
  name     = "Non-Production"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# Get Production OU  
data "aws_organizations_organizational_unit" "prod" {
  provider = aws.management_account
  name     = "Production"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# Get Non-Production child OUs
data "aws_organizations_organizational_unit" "usal_nonprod" {
  provider = aws.management_account
  name     = "USAL-Non-Production"
  parent_id = data.aws_organizations_organizational_unit.nonprod.id
}

data "aws_organizations_organizational_unit" "gst_nonprod" {
  provider = aws.management_account
  name     = "GST-Non-Production"
  parent_id = data.aws_organizations_organizational_unit.nonprod.id
}

data "aws_organizations_organizational_unit" "tfg_nonprod" {
  provider = aws.management_account
  name     = "TFG-Non-Production"
  parent_id = data.aws_organizations_organizational_unit.nonprod.id
}

data "aws_organizations_organizational_unit" "copilotint1_nonprod" {
  provider = aws.management_account
  name     = "CoPilotInt1-Non-Production"
  parent_id = data.aws_organizations_organizational_unit.nonprod.id
}

data "aws_organizations_organizational_unit" "gsfs_nonprod" {
  provider = aws.management_account
  name     = "GSFS-Non-Production"
  parent_id = data.aws_organizations_organizational_unit.nonprod.id
}

# Get Production child OUs
data "aws_organizations_organizational_unit" "gst_prod" {
  provider = aws.management_account
  name     = "GST-Production"
  parent_id = data.aws_organizations_organizational_unit.prod.id
}

data "aws_organizations_organizational_unit" "copilotint1_prod" {
  provider = aws.management_account
  name     = "CoPilotInt1-Production"
  parent_id = data.aws_organizations_organizational_unit.prod.id
}

data "aws_organizations_organizational_unit" "tfg_prod" {
  provider = aws.management_account
  name     = "TFG-Production"
  parent_id = data.aws_organizations_organizational_unit.prod.id
}

data "aws_organizations_organizational_unit" "gsfs_prod" {
  provider = aws.management_account
  name     = "GSFS-Production"
  parent_id = data.aws_organizations_organizational_unit.prod.id
}

data "aws_organizations_organizational_unit" "usal_prod" {
  provider = aws.management_account
  name     = "USAL-Production"
  parent_id = data.aws_organizations_organizational_unit.prod.id
}

# Get other root-level OUs
data "aws_organizations_organizational_unit" "sandbox" {
  provider = aws.management_account
  name     = "Sandbox"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "suspended" {
  provider = aws.management_account
  name     = "Suspended"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "transitional" {
  provider = aws.management_account
  name     = "Transitional"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "security" {
  provider = aws.management_account
  name     = "Security"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "infrastructure" {
  provider = aws.management_account
  name     = "Infrastructure"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "workloads" {
  provider = aws.management_account
  name     = "Workloads"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "policy_staging" {
  provider = aws.management_account
  name     = "Policy Staging"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "exceptions" {
  provider = aws.management_account
  name     = "Exceptions"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# Get Trailblazer child OUs
data "aws_organizations_organizational_unit" "trailblazer" {
  provider = aws.management_account
  name     = "Trailblazer"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "trailblazer_gst" {
  provider = aws.management_account
  name     = "Trailblazer-GST"
  parent_id = data.aws_organizations_organizational_unit.trailblazer.id
}

data "aws_organizations_organizational_unit" "trailblazer_tfg" {
  provider = aws.management_account
  name     = "Trailblazer-TFG"
  parent_id = data.aws_organizations_organizational_unit.trailblazer.id
}

data "aws_organizations_organizational_unit" "trailblazer_gsfs" {
  provider = aws.management_account
  name     = "Trailblazer-GSFS"
  parent_id = data.aws_organizations_organizational_unit.trailblazer.id
}

data "aws_organizations_organizational_unit" "trailblazer_usal" {
  provider = aws.management_account
  name     = "Trailblazer-USAL"
  parent_id = data.aws_organizations_organizational_unit.trailblazer.id
}

data "aws_organizations_organizational_unit" "trailblazer_sandbox" {
  provider = aws.management_account
  name     = "Trailblazer-Sandbox"
  parent_id = data.aws_organizations_organizational_unit.trailblazer.id
}

# OU lookup map
locals {
  ou_map = {
    # Non-Production OUs
    "usal-nonprod"      = data.aws_organizations_organizational_unit.usal_nonprod.id
    "gst-nonprod"       = data.aws_organizations_organizational_unit.gst_nonprod.id
    "tfg-nonprod"       = data.aws_organizations_organizational_unit.tfg_nonprod.id
    "copilotint1-nonprod" = data.aws_organizations_organizational_unit.copilotint1_nonprod.id
    "gsfs-nonprod"      = data.aws_organizations_organizational_unit.gsfs_nonprod.id
    
    # Production OUs
    "gst-prod"          = data.aws_organizations_organizational_unit.gst_prod.id
    "copilotint1-prod"  = data.aws_organizations_organizational_unit.copilotint1_prod.id
    "tfg-prod"          = data.aws_organizations_organizational_unit.tfg_prod.id
    "gsfs-prod"         = data.aws_organizations_organizational_unit.gsfs_prod.id
    "usal-prod"         = data.aws_organizations_organizational_unit.usal_prod.id
    
    # Root-level OUs
    "sandbox"           = data.aws_organizations_organizational_unit.sandbox.id
    "suspended"         = data.aws_organizations_organizational_unit.suspended.id
    "transitional"      = data.aws_organizations_organizational_unit.transitional.id
    "security"          = data.aws_organizations_organizational_unit.security.id
    "infrastructure"    = data.aws_organizations_organizational_unit.infrastructure.id
    "workloads"         = data.aws_organizations_organizational_unit.workloads.id
    "policy-staging"    = data.aws_organizations_organizational_unit.policy_staging.id
    "exceptions"        = data.aws_organizations_organizational_unit.exceptions.id
    
    # Trailblazer OUs
    "trailblazer"       = data.aws_organizations_organizational_unit.trailblazer.id
    "trailblazer-gst"   = data.aws_organizations_organizational_unit.trailblazer_gst.id
    "trailblazer-tfg"   = data.aws_organizations_organizational_unit.trailblazer_tfg.id
    "trailblazer-gsfs"  = data.aws_organizations_organizational_unit.trailblazer_gsfs.id
    "trailblazer-usal"  = data.aws_organizations_organizational_unit.trailblazer_usal.id
    "trailblazer-sandbox" = data.aws_organizations_organizational_unit.trailblazer_sandbox.id
  }
}

# Create accounts
resource "aws_organizations_account" "accounts" {
  provider  = aws.management_account
  for_each  = var.account_requests

  name      = each.value.name
  email     = each.value.email
  parent_id = local.ou_map[each.value.target_ou]
  
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name         = each.value.name
    BusinessUnit = each.value.business_unit
    Environment  = each.value.environment
    Description  = each.value.description
    ManagedBy    = "terraform"
  }
}