function checkelevated(){
	$seguro = $true;

	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
		$seguro = $false;
		Write-Host " You should execute with admin rights." -ForegroundColor red
	}
	return $seguro;
}

$administrator=checkelevated
if(!$administrator){
	return
}

#https://www.improvescripting.com/how-to-create-powershell-profile-step-by-step-with-examples/
$scriptpath = $MyInvocation.MyCommand.Path
$dirinit = Split-Path $scriptpath

cd  "$env:windir\System32\WindowsPowerShell\v1.0\"
((Get-Content -path "$dirinit\profile.ps1" -Raw) -replace '{REPLACE_ME}',$dirinit) | Set-Content -Path "$dirinit\profile.ps1" 
New-Item -ItemType SymbolicLink -Name profile.ps1 -Target "$dirinit\profile.ps1"