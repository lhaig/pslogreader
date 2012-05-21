# Quest Migrator Logfile Parser
$d = Get-Date
$logFileRPath = "D:\Logs\logs"
$logFileWPath = "D:\Logs"
$logFileEPath = "D:\Logs\errors"
$logFileDate = $d.Day - 1
# Add more copy machines to the file below.
$copyServers = Import-Csv $logFileWPath\qmcopyservers.txt
Write-Host "LogDate Is" $logFileDate
#Write-Host $logFiles
#Write-Host $logFileRPath
#Write-Host $logFileWPath
#Write-Host $logFileDate
#Write-Host $copyServers
Write-Host
Write-Host "Copy Servers To Use"
foreach ($server in $copyServers) {
        $copyMachine = $server.CopyMachine
        $copyVolume = $server.Volume
        $sourcePath = "\\$copyMachine\ndsmig\Logs\File Migration"
        Write-Host "Processing Machine"
        Write-Host $copyMachine
        $logFileMPath = "$logFileRPath\$copyMachine"
        if (!(Test-Path -path $logFileRPath\$copyMachine)) {New-Item $logFileRPath\$copyMachine -Type Directory}
        $sourceLog = gci $sourcePath\*Scan.log |? {!$_.PsIsContainer} | % {$_.Name} | where { $_.LastWriteTime.Day -lt $logFileDate}
        foreach ($log in $sourceLog) {
            $result = test-path -path "$logFileMPath\*" -include $log
                if ($result -like "False"){
                    Write-Host "Copying Logfile" $log
                    Copy-Item "$sourcePath\$log" -Destination "$logFileRPath\$copyMachine\"
                }
             }
        Write-Host 
        $logFiles = Get-ChildItem -recurse $logFileRPath | where { $_.LastWriteTime.Day -eq $logFileDate}
        foreach ($objFile in $logFiles) {
            $fileName = "$copyVolume-error-$objFile"
            gc $logFileRPath\$copyMachine\$objFile -read 10000 | %{$_} | ? {$_ -like '*Error   *'} | Out-File $logFileEPath\$fileName
            }
        }
