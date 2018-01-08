# Load webadministration module is not present.
if (!(Get-Module -Name webadministration)) {

    Import-Module webadministration -Verbose

}

# Variable value defined in octopus deploy
$appPoolName = $OctopusParameters['appPoolName']

# Check If AppPool Exists
if (Test-Path IIS:\AppPools\$appPoolName){
    # Start App Pool if stopped else restart
if ((Get-WebAppPoolState($appPoolName)).Value -eq "Stopped"){
    Write-Output "Starting IIS app pool $appPoolName"
    Start-WebAppPool $appPoolName
}
else {
    Write-Output "Restarting IIS app pool $appPoolName"
    Restart-WebAppPool $appPoolName
}
}