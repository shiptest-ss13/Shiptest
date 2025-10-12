#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin for megacarps (ty robustin!)

/mob/living/simple_animal/hostile/carp
	name = "space carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon = 'icons/mob/carp.dmi'
	icon_state = "base"
	icon_living = "base"
	icon_dead = "base_dead"
	icon_gib = "carp_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/fishmeat/carp = 2)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	taunt_chance = 30
	speed = 0
	maxHealth = 25
	health = 25
	food_type = list(/obj/item/food/fishmeat/carp)
	tame_chance = 10
	bonus_tame_chance = 5
	search_objects = 1
	wanted_objects = list(/obj/item/storage/cans)

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	sharpness = SHARP_POINTY
	speak_emote = list("gnashes")

	//Space carp aren't affected by cold.
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list("carp", "mining")
	is_flying_animal = TRUE
	pressure_resistance = 200

	var/random_color = TRUE //if the carp uses random coloring
	var/rarechance = 1 //chance for rare color variant
	var/snack_distance = 0

	var/static/list/carp_colors = list(\
	"lightpurple" = "#c3b9f1", \
	"lightpink" = "#da77a8", \
	"green" = "#70ff25", \
	"grape" = "#df0afb", \
	"swamp" = "#e5e75a", \
	"turquoise" = "#04e1ed", \
	"brown" = "#ca805a", \
	"teal" = "#20e28e", \
	"lightblue" = "#4d88cc", \
	"rusty" = "#dd5f34", \
	"beige" = "#bbaeaf", \
	"yellow" = "#f3ca4a", \
	"blue" = "#09bae1", \
	"palegreen" = "#7ef099", \
	)
	var/static/list/carp_colors_rare = list(\
	"silver" = "#fdfbf3", \
	)

/mob/living/simple_animal/hostile/carp/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	carp_randomify(rarechance)
	update_icons()

/mob/living/simple_animal/hostile/carp/proc/carp_randomify(rarechance)
	if(random_color)
		var/our_color
		if(prob(rarechance))
			our_color = pick(carp_colors_rare)
			add_atom_colour(carp_colors_rare[our_color], FIXED_COLOUR_PRIORITY)
		else
			our_color = pick(carp_colors)
			add_atom_colour(carp_colors[our_color], FIXED_COLOUR_PRIORITY)
		add_carp_overlay()

/mob/living/simple_animal/hostile/carp/proc/add_carp_overlay()
	if(!random_color)
		return
	cut_overlays()
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "base_mouth")
	base_overlay.appearance_flags = RESET_COLOR
	add_overlay(base_overlay)

/mob/living/simple_animal/hostile/carp/proc/add_dead_carp_overlay()
	if(!random_color)
		return
	cut_overlays()
	var/mutable_appearance/base_dead_overlay = mutable_appearance(icon, "base_dead_mouth")
	base_dead_overlay.appearance_flags = RESET_COLOR
	add_overlay(base_dead_overlay)

/mob/living/simple_animal/hostile/carp/proc/chomp_plastic()
	var/obj/item/storage/cans/tasty_plastic = locate(/obj/item/storage/cans) in view(1, src)
	if(tasty_plastic && Adjacent(tasty_plastic))
		visible_message(span_notice("[src] gets its head stuck in [tasty_plastic], and gets cut breaking free from it!"), span_notice("You try to avoid [tasty_plastic], but it looks so... delicious... Ow! It cuts the inside of your mouth!"))

		new /obj/effect/decal/cleanable/plastic(loc)

		adjustBruteLoss(5)
		qdel(tasty_plastic)

/mob/living/simple_animal/hostile/carp/Life()
	. = ..()
	if(stat == CONSCIOUS)
		chomp_plastic()

/mob/living/simple_animal/hostile/carp/death(gibbed)
	. = ..()
	cut_overlays()
	if(!random_color || gibbed)
		return
	add_dead_carp_overlay()

