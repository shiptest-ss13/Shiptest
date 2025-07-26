/obj/item/gun/ballistic/shotgun/blasting_hammer //yeah, I know this is kinda hacky but it's (probably) better than the other way
	name = "blasting hammer"
	icon_state = "blasting-0"
	base_icon_state = "blasting"
	item_state = "blasting"

	desc = "A heavily modified breaching hammer with what appears to be some kind of makeshift loading mechanism bolted on. A brutishly powerful tool for breaking both hull and heads. Loads 12g blanks as propellent to increase it's already impressive destructive power."
	icon = 'icons/obj/weapon/blunt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	force = 5
	throwforce = 15
	armour_penetration = 40
	demolition_mod = 2
	slot_flags = ITEM_SLOT_BACK
	attack_cooldown = 12
	attack_verb = list("bashed", "smashed", "crushed", "smacked")
	hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'


/obj/item/gun/ballistic/shotgun/blasting_hammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 30, icon_wielded="[base_icon_state]_w")

/obj/item/gun/ballistic/shotgun/blasting_hammer/on_wield(obj/item/source, mob/user, instant)
	. = ..()
	tool_behaviour = TOOL_MINING

/obj/item/gun/ballistic/shotgun/blasting_hammer/on_unwield(obj/item/source, mob/user)
	. = ..()
	tool_behaviour = null

/obj/item/gun/ballistic/shotgun/blasting_hammer/attack(mob/M, mob/user)
	. = ..()
	if(chambered)


