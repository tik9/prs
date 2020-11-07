function ga {  git add --all}

function gcam { git commit -a -m $1 }
function gcam_ps { git commit -a -m $args}

function gd { git diff }
function gdc { git diff --cached }

function gg { git log }

function gi {
    ga
    gcam $1
    gpu
}

function gll { git pull }
function glg { git log --stat }
function glum { git pull upstream master }
function gm { git commit -m }

function gpu {  git push }

function gs { git status }
function gsh { git show }

function gsq {
    # Reset the current branch to the commit just before the last 12:
git reset --hard HEAD~2

# HEAD@{1} is where the branch was just before the previous command.
# This command sets the state of the index to be as it would just
# after a merge from that commit:
git merge --squash HEAD@{1}
git commit
}