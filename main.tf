# Get organization information
data "aws_organizations_organization" "main" {
  provider = aws.management_account
}

# Create main OUs (prod and nonprod)
resource "aws_organizations_organizational_unit" "prod_ou" {
  provider  = aws.management_account
  name      = "prod-ou"
  parent_id = data.aws_organizations_organization.main.roots[0].id

  tags = {
    Name        = "prod-ou"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

resource "aws_organizations_organizational_unit" "nonprod_ou" {
  provider  = aws.management_account
  name      = "nonprod-ou"
  parent_id = data.aws_organizations_organization.main.roots[0].id

  tags = {
    Name        = "nonprod-ou"
    Environment = "nonprod"
    ManagedBy   = "terraform"
  }
}

# Create department-specific child OUs
resource "aws_organizations_organizational_unit" "dept_prod_ou" {
  provider  = aws.management_account
  for_each  = var.departments
  
  name      = "${each.key}-prod-ou"
  parent_id = aws_organizations_organizational_unit.prod_ou.id

  tags = {
    Name        = "${each.key}-prod-ou"
    Department  = each.key
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

resource "aws_organizations_organizational_unit" "dept_nonprod_ou" {
  provider  = aws.management_account
  for_each  = var.departments
  
  name      = "${each.key}-nonprod-ou"
  parent_id = aws_organizations_organizational_unit.nonprod_ou.id

  tags = {
    Name        = "${each.key}-nonprod-ou"
    Department  = each.key
    Environment = "nonprod"
    ManagedBy   = "terraform"
  }
}

# Create accounts based on requests
resource "aws_organizations_account" "accounts" {
  provider  = aws.management_account
  for_each  = var.account_requests

  name      = each.value.name
  email     = each.value.email
  parent_id = each.value.environment == "prod" ? 
              aws_organizations_organizational_unit.dept_prod_ou[each.value.department].id :
              aws_organizations_organizational_unit.dept_nonprod_ou[each.value.department].id

  # Prevent accidental account deletion
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = each.value.name
    Department  = each.value.department
    Environment = each.value.environment
    Purpose     = each.value.purpose
    Owner       = each.value.owner
    ManagedBy   = "terraform"
  }
}
