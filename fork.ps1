#! /bin/bash

$repogit = $args
$repogit = 'AlexZeitler/posh-git-alias'
$user,$repo = $repogit.Split('/')

$cl_maintainer = "https://github.com/$user/$repo.git"
$cl = "https://github.com/tik9/$repo.git"

# Write-Output $user

# git clone $cl $home_wsl/$repo
# repo=${repo:0:-4}
# Set-Location $home_wsl/$repo
git remote add upstream $cl_maintainer
# git pull upstream master

#~ git checkout -b branch

#~ git push origin branch
