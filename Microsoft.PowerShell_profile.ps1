# https://gist.github.com/timsneath/19867b12eee7fd5af2ba

function af {
	gci function: 
}

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (($host.Name -match "ConsoleHost") -and ($isAdmin))
{
     $host.UI.RawUI.BackgroundColor = "Darkblue"
     $host.PrivateData.ErrorBackgroundColor = "White"
     $host.PrivateData.ErrorForegroundColor = "DarkRed"
     # Clear-Host
}

# cds
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }
function ..  { cd .. }



# -------------------------------------------------------
set-location ~/skripte

#alias
function e {
	& $profile
}
function al {
	get-alias |format-list|more
}


function pa {
	[System.Environment]::GetEnvironmentVariable("Path","Machine")
}

set-alias grep findstr

function pm {
    cmd c/ shuthdown.exe /h
}

#git

function ga {
	git add .
}

function gcam {
	param (
    [Parameter(Mandatory=$true)][string]$commit = "first commit"
	)
	
	git commit -am $commit
	}

function gs {
	git status
}

function gu {
	git push
}


function prompt {
    # $dateTime = get-date -Format "dd.MM.yyyy HH:mm:ss"
    $gl = $(Get-Location)
    $UncRoot = $gl.Drive.DisplayRoot
	$verbindung = $(Get-NetConnectionProfile).name
    # write-host "$dateTime" -NoNewline -ForegroundColor White
    # write-host " $UncRoot" -ForegroundColor white
    # Convert-Path needed for pure UNC-locations
    write-host "PS $(Convert-Path $currentDirectory) - $verbindung >" -NoNewline
    return " "
}