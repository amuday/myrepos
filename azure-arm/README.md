
ARM templates use declarative syntax, means define the desired state not the detailed steps to create the infrastructure.


https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=json&pivots=deployment-language-bicep
https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-complete-mode-deletion
https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit

```
Connect-AzAccount
Get-AzResourceGroup
```

# Create resource group
```
az group create -l eastus -n sre-dev-001
New-AzResourceGroup -Name sre-dev-001 -location eastus

```

# Deploy template
```
New-AzResourceGroupDeployment -Name myfirsttemplate -ResourceGroupName sre-dev-001 -TemplateFile basic-az-deploy.json
```

# Validation


In the portal Resource Group -> Deployments -> Template.

Resource Group -> Deployments -> Template -> deploy 
                                                    -> Custom Template
                                                    -> Edit Template
                                                    -> Visualize

Resource Group -> Deployments -> Template -> overview
                                            -> Delpoyment Details -> Operation details

VM -> Connect -> RDP                                    

# Parameters 
```
az deployment group create --resource-group sre-dev-001 --template-file parameter-deploy.json --parameters stgname=udaysstg001 --debug

az deployment group create --resource-group sre-dev-001 --template-file parameter-deploy.json --parameters @parameters.json --debug

az resource delete --resource-group sre-dev-001 --ids  /subscriptions/cdfcbefc-2caf-465b-8b95-4b323c07be93/resourceGroups/sre-dev-001/providers/Microsoft.Storage/storageAccounts/udaysstg001 --debug

New-AzResourceGroupDeployment -Name newstorage -ResourceGroupName sre-dev-001 -TemplateFile parameter-deploy.json -stgname udaysstg001
```

# Output Parameters

New-AzResourceGroupDeployment -Name newStorage2 -ResourceGroupName sre-dev-001 -TemplateFile .\output-parameters.json

validation
    Resource Group -> storage -> EndPoints

	* Get all accounts
	Get-AzStorageAccount

	* Get specific account
	Get-AzStorageAccount -Name storage12789 -ResourceGroupName sre-dev-001

	* To get properties of specific account
	Get-AzStorageAccount -Name storage12789 -ResourceGroupName sre-dev-001 | Get-Member

# deployment mode
    ## complete - delete resources in resource group which are not in the template

    New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -Mode Complete

    ## Default mode is incremental, which does not delete resources in resource group and not in the template.        

# Preview

#### commands
```
az deployment group what-if --resource-group sre-dev-001 --template-file parameter-deploy.json --parameters stgname=udaysstg001

New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -WhatIf

New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -WhatIf -WhatIfResultFormat FullResourcePayloads

New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -WhatIf -WhatIfResultFormat ResourceIdOnly
```

#### Confirm Yes or NO

```
New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -Confirm

New-AzResourceGroupDeployment -Name TestDeploymentMode -ResourceGroupName sre-dev-001 -TemplateFile .\preview.json -Confirm -Mode Complete
```
# validate
#### Install toolkit
1. Download the zip from https://github.com/Azure/arm-ttk/releases and extract and run below commands
2. Run commands below
```
Get-ChildItem *.ps1, *.psd1, *.ps1xml, *.psm1 -Recurse | Unblock-File
Import-Module .\arm-ttk.psd1
Test-AzTemplate -TemplatePath validate.json
```

# IAC and Azure DevOps

1. Create Azure Devops account and login
2. Create a repository 
3. Upload the template file to repository 
4. Create a pipeline, select Aure Repos Git
5. Configure pipeline, select starter pipeline
6. Project Settings -> Service Connections -> Azure Resource Manager 
7. Add Azure Resource Manger to the email pipeline
8. Request to increase free parallelism in Azure DevOps
9. Run the pipeline.