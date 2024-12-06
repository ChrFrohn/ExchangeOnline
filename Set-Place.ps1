# Set GeoLocation on a Exchange room mailbox (Hybird or online using MS Graph)

# Import the Microsoft Graph module
Import-Module Microsoft.Graph.Calendar

Connect-MgGraph -Scopes "Place.ReadWrite.All"
# Define the parameters for the room update
$params = @{
    "@odata.type" = "microsoft.graph.room"
    geoCoordinates = @{
        latitude = 70.70994085087831
        longitude = 32.590798382638036
        altitude = 0.0  # Optional, set to 0.0 if not needed
    }
}

# Update the room with the specified ID
$roomId = ""  # UPN of Room
Update-MgPlace -PlaceId $roomId -BodyParameter $params




