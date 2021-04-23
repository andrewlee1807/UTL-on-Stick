Get-Process -Name 'taskmgr' | Format-Table `
    @{Label = "NPM(K)"; Expression = {[int]($_.NPM / 1024)}},
    @{Label = "PM(K)"; Expression = {[int]($_.PM / 1024)}},
    @{Label = "WS(K)"; Expression = {[int]($_.WS / 1024)}},
    @{Label = "VM(M)"; Expression = {[int]($_.VM / 1MB)}},
    @{Label = "CPU(s)"; Expression = {$TotalSec = (New-TimeSpan -Start $_.StartTime).TotalSeconds
    if ($_.CPU) {($_.CPU * 100 / (6*$TotalSec)).ToString("N")}}},
    Id, MachineName, ProcessName -AutoSize