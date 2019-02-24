function Get-SFUsersByActive {
    param(
	[switch]$Active,
	[switch]$InActive
    )

    $from = "fHCM2__Team_Member__c"
    if ($Active) {
	$where = "User_Active__c = True"
    } elseif ($InActive) {
	$where = "User_Active__c = False"
    } else {
	$where = "User_Active__c = True"
    }
    $query = "SELECT $AllFields FROM $from WHERE $where"

    return (Invoke-SFQuery $query).records
}
