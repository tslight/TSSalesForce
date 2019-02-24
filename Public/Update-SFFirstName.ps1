function Update-SFFirstName {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[object]$SFUser
    )

    $Fullname   = $SFUser.Name
    $FirstName	= $SFUser.fHCM2__Preferred_Name__c

    # Check the preferred firstname name, if this is empty get the firstname from the persons fullname
    if (!$FirstName) {
	$FirstName = $FullName.Split(" ")[0]
	Write-Output "$Fullname doesn't have a firstname in SalesForce."
	Write-Output "Setting SalesForce firstname to $FirstName."
	$body = @{
	    "fHCM2__Preferred_Name__c" = $FirstName
	}
	Update-SFUser -Id $SFUser.Id -body $body
    } else {
	Write-Verbose "$Fullname already has $FirstName as firstname in SalesForce."
    }
}
