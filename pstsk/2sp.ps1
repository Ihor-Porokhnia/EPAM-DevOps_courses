$sum = 0
gci ENV:* | ForEach-Object {
    $sum += $_.value -as [int]
};
Write-Output $sum