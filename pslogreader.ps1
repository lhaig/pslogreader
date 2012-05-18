# Quest Migrator Logfile Parser
$d = Get-Date
$logFileRPath = "D:\Logs\logs"
$logFilePath = "D:\Logs"
$logFileEPath = "D:\Logs\errors"
$logFileDate = $d.Day - 1
$logFiles = Get-ChildItem $logFileRPath | where { $_.LastWriteTime.Day -eq $logFileDate}
# Add more copy machines to the file below.
$copyServers = Import-Csv $logFilePath\qmcopyservers.csv
#Write-Host "LogDate Is" $logFileDate
Write-Host
Write-Host "Copy Servers To Use"
foreach ($server in $copyServers) {
        $copyMachine = $server.CopyMachine
        $copyVolume = $server.Volume
        $sourcePath = "\\$copyMachine\ndsmig\Logs\File Migration\"
        Write-Host $copyMachine
        #Write-Host $sourcePath
        $sourceLog = Get-ChildItem $sourcePath\*Scan.log | where { $_.LastWriteTime.Day -eq $logFileDate}
        #Write-Host $sourceLog.LastWriteTime
        Copy-Item -path $sourceLog -destination $logFileRPath\"$copyVolume"-Scan.log
        }
Write-Host
Write-Host "Log Files Selected"
foreach ($logFile in $logFiles) {
        #Write-Host $logFile
        }
Write-Host 
foreach ($objFile in $logFiles) 
    {
        Write-Host "Processing LogFile" $objFile
        gc $logFileRPath\$objFile -read 10000 | %{$_} | ? {$_ -like '*Error   *'} | Out-File $logFileEPath\"$objFile"-errors.log
        }
