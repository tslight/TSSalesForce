function Get-SFSession {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[string]$KeyFile
    )
    # API requires the security protocol is changed
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $EncryptedStr = Get-EncryptedStr $KeyFile
    $DecryptedStr = Get-DecryptedStr $EncryptedStr
    $CredsArr = $DecryptedStr.Split("|")

    $NewSessionArgs = @{
	Username       = $CredsArr[0]
	Password       = $CredsArr[1]
	SecurityToken  = $CredsArr[2]
	ClientId       = $CredsArr[3]
	ClientSecret   = $CredsArr[4]
    }

    # Authenticate to SalesForce and retreive our access token
    $Session = New-SFSession @NewSessionArgs

    if (Test-SFSession $Session) {
	Write-Verbose "Successfully authenticated to SalesForce."
    } else {
	Write-Warning "FAILED to authenticate to SalesForce."
	exit 1
    }

    return $Session
}
