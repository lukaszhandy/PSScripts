cls
$seconds=200
$Date = Get-Date
do{
sleep(60);
$Date1 = Get-Date ;

$DiffDate = $Date1 - $Date;

[int]$res=[convert]::ToInt32($DiffDate.TotalMinutes);

$res;

if($res -eq $seconds)
{
  Restart-Computer -Force
}

}
while(1-eq1)
