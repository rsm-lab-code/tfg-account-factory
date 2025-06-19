# Organization outputs
output "organization_id" {
  description = "AWS Organization ID"
  value       = data.aws_organizations_organization.main.id
}

output "organization_root_id" {
  description = "AWS Organization root ID"
  value       = data.aws_organizations_organization.main.roots[0].id
}

# Main OU outputs
output "prod_ou_id" {
  description = "Production OU ID"
  value       = aws_organizations_organizational_unit.prod_ou.id
}

output "nonprod_ou_id" {
  description = "Non-production OU ID"
  value       = aws_organizations_organizational_unit.nonprod_ou.id
}

# Department OU outputs
output "dept_prod_ou_ids" {
  description = "Department production OU IDs"
  value = {
    for dept, ou in aws_organizations_organizational_unit.dept_prod_ou : 
    dept => ou.id
  }
}

output "dept_nonprod_ou_ids" {
  description = "Department non-production OU IDs"
  value = {
    for dept, ou in aws_organizations_organizational_unit.dept_nonprod_ou : 
    dept => ou.id
  }
}

# Account outputs
output "created_accounts" {
  description = "Information about created accounts"
  value = {
    for key, account in aws_organizations_account.accounts : key => {
      id          = account.id
      name        = account.name
      email       = account.email
      department  = account.tags.Department
      environment = account.tags.Environment
      parent_ou   = account.parent_id
    }
  }
}

# OU structure for reference
output "ou_structure" {
  description = "Complete OU structure created"
  value = {
    root = data.aws_organizations_organization.main.roots[0].id
    prod_ou = aws_organizations_organizational_unit.prod_ou.id
    nonprod_ou = aws_organizations_organizational_unit.nonprod_ou.id
    department_ous = {
      for dept in var.departments : dept => {
        prod_ou = aws_organizations_organizational_unit.dept_prod_ou[dept].id
        nonprod_ou = aws_organizations_organizational_unit.dept_nonprod_ou[dept].id
      }
    }
  }
}
