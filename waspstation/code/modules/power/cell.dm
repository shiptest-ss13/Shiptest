/obj/item/stock_parts/cell/gun
	name = "weapon power cell"
	icon = 'waspstation/icons/obj/power.dmi'
	icon_state = "g-cell"
	maxcharge = 10000
	custom_materials = list(/datum/material/glass=60)
	chargerate = 1500

/obj/item/stock_parts/cell/gun/empty/Initialize()
	. = ..()
	charge = 0
	update_icon()

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

/obj/item/stock_parts/cell/gun/upgraded
	name = "upgraded weapon power cell"
	icon_state = "ug-cell"
	maxcharge = 20000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 2000

/obj/item/stock_parts/cell/gun/upgraded/empty/Initialize()
	. = ..()
	charge = 0
	update_icon()

/obj/item/stock_parts/cell/gun/mini
	name = "miniature weapon power cell"
	icon_state = "mg-cell"
	maxcharge = 5000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 1000

/obj/item/stock_parts/cell/gun/mini/empty/Initialize()
	. = ..()
	charge = 0
	update_icon()

/obj/item/stock_parts/cell/gun/mini/update_icon()
	cut_overlays()
	if(grown_battery)
		. += mutable_appearance('icons/obj/power.dmi', "grown_wires")
	if(charge < 0.01)
		return
	else if(charge/maxcharge >=0.995)
		add_overlay("mg-cell-o2")
	else
		add_overlay("mg-cell-o1")
