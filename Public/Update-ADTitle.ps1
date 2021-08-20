function Update-ADTitle {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[object]$SFUser,
	[Parameter(Mandatory,Position=1)]
	[object]$ADUser,
	[Parameter(Mandatory,Position=2)]
	[object]$Domain
    )

    $FullName	= $SFUser.Name
    $SFTitle	= $SFUser.fHCM2__Job_Title__c
    $ADTitle	= $ADUser.Title

    if ($SFTitle -And ($SFTitle -ne $ADTitle)) {
	Write-Output "$Fullname doesn't have matching job titles."
	Write-Output "Updating AD job title from $ADTitle $SFTitle."
	Set-ADUser $ADUser -Title $SFTitle -Description $SFTitle -Server $Domain
    } else {
	Write-Verbose "$FullName already has matching job titles."
    }
}
