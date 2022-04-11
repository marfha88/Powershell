$PIAs = @()
$Subscriptions = Get-AzSubscription
foreach ($sub in $Subscriptions) {
    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext
    $PIAs += Get-AzPublicIpAddress | Where-Object {$_.name -like "*"} | Select Name,IpAddress,PublicIpAllocationMethod
}
$PIAs | Export-Csv -Path .\PIAs.csv -NoTypeInformation

$PIAs = Import-Csv -Path .\PIAs.csv 
$Excel = New-Object -ComObject excel.application 
$workbook = $Excel.workbooks.add() 

$i = 1 
foreach($PIAs in $PIAs) 
{ 
 $excel.cells.item($i,1) = $PIAs.name
 $excel.cells.item($i,2) = $PIAs.IpAddress
 $excel.cells.item($i,3) = $PIAs.PublicIpAllocationMethod
 $i++ 
}

Remove-Item .\PIAs.csv

$Excel.visible = $true
$excel.DisplayAlerts = 'False'
$ext=".xlsx"
$path="C:\temp\PIAs$ext"
$workbook.SaveAs($path)  
$excel.Quit()