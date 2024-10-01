/obj/item/melee/brass_knuckles
	name = "spiked brass knuckles"
	desc = "spikey."
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

/obj/item/melee/sledgehammer
	name = "sledgehammer"
	icon_state = "sledgehammer"
	icon = 'icons/obj/weapon/blunt.dmi'
	//lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	//righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	force = 5
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_cooldown = 12
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF

/obj/item/melee/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 30, icon_wielded="[base_icon_state]")
