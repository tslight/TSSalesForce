function Invoke-SFADSync {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$SFUser
    )

    begin {
	Write-Output "STARTED RUNNING INVOKE-SFADSYNC AT $Time."
    }

    process {
	Update-SFFirstName $SFUser
	if ($SFUser.fHCM2__Unique_Id__c) {
	    $ADUser = Get-ADUserByName $SFUser.Name
	    # if a user has more than one entry in AD our AD Obj will return double values.
	    if ($ADUser -is [array]) { $ADUser = $ADUser[0] }
	    if ($ADUser) {
		$Domain = Get-ADDomainName $ADUser
		Update-SFMail $SFUser $ADUser
		Update-ADEmployeeID $SFUser $ADUser $Domain
		Update-ADTitle $SFUser $ADUser $Domain
		# Update-ADNames $SFUser $ADUser $Domain
		# Update-ADManager $SFUser $ADUser $Domain
	    } else {
		Write-Output "$($SFUser.Name) is not in AD!"
	    }
	} else {
	    Write-Output "$($SFUser.Name) missing Employee Id in My People."
	}
    }

    end {
	Write-Output "FINISHED RUNNING INVOKE-SFADSYNC AT $Time."
    }
}
