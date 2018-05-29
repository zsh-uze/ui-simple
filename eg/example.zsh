# should be combined with zle!

uze ui/simple :all

banner "The question"
l
menu/accelerator -l \
    "to _be" \
    "or _not to be"
read -sk1 it
case $it {
    b) l "good!" ;;
    n) l "well ... your choice" ;;
}

