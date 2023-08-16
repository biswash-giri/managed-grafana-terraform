variable "organizational_units" {
  description = "The Amazon Organizations organizational units that the workspace is authorized to use data sources from"
  type        = list(string)
  default     = []
}

variable "userid" {
  type        = string
  default     = ""
  description = "User id for your sso account"
}

variable "organizationid" {
  type        = string
  default     = ""
  description = "Your organization id"
}
