
function reloadProfile(){
	Write-Host " reload profile"
	$path=Convert-Path .
	powershell -command "cd $path"
}



function administrator([string]$path){
	if($path -eq "."){
	$path=Convert-Path .
	}
	
	Start-Process powershell -Verb runAs -ArgumentList "-noexit", "-command &{cd $path}"
}

function administratorScript([string]$path,[string]$script){
	if($path -eq "."){
		$path=Convert-Path .
	}

	Start-Process powershell -Verb runAs -ArgumentList "-command &{cd $path}; & {dir}; & {.$script}"
}
# https://gist.github.com/soft2help/50574f23996f79ffc19712a1efb53d34
function refreshVendor(){
	administratorScript . \.vscode\refreshVendor.ps1
}

function refreshProject(){
	administratorScript . \.vscode\refreshProject.ps1
}

function localToRemote(){
	$fileToCheck = ".\.vscode\localToRemote.ps1"
	if ( -not(Test-Path $fileToCheck -PathType leaf)) {
		Write-Host "El script localToRemote.ps1 debe estar en la carpeta .vscode" -ForegroundColor red
		return
	}
	
	administradorScript . \.vscode\localToRemote.ps1
}

function toUnixFormat{
param([string]$file)
Get-ChildItem $file | ForEach-Object {
  # get the contents and replace line breaks by U+000A
  $contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
  # create UTF-8 encoding without signature
  $utf8 = New-Object System.Text.UTF8Encoding $false
  # write the text back
  [IO.File]::WriteAllText($_, $contents, $utf8)
}
}