echo $args argumente

$verz='Z:\home\tk\cv'
$out = 'output'
$out=''

$datei=gci $verz |sort LastWriteTime| select -last 1

# $datei= $args
$neu = $datei  -replace ".{3}$"
$neu
$md=gci "$verz/$neu.md"

$htm="$verz/$out/$neu.html"
# $md
# $htm
pandoc.exe -s $md.fullname -o $htm
Start-Process chrome.exe $htm