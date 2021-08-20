function Get-SFUsersByStatus {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Position=0)]
	[string]$Status='Current',
	[switch]$New
    )

    $From = "fHCM2__Team_Member__c"
    if ($New) {
	$Where = "fHCM2__Email__c = '' AND fHCM2__Employment_Status__c  = '$Status'"
    } else {
	$Where = "fHCM2__Employment_Status__c  = '$Status'"
    }
    $Query = "SELECT $AllFields FROM $From WHERE $Where"

    $Records = (Invoke-SFQuery $Query).records

    Write-Verbose "Found the following user records in SalesForce:`n $($Records.Name)"

    return $Records
}
