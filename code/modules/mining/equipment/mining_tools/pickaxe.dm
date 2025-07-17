/obj/item/pickaxe
	name = "pickaxe"
	icon = 'icons/obj/mining.dmi'
	icon_state = "pickaxe"
	item_state = "pickaxe"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'

	force = 15
	throwforce = 10
	wall_decon_damage = 25 //enough to take down mineral walls in 4 hits
	demolition_mod = 1.1
	toolspeed = 0.7

	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	tool_behaviour = TOOL_MINING
	w_class = WEIGHT_CLASS_BULKY
	supports_variations = VOX_VARIATION

	custom_materials = list(/datum/material/iron = 2000) //one sheet, but where can you make them?

	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	attack_verb = list("hit", "pierced", "sliced", "attacked")

/obj/item/pickaxe/rusted
	name = "rusty pickaxe"
	desc = "A pickaxe that's been left to rust."
	attack_verb = list("ineffectively hit")
	force = 5
	throwforce = 5
	wall_decon_damage = 15

/obj/item/pickaxe/mini
	name = "compact pickaxe"
	desc = "A smaller, compact version of the standard pickaxe."
	icon_state = "minipick"
	force = 10
	throwforce = 7
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 1000)
	wall_decon_damage = 20

/obj/item/pickaxe/silver
	name = "silver-plated pickaxe"
	desc = "A silver-plated pickaxe that mines slightly faster than standard-issue."
	icon_state = "spickaxe"
	item_state = "spickaxe"
	toolspeed = 0.3

/obj/item/pickaxe/diamond
	name = "diamond-tipped pickaxe"
	desc = "A pickaxe with a diamond pick head. Extremely robust at cracking rock walls and digging up dirt."
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	toolspeed = 0.2
	custom_materials = list(/datum/material/diamond = 2000)

/obj/item/pickaxe/improvised
	name = "improvised pickaxe"
	desc = "A pickaxe made with a knife and crowbar taped together, how does it not break?"
	icon_state = "ipickaxe"
	item_state = "ipickaxe"
	force = 10
	throwforce = 7
	toolspeed = 1.5 //slower than a normal pickaxe
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 12050)
