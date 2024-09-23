/obj/item/clothing/shoes/blade_skates
	name = "bladeatheon skates"
	desc = "wip."
	icon_state = "iceboots" //Need sprites
	item_state = "iceboots"
	clothing_flags = NOSLIP_ICE
	lace_time = 12 SECONDS

/obj/item/melee/fimbo_stick
	name = "fimbo"

/obj/item/melee/sword/pedang
	name = "pedang"
	desc = "an electrically-charged fencing sword."
	icon_state = "suns-tsword"

	var/allowed_cells = list(/obj/item/stock_parts/cell/pedang)
	var/preload_cell_type = /obj/item/stock_parts/cell/pedang //if not empty the sabre starts with this type of cell
	var/cell_hit_cost = 1000
	var/activate_sound = "sparks"

/obj/item/stock_parts/cell/pedang
	name = "compact pedang cell"
