function Get-SFEquipment {
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$Users
    )

    $UsersEquipment = @()

    foreach ($User in $Users) {
	$UniqueId = $User.fHCM2__Unique_Id__c
	$fields = "id, `
	  name, `
	  fHCM2__Start_Date__c, `
	  fHCM2__End_Date__c, `
	  fHCM2__Description__c, `
	  Equipment_Type__c, `
	  Identification_Number__c, `
	  fHCM2__Additional_Notes__c"
	$from = "fHCM2__Experience__c"
	$where = "fHCM2__Team_Member__c = '$UniqueId'"
	$query = [System.Web.HttpUtility]::UrlEncode("SELECT $fields FROM $from WHERE $where")
	$Uri = "/services/data/v20.0/query?q=$query"
	try {
	    $UserEquipment = New-SFRequest -Session $Session -Method Get -Uri $Uri
	} catch {
	    throw $_.Exception.Message
	}
	$UsersEquipment += $UserEquipment
    }

    return $UsersEquipment
}
