# https://gist.github.com/timsneath/19867b12eee7fd5af2ba


$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Write-Output "$isAdmin ist admin"

if (($host.Name -match "ConsoleHost") -and ($isAdmin)) {
	$host.UI.RawUI.BackgroundColor = "Darkblue"
	$host.PrivateData.ErrorBackgroundColor = "White"
	$host.PrivateData.ErrorForegroundColor = "DarkRed"
	# Clear-Host
}

# cds
function Set-Location... { Set-Location ..\.. }
function Set-Location.... { Set-Location ..\..\.. }
function .. { Set-Location .. }

# -------------------------------------------------------
$myd = [Environment]::GetFolderPath("MyDocuments")

$pfad_sys = 'C:\Windows\System32\WindowsPowerShell\v1.0'

$prof_home = '~/documents/WindowsPowerShell'

# set-location $prof_home

$sprache = 'de'

$home_wsl = 'z:/home/tk'
$cv = "$home_wsl/cv"

Function ph { set-location $prof_home }

function e { . $profile }

function v { . ./Microsoft.VSCode_profile.ps1 }

function pfad_sys {
	Write-Output $pfad_sys
	. "$pfad_sys/profile.ps1"
}

function gim {
	Get-InstalledModule | Format-List | more
}
function pand_cv {
	pandoc.exe -s "$cv\cv_$sprache.md" -o "$cv\output\cv_$sprache.html" ; Start-Process chrome.exe "$cv\output\cv_$sprache.html"
}

function fin {
	Get-ChildItem c:/ -Filter $args -Recurse | Select-Object -First 1
}

# bekannte verzeichnisse
function bv {
	[enum]::GetNames( [System.Environment+SpecialFolder] ) | 
	Select-object @{ n = "Name"; e = { $_ } },
	@{ n = "Pfad"; e = { [environment]::getfolderpath( $_ ) } }
}
	
function myd {
	Get-ChildItem $myd
}

function res {
	$video = Get-WmiObject -Class CIM_VideoControllerResolution
	$video[-1] | Select-Object Caption
}

function ser {
	Get-Service | Where-Object { $_.status -eq 'running' } | findstr $args
}

function driv {
	Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n = "Root"; e = { if ($null -eq $_.DisplayRoot ) { $_.Root } else { $_.DisplayRoot } } }
}
# --------------------------------------------------------------
function af { Get-ChildItem function: | Format-List | more }
function af2 { Get-ChildItem function: | Format-List }

function af_ {
 Get-ChildItem function: | findstr.exe $args 
	if (! $args) {
		return "nothing"
	}
}

function al { get-alias | format-list | more }

function al2 { get-alias | format-list }

function al_ { get-alias | findstr $args }

function ds { displayswitch.exe /external } # 2 verwenden


function mo { more $args }

function x {
	exit
}

function n { c:/notepad++/notepad++ $args }

function pa {
	[System.Environment]::GetEnvironmentVariable("Path", "Machine")
}


function pm {
	shutdown.exe /h
}


function prompt {
	$gl = Get-Location
	$verbindung = $(Get-NetConnectionProfile).name
	write-host "PS $gl - $verbindung >" -NoNewline
	return " "
}

set-alias g git
set-alias gr findstr
set-alias l gci
set-alias p pwd

. $prof_home\git_alias.ps1