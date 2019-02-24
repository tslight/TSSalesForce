function Get-SFUserById {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline,Position=0)]
	[string]$Id
    )

    $Uri = "/services/data/v20.0/sobjects/fHCM2__Team_Member__c/$Id"

    try {
	$User = New-SFRequest -Method Get -Uri $Uri
    } catch {
	throw $_.Exception.Message
    }

    return $User
}
