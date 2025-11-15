//Space bears!
/mob/living/basic/bear
	name = "space bear"
	desc = "You don't need to be faster than a space bear, you just need to outrun your crewmates."
	icon = 'icons/mob/basic/bear.dmi'
	icon_state = "bear"
	icon_living = "bear"
	icon_dead = "bear_dead"
	icon_gib = "bear_gib"
	status_flags = NONE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/food/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1)

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"

	maxHealth = 60
	health = 60
	speed = 0

	obj_damage = 60
	melee_damage_lower = 15 // i know it's like half what it used to be, but bears cause bleeding like crazy now so it works out
	melee_damage_upper = 15
	bare_wound_bonus = 10 // BEAR wound bonus am i right
	sharpness = SHARP_EDGED
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	friendly_verb_continuous = "bear hugs"
	friendly_verb_simple = "bear hug"

	faction = list(FACTION_MINING)

	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = TCMB
	maximum_survivable_temperature = T0C + 1500
	ai_controller = /datum/ai_controller/basic_controller/bear
	/// is the bear wearing a armor?
	var/armored = FALSE

/mob/living/basic/bear/Initialize(mapload)
	. = ..()
	//Was gonna do this but since we already have sprites for the only two armored varients its a waste of init time.
	//if(armored)
	//	update_icons()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	AddElement(/datum/element/ai_retaliate)
	AddComponent(/datum/component/tree_climber, climbing_distance = 15)

/*
/mob/living/basic/bear/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	//AddElement(/datum/element/ridable, /datum/component/riding/creature/bear)
	can_buckle = TRUE
	buckle_lying = 0
*/

/mob/living/basic/bear/update_icons()
	..()
	if(armored)
		add_overlay("armor_bear")

/mob/living/basic/bear/proc/extract_combs(obj/structure/beebox/hive)
	if(!length(hive.honeycombs))
		return
	var/obj/item/reagent_containers/honeycomb/honey_food = pick_n_take(hive.honeycombs)
	if(isnull(honey_food))
		return
	honey_food.forceMove(get_turf(src))

//SPACE BEARS! SQUEEEEEEEE~     OW! FUCK! IT BIT MY HAND OFF!!
/mob/living/basic/bear/hudson
	name = "Hudson"
	gender = MALE
	desc = "Feared outlaw, this guy is one bad news bear." //I'm sorry...

/mob/living/basic/bear/frontier
	name = "combat bear"
	desc = "A ferocious brown bear decked out in armor plating."
	icon_state = "combatbear"
	icon_living = "combatbear"
	icon_dead = "combatbear_dead"
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	butcher_results = list(/obj/item/food/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1, /obj/item/bear_armor = 1)
	melee_damage_lower = 25
	melee_damage_upper = 35
	armour_penetration = 20
	health = 120
	maxHealth = 120
	armored = TRUE

/mob/living/basic/bear/cave
	name = "brown bear"
	desc = "A ferocious brown bear, ready to maul."
	icon_state = "brownbear"
	icon_living = "brownbear"
	icon_dead = "brownbear_dead"
	icon_gib = "brownbear_gib"
	maxHealth = 70
	health = 70

/mob/living/basic/bear/polar
	name = "polar bear"
	desc = "An aggressive animal that defends it's territory with incredible power. These beasts don't run from their enemies."
	icon_state = "polarbear"
	icon_living = "polarbear"
	icon_dead = "polarbear_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	friendly_verb_continuous = "growls at"
	friendly_verb_simple = "growl at"
	speak_emote = list("growls")
	speed = 12
	maxHealth = 100
	health = 100
	armor = list("melee" = 20, "bullet" = 20, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
	obj_damage = 40
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	//vision_range = 2 // don't aggro unless you basically antagonize it, though they will kill you worse than a goliath will
	//aggro_vision_range = 9
	move_resist = MOVE_FORCE_VERY_STRONG
	butcher_results = list(/obj/item/food/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 1)
	var/mob_trophy = /obj/item/mob_trophy/bear_paw
	var/trophy_drop_mod = 25
	//footstep_type = FOOTSTEP_MOB_CLAW
	/// Message for when the polar bear starts to attack faster
	var/aggressive_message_said = FALSE

/*
/mob/living/basic/bear/polar/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(health > maxHealth*0.3)
		rapid_melee = initial(rapid_melee)
		return
	if(!aggressive_message_said && target)
		visible_message(span_danger("The [name] looks at [target] with an expression of rage!"))
		aggressive_message_said = TRUE
	rapid_melee = 2
	speed = 7
	move_to_delay = 7
*/

/mob/living/basic/bear/polar/Initialize(mapload)
	. = ..()
	if(mob_trophy && prob(trophy_drop_mod))
		AddElement(/datum/element/death_drops, list(mob_trophy))

/mob/living/basic/bear/polar/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	return ..()

//elite bear
/mob/living/basic/bear/polar/warrior
	name = "polar warbear"
	desc = "An aggressive animal that defends its territory with incredible power. This one appears to be a remnant of the short-lived Wojtek-Aleph program."
	icon_state = "warbear"
	icon_living = "warbear"
	icon_dead = "warbear_dead"
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "CQB's"
	attack_verb_simple = "CQB"
	speed = 7
	maxHealth = 300
	health = 300
	obj_damage = 60
	mob_trophy = /obj/item/mob_trophy/war_paw
	trophy_drop_mod = 75
	butcher_results = list(/obj/item/food/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2, /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3, /obj/item/bear_armor = 1)
	armored = TRUE
