/obj/item/melee/axe
	icon = 'icons/obj/weapon/axe.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	force = 5
	throwforce = 15
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_cooldown = HEAVY_WEAPON_CD
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = list('sound/weapons/melee/heavyaxe_hit1.ogg', 'sound/weapons/melee/heavyaxe_hit2.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20
	species_exception = list(/datum/species/kepori)
	var/force_wielded = 25

/obj/item/melee/axe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , 'sound/weapons/bladeslice.ogg') //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = force_wielded, icon_wielded="[base_icon_state]_w")

/obj/item/melee/axe/update_icon_state()
	icon_state = "[base_icon_state]"
	return ..()

/obj/item/melee/axe/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED)) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.atom_destruction("axe")

/obj/item/melee/axe/fire
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	icon_state = "fireaxe"
	base_icon_state = "fireaxe"
	force_wielded = 30

/obj/item/melee/axe/bone  // Blatant imitation of the fireaxe, but made out of bone.
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	icon_state = "bone_axe"
	base_icon_state = "bone_axe"
