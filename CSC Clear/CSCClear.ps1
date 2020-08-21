$computer = Read-host "Compter Name [?]: "
Invoke-Command -ComputerName (Get-ADComputer -Filter *  | where name -Like $computer | select -expandProperty name){
    cls;
    if((Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\CSC\Parameters -Name 'FormatDatabase' -EA SilentlyContinue).FormatDatabase -eq 1)
        { 
            Write-Host "Klucz rejestru już istnieje";
             $zresetowac = Read-Host "Czy zresetować komputer ? T/N [N]"
    
            if ($zresetowac -eq 'T')
            {
                suspend-bitlocker c: 1
                restart-computer -force
            }
        } 
    else 
    { 
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\CSC\Parameters" -Name "FormatDatabase" -Value 1 -PropertyType Dword;
            Suspend-bitlocker c: 1;
            $zresetowac = Read-Host "Czy zresetować komputer ? T/N [N]"
    
            if ($zresetowac -eq 'T')
            {
                suspend-bitlocker c: 1
                restart-computer -force
            }
 
    }
}
