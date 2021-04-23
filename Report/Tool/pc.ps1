#Remove-Item -Path "log.csv"

$Counter = 0

$properties=@(
    @{Name="..."; Expression = {$_.Name}},   
    @{Name="CPU (%) "; Expression = {$_.PercentProcessorTime/10}},    
    #{$_.PercentProcessorTime},
    @{Name="Memory (MB)"; Expression = {[Math]::Round(($_.workingSetPrivate / 1mb),2)}}
    @{Name ="PriorityBase"; Expression = {$_.PriorityBase}}
    #{[Math]::Round(($_.workingSetPrivate / 1mb),2)}
)

$name='Taskmgr'
$name1='python'
$Later = 1


# commented out the next line - the test is ... iffy
#    thanks to Ta11ow for pointing it out [*grin*] 
#while ($Later -ne (Get-Date))
while ($Later)
    {
    #get-process -name Mojo | Group-Object -Property ProcessName | 
    #Format-Table Name, @{n='Mem (KB)';e={'{0:N0}' -f (($_.Group|Measure-Object WorkingSet -Sum).Sum / 1KB)};a='right'} -AutoSize

    #get-process Mojo | select name, description, @{l="Private Memory (MB)"; e={$_.privatememorysize / 1mb}}
    
    Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process -filter "Name='$name' or Name='$name1'" | 
    #Select-Object PercentProcessorTime , WorkingSetPrivate | Format-Table -HideTableHeaders >> "test.txt"
    # Capture down log file
    #Select-Object  $properties | Export-CSV "log.csv" -Append -NoTypeInformation 
    Select-Object $properties


    $Counter ++
    #$Counter
   
    Start-Sleep -Seconds 0.4

    }

