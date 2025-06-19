# Department configuration
variable "departments" {
  description = "Set of department names to create OUs for"
  type        = set(string)
  default     = ["IT", "Finance", "HR", "Marketing"]
}

# New account requests
variable "account_requests" {
  description = "Map of new accounts to create"
  type = map(object({
    name        = string
    email       = string
    department  = string
    environment = string  # "prod" or "nonprod"
    purpose     = string
    owner       = string
  }))
  default = {}
  
  validation {
    condition = alltrue([
      for account in var.account_requests : 
      contains(["prod", "nonprod"], account.environment)
    ])
    error_message = "Environment must be either 'prod' or 'nonprod'."
  }
}
