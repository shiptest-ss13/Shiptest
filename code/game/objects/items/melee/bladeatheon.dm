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
	attack_verb =  list("pierced", "swipe", "slash", "chop")

/obj/item/melee/sword/pedang/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/sword/pedang/ComponentInitialize()
	. = ..()
	AddComponent( \
		/datum/component/transforming/charged, \
		force_on = 15, \
		throwforce_on = 20, \
		_allowed_cells = list(/obj/item/stock_parts/cell/melee/pedang), \
		_preload_cell_type = /obj/item/stock_parts/cell/melee/pedang, \
		_cell_hit_cost = 1000, \
		_can_remove_cell = TRUE, \
	)

/obj/item/melee/sword/pedang/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/stock_parts/cell/melee
	maxcharge = 5000

/obj/item/stock_parts/cell/melee/pedang
	name = "compact pedang cell"
