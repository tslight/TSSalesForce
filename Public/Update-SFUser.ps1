function Update-SFUser {
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=0)]
	[string]$Id,
	[Parameter(Mandatory,Position=1)]
	[object]$Body
    )

    $Uri = "/services/data/v20.0/sobjects/fHCM2__Team_Member__c/$Id"
    try {
	$Result = New-SFRequest -Method Patch -Uri $Uri -Body $Body
    } catch {
	throw $_.Exception.Message
    }

    return $Result
}
