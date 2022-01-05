$Mailboxes = Get-Mailbox -RecipientTypeDetails UserMailbox

Foreach ($mailbox in $Mailboxes)
{
    $UserName = $Mailbox.Identity
    Get-MailboxFolderPermission $UserName ':\Inbox' | where {$_.user.tostring() -ne "Default" } | Select-Object Identity, User,FolderName,AccesRights
}
