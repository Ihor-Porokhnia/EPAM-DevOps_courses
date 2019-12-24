$filename=$args[0]
$mask = $args[1]
$sum = 0;
gci $filename | ForEach-Object {if ($_.Name -notlike $mask){$sum += $_.Length}}
echo ($sum/1MB)