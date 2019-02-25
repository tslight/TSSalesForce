#region get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
#endregion

#region source the files
foreach ($import in @($Public + $Private)) {
    Try {
	. $import.fullname
    } Catch {
	Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}
#endregion

#region read in or create an initial config file and variable
$ConfigFile = "Config.psd1"
if (Test-Path "$PSScriptRoot\$ConfigFile") {
    try {
	$Config          = Import-LocalizedData -BaseDirectory $PSScriptRoot -FileName $ConfigFile
	$SFApiKeyFile    = $Config.SFApiKeyFile
	$ADGlobalCatalog = $Config.ADGlobalCatalog
	$EmailAddress    = $Config.EmailAddress
	$Session         = Get-SFSession $SFApiKeyFile
    } catch {
	Write-Warning "Invalid configuration data in $ConfigFile."
	Write-Warning "Please fill out or correct $PSScriptRoot\$ConfigFile."
	Write-Verbose $_.Exception.Message
	Write-Verbose $_.InvocationInfo.ScriptName
	Write-Verbose $_.InvocationInfo.PositionMessage
    }
} else {
    @"
@{
    SFApiKeyFile    = ""
    ADGlobalCatalog = ""
    EmailAddress    = ""
}
"@ | Out-File -Encoding UTF8 -FilePath "$PSScriptRoot\$ConfigFile"
    Write-Warning "Generated $PSScriptRoot\$ConfigFile."
    Write-Warning "Please edit $ConfigFile and re-import module."
}
#endregion

#region set variables visible to the module and its functions only
$AllFields = "id, `
  fHCM2__Unique_Id__c, `
  Name, `
  fHCM2__Preferred_Name__c, `
  fHCM2__Surname__c, `
  fHCM2__Job_Title__c, `
  fHCM2__Division__c, `
  fHCM2__Business__c, `
  fHCM2__Team__c, `
  fHCM2__Email__c, `
  fHCM2__Manager__c, `
  fHCM2__Manager_User__c, `
  Manager_First_or_Preferred_Name__c, `
  Last_Working_Date__c, `
  Work_Location_Name__c, `
  CreatedDate, `
  Created_Date_Time_Stamp__c, `
  fHCM2__Employment_Status__c, `
  User_Active__c"
$Date = Get-Date -UFormat "%Y.%m.%d"
$Time = Get-Date -UFormat "%H:%M:%S"
#endregion

#region export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.Basename
#endregion
