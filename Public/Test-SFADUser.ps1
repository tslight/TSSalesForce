function Test-SFADUser {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline,Position=0)]
	[object]$SFUser,
	[switch]$All
    )

    process {
	if ($All) {
	    Get-SFUserByID $SFUser.Id
	    Get-ADUserByName $SFUser.Name
	} else {
	    $SFManager = (Get-SFUserById $SFUser.fHCM2__Manager__c).Name
	    if ($ADUser = Get-ADUserByName $SFUser.Name) {
		$ADManager = (Get-ADUser -Identity $ADUser.Manager -Server $ADGlobalCatalog).name
	    }
	    Write-Output "`nSF Email:       " $SFUser.fHCM2__Email__c
	    Write-Output "AD Email:       " $ADUser.EmailAddress "`n"
	    Write-Output "SF ID:          " $SFUser.fHCM2__Unique_Id__c
	    Write-Output "AD ID:          " $ADUser.EmployeeID "`n"
	    Write-Output "SF First Name:  " $SFUser.fHCM2__Preferred_Name__c
	    Write-Output "AD Given Name:  " $ADUser.GivenName "`n"
	    Write-Output "SF Surname:     " $SFUser.fHCM2__Surname__c
	    Write-Output "AD Surname:     " $ADUser.Surname "`n"
	    Write-Output "SF Manager:     " $SFManager
	    Write-Output "AD Manager:     " $ADManager "`n"
	    Write-Output "SF Title:       " $SFUser.fHCM2__Job_Title__c
	    Write-Output "AD Title:       " $ADUser.Title
	    Write-Output "AD Description: " $ADUser.Description "`n"
	}
    }
}
