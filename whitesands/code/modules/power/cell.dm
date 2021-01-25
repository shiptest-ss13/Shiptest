/obj/item/stock_parts/cell/gun
	name = "weapon power cell"
	icon = 'whitesands/icons/obj/power.dmi'
	icon_state = "g-cell"
	maxcharge = 10000
	custom_materials = list(/datum/material/glass=60)
	chargerate = 1500
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/gun/empty/Initialize()
	. = ..()
	charge = 0
	update_icon()

/obj/item/stock_parts/cell/gun/update_icon()
	cut_overlays()
	if(grown_battery)
		. += mutable_appearance('icons/obj/power.dmi', "grown_wires")
	if(charge < 0.1)
		return
	else if(charge/maxcharge >=0.995)
		add_overlay("[initial(icon_state)]-o4")
	else if(charge/maxcharge >=0.745)
		add_overlay("[initial(icon_state)]-o3")
	else if(charge/maxcharge >=0.495)
		add_overlay("[initial(icon_state)]-o2")
	else
		add_overlay("[initial(icon_state)]-o1")

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

/obj/item/stock_parts/cell/gun/SolGov
	name = "SolGov power cell"
	icon = 'whitesands/icons/obj/power.dmi'
	icon_state = "g-cell"
	maxcharge = 8000
	custom_materials = list(/datum/material/glass=60)
	chargerate = 2000

/obj/item/stock_parts/cell/gun/large
	name = "extra-large weapon power cell"
	icon_state = "bg-cell"
	maxcharge = 50000
	custom_materials = list(/datum/material/glass=1000)
	chargerate = 5000
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/stock_parts/cell/gun/large/empty/Initialize()
	. = ..()
	charge = 0
	update_icon()
