
$lib_home="{REPLACE_ME}\modules\"
Write-Host "### Loading modules from $lib_home ###"
Get-ChildItem ($lib_home + "*.ps1") | ForEach-Object {. (Join-Path $lib_home $_.Name)} | Out-Null
Write-Host -NoNewline "$PSScriptRoot\"
$MyInvocation.MyCommand.Name