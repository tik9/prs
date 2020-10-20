$processes = Get-Process "*docker desktop*"
echo $processes

if ($processes.Count -gt 0)
{
    $processes[0].Kill()
    $processes[0].WaitForExit()
}
#Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"

Get-Process "*docker desktop*"

# docker ps -q | % { docker stop $_ }