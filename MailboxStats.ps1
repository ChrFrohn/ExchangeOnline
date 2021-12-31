#Mailbox folder stats - Inbox + Subfolders export
#Save the code below as a .ps1 file - Then run it like this:
#CMD: .\Test.ps1 | Export-CSV c:\Temp\inboxsizes.csv -NoTypeInformation -Encoding Unicode -Append

#Name of the AD group containing members you would like to see
$Group = Get-ADGroupMember "" -Recursive | Select-Object SamAccountName

Foreach($User in $Group)
{
    Get-Mailbox -Identity $User.SamAccountName -ResultSize Unlimited  | Get-MailboxFolderStatistics -FolderScope Inbox |
    Select Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize, @{n=”Total Size (GB)”;e={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1GB),2)}} 
}


#Mailbox folder stats - Inbox folder only
#Save the code below as a .ps1 file - Then run it like this:
#CMD: .\Test.ps1 | Export-CSV c:\Temp\inboxsizes.csv -NoTypeInformation -Encoding Unicode -Append

#Name of the AD group containing members you would like to see
$Group = Get-ADGroupMember "" -Recursive | Select-Object SamAccountName

Foreach($User in $Group)
{
    Get-Mailbox -Identity $User.SamAccountName -ResultSize Unlimited  | Get-MailboxFolderStatistics -FolderScope Inbox | Where {$_.FolderPath -eq "/Inbox"} |
    Select Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize, @{n=”Total Size (GB)”;e={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1GB),2)}} 
}


#Get mailbox stats (Whole mailbox)

#Name of the AD group containing members you would like to see
$Group = Get-ADGroupMember "" -Recursive | Select-Object SamAccountName

Foreach($User in $Group)
{
    Get-Mailbox -Identity $User.SamAccountName -ResultSize Unlimited  | Get-MailboxStatistics |
    Select DisplayName, @{n=”Total Size (GB)”;e={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1GB),2)}} 
}


#Single user
#Inbox only
Get-MailboxFolderStatistics -Identity "" -FolderScope Inbox | Where {$_.FolderPath -eq "/Inbox"}  | Format-Table Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize -AutoSize

#Inbox + inboxsubfolders
Get-MailboxFolderStatistics -Identity "" -FolderScope Inbox | Format-Table Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize -AutoSize 


