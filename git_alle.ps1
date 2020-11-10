$commit = 'Newest commit'

function gi_do ($verz) {
    Set-Location $verz.FullName
    Write-Output "\n[**** update Git: " $verz.fullname
    # git status
    # git pull
    git add .
    git commit -am $commit
    git push
}

$gd_find = Get-ChildItem $home_wsl -exclude '.*' -directory
# $gd_find
# exit
# Write-Output $home_wsl

foreach ($verz in $gd_find) {
    # Write-Output dire $(Get-ChildItem $verz)
    if ('.git' -in (Get-ChildItem -Path $verz).name) {
        # Write-Output verz $verz
        # gi_do $verz
    }
}

$ar = 
# $cs, 
$prof_home, $zsh_cu
,$doks

foreach ($elem in $ar) {
    $verz = Get-Item $elem
    # Write-Output $verz
    gi_do $verz
}

Set-Location $home_wsl