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


# The colleagues who are added to the AI Core launchpad.
variable "ai_launchpad_user" {
  type        = list(string)
  description = "Defines the colleagues assigned to the AI launchpad roles."
}

# The list of rolecollections to be assigned to the users to access the AI Launchpad.
variable "roles_ai_launchpad" {
  type        = list(string)
  description = "Defines the list of roles to be assigned to the users in the AI Launchpad."
  default = [
    "ailaunchpad_aicore_admin_editor",
    "ailaunchpad_aicore_admin_editor_without_genai",
    "ailaunchpad_aicore_admin_viewer",
    "ailaunchpad_aicore_admin_viewer_without_genai",
    "ailaunchpad_allow_all_resourcegroups",
    "ailaunchpad_connections_editor",
    "ailaunchpad_connections_editor_without_genai",
    "ailaunchpad_functions_explorer_editor",
    "ailaunchpad_functions_explorer_editor_v2",
    "ailaunchpad_functions_explorer_editor_v2_without_genai",
    "ailaunchpad_functions_explorer_editor_without_genai",
    "ailaunchpad_functions_explorer_viewer",
    "ailaunchpad_functions_explorer_viewer_v2",
    "ailaunchpad_functions_explorer_viewer_v2_without_genai",
    "ailaunchpad_functions_explorer_viewer_without_genai",
    "ailaunchpad_genai_administrator",
    "ailaunchpad_genai_experimenter",
    "ailaunchpad_genai_manager",
    "ailaunchpad_mloperations_editor",
    "ailaunchpad_mloperations_editor_without_genai",
    "ailaunchpad_mloperations_viewer",
    "ailaunchpad_mloperations_viewer_without_genai"
  ]
}
