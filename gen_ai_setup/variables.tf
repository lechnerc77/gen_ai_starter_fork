variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the subaccount shall be created."
}

variable "create_subaccount" {
  type        = bool
  description = "Flag if a subaccount should be created."
  default     = "false"
}

###
# ONLY NEEDED IF create_subaccount is true
###
variable "subaccount_name" {
  type        = string
  description = "The name of the subaccoun."
  default     = "My GenAI subaccount"
}

###
# ONLY NEEDED IF create_subaccount is true
###
variable "subdomain" {
  type        = string
  description = "The subdomain of the subaccount (MUST BE UNIQUE)."
  default     = "btp-genAI-subaccount"
}


###
# ONLY NEEDED IF create_subaccount is true
###
variable "region" {
  type        = string
  description = "The region where the sub account shall be created."
  default     = "eu12"

  # The region can be only "eu10", "eu11", "us10".
  validation {
    condition     = contains(["eu10", "eu11", "us10"], var.region)
    error_message = "Valid values for region are: eu10, eu11, us10."
  }
}


###
# ONLY NEEDED IF create_subaccount is false
###
variable "subaccount_id" {
  type        = string
  description = "The id of the subaccount to be used."
  default     = ""
}


variable "ai_core_plan_name" {
  type        = string
  description = "The name of the AI Core service plan."
  default     = "extended"

  validation {
    condition     = contains(["extended"], var.ai_core_plan_name)
    error_message = "Valid values for ai_core_plan_name are: extended."
  }
}

# The target AI core model to be used by the AI Core service (used for configuration).
variable "target_ai_core_model" {
  type        = list(any)
  description = "Defines the target AI core model to be used by the AI Core service"
  default     = ["gpt-35-turbo"]

  validation {
    condition = length([
      for o in var.target_ai_core_model : true
      if contains(["gpt-35-turbo", "gpt-35-turbo-16k", "gpt-4", "gpt-4-32k", "text-embedding-ada-002", "tiiuae--falcon-40b-instruct"], o)
    ]) == length(var.target_ai_core_model)
    error_message = "Please enter a valid entry for the target_ai_core_model of the AI Core service. Valid values are: gpt-35-turbo, gpt-35-turbo-16k, gpt-4, gpt-4-32k, text-embedding-ada-002, tiiuae--falcon-40b-instruct."
  }
}
