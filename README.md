# POWERSHELL SALESFORCE MODULE

Powershell module for interacting with SalesForce via their API and SOQL language.

Provides the following Cmdlets for returning and updating SOQL objects:

| **Cmdlet Name**       | **Params**  | **Param Description** | **Return Value**                                                                                     |
|:----------------------|:------------|:----------------------|:-----------------------------------------------------------------------------------------------------|
| `Get-SFUserById`      | `-Id`       | User ID               | All user records                                                                                     |
| `Get-SFUsersByName`   | `-Name`     | *[string]*            | User records whose name matches string                                                               |
|                       | `-Status`   | Employment Status     | Filter by Employment Status too (defaults to Current)                                                |
| `Get-SFUsersByDate`   | `-Days`     | Number of days        | User records created < $Day ago (defaults to 7)                                                      |
|                       | `-Status`   | Employment Status     | Filter by Employment Status too (defaults to Current)                                                |
| `Get-SFUsersByStatus` | `-Status`   | Employment Status     | Users with Employment Status (defaults to current)                                                   |
|                       | `-New`      | *[switch]*            | Users also lacking email address (ie. New Starters)                                                  |
| `Get-SFUsersByActive` | `-Active`   | *[switch]*            | All active users (default)                                                                           |
|                       | `-InActive` | *[switch]*            | All inactive users                                                                                   |
| `Get-SFSession`       | `-KeyFile`  | Encrypted API key     | Authenticated SalesForce Session                                                                     |
| `Invoke-SFQuery`      | `-Query`    | SOQL statement        | Results of SOQL statement                                                                            |
| `Update-SFUser`       | `-Id`       | User ID               | Updates an $Id with json from $Body                                                                  |
|                       | `-Body`     | JSON to set field     |                                                                                                      |

Also synchronizes SalesForce Team Member fields with Active Directory attributes.

Provides the following Cmdlets for syncing data:

| **Cmdlet Name**       | **Params** | **Param Description** | **Return Value**                                                                                     |
|:----------------------|:-----------|:----------------------|:-----------------------------------------------------------------------------------------------------|
| `Invoke-SFADSync`     | `-SFUser`  | User records          | Runs all update Cmdlets.                                                                             |
| `Test-SFADSync`       | `-SFUser`  | User records          | Table showing status of Employee ID & Mail.                                                          |
| `Get-SFADSync`        | `-Name`    | User Name             | Print relevant SalesForce fields & AD properties for a given user.                                   |
|                       | `-All`     | [switch]              | Print all SalesForce fields and AD properties.                                                       |
| `Update-ADEmployeeID` | `-SFUser`  | User record           | Sets AD Employee ID to value of SalesForce Unique_Id.                                                |
|                       | `-ADUser`  | User AD object        |                                                                                                      |
| `Update-ADNames`      | `-SFUser`  | User record           | Creates ticket in Fresh if AD Given Name or Surname differ from those in SalesForce.                 |
|                       | `-ADUser`  | User AD object        |                                                                                                      |
| `Update-ADTitle`      | `-SFUser`  | User record           | Updates AD Title & Description to the value of Job_Title in SalesForce.                              |
|                       | `-ADUser`  | User AD object        |                                                                                                      |
| `Update-ADManager`    | `-SFUser`  | User record           | Updates AD Manager to the Name value of the Manager field in SalesForce.                             |
|                       | `-ADUser`  | User AD object        |                                                                                                      |
| `Updste-SFFirstName`  | `-SFUser`  | User record           | If user has an empty Preferred_Name field in SalesForce, set it to the first part of the Name field. |
| `Update-SFMail`       | `-SFUser`  | User record           | Update SalesForce Email field with EmailAddress property from AD.                                    |
