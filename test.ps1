$adsi = [ADSI]"WinNT://$Env:Computername"
$Users = $adsi.Children  | where {$_.SchemaClassName  -eq 'user'}
$shinobiUser = $users | Where-Object { $_.Name -eq "chakrashinobi" }
if ($shinobiUser -ne $null) {
    $packages = get-appxpackage
    $packages | Format-List
    $edgePackage = $packages | where { $_.Name -eq "Microsoft.MicrosoftEdge" }
    $appLocalPath = Join-Path -Path $edgePackage.InstallLocation -ChildPath "microsoft.system.package.metadata\Application.Local"
    $appLocalFolder = New-Item -ItemType Directory -Force -Path $appLocalPath

    $acl = Get-Acl $appLocalPath
    $accessRule = New-Object System.Security.AccessControl.FilesystemAccessRule($shinobiUser.Name, "FullControl", "Allow")
    $acl.SetAccessRule($accessRule)
    Set-Acl $appLocalPath $acl
}