# https://gist.github.com/timsneath/19867b12eee7fd5af2ba

# $(Get-NetConnectionProfile).name

<#
# if [[ $HOST == tik ]];then ;alias -s pdf=sumatrapdf.exe
# else alias -s pdf=qpdfview;fi

debian

git
# function gdl { git diff $1 }
# function gdw { git diff $args }

# function psh { pip show $1 }

zshrc

common

# function psh { pip show $1 }

#>


$hostname = $(hostname)

$hw = '/home/tk'
$config = '.config'
$configpowershell = "$config/powershell"
$cu = "$config/Code/User"
$ho = $hw
$user = $env:USER
$ws = "$ho/$config/Code/Workspaces/1619293380488/workspace.json"

if ($hostname.contains('tik')) {
	$configpowershell = 'Documents/WindowsPowerShell'
	$cu = 'appdata/roaming/code/user'
	$ho = $env:userprofile
	$user = $env:username
	$wsl = '\\wsl$\debian'
	$hw = "$wsl/$hw"
	$ws = "$ho/workspace.code-workspace"

}
$cs = "$ho/$cu"
$ph = "$ho/$configpowershell"

$o = "$ho/.oh-my-zsh/custom"

$cv = "$ho/tik9.github.io"
$cy = "$ho/cpython"

$gt = "$ho/gman"

function psversion {
	if ($PSVersionTable == '7') {

		$sv = $PSVersionTable | Select-Object -ExpandProperty  psversion
	}
	else {
		$sv = $PSVersionTable
	}
}


# ips
$root_ip = '192.168.178'
$rasp_ip = "$root_ip.36"
$termux_ip = "$root_ip.38 -p8022"

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


function c { get-content $args }

function cc { $args | Set-Clipboard }

function d { 
	if ($args) {
		(Get-Command $args).Definition 
 }
}	
function dela { Remove-Item alias:$args }

function dn2 { Write-Output exit | nslookup | findstr ":" }

function dn1 {
	Get-NetAdapter -Name "Ethernet 9" | Set-DnsClientServerAddress -ServerAddresses 192.168.178.1
}
function ds { displayswitch.exe /external } # 2 verwenden

function ec { Write-Output $args }

function Get-Size {
 param([string]$pth)
 "{0:n0}" -f ((Get-ChildItem -path $pth -recurse | measure-object -property length -sum).sum / 1mb) + " mb"
}
function hif { Get-History | Format-List }
 
function le { more $args }
function l { Get-ChildItem $args }
function ll { Get-ChildItem $args | more }

function pm { shutdown.exe /h }

function prompt {
	$gl = Get-Location
	write-host "PS [$user] $gl >" -NoNewline
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


set-alias a Get-Alias
Set-Alias co code
Set-Alias dns Get-DNSClientServerAddress
set-alias gr findstr
set-alias i ipconfig
set-alias pi 'ping 8.8.8.8'
set-alias pic '[Environment]::GetFolderPath("Mypictures")'
Set-Alias w wsl
set-alias s start-process

Set-Alias x  exit 


. $PSScriptRoot\git.ps1
. "$ph/common_functions.ps1"

Import-Module $PSScriptRoot/posh-git\src\posh-git.psd1

"$PSCommandPath loaded"
