$hostname=[System.Net.Dns]::GetHostByName((hostname)).HostName 
$file='Microsoft.PowerShell_profile.ps1'
if ($hostname.contains('tik')) {
. "C:\Users\User\Documents\WindowsPowerShell/$file"
} else {
    . "/home/tk/.config/powershell/$file"
}