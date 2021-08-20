function Get-SFUsersByName {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline,Position=0)]
	[string]$Name,
	[Parameter(Position=1)]
	[string]$Status='Current'
    )

    begin {
	$Records = @()
	$from = "fHCM2__Team_Member__c"
    }

    process {
	$where = "(Name = '$Name' OR Name LIKE '%$Name%') AND fHCM2__Employment_Status__c  = '$Status'"
	$query = "SELECT $AllFields FROM $from WHERE $where"
	$Records += (Invoke-SFQuery $query).records
    }

    end {
	return $Records
    }
}
