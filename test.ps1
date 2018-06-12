([System.Security.Principal.WindowsIdentity]::GetCurrent()) | Format-List

Write-Host IsAdmin: ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)