/*****************Pickaxes & Drills & Shovels****************/
/obj/item/pickaxe
	name = "pickaxe"
	icon = 'icons/obj/mining.dmi'
	icon_state = "pickaxe"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 15
	throwforce = 10
	item_state = "pickaxe"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	supports_variations = VOX_VARIATION
	custom_materials = list(/datum/material/iron=2000) //one sheet, but where can you make them?
	tool_behaviour = TOOL_MINING
	toolspeed = 0.5
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	wall_decon_damage = MINERAL_WALL_INTEGRITY
	demolition_mod = 1.15

/obj/item/pickaxe/rusted
	name = "rusty pickaxe"
	desc = "A pickaxe that's been left to rust."
	attack_verb = list("ineffectively hit")
	force = 1
	throwforce = 1
	wall_decon_damage = 50

/obj/item/pickaxe/mini
	name = "compact pickaxe"
	desc = "A smaller, compact version of the standard pickaxe."
	icon_state = "minipick"
	force = 10
	throwforce = 7
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=1000)

/obj/item/pickaxe/silver
	name = "silver-plated pickaxe"
	icon_state = "spickaxe"
	item_state = "spickaxe"
	toolspeed = 0.3 //mines faster than a normal pickaxe, bought from mining vendor
	desc = "A silver-plated pickaxe that mines slightly faster than standard-issue."
	force = 17
	custom_price = 1000

/obj/item/pickaxe/diamond
	name = "diamond-tipped pickaxe"
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	toolspeed = 0.2
	desc = "A pickaxe with a diamond pick head. Extremely robust at cracking rock walls and digging up dirt."
	force = 19
	custom_price = 1500
	custom_premium_price = 2000
	custom_materials = list(/datum/material/diamond=2000)

/obj/item/pickaxe/drill
	name = "mining drill"
	icon_state = "handrill"
	item_state = "handrill"
	slot_flags = ITEM_SLOT_BELT
	toolspeed = 0.4 //available from roundstart, faster than a pickaxe.
	usesound = 'sound/weapons/drill.ogg'
	hitsound = 'sound/weapons/drill.ogg'
	desc = "An electric mining drill, complete with self-cleaning bit and part replacements. Optimized for the especially scrawny."
	attack_verb = list("drilled", "bored", "rent", "carved")

/obj/item/pickaxe/drill/cyborg
	name = "integrated mining drill"
	desc = "An integrated electric mining drill."
	flags_1 = NONE

/obj/item/pickaxe/drill/cyborg/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CYBORG_ITEM_TRAIT)

/obj/item/pickaxe/drill/diamonddrill
	name = "diamond-tipped mining drill"
	icon_state = "diamonddrill"
	item_state = "diamonddrill"
	toolspeed = 0.2
	desc = "EXOCOM's improvement on the NT autodrill design, featuring a premium diamond cutting head. Yours is the drill that will pierce the heavens!"
	force = 20
	custom_materials = list(/datum/material/diamond=2000)

/obj/item/pickaxe/drill/cyborg/diamond //This is the BORG version!
	name = "diamond-tipped integrated mining drill" //To inherit the NODROP_1 flag, and easier to change borg specific drill mechanics.
	icon_state = "diamonddrill"
	toolspeed = 0.2

/obj/item/pickaxe/drill/jackhammer
	name = "hypersonic jackhammer"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	toolspeed = 0.1 //the epitome of powertools. extremely fast mining
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	hitsound = 'sound/weapons/sonic_jackhammer.ogg'
	desc = "The epitome of conventional rock-smashing technology, invented by NT and cost-optimized by EXOCOM. Smashes rocks, objects, and unfortunate wildlife with sonic blasts."
	force = 20
	armour_penetration = 15
	attack_verb = list("blasted", "smashed", "slammed", "hammered")
	demolition_mod = 6

// //back in my day, our jackhammers used nothing but rattlin' drill bits! And we liked it!
/obj/item/pickaxe/drill/jackhammer/old
	name = "blastwave jackhammer"
	icon_state = "jackhammerold"
	item_state = "jackhammerold"
	toolspeed = 0.4//meh
	desc = "The old fashioned solution to a stubborn wall- used heavily all over known space until the onset of sonic deconstruction technology and Rapid Construction Devices."
	force = 15
	armour_penetration = 15

