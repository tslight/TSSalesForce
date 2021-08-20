function Update-ADEmployeeID {
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
    $ADEmployeeId = $ADUser.EmployeeId
    $SFEmployeeID = $SFUser.fHCM2__Unique_Id__c

    if (!$ADEmployeeID) {
	Write-Output "$Fullname doesn't have an Employee ID."
	Write-Output "Setting AD Employee ID to $SFEmployeeID."
	Set-ADUser $ADUser -EmployeeID $SFEmployeeID -Server $Domain
    } elseif ($ADEmployeeID -ne $SFEmployeeID) {
	Write-Output "$Fullname doesn't have matching Employee ID."
	Write-Output "Changing AD Employee ID to $SFEmployeeID."
	Set-ADUser $ADUser -EmployeeID $SFEmployeeID -Server $Domain
    } else {
	Write-Verbose "$Fullname already has matching Employee Id's."
    }
}
