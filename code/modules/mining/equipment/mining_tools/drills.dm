/obj/item/pickaxe/drill
	name = "mining drill"
	icon_state = "handrill"
	item_state = "handrill"
	slot_flags = ITEM_SLOT_BELT
	toolspeed = 0.5
	usesound = 'sound/weapons/drill.ogg'
	hitsound = 'sound/weapons/drill.ogg'
	desc = "An electric mining drill, complete with self-cleaning bit and part replacements. Optimized for the especially scrawny."
	attack_verb = list("drilled", "bored", "rent", "carved")

/obj/item/pickaxe/drill/diamonddrill
	name = "diamond-tipped mining drill"
	desc = "EXOCOM's improvement on the NT autodrill design, featuring a premium diamond cutting head."
	icon_state = "diamonddrill"
	item_state = "diamonddrill"
	toolspeed = 0.4
	force = 20
	custom_materials = list(/datum/material/diamond = 2000)

/obj/item/pickaxe/drill/jackhammer
	name = "hypersonic jackhammer"
	desc = "The epitome of conventional rock-smashing technology, invented by NT and cost-optimized by EXOCOM. Smashes rocks, objects, and unfortunate wildlife with sonic blasts."
	icon_state = "jackhammer"
	item_state = "jackhammer"
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	hitsound = 'sound/weapons/sonic_jackhammer.ogg'
	force = 20
	armour_penetration = 15
	wall_decon_damage = 35
	demolition_mod = 1.2
	attack_verb = list("blasted", "smashed", "slammed", "hammered")

/obj/item/pickaxe/drill/jackhammer/old
	name = "blastwave jackhammer"
	desc = "The old fashioned solution to a stubborn wall- used heavily all over known space until the onset of sonic deconstruction technology and Rapid Construction Devices."
	icon_state = "jackhammerold"
	item_state = "jackhammerold"
	toolspeed = 0.8
	force = 15
	armour_penetration = 15
