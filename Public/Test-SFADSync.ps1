function Test-SFADSync {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(ValueFromPipeline)]
	[object[]]$SFUser
    )

    process {
	if ($ADUser = Get-ADUserByName $SFUser.Name) {
	    $Properties = [ordered]@{
		"SF Name"       = $SFUser.Name
		"AD Name"       = $ADUser.Name
		"SF ID"		= $SFUser.fHCM2__Unique_Id__c
		"AD ID"		= $ADUser.EmployeeID
		"SF Email"      = $SFUser.fHCM2__Email__c
		"AD Email"      = $ADUser.EmailAddress
		"AD Created"	= $ADUser.whenCreated | Get-Date -UFormat "%Y-%m-%d %H:%M"
		"SF Created"	= $SFUser.CreatedDate | Get-Date -UFormat "%Y-%m-%d %H:%M"
	    }
	    New-Object PSObject -Property $Properties
	}
    }
}
