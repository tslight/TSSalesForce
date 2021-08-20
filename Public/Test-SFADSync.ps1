function Test-SFADSync {
    <#
    .SYNOPSIS
    View status of SalesForce user compared to AD User.

    .DESCRIPTION
    Check the synchronisation status of a user's attributes between Active
    Directory and SalesForce.

    .PARAMETER SFUser
    A user object from SalesForce.

    .PARAMETER All
    Return all attributes of both SalesForce and AD objects.

    .PARAMETER Terse
    Return a much terser subset of properties.

    .PARAMETER IsInAD
    Only return users who are also in AD.

    .EXAMPLE
    Get-SFUsersByDate | Test-SFADSync | Format-Table -AutoSize

    .LINK
    https://gitlab.com/mcs_win/TSSalesForce
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$SFUser,
	[switch]$All,
	[switch]$Terse,
	[switch]$IsInAD
    )

    process {
	if ($ADUser = Get-ADUserByName $SFUser.Name) {
	    if ($ADUser -is [array]) {
		$ADUser = $ADUser[0]
	    }
	    $ADManager = (
		Get-ADUser -Identity $ADUser.Manager -Server $ADGlobalCatalog
	    ).name
	    $ADCreatedDate = $ADUser.whenCreated | Get-Date -UFormat "%Y-%m-%d %H:%M"
	} elseif ($IsInAD) {
	    return
	}

	if ($All) {
	    $SFUser = Get-SFUserByID $SFUser.Id
	    Merge-Objects -ObjectOne $SFUser -ObjectTwo $ADUser -PrefixOne "SF" -PrefixTwo "AD"
	} elseif ($Terse) {
	    $Properties = [ordered]@{
		"SF Name"       = $SFUser.Name
		"AD Name"       = $ADUser.Name
		"SF ID"		= $SFUser.fHCM2__Unique_Id__c
		"AD ID"		= $ADUser.EmployeeID
		"SF Email"      = $SFUser.fHCM2__Email__c
		"AD Email"      = $ADUser.EmailAddress
		"AD Created"	= $ADCreatedDate
		"SF Created"	= $SFUser.CreatedDate | Get-Date -UFormat "%Y-%m-%d %H:%M"
	    }
	} else {
	    $SFManager = (Get-SFUserById $SFUser.fHCM2__Manager__c).Name
	    $Properties = [ordered]@{
		"SF Email"		= $SFUser.fHCM2__Email__c
		"AD Email"		= $ADUser.EmailAddress
		"SF ID"			= $SFUser.fHCM2__Unique_Id__c
		"AD ID"			= $ADUser.EmployeeID
		"SF Name"		= $SFUser.Name
		"AD Name"		= $ADUser.Name
		"SF First Name"		= $SFUser.fHCM2__Preferred_Name__c
		"AD Given Name"		= $ADUser.GivenName
		"SF Surname"		= $SFUser.fHCM2__Surname__c
		"AD Surname"		= $ADUser.Surname
		"SF Manager"		= $SFManager
		"AD Manager"		= $ADManager
		"SF Title"		= $SFUser.fHCM2__Job_Title__c
		"AD Title"		= $ADUser.Title
		"AD Description"	= $ADUser.Description
		"AD Created"		= $ADCreatedDate
		"SF Created"		= $SFUser.CreatedDate | Get-Date -UFormat "%Y-%m-%d %H:%M"
	    }
	}
	New-Object PSObject -Property $Properties
    }
}
