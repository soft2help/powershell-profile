Write-Host  "docker"
function waitmachine($machine) {
    while (($inspect = docker inspect --format='{{.State.Running}}' $machine) -eq "false") {	
        Write-Host -NoNewline "."
        Start-Sleep 1 
    }

}

function stop-all-containers() {

    docker stop $(docker ps -a -q)

}

function remove-all-containers() {

    docker rm $(docker ps -a -q)

}
function stopremove-all-containers() {

    stop-all-containers
    remove-all-containers

}

function clean-docker() {
    
    docker image prune
    docker container prune
    docker volume prune
    docker network prune
    docker system prune

}



function getEnv() {
    $conf = Get-Content '.env' | Select -Skip 1 | ConvertFrom-StringData
    return $conf
}

function promptHost($dominio) {
    $a = new-object -comobject wscript.shell 
    $intAnswer = $a.popup("Set hosts?", 4, "hosts", 4)
    if ($intAnswer -eq 6 -Or $intAnswer -eq -1) {
        add-host "127.0.0.1" $dominio
    }
    else {
        remove-host $dominio
    }
}

