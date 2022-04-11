Set-AzContext -Subscription "your subscription"
$resourcegroupname = "your RG"
$Location = "your location"
$name = "exampel of name"

$workspaceId = "your LAW id"
$workspaceKey = "your LAW key"
                                                             
$Publicsettings=@{"workspaceId" = $workspaceId}
 
$Protectedsettings=@{"workspaceKey" = $workspaceKey.primarysharedkey}
 
$vms=Get-AzVM -ResourceGroupName $resourceGroupName | Where-Object {$_.name -like "*${name}*"} 

$vms.Name

foreach($vm in $vms){
$vmName=$vm.name

Remove-AzVMExtension -ResourceGroupName $resourceGroupName -VMName $vmName -Name MicrosoftMonitoringAgent -Force

}

{
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


