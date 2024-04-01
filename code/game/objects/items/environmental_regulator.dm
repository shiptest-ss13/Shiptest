/obj/item/environmental_regulator
	name = "environmental regulator"
	desc = "A back-mounted machine designed to aid carbon lifeforms in regulating their body temperature."
	icon = 'icons/obj/vox_items.dmi'
	icon_state = "thermo"
	mob_overlay_state = "thermoback"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/smash.ogg'
	pressure_resistance = ONE_ATMOSPHERE * 5
	force = 5
	throwforce = 10
	throw_speed = 1
	throw_range = 4
	custom_materials = list(/datum/material/iron = 500)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 30)
	supports_variations = VOX_VARIATION

	var/mob/living/owner

/obj/item/environmental_regulator/Destroy()
	owner = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/environmental_regulator/equipped(mob/user, slot, initial)
	. = ..()
	switch(slot)
		if(ITEM_SLOT_BACK, ITEM_SLOT_SUITSTORE)
			START_PROCESSING(SSobj, src)
			owner = user
		else
			owner = null

/obj/item/environmental_regulator/dropped(mob/user, silent)
	. = ..()
	owner = null

/obj/item/environmental_regulator/process()
	if(!owner)
		STOP_PROCESSING(SSprocessing, src)
		return

	if(IS_IN_STASIS(owner))
		return

	if(owner.bodytemperature >= HUMAN_BODYTEMP_NORMAL)
		owner.adjust_bodytemperature(-6, HUMAN_BODYTEMP_NORMAL)
	else
		owner.adjust_bodytemperature(6, HUMAN_BODYTEMP_NORMAL)
