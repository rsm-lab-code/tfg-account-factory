# New account requests
variable "account_requests" {
  description = "Map of new accounts to create"
  type = map(object({
    name         = string
    email        = string
    business_unit = string
    environment  = string
    target_ou    = string  # Available: gst-prod, tfg-prod, gsfs-prod, usal-prod, copilotint1-prod, gst-nonprod, tfg-nonprod, gsfs-nonprod, usal-nonprod, copilotint1-nonprod, root-production, sandbox, security, infrastructure, workloads, transitional, suspended, policy-staging, exceptions, trailblazer, trailblazer-gst, trailblazer-tfg, trailblazer-gsfs, trailblazer-usal, trailblazer-sandbox
    description  = string
  }))
  default = {}
}