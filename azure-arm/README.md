```
Connect-AzAccount
Get-AzResourceGroup
```

# Create resource group
```
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

