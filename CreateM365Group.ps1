$NameOfGroup = ""
$Alias = ""

#Creating the group:
New-UnifiedGroup -DisplayName $NameOfGroup -Alias $Alias

## Modifying the group:

#Disabled welcome email
Set-UnifiedGroup -Identity $NameOfGroup -UnifiedGroupWelcomeMessageEnabled:$false

#Make group private
Set-UnifiedGroup -Identity $NameOfGroup -AccessType Private

#Subscribe to all emails
Set-UnifiedGroup -Identity $NameOfGroup -AutoSubscribeNewMembers:$true
