function Get-SFUsersByDate {
    [cmdletbinding()]
    param (
	[Parameter(Position=0)]
	[int]$Days=7,
	[Parameter(Position=1)]
	[string]$Status='Current'
    )

    $Date = ((Get-Date).AddDays(-$Days)).ToString("yyyy-MM-ddTHH:mm:ss.000+0000")

    $from = "fHCM2__Team_Member__c"
    $where = "CreatedDate > $Date AND fHCM2__Employment_Status__c  = '$Status'"
    $query = "SELECT $AllFields FROM $from WHERE $where"

    $Records = (Invoke-SFQuery $query).records | Sort-Object CreatedDate

    return $Records
}
