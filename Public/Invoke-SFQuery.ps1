function Invoke-SFQuery {
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=0)]
	[string]$Query
    )

    $SanitisedQuery = [System.Web.HttpUtility]::UrlEncode($Query)
    $Uri = "/services/data/v20.0/query?q=$SanitisedQuery"

    return Get-SFPaginatedResults $Uri
}
