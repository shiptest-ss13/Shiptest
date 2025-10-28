//spears
/obj/item/melee/spear
	icon_state = "spearglass"
	icon = 'icons/obj/weapon/spear.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "spear"
	desc = "A haphazardly-constructed yet still deadly weapon of ancient design."
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 4
	embedding = list("impact_pain_mult" = 2, "remove_pain_mult" = 4, "jostle_chance" = 2.5)
	armour_penetration = 10
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "tore", "lacerated", "gored")
	sharpness = SHARP_EDGED
	wound_bonus = -15
	bare_wound_bonus = 15
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	species_exception = list(/datum/species/kepori)
	var/icon_prefix = "spearglass"
	var/force_wielded = 18
	demolition_mod = 0.75

/obj/item/melee/spear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
	AddComponent(/datum/component/jousting, max_tile_charge = 9, min_tile_charge = 6)
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = force_wielded, icon_wielded = "[icon_prefix]_w")

/obj/item/melee/spear/update_icon_state()
	icon_state = "[icon_prefix]"
	return ..()

/obj/item/melee/spear/CheckParts(list/parts_list)
	var/obj/item/shard/tip = locate() in parts_list
	if (istype(tip, /obj/item/shard/plasma))
		throwforce = 21
		force_wielded = 19
		icon_prefix = "spearplasma"
		AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = force_wielded, icon_wielded = "[icon_prefix]_w")
	update_appearance()
	qdel(tip)
	..()

/*
 * Bone Spear
 */
/obj/item/melee/spear/bone	//Blatant imitation of spear, but made out of bone. Not valid for explosive modification.
	icon_state = "bone_spear"
	name = "bone spear"
	base_icon_state = "bone_spear"
	icon_prefix = "bone_spear"
	desc = "A haphazardly-constructed yet still deadly weapon. The pinnacle of modern technology."
	//this should be a plasma spear or worse.
	force = 11
	throwforce = 19
	force_wielded = 17

/obj/item/melee/spear/explosive
	name = "explosive lance"
	icon_state = "spearbomb"
	base_icon_state = "spearbomb"
	icon_prefix = "spearbomb"
	var/obj/item/grenade/explosive = null
	var/war_cry = "AAAAARGH!!!"

/obj/item/melee/spear/explosive/Initialize(mapload)
	. = ..()
	set_explosive(new /obj/item/grenade/iedcasing/spawned()) //For admin-spawned explosive lances

/obj/item/melee/spear/explosive/proc/set_explosive(obj/item/grenade/G)
	if(explosive)
		QDEL_NULL(explosive)
	G.forceMove(src)
	explosive = G
	desc = "A makeshift spear with [G] attached to it"

/obj/item/melee/spear/explosive/CheckParts(list/parts_list)
	var/obj/item/grenade/G = locate() in parts_list
	if(G)
		var/obj/item/melee/spear/lancePart = locate() in parts_list
		var/datum/component/two_handed/comp_twohand = lancePart.GetComponent(/datum/component/two_handed)
		if(comp_twohand)
			var/lance_wielded = comp_twohand.force_wielded
			var/lance_unwielded = comp_twohand.force_unwielded
			AddComponent(/datum/component/two_handed, force_unwielded=lance_unwielded, force_wielded=lance_wielded)
		throwforce = lancePart.throwforce
		icon_prefix = lancePart.icon_prefix
		parts_list -= G
		parts_list -= lancePart
		set_explosive(G)
		qdel(lancePart)
	..()

/obj/item/melee/spear/explosive/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to set your war cry.")

/obj/item/melee/spear/explosive/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you want your war cry to be? You will shout it when you hit someone in melee.", ,"", 50)
			if(input)
				src.war_cry = input

/obj/item/melee/spear/explosive/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		user.say("[war_cry]", forced="spear warcry")
		explosive.forceMove(AM)
		explosive.prime()
		qdel(src)
