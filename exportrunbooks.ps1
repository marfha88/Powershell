$rg = "resoursegroup"
$aa = "automationaccount"

Get-AzAutomationRunbook -ResourceGroupName $rg -AutomationAccountName $aa | Where-Object {$_.name -like "*"} | Export-AzAutomationRunbook -Slot "Published" -OutputFolder "C:\temp\runbooks"
