$resourceGroup = "exam-grp"
$location = "East US"
$network="exam-network"
$AddressPrefix="10.1.0.0/16"

#Remove-AzVirtualNetwork -Name $network -ResourceGroupName $resourceGroup

$virtualnetwork = New-AzVirtualNetwork -Name $network -ResourceGroupName $resourceGroup -Location $location -AddressPrefix $AddressPrefix
Write-Output $virtualnetwork.Location
Write-Output $virtualnetwork.AddressSpace.AddressPrefixes
Write-Output $virtualnetwork.Id