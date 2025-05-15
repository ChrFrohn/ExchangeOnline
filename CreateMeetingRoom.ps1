# Define meeting room details
$RoomName = "" # Replace with the room name
$RoomDisplayName = $RoomName + " - Meeting Room"
$RoomEmail = $RoomName + "@domain.com" # Replace with the room email domain
$Floor = "" # Replace with the floor number
$Building = "" # Replace with the building name
$City = "" # Replace with the city name
$CountryOrRegion = "" # Replace with the country or region
$PostalCode = "" # Replace with the postal code
$Street = "" # Replace with the street address
$Capacity = "" # Replace with the room capacity
$VideoDeviceName = "" # Replace with the video device name
$GeoCoordinates = "" # Replace with geo-coordinates

# Create the room mailbox
New-Mailbox -Name $RoomName -Room -PrimarySmtpAddress $RoomEmail -DisplayName $RoomDisplayName -Alias $RoomName

# Wait for the mailbox to be created
Start-Sleep -Seconds 30

# Retrieve mailbox details
$MailBoxGraph = Get-MgUser -ConsistencyLevel eventual -Count userCount -Filter "startsWith(DisplayName, '$RoomDisplayName')"

# Update mailbox details
Update-MgUser -UserId $MailBoxGraph.Id -UserPrincipalName $RoomEmail -UsageLocation "DK"

# Set user photo (optional)
$photoPath = "" # Replace with the path to the photo
Set-MgUserPhotoContent -UserId $MailBoxGraph.Id -InFile $photoPath -ErrorAction Stop

# Configure calendar processing
Set-MailboxCalendarConfiguration -Identity $RoomName -WorkingHoursTimeZone "Romance Standard Time" -WorkingHoursStartTime "08:00:00" -WorkingHoursEndTime "17:00:00" -Verbose
Set-CalendarProcessing $RoomName -AutomateProcessing AutoAccept -AllowRecurringMeetings $true -AllowConflicts $false -BookingWindowInDays "365" -DeleteSubject $true -DeleteComments $false -RemovePrivateProperty $false -ProcessExternalMeetingMessages $false -AddAdditionalResponse $true -AdditionalResponse ""

# Set place details
Set-Place -Identity $RoomName -Floor $Floor -Building $Building -CountryOrRegion $CountryOrRegion -City $City -PostalCode $PostalCode -Street $Street -Capacity $Capacity -GeoCoordinates $GeoCoordinates -MTREnabled $true -VideoDeviceName $VideoDeviceName -DisplayDeviceName "" -IsWheelChairAccessible $true

# Add the room to a distribution group (optional)
$DistributionGroup = "" # Replace with the distribution group email
if ($DistributionGroup) {
    Add-DistributionGroupMember -Identity $DistributionGroup -Member $RoomName
}

# Set mailbox folder permissions (optional)
Set-MailboxFolderPermission -Identity $RoomName":\Calendar" -User Default -AccessRights PublishingAuthor
Add-MailboxFolderPermission -Identity $RoomName":\Calendar" -User "" -AccessRights "Owner"
