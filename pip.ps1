# alias pip=pip3
function pli { pip list | more }
function pi { pip install $args }
function plo { pip list --outdated }
function pre { pip uninstall $args }
function python { python3 }
function pipu {
    pip freeze | % { $_.split('==')[0] } | % { pip install --upgrade $_ }

}