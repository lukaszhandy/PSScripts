cls
#1. 
$hostname = hostname;
$sysinfo=Get-ComputerInfo
$disk=Get-disk  | select Model, 'Size'
$bios=Get-WmiObject win32_bios 
Write-Host "NAZWA KOMPUTERA: $hostname"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "NUMER SERYJNY: $($bios.Serialnumber)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DYSKI: "
Get-WmiObject Win32_DiskDrive | ForEach-Object {
  $disk = $_
  $partitions = "ASSOCIATORS OF " +
                "{Win32_DiskDrive.DeviceID='$($disk.DeviceID)'} " +
                "WHERE AssocClass = Win32_DiskDriveToDiskPartition"
  Get-WmiObject -Query $partitions | ForEach-Object {
    $partition = $_
    $drives = "ASSOCIATORS OF " +
              "{Win32_DiskPartition.DeviceID='$($partition.DeviceID)'} " +
              "WHERE AssocClass = Win32_LogicalDiskToPartition"
    Get-WmiObject -Query $drives | ForEach-Object {
      New-Object -Type PSCustomObject -Property @{
        Disk        = $disk.DeviceID
        DiskSize    = $disk.Size
        DiskModel   = $disk.Model
        Partition   = $partition.Name
        RawSize     = $partition.Size
        DriveLetter = $_.DeviceID
        VolumeName  = $_.VolumeName
        Size        = $_.Size
        FreeSpace   = $_.FreeSpace
      }
    }
  }
}

Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "WERSJA BIOS $($bios.SMBIOSBIOSVersion)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DATA BIOS: $($sysinfo.BiosReleaseDate)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DATA BOOTOWANIA: $($sysinfo.OsLastBootUpTime)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DOMENA: $($sysinfo.CsDomain)"
Write-Host "NAZWA UŻYTKOWNIKA: $($env:UserName)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DANE OSTATNIEGO LOGOWANIA:"
            QUERY USER
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "NAZWA HANDLOWA OS: $($sysinfo.WindowsProductName)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "WERSJA OS: $($sysinfo.OsVersion)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "DATA INSTALACJI OS: $($sysinfo.WindowsInstallDateFromRegistry)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "KATALOG GŁÓWNY OS: $($sysinfo.WindowsSystemRoot)"
Write-Host "-----------------------------------------------------------------------------------------------";

switch ($sysinfo.OsVersion) {
    "10.0.10240" {$ustatus = "1507 - WSPARCIE WYGASŁO:" ;$udate = "9 maja 2017"}
    "10.0.10586" {$ustatus = "1511 - WSPARCIE WYGASŁO:" ;$udate = "10 października 2017"}
    "10.0.14393" {$ustatus = "1607 - WSPARCIE WYGASŁO:" ;$udate = "10 kwietnia 2018"}
    "10.0.15063" {$ustatus = "1703 - WSPARCIE WYGASŁO:" ;$udate = "9 października 2018"}
    "10.0.16299" {$ustatus = "1709 - WSPARCIE WYGASŁO:" ;$udate = "9 kwietnia 2019"}
    "10.0.17134" {$ustatus = "1803 - WSPARCIE WYGASŁO:" ;$udate = "12 listopada 2019"}
    "10.0.17763" {$ustatus = "1809 - WSPARCIE WYGASŁO:" ;$udate = "10 listopada 2020"}
    "10.0.18362" {$ustatus = "1903 - WSPARCIE WYGASŁO:" ;$udate = "8 grudnia 2020"}
    "10.0.18363" {$ustatus = "1909 - WSPIERANY DO:" ;$udate = "9 maja 2021"}
    "10.0.19041" {$ustatus = "2004 - WSPIERANY DO:" ;$udate = "14 grudnia 2021"}
    "10.0.19042" {$ustatus = "20H2 - WSPIERANY DO:" ;$udate = "10 maja 2022"}
default {$ustatus = "NN" ;$udate = "NN"}
}
Write-Host "WERSJA OS: $ustatus $udate"
Write-Host "-----------------------------------------------------------------------------------------------";
$wmiQuery = "SELECT * FROM AntiVirusProduct"
$AntivirusProduct = Get-WmiObject -Namespace "root\SecurityCenter2" -Query $wmiQuery  @psboundparameters # -ErrorVariable myError -ErrorAction 'SilentlyContinue'
switch ($AntiVirusProduct.productState) {
"262144" {$defstatus = "Up to date" ;$rtstatus = "Disabled"}
    "262160" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
    "266240" {$defstatus = "Up to date" ;$rtstatus = "Enabled"}
    "266256" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
    "393216" {$defstatus = "Up to date" ;$rtstatus = "Disabled"}
    "393232" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
    "393488" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
    "397312" {$defstatus = "Up to date" ;$rtstatus = "Enabled"}
    "397328" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
    "397584" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
default {$defstatus = "Unknown" ;$rtstatus = "Unknown"}
}
Write-host $rtstatus
       
Write-host "PROGRAM ANTYWIRUSOWY: $($AntivirusProduct.displayName)"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "ADRESY IP:"
            Get-NetIPAddress
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "PUBLICZNE IP: " # (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
$ip = Invoke-RestMethod http://ipinfo.io/json
$ip.ip
$ip.hostname
$ip.city
$ip.region
$ip.country
$ip.loc
$ip.org
$ip.postal
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "PROFILE WIFI:"
netsh wlan show profiles
Write-Host "-----------------------------------------------------------------------------------------------";
Write-Host "PROFILE WIFI Z HASŁAMI (AUTOPOŁĄCZENIE):"
(netsh wlan show profiles)|%{$n=(""+($_ -split ":")[1]).trim(); netsh wlan show profile name="$n" key=clear}|sls "Key Content","SSID name"
Write-Host "-----------------------------------------------------------------------------------------------";
Write-host $AntivirusProduct.displayName
Write-Host "-----------------------------------------------------------------------------------------------";
gwmi Win32_USBControllerDevice |%{[wmi]($_.Dependent)}  | Sort Description,DeviceID | ft Description,DeviceID -auto
Write-Host "-----------------------------------------------------------------------------------------------";


