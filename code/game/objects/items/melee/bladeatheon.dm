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

	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell/pedang //if not empty the sabre starts with this type of cell
	var/cell_hit_cost = 1000
	var/can_remove_cell = TRUE

	var/turned_on = FALSE
	var/activate_sound = "sparks"

/obj/item/stock_parts/cell/pedang
	name = "compact pedang cell"

/obj/item/melee/sword/pedang/Initialize()
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	update_appearance()

/obj/item/melee/sword/pedang/Destroy()
	if(cell)
		QDEL_NULL(cell)
	UnregisterSignal(src, COMSIG_PARENT_ATTACKBY)
	return ..()

/obj/item/melee/baton/examine(mob/user)
	. = ..()
	if(cell)
		. += span_noitce("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

