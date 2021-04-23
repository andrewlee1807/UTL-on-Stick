#$ProcessPID = “272408”

$ProcessName = 'powershell'
Write-Output $ProcessName

$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$Samples = (Get-Counter “\Process($Processname*)\% Processor Time”).CounterSamples

Write-Output $CpuCores

$Samples | Select `
InstanceName,
@{Name=”CPU %”;Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 2)}}

Get-Counter '\Process(*)\% Processor Time' | 
Select-Object -ExpandProperty countersamples|
Select-Object -Property instancename, cookedvalue| ? {$_.instanceName -notmatch "^(idle|_total|system)$"} | 
Sort-Object -Property cookedvalue -Descending| 
Select-Object -First 25| ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100/$env:NUMBER_OF_PROCESSORS).toString('P')}} -AutoSize