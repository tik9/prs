# https://gist.github.com/timsneath/19867b12eee7fd5af2ba


$wsl = '\\wsl$\debian'
$hw='/home/tk'
#$hw = "$wsl/$hw"

$o = "$hw/.oh-my-zsh/custom"

$ca = "$o/plugins/common-aliases/common-aliases.plugin.zsh"
$cf = "$PSScriptRoot/common_functions.ps1"

$cs = "$ho\AppData\Roaming\Code\User\"

$cv = "$hw/tik9.github.io.git"
$cy = "$hw/cpyth"
$ga = "$hw/game"

$gt = "$hw/git"
$ho = $env:userprofile

$ph = $PSScriptRoot


# choco
function ch { choco -? | more }
function chi { choco install $args }
function coi { choco list --local-only }
function coo { choco outdated ; choco upgrade all }
function cr { choco uninstall $args }

function a { displayswitch.exe /external } # 2 verwenden

function c { get-content $args }

function chr { Start-Process chrome.exe $args }
function com { wmic computersystem get model, name, manufacturer, systemtype }

function cu {
	$url = 'http://192.168.178.36/cgit/doks.git/tree/arbeiten_haus.md'
	$url = $args
	Invoke-WebRequest  -UseBasicParsing $url
}

function d { (Get-Command $args).Definition }
function dela { Remove-Item alias:$args }
function driv {	Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n = "Root"; e = { if ($null -eq $_.DisplayRoot ) { $_.Root } else { $_.DisplayRoot } } } }


function e { . $profile }
function ec { Write-Output $args }

function fin {	Get-ChildItem c:/ -Filter $args[0] -Recurse | Select-Object -First 1 }

function finstr { Get-ChildItem -Recurse | Select-String -Pattern $args | Select-Object -Unique Path }

function hif { Get-History | Format-List }
function map_net { net use z: $wsl }
 
function map { New-PSrive -Name 'y' -Root $lw -Persist -PSProvider "FileSystem" }

function le { more $args }


function pa { [System.Environment]::GetEnvironmentVariable("Path", "Machine") }

function pm { shutdown.exe /h }

function prompt {
	$gl = Get-Location
	#$verbindung = $(Get-NetConnectionProfile).name
	write-host "PS [$Env:username] $gl >" -NoNewline
	return " "
}

function pwcf {
	#hibern=2
	#nothing=0

	powercfg -SETACVALUEINDEX 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 $args
	powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
}

function q {
	$dat_te = 'http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
	$a = Get-Date
	Invoke-WebRequest $dat_te -UseBasicParsing | Out-Null; "$((10/((Get-Date)-$a).TotalSeconds)*8) Mbps"
}
function res {
	$video = Get-WmiObject -Class CIM_VideoControllerResolution
	$video[-1] | Select-Object Caption
}
function run_adm { Start-Process "powershell" -Verb RunAs }

function ser { Get-Service | Where-Object { $_.status -eq 'running' } | findstr $args }

function spr { Get-Process $args | Stop-Process }

function update {
	Get-HotFix | Where-Object { $_.InstalledOn -gt ((Get-Date).AddDays(-30)) }
	(New-Object -com "Microsoft.Update.AutoUpdate"). Results | Format-List
}
function upd {
	$Session = New-Object -ComObject Microsoft.Update.Session 
	$Searcher = $Session.CreateUpdateSearcher()
	$HistoryCount = $Searcher.GetTotalHistoryCount()
	# http://msdn.microsoft.com/en-us/library/windows/desktop/aa386532%28v=vs.85%29.aspx
	$Searcher.QueryHistory(0, $HistoryCount) | ForEach-Object { $_ }
}

function vse { Write-Output $(code --list-extensions) | Out-File extensions.txt }
function x { exit }

set-alias gr findstr

. $PSScriptRoot\git.ps1
. $cf

Import-Module $PSScriptRoot/posh-git\src\posh-git.psd1
