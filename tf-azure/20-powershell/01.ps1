# Defining a value for the resource group
$resourceGroup = "exam-grp"
$location = "East US"

New-AzResourceGroup -Name $resourceGroup -Location $location