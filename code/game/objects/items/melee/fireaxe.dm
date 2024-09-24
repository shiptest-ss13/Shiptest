/obj/item/melee/axe
	icon = 'icons/obj/weapon/axe.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	force = 5
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	species_exception = list(/datum/species/kepori)
	var/wielded = FALSE // track wielded status on item

/obj/item/melee/axe/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/melee/axe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=24, icon_wielded="[base_icon_state]1")

/// triggered on wield of two handed item
/obj/item/melee/axe/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/melee/axe/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/axe/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/melee/axe/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(wielded) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.obj_destruction("axe")

/obj/item/melee/axe/fire  // DEM AXES MAN, marker -Agouri
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	icon_state = "fireaxe0"
	base_icon_state = "fireaxe"

/obj/item/melee/axe/bone  // Blatant imitation of the fireaxe, but made out of bone.
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	icon_state = "bone_axe0"
	base_icon_state = "bone_axe"

/obj/item/melee/axe/scrap
	name = "scrap axe"
	desc = "Oversided and with a pretty dull blade, its decent against armour"
	armour_penetration = 10

/obj/item/melee/axe/scrap/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=22, icon_wielded="[base_icon_state]1")
