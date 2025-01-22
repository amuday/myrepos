
Setup AZ varibles in the command line

1. Run terraform init

2. Run import command or use import block with import.tf file

terraform import "azurerm_storage_account.import_example" "/subscriptions/XXXXXXXXXXXXXXXXXXXXX/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/stimportest"