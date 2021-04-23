$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
write-host core $CpuCores
#(Get-Counter "\Process(*)\% Processor Time").CounterSamples | Select InstanceName, @{Name="CPU %";Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 2)}}
while (1)
    {
    Get-Counter -ErrorAction SilentlyContinue '\Process(*)\% Processor Time' | 
    Select-Object -ExpandProperty countersamples| Select-Object -Property instancename, cookedvalue| 
    ? {$_.instanceName -notmatch "^(idle|_total|system)$"} | Sort-Object -Property cookedvalue -Descending| 
    Select-Object -First 10| ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100/$env:NUMBER_OF_PROCESSORS).toString('P')}} -AutoSize
    }
