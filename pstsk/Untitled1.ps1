$Query = "Select * From __InstanceCreationEvent within 3 Where TargetInstance ISA 'Win32_Process'"            
$Identifier = "StartProcess"            
$ActionBlock = {            
 $e = $event.SourceEventArgs.NewEvent.TargetInstance            
 write-host ("Process {0} with PID {1} has started" -f $e.Name, $e.ProcessID)            
}            
Register-WMIEvent -Query $Query -SourceIdentifier $Identifier -Action $ActionBlock