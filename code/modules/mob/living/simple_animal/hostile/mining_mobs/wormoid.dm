//wormoid.dm NAME UNDECIDED
/*
	Wanders around, eats flora
	When it sees a balisk, it hides in the ground until it goes away, or it doesnt hide when aggroed
	Balisks will attempempt to freeze and then eat the wormoid whole, it has no intrest in eating corpses
	When it sees a human, it will:
		If it has a survivor suit on or is a survivor mob, it hides
		If it doesnt have anything else, it attacks
			If the human is on the tile it is on or next to it, it does its normal attack
	If it is further than the next tile it will do this:
		It will perk up like a ferret on sight, and then dig down
		After a few seconds, it will then rumble the ground it is about to come out of for half a second, then come out
			Once that happens, if you are still on the turf its still on, you will get stunned and beaten up by the first attack, although the stun is not as punishing as the goliath stun
	If you are more than 6 tiles away, it will instead shoot something at you, slowing you down and doing very little damage

*/
/*
/mob/living/simple_animal/hostile/asteroid/wormoid
	name = "wormoid"
	desc = "funny looking ferret"
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "wormoid"
	icon_living = "wormoid"
	icon_aggro = "Goliath_alert"
	icon_dead = "Goliath_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	move_to_delay = 40
	ranged = 1
	ranged_cooldown_time = 120
	friendly_verb_continuous = "wails at"
	friendly_verb_simple = "wail at"
	speak_emote = list("bellows")
	speed = 3
	throw_deflection = 10
	maxHealth = 200
	health = 200
	armor = list("melee" = 30, "bullet" = 15, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
	harm_intent_damage = 0
	obj_damage = 100
	environment_smash = ENVIRONMENT_SMASH_MINERALS
	melee_damage_lower = 12
	melee_damage_upper = 20
	attack_verb_continuous = "pulverizes"
	attack_verb_simple = "pulverize"
	attack_sound = 'sound/weapons/punch1.ogg'

	vision_range = 6
	aggro_vision_range = 10
	var/tentacle_type = /obj/effect/temp_visual/goliath_tentacle
	loot = list(/obj/item/stack/sheet/animalhide/goliath_hide)
	tame_chance = 0
	bonus_tame_chance = 10
	search_objects = 1
	wanted_objects = list(/obj/structure/flora/ash)
*/
