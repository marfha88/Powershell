
$policyname = "get info from policy.json file to be passt here"
$PolicyDefinitions = Get-AzPolicyDefinition | Where-Object {$_.name -like "*${policyname}*"}

foreach($PolicyDefinition in $PolicyDefinitions){
    $policyid=$PolicyDefinition.ResourceId
    
Remove-AzPolicyDefinition -Id $policyid -Force
}


