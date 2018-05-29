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

uze/export/ui/simple () {
    EXPORT_TAGS=(
        :all 'menu/accelerator banner'
    )
}


