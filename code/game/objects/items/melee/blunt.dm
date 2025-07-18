/obj/item/melee/sledgehammer
	name = "sledgehammer"
	icon_state = "sledgehammer"
	base_icon_state = "sledgehammer"
	icon = 'icons/obj/weapon/blunt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	force = 5
	throwforce = 15
	armour_penetration = 40
	demolition_mod = 2
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_cooldown = 12
	attack_verb = list("bashed", "smashed", "crushed", "smacked")
	hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF

/obj/item/melee/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 30, icon_wielded="[base_icon_state]_w")

/obj/item/melee/sledgehammer/update_icon_state()
	icon_state = "[base_icon_state]"
	return ..()

/obj/item/melee/sledgehammer/gorlex
	icon_state = "gorlex_sledgehammer"
	base_icon_state = "gorlex_sledgehammer"
	name = "breaching sledgehammer"
	desc = "A large hammer used by the Gorlex Marauder splinters. As powerful as a weapon as it is a shipbreaking and mining tool."
	toolspeed = 0.5
	wall_decon_damage = MINERAL_WALL_INTEGRITY
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')

/obj/item/melee/sledgehammer/gorlex/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/melee/sledgehammer/gorlex/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	tool_behaviour = TOOL_MINING

/obj/item/melee/sledgehammer/gorlex/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	tool_behaviour = null

/obj/item/melee/sledgehammer/gorlex/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(!target.anchored)
		target.throw_at(throw_target, rand(1,2), 2, user, gentle = TRUE)

/obj/item/melee/sledgehammer/gorlex/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED)) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.obj_destruction("axe")
