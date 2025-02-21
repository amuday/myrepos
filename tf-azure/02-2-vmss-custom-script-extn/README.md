
https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-linux


az vmss extension set --vmss-name test-vmss --name customScript --resource-group myResourceGroup --version 2.0 --publisher Microsoft.Azure.Extensions --settings extn.json

az vmss extension set --vmss-name test-vmss --name customScript --resource-group myResourceGroup --version 2.0 --publisher Microsoft.Azure.Extensions --settings ./script-config.json --protected-settings ./protected-config.json