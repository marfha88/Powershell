#Connect-AzAccount
Set-AzContext "0563c2c3-2a39-4c80-bbaa-93196e049cd2"

$resourcegroupname = "hub-prod-o365adm-resources"
$VMname = "o365-eac2"
$loction = "westeurope"

Set-AzVMExtension -ExtensionName "AzureMonitorWindowsAgent" `
-ResourceGroupName $resourcegroupname `
-VMName $VMname `
-EnableAutomaticUpgrade $true `
-Publisher "Microsoft.Azure.Monitor" `
-ExtensionType "AzureMonitorWindowsAgent" `
-Location $loction
