function New-SFRequest {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory)]
	[string]$Method,
	[Parameter(Mandatory)]
	[string]$Uri,
	[Parameter()]
	[object]$body
    )

    if (!(Test-SFSession)) {
	throw "Null or invalid session request"
    }

    # Build headers
    $headers = New-SFHeader -accessToken $Session.access_token -compress

    # Build Uri
    $baseUri = $Session.instance_url
    $baseUri += $Uri

    $params = @{
	"Method"	= $Method
	"Headers"	= $headers
	"Uri"		= $baseUri
    }

    if ($body) {
	$params.Add("Body", (ConvertTo-Json $body))
    }

    Invoke-RestMethod @params
}
