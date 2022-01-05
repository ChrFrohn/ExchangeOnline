$Mailboxes = Get-Mailbox -RecipientTypeDetails UserMailbox

Foreach ($mailbox in $Mailboxes)
{
    $UserName = $Mailbox.Identity
    Get-MailboxFolderPermission $UserName':\Inbox' | where {$_.user.tostring() -ne "Default" } | Select-Object Identity, User,FolderName,AccesRights
}


$Mailboxes = Get-Mailbox

Foreach ($mailbox in $Mailboxes)
{
    Get-MailboxPermission $Mailbox.Identity | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Export-Csv C:\Temp -NoTypeInformation -Encoding Unicode -Append

}
