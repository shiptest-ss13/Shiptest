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

	force = 0
	var/active_force = 10

	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell/pedang //if not empty the sabre starts with this type of cell
	var/cell_hit_cost = 1000

	var/activate_sound = "sparks"

/obj/item/stock_parts/cell/pedang
	name = "compact pedang cell"

/obj/item/melee/sword/pedang/Initialize()
	. = ..()
	if(preload_cell_type)
		if(ispath(preload_cell_type, /obj/item/stock_parts/cell/pedang))
			cell = new preload_cell_type(src)

	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/sword/pedang/proc/on_transform()
	SIGNAL_HANDLER

	playsound(src, activate_sound, 75, TRUE, -1)

/obj/item/melee/sword/pedang/Destroy()
	if(cell)
		QDEL_NULL(cell)
	return ..()

/obj/item/melee/sword/pedang/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

