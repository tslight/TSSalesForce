function New-SFSession {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory)]
	[string]$Username,
	[Parameter(Mandatory)]
	[string]$Password,
	[Parameter(Mandatory)]
	[string]$ClientId,
	[Parameter(Mandatory)]
	[string]$ClientSecret,
	[Parameter(Mandatory)]
	[string]$SecurityToken
    )

    $uri = "https://login.salesforce.com/services/oauth2/token?"
    $uri += "grant_type=password&"
    $uri += "client_id=$ClientId&"
    $uri += "client_secret=$ClientSecret&"
    $uri += "username=$Username&"
    $uri += "password=$Password$SecurityToken"

    try {
	$request = Invoke-RestMethod -Method Post -Uri $Uri
	$session = @{
	    "username" = $Username
	    "security_token" = $securityToken
	    "access_token" = $request.access_token
	    "instance_url" = $request.instance_url
	}
    } catch {
	throw $_.Exception.Message
    }
    return $session
}
