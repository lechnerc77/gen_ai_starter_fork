globalaccount        = "terraformintprod"
region               = "eu10"
target_ai_core_model = ["gpt-35-turbo", "text-embedding-ada-002"]
ai_launchpad_user    = ["christian.lechner@sap.com"]
# Add a value if you want to create the service in an existing subaccount
subaccount_id = "885feab0-59a4-4640-a94a-b4d352a66bad"
# Uncomment the following line if subaccount shoud be created
create_subaccount = true
