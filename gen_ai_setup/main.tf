###
# Creation of subaccount
###
resource "btp_subaccount" "sa_gen_ai" {
  count     = var.create_subaccount ? 1 : 0
  name      = var.subaccount_name
  subdomain = lower(var.subdomain)
  region    = lower(var.region)
}

###
# Entitle subaccount for usage of SAP AI Core service
# Checkout https://github.com/SAP-samples/btp-service-metadata/blob/main/v0/developer/aicore.json for 
# available plans and their region availability 
###
resource "btp_subaccount_entitlement" "ai_core" {
  count         = var.create_subaccount ? 1 : 0
  subaccount_id = btp_subaccount.sa_gen_ai[0].id
  service_name  = "aicore"
  plan_name     = var.ai_core_plan_name
}

###
# Creation of service instance
###
data "btp_subaccount_service_plan" "ai_core" {
  subaccount_id = var.create_subaccount ? btp_subaccount.sa_gen_ai[0].id : var.subaccount_id
  offering_name = "aicore"
  name          = var.ai_core_plan_name
  depends_on    = [btp_subaccount_entitlement.ai_core]
}

resource "btp_subaccount_service_instance" "ai_core" {
  subaccount_id  = var.create_subaccount ? btp_subaccount.sa_gen_ai[0].id : var.subaccount_id
  serviceplan_id = data.btp_subaccount_service_plan.ai_core.id
  name           = "my-ai-core-instance"
  depends_on     = [btp_subaccount_entitlement.ai_core]
}

###
# Create service binding to SAP AI Core service
###
resource "btp_subaccount_service_binding" "ai_core_binding" {
  subaccount_id       = var.create_subaccount ? btp_subaccount.sa_gen_ai[0].id : var.subaccount_id
  service_instance_id = btp_subaccount_service_instance.ai_core.id
  name                = "ai-core-key"
}

###
# Export the AI Core service binding keys to a local file for further usage
###
resource "local_file" "env_file" {
  content  = <<-EOT
  AICORE_LLM_AUTH_URL=${jsondecode(btp_subaccount_service_binding.ai_core_binding.credentials)["url"]}
  AICORE_LLM_CLIENT_ID=${jsondecode(btp_subaccount_service_binding.ai_core_binding.credentials)["clientid"]}
  AICORE_LLM_CLIENT_SECRET=${jsondecode(btp_subaccount_service_binding.ai_core_binding.credentials)["clientsecret"]}
  AICORE_LLM_API_BASE=${jsondecode(btp_subaccount_service_binding.ai_core_binding.credentials)["serviceurls"]["AI_API_URL"]}
  AICORE_LLM_RESOURCE_GROUP=default
  TARGET_AI_CORE_MODEL=${jsonencode(var.target_ai_core_model)}
  EOT
  filename = ".env"
}
