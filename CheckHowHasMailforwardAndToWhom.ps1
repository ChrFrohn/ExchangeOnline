Get-Mailbox | Where {$_.ForwardingAddress -ne $null} | Select Name, PrimarySMTPAddress, ForwardingAddress, DeliverToMailboxAndForward
