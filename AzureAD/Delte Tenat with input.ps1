
# Install-Module AzureAD
# Install-module AzureADPreview

# $Tenant = Read-Host "Please enter TenantID" # (You will need this if you log in with an account that has access to other tenants as well)
AzureADPreview\Connect-AzureAD # -TenantId "$Tenant" # (just use it with account that has access to other tenants as well)

# Exclude user 
$exclude = Read-Host "Please enter Global admin account"

# Domain to remove
$domaintoremove = Read-Host "Please enter external domain to be deleted"

# Remove all users exept 1. Change admin@domain.com to your admin account.
Get-AzureADUser -All $true | Where {$_.userPrincipalName -ne $exclude} | Remove-AzureADUser

# Remove all groups
Get-AzureADGroup | Remove-AzureADGroup

# remove Domain.
Remove-AzureADDomain -Name $domaintoremove

# app registration remove
Get-AzureADApplication | Remove-AzureADApplication

# Delte all enterprise applications it will give some errors ignor them. It will take some time for azure to delete all
Get-AzureADServicePrincipal | Select-Object -ExpandProperty ObjectId | ForEach-Object { Remove-AzureADServicePrincipal -ObjectId $_}
Start-Sleep -s 1
Get-AzureADServicePrincipal | Select-Object -ExpandProperty ObjectId | ForEach-Object { Remove-AzureADServicePrincipal -ObjectId $_}
Start-Sleep -s 1
Get-AzureADServicePrincipal | Select-Object -ExpandProperty ObjectId | ForEach-Object { Remove-AzureADServicePrincipal -ObjectId $_}



