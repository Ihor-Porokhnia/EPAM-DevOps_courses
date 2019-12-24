$fl=$args[0]
$path=$args[1]
[console]::ForegroundColor="red";
if ($fl -eq 0){

    Get-HotFix | Export-Csv -Path $path\f.csv;
    Import-Csv  $path\f.csv | Format-List | foreach {
        $k = Get-Random -Maximum 5;
        If ($k -eq 0) {
            
            [console]::ForegroundColor="red";
            $_;
                
        }
        elseif ($k -eq 1) {
            [console]::ForegroundColor="green";
            $_;
        }
        elseif ($k -eq 2) {
            [console]::ForegroundColor="blue";
            $_;
        }
        else {
            [console]::ForegroundColor="yellow";
            $_;
        }
    } 
     
}
else {
 dir HKLM:\SOFTWARE\Microsoft | Export-Clixml $path\g.xml;
 
    Import-Clixml  $path\g.xml | Format-List | foreach {
        $k = Get-Random -Maximum 5;
        If ($k -eq 0) {
            
            [console]::ForegroundColor="red";
            $_;
                
        }
        elseif ($k -eq 1) {
            [console]::ForegroundColor="green";
            $_;
        }
        elseif ($k -eq 2) {
            [console]::ForegroundColor="blue";
            $_;
        }
        else {
            [console]::ForegroundColor="yellow";
            $_;
        }
    }
}
