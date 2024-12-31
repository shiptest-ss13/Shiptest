/obj/item/melee/brass_knuckles
	name = "brass knuckles"
	desc = "yea."
	icon_state = "powerfist"
	item_state = "powerfist"
	hitsound = 'sound/weapons/melee/stab_hit.ogg'
	pickup_sound = 'sound/weapons/melee/general_pickup.ogg'
	flags_1 = CONDUCT_1
	attack_verb = list("punched", "jabed", "clocked", "nailed", "bludgeoned", "whacked", "bonked")
	force = 20
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)
	resistance_flags = FIRE_PROOF

/obj/item/melee/brass_knuckles/spiked
	name = "spiked brass knuckles"
	desc = "spikey."
	sharpness = IS_SHARP

/obj/item/gun/ballistic/automatic/pistol/disposable/buster
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/dual/lethal
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/dual/lethal,
	)

/obj/item/melee/brass_knuckles/busters
	name = "knucklebusters"
	force = 10
	var/obj/item/gun/stored_gun

/obj/item/melee/brass_knuckles/busters/Initialize()
	. = ..()
	stored_gun = new /obj/item/gun/ballistic/automatic/pistol/disposable/buster()

/obj/item/melee/brass_knuckles/busters/attack(mob/living/M, mob/living/user)
	. = ..()
	stored_gun.afterattack(M, user)

/obj/item/melee/sledgehammer
	name = "sledgehammer"
	icon_state = "sledgehammer"
	icon = 'icons/obj/weapon/blunt.dmi'
	//lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	//righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	force = 5
	throwforce = 15
	armour_penetration = 40
	sharpness = IS_BLUNT
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

/obj/item/melee/sledgehammer/gorlex
	icon_state = "sledgehammer"
	base_icon_state = "sledgehammer"
	icon = 'icons/obj/weapon/axe.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
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
