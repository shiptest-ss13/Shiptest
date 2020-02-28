/obj/item/stock_parts/cell/gun/update_icon()
	cut_overlays()
	if(grown_battery)
		. += mutable_appearance('icons/obj/power.dmi', "grown_wires")
	if(charge < 0.01)
		return
	else if(charge/maxcharge >=0.995)
		add_overlay("g-cell-o2")
	else
		add_overlay("g-cell-o1")
