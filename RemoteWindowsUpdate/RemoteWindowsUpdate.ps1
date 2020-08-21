$computer = Read-host "podaj nazwę komputera(ów): "
$computer+='*'
$computer

$sessions = New-PSSession -ComputerName (Get-ADComputer -Filter * | where name -Like $computer | select -expandProperty name)

$sessions

 Invoke-Command -Session $sessions {
#C:\Windows\System32\USOClient.exe StartInteractiveScan    
#C:\Windows\System32\USOClient.exe startdownload   
#C:\Windows\System32\USOClient.exe StartInstall 
#C:\Windows\System32\USOClient.exe ScanInstallWait    
#C:\Windows\System32\USOClient.exe RestartDevice    
#C:\Windows\System32\USOClient.exe ResumeUpdate    
#C:\Windows\System32\USOClient.exe Refreshsettings   
}

Get-PSSession | Remove-PSSession
