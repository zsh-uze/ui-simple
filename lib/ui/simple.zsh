ui/simple/menu/accelerator () {
	my:match
	print ${@//(#b)_(?)/${(e%)UI_ACCELERATOR_FMT:-'%B%F{red}$match[1]%f%b'}}
}

ui/simple/banner () {
	local label="$*"
	local long=$[2 + $#label ]
	print " ${(r:$[2 + $#label ]::_:):-}"
	print "│ $label │${(r:$[COLUMNS - ( $#label + 4 ) ]::_:):-}"
}

# * show the selected value
# * show error message and retry if accelerator isn't a valid one

ui/simple/menu/accelerator/choose () {
	while {true} {
        # fill $it with the selected accelerator
		menu/accelerator -n $@
		read -sk1 it;
        # _ch0seLen_ : the length of the line to be printed
        # _ch0seFind : index of the menu item for the accelerator
        # KNOWN BUG
        # if there is a menu item with with another accelerator
        # then it will be choosen
        # so _foo _bar_roo # accelerators are
        # f for foo and b for _bar_roo
        # but r is choosen anyway
        # WONTFIX: easy to work around :)
		local _ch0seLen_=${#:-"$*"} _ch0seFind=$@[(I)*_$it*]

		(( _ch0seFind  )) || {
            # if not, show an error message and show the menu again
			l -Pu2 "\r%F{red}${(r:$_ch0seLen_:):-$it not found}%f "
			continue
		}

        # show the found element (removing the rest of the line with padding)
        # and return (it is fill)
		print -P "\r%F{blue}${(r:$_ch0seLen_:: :)@[(r)*_$it*]/_/}%f "
		return
	}
}




uze/export/ui/simple () {
    EXPORT_TAGS=(
        :all 'menu/accelerator banner'
    )
}