/mob/living/simple_animal/hostile/carp/revive(full_heal = FALSE, admin_revive = FALSE)
	. = ..()
	if(.)
		regenerate_icons()

/mob/living/simple_animal/hostile/carp/regenerate_icons()
	cut_overlays()
	if(!random_color)
		return
	if(stat != DEAD)
		add_carp_overlay()
	else
		add_dead_carp_overlay()
	..()

/mob/living/simple_animal/hostile/carp/throw_atom_into_space()
	return

/mob/living/simple_animal/hostile/carp/tamed()
	. = ..()
	can_buckle = TRUE
	buckle_lying = FALSE
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 13), TEXT_SOUTH = list(0, 15), TEXT_EAST = list(-2, 12), TEXT_WEST = list(2, 12)))
	D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
	D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
	D.set_vehicle_dir_layer(WEST, OBJ_LAYER)
	D.drive_verb = "ride"
	D.override_allow_spacemove = TRUE

/mob/living/simple_animal/hostile/carp/holocarp
	icon_state = "holocarp"
	icon_living = "holocarp"
	maxbodytemp = INFINITY
	del_on_death = 1
	random_color = FALSE
	food_type = list()
	tame_chance = 0
	bonus_tame_chance = 0

/mob/living/simple_animal/hostile/carp/megacarp
	icon = 'icons/mob/broadMobs.dmi'
	name = "Mega Space Carp"
	desc = "A ferocious, fang bearing creature that resembles a shark. This one seems especially ticked off."
	icon_state = "megacarp"
	icon_living = "megacarp"
	icon_dead = "megacarp_dead"
	icon_gib = "megacarp_gib"
	health_doll_icon = "megacarp"
	maxHealth = 20
	health = 20
	pixel_x = -16
	base_pixel_x = -16
	mob_size = MOB_SIZE_LARGE
	random_color = FALSE
	food_type = list()
	tame_chance = 0
	bonus_tame_chance = 0

	obj_damage = 80
	melee_damage_lower = 20
	melee_damage_upper = 20

	var/regen_cooldown = 0
	var/rideable = FALSE

/mob/living/simple_animal/hostile/carp/megacarp/Initialize()
	. = ..()
	name = "[pick(GLOB.megacarp_first_names)] [pick(GLOB.megacarp_last_names)]"
	melee_damage_lower += rand(2, 10)
	melee_damage_upper += rand(10,20)
	maxHealth += rand(30,60)
	move_to_delay = rand(3,7)

/mob/living/simple_animal/hostile/carp/megacarp/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(.)
		regen_cooldown = world.time + REGENERATION_DELAY

/mob/living/simple_animal/hostile/carp/megacarp/Life()
	. = ..()
	if(regen_cooldown < world.time)
		heal_overall_damage(4)
	if(!rideable && src.mind)
		can_buckle = TRUE
		buckle_lying = FALSE
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(1, 8), TEXT_SOUTH = list(1, 8), TEXT_EAST = list(-3, 6), TEXT_WEST = list(3, 6)))
		D.set_vehicle_dir_offsets(SOUTH, pixel_x, 0)
		D.set_vehicle_dir_offsets(NORTH, pixel_x, 0)
		D.set_vehicle_dir_offsets(EAST, pixel_x, 0)
		D.set_vehicle_dir_offsets(WEST, pixel_x, 0)
		D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)
		rideable = TRUE

/mob/living/simple_animal/hostile/carp/cayenne
	name = "Cayenne"
	desc = "A failed Syndicate experiment in weaponized space carp technology, it now serves as a lovable mascot."
	gender = FEMALE
	speak_emote = list("squeaks")
	faction = list(ROLE_SYNDICATE)
	AIStatus = AI_OFF
	rarechance = 10
	food_type = list()
	tame_chance = 0
	bonus_tame_chance = 0

#undef REGENERATION_DELAY
