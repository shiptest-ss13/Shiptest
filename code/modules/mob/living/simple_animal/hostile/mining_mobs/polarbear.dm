/mob/living/simple_animal/hostile/asteroid/polarbear
	name = "polar bear"
	desc = "An aggressive animal that defends it's territory with incredible power. These beasts don't run from their enemies."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "polarbear"
	icon_living = "polarbear"
	icon_dead = "polarbear_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	friendly_verb_continuous = "growls at"
	friendly_verb_simple = "growl at"
	speak_emote = list("growls")
	speed = 12
	move_to_delay = 12
	maxHealth = 100
	health = 100
	armor = list("melee" = 20, "bullet" = 20, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
	obj_damage = 40
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	vision_range = 2 // don't aggro unless you basically antagonize it, though they will kill you worse than a goliath will
	aggro_vision_range = 9
	move_resist = MOVE_FORCE_VERY_STRONG
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 1)
	loot = list()
	//mob_trophy = /obj/item/mob_trophy/bear_paw
	stat_attack = HARD_CRIT
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	/// Message for when the polar bear starts to attack faster
	var/aggressive_message_said = FALSE

/mob/living/simple_animal/hostile/asteroid/polarbear/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(health > maxHealth*0.3)
		rapid_melee = initial(rapid_melee)
		return
	if(!aggressive_message_said && target)
		visible_message("<span class='danger'>The [name] looks at [target] with an expression of rage!</span>")
		aggressive_message_said = TRUE
	rapid_melee = 2
	speed = 7
	move_to_delay = 7

/mob/living/simple_animal/hostile/asteroid/polarbear/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	return ..()

/mob/living/simple_animal/hostile/asteroid/polarbear/lesser
	name = "magic polar bear"
	desc = "It seems sentient somehow."
	faction = list("neutral")

//elite bear
/mob/living/simple_animal/hostile/asteroid/polarbear/warrior
	name = "polar warbear"
	desc = "An aggressive animal that defends its territory with incredible power. This one appears to be a remnant of the short-lived Wojtek-Aleph program."
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "CQB's"
	attack_verb_simple = "CQB"
	speed = 7
	move_to_delay = 7
	maxHealth = 300
	health = 300
	obj_damage = 60
	icon_state = "warbear"
	icon_living = "warbear"
	icon_dead = "warbear_dead"
	//mob_trophy = /obj/item/mob_trophy/war_paw
	trophy_drop_mod = 75
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2, /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3, /obj/item/bear_armor = 1)

/mob/living/simple_animal/hostile/asteroid/polarbear/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/polarbear/warrior(loc)
		return INITIALIZE_HINT_QDEL
