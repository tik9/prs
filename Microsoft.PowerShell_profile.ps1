# https://gist.github.com/timsneath/19867b12eee7fd5af2ba

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

$up = $env:userprofile

$ca = "$zsh_cu/plugins/common-aliases/common-aliases.plugin.zsh"
$cs = "$up\AppData\Roaming\Code\User\"
$lw = '\\Laptopweiss\c'
$myd = [Environment]::GetFolderPath("MyDocuments")

$prof_home = "$up/documents/WindowsPowerShell"

$wsl = '\\wsl$\debian'
$home_wsl = "$wsl/home/tk"

$zsh_cu = "$home_wsl/.oh-my-zsh/custom"

function cv { cd z:/home/tk/cv }

# set-location
. $prof_home/gemeinsam.ps1
# code
function co { code $args }

# choco
function ch { choco -? | more }
function coi { choco list --local-only }
function coo { choco outdated ; choco upgrade all }

function af { Get-ChildItem function: | Format-List | more }

function af2 { Get-ChildItem function: | Format-List }
function al { get-alias | format-list | more }

function al2 { get-alias | format-list }

function bg() { Start-Process -NoNewWindow @args }

function c { get-content $args }

function com { wmic computersystem get model, name, manufacturer, systemtype }

function d { (Get-Command $args).Definition }
function dela { Remove-Item alias:$args }
function driv {	Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n = "Root"; e = { if ($null -eq $_.DisplayRoot ) { $_.Root } else { $_.DisplayRoot } } } }

function ds { displayswitch.exe /external } # 2 verwenden
function e { . $profile }
function get_reg {
	$reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters/"
	$reg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" # .ReleaseId
	Get-ItemProperty -Path $reg
}

function fin {	Get-ChildItem c:/ -Filter $args[0] -Recurse | Select-Object -First 1 }

function gim {	Get-InstalledModule | Format-List | more }

function map_net { net use z: $wsl }
 
function map { New-PSDrive -Name 'y' -Root $lw -Persist -PSProvider "FileSystem" }

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

function x { exit }

set-alias ec echo
set-alias g git
set-alias gr findstr
set-alias l gci
set-alias pw pwd

. $prof_home\git_alias.ps1

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
