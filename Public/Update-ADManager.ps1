function Update-ADManager {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[object]$SFUser,
	[Parameter(Mandatory,Position=1)]
	[object]$ADUser,
	[Parameter(Mandatory,Position=2)]
	[object]$Domain
    )

    $FullName = $SFUser.Name

    if ($SFUser.fHCM2__Manager__c) {
	$SFManager = (Get-SFUserById $SFUser.fHCM2__Manager__c).Name
    } else {
	Write-Output "$Fullname doesn't have a Manager in SalesForce. Aborting."
	return
    }

    if ($ADUser.Manager) {
	$ADManager = (Get-ADUser -Identity $ADUser.Manager -Server $ADGlobalCatalog).name
    } else {
	$ADManager = "N/A"
    }

    if ($ADManager -ne $SFManager) {
	Write-Output "$FullName doesn't have matching AD and SalesForce manager. "
	Write-Output "Updating $FullName's AD manager from $ADManager to $SFManager."
	# Set-ADUser $ADUser -Manager $SFManager -Server $Domain
    } else {
	Write-Verbose "$FullName already has $SFManager as manager in AD."
    }
}
