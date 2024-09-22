/obj/item/melee/charged
	force = 0
	var/active_force = 10

	var/obj/item/stock_parts/cell/cell
	var/allowed_cells = list()
	var/preload_cell_type = /obj/item/stock_parts/cell/melee //if not empty the sabre starts with this type of cell
	var/cell_hit_cost = 1000
	var/activate_sound = "sparks"

/obj/item/melee/charged/Initialize()
	. = ..()
	if(preload_cell_type)
		if(preload_cell_type in allowed_cells)
			cell = new preload_cell_type(src)

/obj/item/melee/charged/ComponentInitialize()
	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/charged/Destroy()
	if(cell)
		QDEL_NULL(cell)
	return ..()

/obj/item/melee/charged/proc/on_transform()
	SIGNAL_HANDLER

	playsound(src, activate_sound, 75, TRUE, -1)

/obj/item/melee/charged/proc/deductcharge(chrgdeductamt)
	if(cell)
		//Note this value returned is significant, as it will determine
		//if a stun is applied or not
		. = cell.use(chrgdeductamt)
		if(turned_on && cell.charge < cell_hit_cost)
			//we're below minimum, turn off
			SEND_SIGNAL(src, COSMIG_ITEM_FORCE_TRANSFORM, src)
			update_appearance()
			playsound(src, activate_sound, 75, TRUE, -1)

/obj/item/melee/charged/update_icon_state()
	if(turned_on)
		icon_state = "[initial(icon_state)]_on"
		return ..()
	if(!cell)
		icon_state = "[initial(icon_state)]_nocell"
		return ..()
	icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/melee/charged/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/melee/charged/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, span_notice("[src] already has a cell!"))
		else
			if(C.maxcharge < cell_hit_cost)
				to_chat(user, span_notice("[src] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You install a cell in [src]."))
			update_appearance()
	else
		return ..()

/obj/item/melee/charged/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(cell && can_remove_cell)
		cell.update_appearance()
		cell.forceMove(get_turf(src))
		cell = null
		to_chat(user, span_notice("You remove the cell from [src]."))
		turned_on = FALSE
		update_appearance()
