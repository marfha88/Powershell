# Install modules
# Install-Module AzureAD
# Install-module AzureADPreview

# Create Student username, password, Domain and it admin
# $Tenant = Read-Host "Please enter TenantID" (You will need this if you log in with an account that has access to other tenants as well)
$user = Read-Host "Please enter student username"
$domain = Read-Host "Please enter domain to use"
$password = Read-Host "Please enter student-user password" -AsSecureString
# Login to azure with admin account
AzureADPreview\Connect-AzureAD # -TenantId "$Tenant" # (just use it with account that has access to other tenants as well)
# IT Admin
$itadmusername = "IT Admin"
$itadminmail = "your IT admins mailadress"
$Globaladmin = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Global administrator"}

# Set password for the user
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "$password"

# Creates the Student-User Account
New-AzureADUser -DisplayName "$user" -PasswordProfile $PasswordProfile -UserPrincipalName ("$user"+"@"+"$domain") -AccountEnabled $true -MailNickName "$user"

# invite IT Admin user
$invite = New-AzureADMSInvitation -InvitedUserDisplayName "$itadmusername" -InvitedUserEmailAddress $itadminmail -InviteRedirectURL https://portal.azure.com -SendInvitationMessage $true

# Add IT admin to Global admin
Add-AzureADDirectoryRoleMember -ObjectId $Globaladmin.ObjectId -RefObjectId $invite.inviteduser.id

# Enable Azure AD Rolles.
$InviterRole1 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Application administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole1.ObjectId
$InviterRole2 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Authentication administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole2.ObjectId
$InviterRole3 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Authentication policy administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole3.ObjectId
$InviterRole4 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Azure AD joined device local administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole4.ObjectId
$InviterRole5 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Cloud device administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole5.ObjectId
$InviterRole6 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Compliance administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole6.ObjectId
$InviterRole7 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Domain name administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole7.ObjectId
$InviterRole8 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Exchange administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole8.ObjectId
$InviterRole9 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Global reader"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole9.ObjectId
$InviterRole10 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Intune administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole10.ObjectId
$InviterRole11 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Security administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole11.ObjectId
$InviterRole12 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "SharePoint administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole12.ObjectId
$InviterRole13 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Teams administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole13.ObjectId
$InviterRole14 = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "User administrator"}
Enable-AzureADDirectoryRole -RoleTemplateId $InviterRole14.ObjectId

# Enables the ID of the roles
$InviterRole1 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Application administrator"}
$InviterRole2 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Authentication administrator"}
$InviterRole3 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Authentication policy administrator"}
$InviterRole4 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Azure AD joined device local administrator"}
$InviterRole5 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Cloud device administrator"}
$InviterRole6 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Compliance administrator"}
$InviterRole7 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Domain name administrator"}
$InviterRole8 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Exchange administrator"}
$InviterRole9 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Global reader"}
$InviterRole10 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Intune administrator"}
$InviterRole11 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Security administrator"}
$InviterRole12 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "SharePoint administrator"}
$InviterRole13 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Teams administrator"}
$InviterRole14 = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "User administrator"}

Start-Sleep -s 2 
# Student User ID
$studentid = Get-AzureADUser | Where-Object {$_.DisplayName -eq "$user"}

# Adding the roles to Student users
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole1.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole2.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole3.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole4.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole5.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole6.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole7.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole8.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole9.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole10.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole11.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole12.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole13.ObjectId -RefObjectId $studentid.ObjectId
Add-AzureADDirectoryRoleMember -ObjectId $InviterRole14.ObjectId -RefObjectId $studentid.ObjectId

