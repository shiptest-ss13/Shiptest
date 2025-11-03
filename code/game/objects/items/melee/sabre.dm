
/obj/item/melee/sword/sabre
	name = "officer's sabre"
	desc = "An elegant weapon, its monomolecular edge is capable of cutting through flesh and bone with ease."
	icon_state = "sabre"
	item_state = "sabre"
	force = 25
	throwforce = 10
	block_chance = 30
	armour_penetration = 75
	wound_bonus = 10
	bare_wound_bonus = 25
	attack_verb = list("slashed", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/sword/sabre/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/sword/sabre/solgov
	name = "solarian sabre"
	desc = "A refined ceremonial blade often given to soldiers and high ranking officials of SolGov."
	icon_state = "sabresolgov"
	item_state = "sabresolgov"

/obj/item/melee/sword/sabre/suns
	name = "SUNS sabre"
	desc = "A blade of Solarian origin given to SUNS followers."
	icon_state = "suns-sabre"
	item_state = "suns-sabre"

/obj/item/melee/sword/sabre/suns/captain
	name = "SUNS captain sabre"
	desc = "An elegant blade awarded to SUNS captains. Despite its higher craftmanship, it appears to be just as effective as a normal sabre."
	icon_state = "suns-capsabre"
	item_state = "suns-capsabre"

/obj/item/melee/sword/sabre/suns/cmo
	name = "SUNS stick sabre"
	desc = "A thin blade used by SUNS medical instructors."
	icon_state = "suns-swordstick"
	item_state = "suns-swordstick"

/obj/item/melee/sword/sabre/pgf
	name = "\improper boarding cutlass"
	desc = "When beam and bullet puncture the hull, a trustworthy blade will carry you through the fight"
	icon_state = "pgf-sabre"
	block_chance = 15
	force = 28
	demolition_mod = 1.25
	attack_cooldown = 6


/obj/item/melee/sword/sabre/suns/telescopic
	name = "telescopic sabre"
	desc = "A telescopic and retractable blade given to SUNS peacekeepers for easy concealment and carry. It's design makes it slightly less effective than normal sabres sadly, however it is still excelent at piercing armor."
	icon_state = "suns-tsword"
	item_state = "suns-tsword"
	force = 0
	throwforce = 0
	block_chance = 0

	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("smacked", "prodded")

	var/extend_sound = 'sound/weapons/batonextend.ogg'

	var/on_block_chance = 40

/obj/item/melee/sword/sabre/suns/telescopic/ComponentInitialize()
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 10, \
		throwforce_on = 10, \
		attack_verb_on = list("slashed", "cut"), \
		w_class_on = WEIGHT_CLASS_BULKY, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/sword/sabre/suns/telescopic/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		block_chance = on_block_chance
	else
		block_chance = initial(block_chance)
	playsound(user, extend_sound, 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE
