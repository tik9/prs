# https://gist.github.com/timsneath/19867b12eee7fd5af2ba
# git log -1 --date=format:"%Y/%m/%d %T" --format="%ad"

# $hostname = $(hostname)

$hw = '/home/tk'
$ho = $hw
$ph = "$ho/.config/powershell"

if ($hostname.contains('tik')) {
	# $ho = $env:userprofile

	$wsl = '\\wsl$\debian'
	$hw = "$wsl/$hw"
	$ho='c:/users/user'
	$ph = "$ho/Documents/WindowsPowerShell"
}

$o = "$ho/.oh-my-zsh/custom"

$be = "$ho/bewerbung"
$cf = "$PSScriptRoot/common_functions.ps1"

$cv = "$ho/tik9.github.io.git"
$cy = "$ho/cpython"

$gt = "$ho/git"

$rt = "$ho/rest-test"
$ws = "$ho/workspace.code-workspace"

# ips
$root_ip='192.168.178'
$rasp_ip='root@$root_ip.36'

# node
function n { npm $args }
function no { node $args }
function nog { npm i -g $args }
function noi { npm i $args }
function nr { npm run $args }

# choco
function chi { choco install $args }
function coi { choco list --local-only }
function coo { choco outdated ; choco upgrade all }

function a { displayswitch.exe /external } # 2 verwenden

function c { get-content $args }

function co { code $args }
function chr { Start-Process chrome.exe $args }
function cph { cp '/root/.config/powershell/Microsoft.PowerShell_profile.ps1' '/home/tk/.config/powershell' }
function cu {
	$url = 'http://192.168.178.36/cgit/doks.git/tree/<foo>.md'
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

function Get-Size {
 param([string]$pth)
 "{0:n0}" -f ((Get-ChildItem -path $pth -recurse | measure-object -property length -sum).sum / 1mb) + " mb"
}
function hif { Get-History | Format-List }
 
function le { more $args }
function l { ls }
function ll { ls | more }

function m {$args|more}
function pa { [System.Environment]::GetEnvironmentVariable("Path", "Machine") }

function prid {
	$prid = 35729
	# $prid=$args
	Get-Process -Id (Get-NetTCPConnection -LocalPort $prid).OwningProcess | Stop-Process
}

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
	$video = Get-CimInstance -Class CIM_VideoControllerResolution
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
function w { wsl }
function x { exit }

set-alias gr findstr
set-alias p pwsh

. $PSScriptRoot\git.ps1
. $cf

Import-Module $PSScriptRoot/posh-git\src\posh-git.psd1

# Write-Output '12'
$PSCommandPath
