$verzeichnis='C:\'
$datei='ps.exe'
$datei='cmd.exe'

dir -Path $verzeichnis -Filter $datei -Recurse | %{$_.FullName}
