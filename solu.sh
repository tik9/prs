#! /bin/bash

verz=$(dirname "$0")

dat=$verz/angular.md
# echo $verz $dat

mapfile -t lines < "$dat"
# echo "${!lines[@]}"

as=(0 3 4 3 2 3 1 2 1 4 3 2 2 3 1 3 2 1 2)
counta=0
countq=0
for i in "${!lines[@]}"; do
    li=${lines[i]}
    if [[ ! $li =~ [^[:space:]] ]] ; then
        continue
    fi

    # if [ $i -eq 10 ]; then
    #     break
    # fi

    if [[ $li = *"##"* ]]; then 
     ((countq++)); 
     counta=0 
     continue
     fi
     ((counta++))

    al=${as[((countq))]}
    # al=${as[1]}

    if [[ $counta == $al ]] ;then
        
        li=${li:5}
        li="${li/\//\\/}"
        # li=$(echo "$li" | tr -d '\n')
        li2=$(tr -d '\n' <<< "$li")
        echo $li2

        # sed "s/$li/- [x]${li:5}/" $dat
    fi

    # echo 'countq: ' $countq 'counta: ' $counta ', al: ' $al 
    
done
