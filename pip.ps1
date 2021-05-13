# alias pip=pip3
function pli { pip list | more }
function pi { pip install $args }
function plo { pip list --outdated }
function pre { pip uninstall $args }
function pu { pip install --upgrade $args }

function python { python3 }
function pipu {
    pip freeze | ForEach-Object { $_.split('==')[0] } | ForEach-Object { pip install --upgrade $_ }

}

"$PSCommandPath loaded"
