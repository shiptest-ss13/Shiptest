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
	demolition_mod = 2.5
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_cooldown = 12
	attack_verb = list("bashed", "smashed", "crushed", "smacked")
	hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	var/throw_min = 1
	var/throw_max = 2

/obj/item/melee/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 40, icon_wielded="[base_icon_state]_w")

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
		target.throw_at(throw_target, rand(throw_min,throw_max), 2, user, gentle = TRUE)

/obj/item/melee/sledgehammer/gorlex/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED)) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.atom_destruction("axe")

/obj/item/brass_knuckles
	name = "brass knuckles"
	icon_state = "brass_knuckles"
	base_icon_state = "brass_knuckles"
	icon = 'icons/obj/weapon/blunt.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	desc = "A pair of brass knuckles, fit for the common thug or stylish gangster. Can be carried in one hand but are most effective when wielded as a pair."
	force = 15
	wound_bonus = 10
	throwforce = 5
	demolition_mod = 1.25
	custom_price = 180
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_POCKETS
	attack_cooldown = LIGHT_WEAPON_CD
	attack_verb = list("punched", "wholloped", "hooked", "jabbed", "slammed")
	hitsound = list('sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg', 'sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg', 'sound/weapons/slap.ogg')
	pickup_sound = 'sound/weapons/melee/general_pickup.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF

/obj/item/brass_knuckles/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, attack_cooldown_wielded = 4, attack_cooldown_unwielded = LIGHT_WEAPON_CD, icon_wielded="[base_icon_state]_w")

/obj/item/brass_knuckles/update_icon_state()
	icon_state = base_icon_state
	return ..()
