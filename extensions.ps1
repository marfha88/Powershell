Set-AzContext -Subscription "0563c2c3-2a39-4c80-bbaa-93196e049cd2"
$resourcegroupname = "HUB-PROD-MSS-RESOURCES"
$Location = "westeurope"
$name = "ms"

$workspaceId = "903fd8e2-d3bf-4bea-8dd2-566f56a71881"
$workspaceKey = "/pTTBF2nnBuRojEYmN7bf/JAy3LM0RDjxZEDoQRUf2r8PsOKcymsoVkXtFrIrOJlMn8wn3etaKvJifkBJqMTXw=="
                                                             
$Publicsettings=@{"workspaceId" = $workspaceId}
 
$Protectedsettings=@{"workspaceKey" = $workspaceKey.primarysharedkey}
 
$vms=Get-AzVM -ResourceGroupName $resourceGroupName | Where-Object {$_.name -like "*${name}*"} 

$vms.Name

foreach($vm in $vms){
$vmName=$vm.name


Remove-AzVMExtension -ResourceGroupName $resourceGroupName -VMName $vmName -Name MicrosoftMonitoringAgent -Force

}
<#
Set-AzVMExtension -ExtensionName "AzureMonitorWindowsAgent" `
                  -ResourceGroupName $resourceGroupName `
                  -VMName $vmName `
                  -Publisher "Microsoft.Azure.Monitor" `
                  -ExtensionType "AzureMonitorWindowsAgent" `
                  -TypeHandlerVersion 1.1 `
                  -Settings $PublicSettings `
                  -ProtectedSettings $ProtectedSettings `
                  -Location $Location `
                  -EnableAutomaticUpgrade $true
}
#>

