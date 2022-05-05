function Start-ExecutionLog($startTime, $logPath, $targetHostname, $targetUser, $commandLine, $isWindows) {

}

function Write-ExecutionLog($startTime, $stopTime, $curTechnique, $technique, $testNum, $testName, $testGuid, $testExecutor, $testDescription, $command, $logPath, $targetHostname, $targetUser, $stdOut, $stdErr, $isWindows) {
    if (!(Test-Path $logPath)) { 
        New-Item $logPath -Force -ItemType File | Out-Null
    } 

    $timeUTC = (Get-Date($startTime).toUniversalTime() -uformat "%Y-%m-%dT%H:%M:%SZ").ToString()
    $timeStopUTC = (Get-Date($stopTime).toUniversalTime() -uformat "%Y-%m-%dT%H:%M:%SZ").ToString()
    $timeLocal = (Get-Date($startTime) -uformat "%Y-%m-%dT%H:%M:%S").ToString()
    [PSCustomObject][ordered]@{ 
        "Execution Time (UTC)"   = $timeUTC;
        "Stop Time (UTC)"        = $timeStopUTC;        
        "Execution Time (Local)" = $timeLocal; 
        "Technique ID"           = $technique; 
        "Technique Name"         = $curTechnique.display_name.ToString(); 
        "Test Number"            = $testNum; 
        "Test Name"              = $testName; 
        "Hostname"               = $targetHostname; 
        "Username"               = $targetUser
        "GUID"                   = $testGuid
        "command"                = $command
        "stdOut"                 = $stdOut
        "stdErr"                 = $stdErr
    } | Export-Csv -Path $LogPath -NoTypeInformation -Append
}

function Stop-ExecutionLog($startTime, $logPath, $targetHostname, $targetUser, $isWindows) {

}