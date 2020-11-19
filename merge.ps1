$pfad = 'C:\Users\User\Documents\download'
$out = "$pfad/gericht_olg.pdf"

$arguments = $(Get-ChildItem $pfad | ForEach-Object { $_.Name }) -join ","

Write-Output $arguments

Invoke-Expression ("merge-pdf {0} -outputfile {1}" -f ($arguments, $out))
