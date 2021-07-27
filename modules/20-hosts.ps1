$global:hosts = "$env:windir\System32\drivers\etc\hosts"

<#
.SYNOPSIS
    This function check is the shell have admin right
.DESCRIPTION
    This function check if in actual shell you have admin rights,
	return true if you have, otherwise writes a red message in shell and returns false
	can be used inside script or in shell its up to you.
.EXAMPLE
    C:\PS> 
    checkelevated
	or
	in script
	if(!checkelevated){
		return
	}	
.NOTES
    Author: Luis Fernandes
    Date:   Octubre 22, 2018    
#>
function checkelevated(){
	$seguro = $true;

	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
		$seguro = $false;
		Write-Host " You should execute with admin rights." -ForegroundColor red
	}
	return $seguro;
}


function add-host([string]$ip, [string]$hostname) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	remove-host $hostname
	$ip + "`t`t" + $hostname | Out-File -encoding ASCII -append $global:hosts
	
}

function remove-host([string]$hostname) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {
            if ($bits[1] -ne $hostname) {
                $newLines += $line
            }
        } else {
            $newLines += $line
        }
    }

    # Write file
    Clear-Content $global:hosts
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $global:hosts
    }
}

function disable-host([string]$hostname) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {
            if ($bits[1] -eq $hostname) {
				$line=$line.Replace("#", "")
                $newLines += "#"+$line
            }
        } 
		
            $newLines += $line
        
    }

    # Write file
    Clear-Content $global:hosts
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $global:hosts
    }
}

function enable-host([string]$hostname) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {
            if ($bits[1] -eq $hostname) {
				$line=$line.Replace("#", "")                
            }			
        } 
        $newLines += $line
        
    }

    # Write file
    Clear-Content $global:hosts
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $global:hosts
    }
}

function print-hosts() {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	 
    $c = Get-Content $global:hosts

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {
            Write-Host $bits[0] `t`t $bits[1]
        }
    }
}

function enable-all-hosts() {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {           
			$line=$line.Replace("#", "") 
        } 
		
        $newLines += $line
        
    }

    # Write file
    Clear-Content $global:hosts
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $global:hosts
    }
}

function disable-all-hosts() {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $bits = [regex]::Split($line, "\s+")
        if ($bits.count -eq 2) {           
			$line="#"+$line
        } 
		
        $newLines += $line
        
    }

    # Write file
    Clear-Content $global:hosts
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $global:hosts
    }
}

function backup-hosts([string]$file) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $newLines += $line
    }
	
	$destino= Split-Path -Path $global:hosts
	$destino=$destino+"\"+$file
 
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $destino
    }

}


function restore-hosts([string]$file) {
	$administrador=checkelevated
	if(!$administrador){
	 return
	}
	
	$restore= Split-Path -Path $global:hosts
	$restore=$restore+"\"+$file
	
    $c = Get-Content $global:hosts
    $newLines = @()

    foreach ($line in $c) {
        $newLines += $line
    }
	
	$destino= Split-Path -Path $global:hosts
	$destino=$destino+"\"+$file
 
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $destino
    }

}




