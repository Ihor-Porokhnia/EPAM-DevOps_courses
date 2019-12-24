$filename=$args[0]
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 | Out-File -Append $filename
