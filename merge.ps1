$homet = 'Z:\home\tk'

$pfad = $homet + '/bewerbung'
$out = "$pfad/app.pdf"

$arguments = $(Get-ChildItem $pfad | ForEach-Object { $_.Name }) -join ","

Write-Output 'Argumente und Out ' $arguments, $out

# Invoke-Expression ("merge-pdf {0} -outputfile {1}" -f ($arguments, $out))
