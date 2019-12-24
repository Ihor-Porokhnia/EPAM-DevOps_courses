$filename=$args[0]
Get-Service | where {$_.status -eq 'running'} | Out-File $filename
$s = $filename.parent()
dir $s
Get-Content $filename | Format-List