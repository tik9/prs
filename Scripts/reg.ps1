$reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters/"

Get-ItemProperty -Path $reg

# Ergebnis: %SystemRoot%\System32\drivers\etc