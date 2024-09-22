/obj/item/clothing/shoes/blade_skates
	name = "bladeatheon skates"
	desc = "wip."
	icon_state = "iceboots" //Need sprites
	item_state = "iceboots"
	clothing_flags = NOSLIP_ICE
	lace_time = 12 SECONDS

/obj/item/melee/fimbo_stick
	name = "fimbo"

/obj/item/melee/charged/pedang
	name = "pedang"
	desc = "an electrically-charged fencing sword."
	icon = 'icons/obj/weapon/sword.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "suns-tsword"

	pickup_sound =  'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/handling/metal_drop.ogg'
	hitsound = 'sound/weapons/bladeslice.ogg'

	allowed_cells = list(/obj/item/stock_parts/cell/pedang)
	preload_cell_type = /obj/item/stock_parts/cell/pedang //if not empty the sabre starts with this type of cell
	cell_hit_cost = 1000

	var/activate_sound = "sparks"

/obj/item/stock_parts/cell/pedang
	name = "compact pedang cell"
