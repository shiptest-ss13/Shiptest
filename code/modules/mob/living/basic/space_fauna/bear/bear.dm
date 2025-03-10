//Space bears!
/mob/living/basic/bear
	name = "space bear"
	desc = "You don't need to be faster than a space bear, you just need to outrun your crewmates."
	icon_state = "bear"
	icon_living = "bear"
	icon_dead = "bear_dead"
	icon_gib = "bear_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1)

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"

	maxHealth = 60
	health = 60
	speed = 0

	obj_damage = 60
	melee_damage_lower = 15
	melee_damage_upper = 15
	sharpness = IS_SHARP
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	friendly_verb_continuous = "bear hugs"
	friendly_verb_simple = "bear hug"

	faction = list("mining")

	habitable_atmos = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = TCMB
	maximum_survivable_temperature = T0C + 1500
	ai_controller = /datum/ai_controller/basic_controller/bear
	/// is the bear wearing a armor?
	var/armored = FALSE

/mob/living/basic/bear/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	AddElement(/datum/element/ai_retaliate)
	AddComponent(/datum/component/tree_climber, climbing_distance = 15)

/mob/living/basic/bear/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	//AddElement(/datum/element/ridable, /datum/component/riding/creature/bear)
	can_buckle = TRUE
	buckle_lying = 0

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

/mob/living/basic/bear/snow
	name = "space polar bear"
	icon_state = "snowbear"
	icon_living = "snowbear"
	icon_dead = "snowbear_dead"
	desc = "It's a polar bear, in space, but not actually in space."

/mob/living/basic/bear/snow/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SNOWSTORM_IMMUNE, INNATE_TRAIT)

/mob/living/basic/bear/frontier
	name = "combat bear"
	desc = "A ferocious brown bear decked out in armor plating, a red star with yellow outlining details the shoulder plating."
	icon_state = "combatbear"
	icon_living = "combatbear"
	icon_dead = "combatbear_dead"
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1, /obj/item/bear_armor = 1)
	melee_damage_lower = 25
	melee_damage_upper = 35
	armour_penetration = 20
	health = 120
	maxHealth = 120
	armored = TRUE
