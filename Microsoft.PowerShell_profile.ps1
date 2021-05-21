# https://gist.github.com/timsneath/19867b12eee7fd5af2ba
<#

c='less --quit-if-one-screen'
sv='zsh --version'

debian
debian apt-copy , apt-history usage
egrep -v '^#|^ *$' /etc/apt/sources.list /etc/apt/sources.list.d/*

zshrc
npm complete?

git
git config --System alias.ad 'add .' 
git config --System --replace-all core.pager "less -F -X"

user
st='su tk'
sg='su git'

common
function sv { ec $sv }

#>

$hostname = $(hostname)

$hw = '/home/tk'
$ho = $hw
$configpowershell = '.config/powershell'
$i = 'ifconfig'
$cu = '.config/Code/User'

if ($hostname.contains('tik')) {
	$cu = 'appdata/roaming/code/user'
	$ho = $env:userprofile
	$wsl = '\\wsl$\debian'
	$hw = "$wsl/$hw"
	$configpowershell = 'Documents/WindowsPowerShell'
	$i = 'ipconfig'
}
$cs = "$ho/$cu"
$ph = "$ho/$configpowershell"

$o = "$ho/.oh-my-zsh/custom"

$cv = "$ho/tik9.github.io"
$cy = "$ho/cpython"

$gt = "$ho/git"

$rt = "$ho/rest-test"
$sv=($PSVersionTable|Select-Object -ExpandProperty  psversion)

$ws = "$ho/workspace.code-workspace"

# ips
$root_ip = '192.168.178'
$rasp_ip = "$root_ip.36"
$termux_port = '-p8022'
$termux_ip = 38

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

function ds { displayswitch.exe /external } # 2 verwenden

function c { get-content $args }
function cr { get-content $profile }

function cc { $args | Set-Clipboard }
function chr { Start-Process chrome.exe $args }
function cph { Copy-Item "/home/tk/$configpowershell/Microsoft.PowerShell_profile.ps1" "/root/$configpowershell"; cr }
function cur {
	$url = "$rasp_ip/cgit/doks.git/tree/<foo>.md"
	Invoke-WebRequest $url
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

function m { $args | more }

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
Set-Alias w wsl
Set-Alias x  exit 

set-alias a Get-Alias
Set-Alias co code
set-alias gr findstr
set-alias pi 'ping 8.8.8.8'

. $PSScriptRoot\git.ps1
. "$ph/common_functions.ps1"

Import-Module $PSScriptRoot/posh-git\src\posh-git.psd1

"$PSCommandPath loaded"
