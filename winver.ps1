(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId

[System.Environment]::OSVersion.Version

Get-WmiObject -Class win32_operatingsystem