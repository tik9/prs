# https://gist.github.com/timsneath/19867b12eee7fd5af2ba

function te { Set-Location ~}

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Write-Output "$isAdmin ist admin"

# $FormatEnumerationLimit = -1

if (($host.Name -match "ConsoleHost") -and ($isAdmin)) {
	$host.UI.RawUI.BackgroundColor = "Darkblue"
	$host.PrivateData.ErrorBackgroundColor = "White"
	$host.PrivateData.ErrorForegroundColor = "DarkRed"
}

$ca = "$zsh_cu/plugins/common-aliases/common-aliases.plugin.zsh"
$cf = 'common_functions'
$cs = "$up\AppData\Roaming\Code\User\"
$doks = "$home_wsl/doks"
$home_wsl = "$wsl/home/tk"
$lw = '\\Laptopweiss\c'
$myd = [Environment]::GetFolderPath("MyDocuments")

$plu = "$zsh_cu/plugins"
$up = $env:userprofile
$prof_home = "$up/documents/WindowsPowerShell"


$wsl = '\\wsl$\debian'

$zsh_cu = "$home_wsl/.oh-my-zsh/custom"

function cv { Set-Location z:/home/tk/cv }

# code
function co { code $args }

# choco
function ch { choco -? | more }
function chi { choco install $args }
function coi { choco list --local-only }
function coo { choco outdated ; choco upgrade all }

function bg() { Start-Process -NoNewWindow @args }

function c { get-content $args }

function com { wmic computersystem get model, name, manufacturer, systemtype }

function cu {
	$url = 'http://192.168.178.36/cgit/doks.git/tree/arbeiten_haus.md'
	$url = $args
	Invoke-WebRequest  -UseBasicParsing $url
}

function d { (Get-Command $args).Definition }
function dela { Remove-Item alias:$args }
function driv {	Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n = "Root"; e = { if ($null -eq $_.DisplayRoot ) { $_.Root } else { $_.DisplayRoot } } } }

function ds { displayswitch.exe /external } # 2 verwenden
function e { . $profile }
function ec { Write-Output $args }

function get_reg {
	$reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters/"
	$reg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" # .ReleaseId
	Get-ItemProperty -Path $reg
}

function fin {	Get-ChildItem c:/ -Filter $args[0] -Recurse | Select-Object -First 1 }

function finstr { Get-ChildItem -Recurse | Select-String -Pattern $args | Select-Object -Unique Path }

function gim {	Get-InstalledModule | Format-List | more }

function map_net { net use z: $wsl }
 
function map { New-PSrive -Name 'y' -Root $lw -Persist -PSProvider "FileSystem" }

function mem { Get-CimInstance win32_physicalmemory | Select-Object -ExpandProperty }

function mo { more $args }

function n { c:/notepad++/notepad++ $args }

function pa { [System.Environment]::GetEnvironmentVariable("Path", "Machine") }

function pand_cv {	pandoc.exe -s "$cv\.md" -o "$cv\output\cv_.html" ; Start-Process chrome.exe "$cv\output\cv_.html" }

function pm { shutdown.exe /h }

function prompt {
	$gl = Get-Location
	$verbindung = $(Get-NetConnectionProfile).name
	write-host "PS $gl - $verbindung >" -NoNewline
	return " "
}
function res {
	$video = Get-WmiObject -Class CIM_VideoControllerResolution
	$video[-1] | Select-Object Caption
}
function run_adm { Start-Process "powershell" -Verb RunAs }

function ser { Get-Service | Where-Object { $_.status -eq 'running' } | findstr $args }
function sf {
	[enum]::GetNames( [System.Environment+SpecialFolder] ) | 
	Select-object @{ n = "Name"; e = { $_ } },
	@{ n = "Pfad"; e = { [environment]::getfolderpath( $_ ) } } | sort-object name
}
function spr { Get-Process $args | Stop-Process }

function us{ec $env:USERNAME}
function x { exit }


set-alias gr findstr

. $prof_home\git.ps1
. $prof_home/$cf.ps1

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
