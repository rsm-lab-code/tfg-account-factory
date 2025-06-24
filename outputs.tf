# Main OU IDs for SCP targeting
output "prod_ou_id" {
  description = "Production OU ID"
  value       = data.aws_organizations_organizational_unit.prod.id
}

output "nonprod_ou_id" {
  description = "Non-production OU ID"
  value       = data.aws_organizations_organizational_unit.nonprod.id
}

# Key OU IDs for reference
output "key_ou_ids" {
  description = "Key OU IDs for reference"
  value = {
    sandbox        = data.aws_organizations_organizational_unit.sandbox.id
    security       = data.aws_organizations_organizational_unit.security.id
    infrastructure = data.aws_organizations_organizational_unit.infrastructure.id
    workloads      = data.aws_organizations_organizational_unit.workloads.id
    trailblazer    = data.aws_organizations_organizational_unit.trailblazer.id
  }
}

# Created accounts
output "created_accounts" {
  description = "Information about created accounts"
  value = {
    for key, account in aws_organizations_account.accounts : key => {
      id          = account.id
      name        = account.name
      email       = account.email
      parent_ou   = account.parent_id
    }
  }
}
