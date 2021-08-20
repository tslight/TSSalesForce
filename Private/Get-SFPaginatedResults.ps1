function Get-SFPaginatedResults {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,Position=0)]
	[string]$Uri
    )

    $Results = @()

    try {
	$Result = New-SFRequest -Method Get -Uri $Uri
	$Results += $Result
	while ($Result.nextRecordsUrl) {
	    $Result = New-SFRequest -Method Get -Uri $Result.nextRecordsUrl
	    $Results += $Result
	}
    } catch {
	throw
    }

    return $Results
}
