function Test-SFSession {
    if ($Session -eq $null) {
	return $false
    }

    # The instance Uri needs to be valid
    if ([string]::IsNullOrEmpty($Session.instance_url) -or [string]::IsNullOrEmpty($Session.access_token)) {
	return $false
    }

    return $true
}