/obj/item/pickaxe/drill/jackhammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/knockback, 1, FALSE, FALSE)

//The fist of justice
/obj/item/pickaxe/drill/jackhammer/brigador
	name = "mechanized fist"
	desc = "A reinforced hydraulic punching apparatus. Capable of smashing through walls, mineral aggregate, and unfortunate opponents."
	force = 35
	armour_penetration = 25//yours is the fist that will pierce the heavens
	toolspeed = 0.3 //slower than the sonic
	icon_state = "powerfist"
	icon = 'icons/obj/items_cyborg.dmi'
	attack_verb = list("uppercut", "sucker-punched", "hammered", "pummeled", "jabbed")

/obj/item/pickaxe/drill/jackhammer/brigador/melee_attack_chain(mob/user, atom/target, params)
	..()
	user.changeNext_move(CLICK_CD_MELEE * 0.7)

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
	custom_materials = list(/datum/material/iron=12050) //metal needed for a crowbar and for a knife, why the FUCK does a knife cost 6 metal sheets while a crowbar costs 0.025 sheets? shit makes no sense fuck this

/obj/item/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/mining.dmi'
	icon_state = "shovel"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 8
	tool_behaviour = TOOL_SHOVEL
	toolspeed = 0.6
	usesound = 'sound/effects/shovel_dig.ogg'
	throwforce = 4
	item_state = "shovel"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharpness = SHARP_EDGED

/obj/item/shovel/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 150, 40) //it's sharp, so it works, but barely.

/obj/item/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/shovel/serrated
	name = "serrated bone shovel"
	desc = "A wicked tool that cleaves through dirt just as easily as it does flesh. The design was styled after ancient lavaland tribal designs."
	icon_state = "shovel_bone"
	item_state = "shovel_bone"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 15
	throwforce = 12
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.6
	attack_verb = list("slashed", "impaled", "stabbed", "sliced")
	sharpness = SHARP_EDGED

/obj/item/shovel/spoon
	name = "comically large spoon"
	desc = "Digs out only a spoonfull"
	item_state = "spoon"
	force = 6
	throwforce = 2
	toolspeed = 0.8
	attack_verb = list("bashed", "bludgeoned", "spooned", "scooped")
	sharpness = SHARP_NONE

/obj/item/trench_tool
	name = "entrenching tool"
	desc = "A dual-purpose excavation tool in black and red, serving as both a powerful bladed shovel and a pickaxe. Manufactured by the New Gorlex Republic."
	icon = 'icons/obj/mining.dmi'
	icon_state = "trench_tool"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 15
	throwforce = 6
	armour_penetration = 15
	wound_bonus = 5
	tool_behaviour = TOOL_MINING
	slot_flags = ITEM_SLOT_BELT
	demolition_mod = 1.15
	wall_decon_damage = MINERAL_WALL_INTEGRITY
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_POINTY
	toolspeed = 0.5
	usesound = 'sound/effects/picaxe1.ogg'
	attack_verb = list("hits", "pierced", "sliced", "attacked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	wound_bonus = 5

/obj/item/trench_tool/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/trench_tool/ComponentInitialize()
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 20, \
		throwforce_on = 10, \
		hitsound_on = 'sound/weapons/bladeslice.ogg', \
		attack_verb_on = list("slashed", "impaled", "stabbed", "sliced"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/trench_tool/examine(mob/user)
	. = ..()
	. += span_notice("It functions as a [tool_behaviour] tool.")

/obj/item/trench_tool/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_SHOVEL
		sharpness = SHARP_EDGED
		toolspeed = 0.25
		usesound = 'sound/effects/shovel_dig.ogg'
		bare_wound_bonus = 10
		armour_penetration = 0
	else
		tool_behaviour = TOOL_MINING
		sharpness = SHARP_POINTY
		toolspeed = 0.5
		usesound = 'sound/effects/picaxe1.ogg'
		bare_wound_bonus = 0
		armour_penetration = 15
	playsound(src, 'sound/items/ratchet.ogg', 50, vary = TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/trench_tool/gezena
	name = "entrenching tool"
	desc = "A dual-purpose excavation tool in green, serving as both a powerful bladed shovel and a pickaxe. In use by the Pan-Gezenan Federation."
	icon_state = "trench_tool_gezena"
