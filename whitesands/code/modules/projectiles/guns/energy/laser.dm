/obj/item/gun/energy/laser/terra
	name = "SolGov laser rifle"
	desc = "A laser rifle used by SolGov's cannon fodder. Has a self-recharging cell but only 6 shots before needing to recharge."
	icon_state = "terralaser"
	item_state = "laser"
	w_class = WEIGHT_CLASS_NORMAL
	flags_1 =  CONDUCT_1
	selfcharge = 1
	cell_type = /obj/item/stock_parts/cell/gun/mini
	internal_cell = TRUE
	charge_delay = 1 //50 seconds to recharge the clip

/obj/item/gun/energy/laser/iot
	name = "ESG 2555 Ultimate"
	desc = "An energy shotgun with surveillance and statistics managing systems.\nApparently used to better inform command on how soldiers operate.\nRealistically used to compare kill counts and such."
	icon_state = "iotshotgun"
	item_state = "laser"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter)
