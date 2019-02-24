function Update-ADNames {
    [cmdletbinding(SupportsShouldProcess)]
    param(
	[Parameter(Mandatory,Position=0)]
	[object]$SFUser,
	[Parameter(Mandatory,Position=1)]
	[object]$ADUser,
	[Parameter(Mandatory,Position=2)]
	[object]$Domain
    )

    $Fullname		= $SFUser.Name
    $SFFirstName	= $SFUser.fHCM2__Preferred_Name__c
    $ADFirstName	= $ADUser.GivenName
    $SFSurname		= $SFUser.fHCM2__Surname__c
    $ADSurname		= $ADUser.Surname

    if (($SFFirstName -ne $ADFirstName) -or ($SFSurname -ne $ADSurname)) {
	Write-Output "$FullName doesn't have matching AD and SalesForce names."

	$FreshSubject = "Name Change for $ADFirstName $ADSurname to $SFFirstName $SFSurname"
	$FreshDescription = "The IT dog found different first and last names for $ADFirstName $ADSurname in MyPeople."
	$FreshDescription += "Please change Active Directory GivenName and Surname fields to $SFFirstName $SFSurname. Woof! Woof!"

	$OpenTickets = Get-FreshTicketsByID 15824 | select subject,status_name,responder_name
	$Ticket = $OpenTickets | ? { $_.subject -eq "$FreshSubject" }

	if ($Ticket) {
	    Write-Output "$($Ticket.status_name) ticket already exists in Fresh and is assigned to $($Ticket.responder_name)."
	} else {
	    Write-Output "Creating Fresh ticket to change $($ADUser.GivenName) $($ADUser.Surname) to $FirstName $Surname."
	    $json = "{
		""helpdesk_ticket"":{
		    ""description"": ""$FreshDescription"",
		    ""subject"":""$FreshSubject"",
		    ""email"":""$EmailAddress"",
		    ""priority"":1, ""status"":2, ""source"":2,""ticket_type"":""Incident""
		},
		""cc_emails"":""""
	    }"
	    # New-FreshTicket -json $json
	}
    } else {
	Write-Verbose "$Fullname already has matching AD and SalesForce names."
    }
}
