# New account requests
variable "account_requests" {
  description = "Map of new accounts to create"
  type = map(object({
    name         = string
    email        = string
    business_unit = string
    environment  = string
    target_ou    = string  # Available: prod/nonprod business units, sandbox, security, infrastructure, workloads, transitional, suspended, policy-staging, exceptions, trailblazer variants
    description  = string
  }))
  default = {}
}
