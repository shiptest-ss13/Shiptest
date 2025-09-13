#define MAIN_MODULE_PA "mainmodulepa"
#define PASSIVE_MODULE_PA "passivemodulepa"

/obj/item/pa_module
	name = "circuit board"
	icon = 'icons/obj/module.dmi'
	icon_state = "circuit_map"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	
	#warn doc
	var/class_type = MAIN_MODULE_PA
	var/list/actions_modules = null
	var/zone = null
	var/obj/item/power_armor/part_pa = null

/obj/item/pa_module/proc/added_to_pa()
	return

/obj/item/pa_module/proc/removed_from_pa()
	return

/obj/item/pa_module/Initialize(mapload)
	. = ..()
	for(var/i in actions_modules)
		actions_modules -= i
		actions_modules += new i(src)

/obj/item/pa_module/Destroy(force)
	. = ..()
	QDEL_LIST(actions_modules)

/obj/item/pa_module/minimap
	name = "Circuit board minimap"
	zone = BODY_ZONE_HEAD
