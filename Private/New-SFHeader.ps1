function New-SFHeader {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,Position=0)]
	[string]$AccessToken,
	[switch]$Compress
    )

    $Headers = @{}
    $Headers.Add('Authorization', ("Bearer {0}" -f $AccessToken))
    $Headers.Add('Content-Type', 'application/json')

    if ($Compress.IsPresent) {
	$Headers.Add('Accept-Encoding', 'deflate')
    }

    return $Headers
}
