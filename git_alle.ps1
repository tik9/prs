$commit='Newest commit'

function gi_do ($dir_home) {
    Set-Location $dir_home
    Write-Output "update Git: " $dir_home
    git status
    # git pull
    # git add .
    # git commit -am $commit
    # git push
    Set-Location ..
}

$gd_find = Get-ChildItem $home_wsl -exclude '.*' -directory
# $cm_find
# exit

foreach ($dir_home in $gd_find) {
    if ('.git' -in (Get-ChildItem -Path $dir_home).Name) {
        # gi_do $dir_home
        # Write-Output verz $dir_home
    }
}

gi_do $prof_home
gi_do $zsh_cu