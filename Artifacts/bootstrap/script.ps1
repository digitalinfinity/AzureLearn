Param(
    [ValidateNotNullOrEmpty()]
    [string]$localAdminUsername=$(throw "localAdminUsername is mandatory"),
    [ValidateNotNullOrEmpty()]
    [string]$localAdminPassword=$(throw "localAdminPassword is mandatory")
)

Write-Host User is $localAdminUsername
Write-Host Password is $localAdminPassword

$winlogonKey="HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$runKey="HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"

if (!(Test-Path $winlogonKey)) {
    Write-Host Creating Winlogon key 
    New-Item -Path $winlogonKey -Force
}

if (!(Test-Path $runKey)) {
    Write-Host Creating Run key 
    New-Item -Path $runKey -Force
}

New-ItemProperty -Path $winlogonKey -Name "DefaultUserName" -Value $localAdminUsername -Force
New-ItemProperty -Path $winlogonKey -Name "DefaultPassword" -Value $localAdminPassword -Force
New-ItemProperty -Path $winlogonKey -Name "AutoAdminLogon" -Value "1" -Force

$shinobiRoot = "C:\Shinobi"
New-Item -ItemType Directory -Path $shinobiRoot -Force

$agentRoot = "{0}\agent" -f $PSScriptRoot

Copy-Item -Path $agentRoot -Recurse -Destination $shinobiRoot -Container

$shinobiAgentCommand = '"C:\Program Files\nodejs\node.exe" {0}\agent\build\agent.js' -f $shinobiRoot
New-ItemProperty -Path $runKey -Name "ShinobiAgent" -Value $shinobiAgentCommand -Force

