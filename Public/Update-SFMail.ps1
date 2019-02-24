function Update-SFMail {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[object]$SFUser,
	[Parameter(Mandatory,Position=1)]
	[object]$ADUser
    )

    $FullName	= $SFUser.Name
    $SFMail	= $SFUser.fHCM2__Email__c
    $ADMail	= $ADUser.Mail

    if (!$ADMail) {
	Write-Output "$FullName doesn't have an email address in AD. Aborting."
    } elseif (!(Test-EmailAddress $ADMail)) {
	Write-Output "$ADMail is not a valid email address. Aborting."
    } elseif ($ADMail -eq $SFMail) {
	Write-Verbose "$Fullname already has matching email addresses."
    } else {
	if (!$SFMail) {
	    Write-Output "$Fullname's doesn't have an email address in SalesForce."
	    Write-Output "Setting SalesForce email address to $ADMail."
	} elseif ($ADMail -ne $SFMail) {
	    Write-Output "$Fullname's email addresses don't match."
	    Write-Output "Changing SalesForce email address from $SFMail to $ADMail."
	}
	$body = @{
	    "fHCM2__Email__c" = $ADMail
	}
	Update-SFUser -Id $SFUser.Id -body $body
    }
}
