$sleepseconds = 0.5
$numcores = 6
$id = 267352
while(1)
{
    
    $cpu1 = (get-process -Id $id).cpu
    sleep $sleepseconds
    $cpu2 = (get-process -Id $id).cpu
    $cpupercent = (($cpu2 - $cpu1)/($numcores*$sleepseconds) * 100)
    Write-Output $cpupercent    
}