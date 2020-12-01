(Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes' |
    Where-Object { (Get-ItemProperty $_.PSPath).CanonicalName -match '\.S' }).PSChildname | ForEach-Object {
    $SRPath = "HKLM:\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell\$_"
    new-item -Path $SRPath
    New-ItemProperty -Path $SRPath -Name 'Mode' -Value 4
}