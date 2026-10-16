/mob/living/basic/human
	name = "crazed human"
	desc = "A crazed human, they cannot be reasoned with."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	icon_dead = null
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	basic_mob_flags = DEL_ON_DEATH
	faction = list(FACTION_ANTAG_HERMITS)
	// picked from what we're holding
	ai_controller = null

	maxHealth = 100
	health = 100
	// about as quick as the hostile simplehumans they replace, which chased at 0.3 seconds a tile
	speed = 1 // a touch quicker than a running player, see RUN_DELAY, so they can be run down, plus whatever our outfit slows us by, see Initialize()

	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	response_help_continuous = "pushes"
	response_help_simple = "push"

	unsuitable_atmos_damage = 7.5
	minimum_survivable_temperature = 180

	// we break things like tables and closets in our way, when there's no way around
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 40

	/// If we use stuff from dynamic human icon generation for loot
	var/human_loot = TRUE
	/// Path of the mob spawner we base the mob's visuals off of, and leave behind as our corpse
	var/obj/effect/mob_spawn/human/mob_spawner
	/// The corpse we left behind, once we've died, so our last words show above it, as the mob gets deleted and replaced by the corpse
	var/datum/weakref/corpse_ref
	/// Path of the species we base the mob's visuals off of, and talk like. Picked at random when we have a mob_spawner but no species
	var/datum/species/mob_species
	/// The species we might be, as list(species path = weight), when our type doesn't set mob_species. Our corpse is the same species
	var/list/species_weights = list(
		/datum/species/lizard = 28,
		/datum/species/human = 22,
		/datum/species/ipc = 20,
		/datum/species/elzuose = 20,
		/datum/species/moth = 5,
		/datum/species/spider = 3,
	)
	/// Path of the right hand held item we give to the mob's visuals.
	var/obj/r_hand
	/// THE DEFAULT HAND (Required if you want them to wield it). Path of the left hand held item we give to the mob's visuals.
	var/obj/l_hand
	// Prob of us dropping l/r hand loot.
	var/weapon_drop_chance = 10
	///Steals the armor datum from this type of armor. Only if we've no mob_spawner to be armoured by the outfit of, or we're armored_all_over, see human_armor.dm
	var/obj/item/clothing/armor_base
	/// If TRUE, armor_base covers us all over even though we've a mob_spawner, rather than what our corpse wears, like armour that isn't part of the outfit
	var/armored_all_over = FALSE
	/// Anything else we drop when we die, besides our corpse and weapons
	var/list/loot
	/// If TRUE, we're sealed in a hardsuit: we can walk in space, and its lights are on
	var/in_hardsuit = FALSE
	/// If TRUE, immune to low pressure/space. basicmobs don't breathe so this only is fine
	var/pressure_sealed = FALSE

	/// What the mob's gun fires, if they have one. Use only one of this or projectile_type
	var/obj/item/ammo_casing/casing_type
	/// What the mob's gun fires, for guns without casings, like most energy weapons. Use only one of this or casing_type
	var/obj/projectile/projectile_type
	/// The sound of the mob firing
	var/projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	/// How many shots each volley fires
	var/burst_shots = 1
	/// The time between shots in a volley
	var/burst_interval = 0.2 SECONDS
	/// The time between volleys
	var/ranged_cooldown = 3 SECONDS
	/// How far off the mob's shots stray, overriding their gun's. Null to go by their gun
	var/spread
	/// inherent aim spread, in degrees either way, on top of gun spread
	var/aim_spread = 5
	/// Extra spread on our first volley at someone, before we've settled our aim on them
	var/first_contact_spread = 10
	/// If TRUE, the mob sprays fire with a flamethrower rather than firing a gun
	var/fires_flames = FALSE
	/// If TRUE, the mob holds their fire when one of theirs is in the way
	var/check_friendly_fire = FALSE

	/// How many times the mob hits in each melee attack, spread over the time between them
	var/rapid_melee = 1
	/// If TRUE, the mob swerves as they close in and sidestep around who they're fighting in melee
	var/dodging = FALSE
	/// With dodging, the chance for each step towards our target to swerve instead. Off by default, as swerving only slows closing in
	var/dodge_chance = 0
	/// With dodging, how many times we sidestep between each melee attack
	var/sidesteps = 1
	/// If FALSE, the mob never loses their nerve and falls back, however bad it gets
	var/morale_breaks = TRUE
	/// Chance we carry a flashlight for fighting in the dark, unless our outfit already has one
	var/flashlight_chance = 10
	/// How much the mob moves about in a fight, an AI_MOBILITY_ define. Null to go by their gun: light pistols dart about, heavy weapons hold their ground, see pick_mobility()
	var/mobility
	/// Chance to block a projectile, like with a shield
	var/projectile_deflect_chance = 0
	/// How many tiles the mob's melee hits knock people back, up to. 0 for none
	var/melee_knockback = 0
	/// If TRUE, the mob's knockback throws people gently, so they don't get knocked down by what they hit
	var/gentle_knockback = TRUE

	/// Closer than this and the mob backs off, if they fight from range. Null leaves it to their AI, unless engage_distance is set, in which case they never back off
	var/retreat_distance
	/// Further than this and the mob closes in, if they fight from range. Null leaves it to their AI
	var/engage_distance
	/// How far gone someone can be and still be worth attacking, like HARD_CRIT for those who finish people off. See BB_TARGET_MINIMUM_STAT
	var/stat_attack = CONSCIOUS
	/// How far the mob sees targets from. Null leaves it to their AI
	var/vision_range
	/// If FALSE, the mob stands still rather than wandering about when there's nothing to do, like sentries
	var/wander = TRUE
	/// If TRUE, the mob doesn't fight, but runs and shouts for help instead
	var/noncombatant = FALSE
	/// Typepath of the /datum/ai_callout_set the mob says things from in a fight. Null to stay quiet
	var/callout_set = /datum/ai_callout_set/human
	/// Lines the mob might shout when they pick a fight with someone, for one-off characters set up on a map. Said when we spot them, in place of our callout set's lines for it
	var/list/on_aggro_say
	/// Chance to shout one of on_aggro_say each time
	var/aggro_say_chance = 0
	/// How far the mob can be heard calling allies to a fight, if further than usual, like someone rallying a whole settlement.
	var/alert_range
	/// If TRUE, the mob makes a show of calling allies to a fight, with a "!" over its head and a chime
	var/summons_backup = FALSE
	/// Things the mob says now and then while there's nobody to fight
	var/list/speak
	/// Emotes the mob does now and then while there's nobody to fight, heard and seen, like "grumbles."
	var/list/emote_hear
	var/list/emote_see
	/// Chance each 2 seconds of one of speak, emote_hear or emote_see, while there's nobody to fight
	var/speak_chance = 0

/mob/living/basic/human/Initialize(mapload)
	. = ..()
	// what we wear and carry slows us as much as it would a player: a hardsuit, or a heavy gun held ready
	var/extra_slowdown = mob_spawner ? get_spawner_slowdown(mob_spawner) : 0
	var/obj/item/gun/gun_type = get_gun_type()
	if(gun_type)
		extra_slowdown += initial(gun_type.wield_slowdown)
	if(extra_slowdown)
		set_varspeed(speed + extra_slowdown)
	if(mob_spawner)
		if(!mob_species)
			mob_species = pick_weight(species_weights)
		apply_dynamic_human_appearance(src, species_path = mob_species, mob_spawn_path = mob_spawner, r_hand = r_hand, l_hand = l_hand, seed = rand(1, 3))
	if(ispath(armor_base, /obj/item/clothing) && (!mob_spawner || armored_all_over)) // otherwise setup_body_armor() dresses us in our corpse's outfit instead
		armor = get_clothing_armor(armor_base)
	setup_body_armor()
	if(in_hardsuit)
		ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
		set_light(4)
	pressure_sealed = in_hardsuit || (mob_spawner && spawner_is_pressure_sealed(mob_spawner)) // a gas mask gives us air, not pressure, so it takes a suit and helmet like a player
	if(length(loot))
		AddElement(/datum/element/death_drops, string_list(loot))
	setup_blood()
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_SHOE)
	setup_melee()
	setup_weapon()
	setup_ai()

/mob/living/basic/human/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	. = ..()
	if(stat == DEAD || pressure_sealed || !isturf(loc))
		return
	var/datum/gas_mixture/air = loc.return_air()
	if((air ? air.return_pressure() : 0) < HAZARD_LOW_PRESSURE)
		adjustBruteLoss(LOW_PRESSURE_DAMAGE)

/mob/living/basic/human/InitializeAIController()
	if(!ai_controller)
		if(noncombatant)
			ai_controller = /datum/ai_controller/basic_controller/human/noncombatant
		else if(casing_type || projectile_type || fires_flames)
			ai_controller = pick_ranged_controller()
		else
			ai_controller = pick_melee_controller()
	return ..()

/mob/living/basic/human/proc/pick_melee_controller()
	if(has_heavy_melee_weapon())
		return /datum/ai_controller/basic_controller/human/brute
	return /datum/ai_controller/basic_controller/human

/mob/living/basic/human/proc/has_heavy_melee_weapon(obj/item/weapon)
	var/static/list/heavy_weapons = typecacheof(list(/obj/item/melee/sledgehammer, /obj/item/melee/axe, /obj/item/melee/boarding_axe, /obj/item/melee/trench_club))
	if(isnull(weapon))
		weapon = get_melee_weapon()
	return ispath(weapon, /obj/item) && heavy_weapons[weapon]


// who flanks first based on archetype
/mob/living/basic/human/proc/get_flank_priority()
	if(!casing_type && !projectile_type)
		return 0
	if(istype(ai_controller, /datum/ai_controller/basic_controller/human/ranged/rusher))
		return 5
	if(istype(ai_controller, /datum/ai_controller/basic_controller/human/ranged/gunslinger))
		return 4
	if(istype(ai_controller, /datum/ai_controller/basic_controller/human/ranged/support_gunner))
		return 2
	if(istype(ai_controller, /datum/ai_controller/basic_controller/human/ranged/marksman))
		return 1
	return 3

// pick ranged archetype based on weapon used
/mob/living/basic/human/proc/pick_ranged_controller()
	var/obj/item/gun/gun_type = get_gun_type()
	if(ispath(gun_type, /obj/item/gun/ballistic/automatic/hmg))
		return /datum/ai_controller/basic_controller/human/ranged/support_gunner
	if(ispath(gun_type, /obj/item/gun/ballistic/rifle) || (ispath(gun_type, /obj/item/gun) && initial(gun_type.zoom_amt) >= DMR_ZOOM))
		return /datum/ai_controller/basic_controller/human/ranged/marksman
	if(ispath(casing_type, /obj/item/ammo_casing) && initial(casing_type.pellets) > 1)
		return /datum/ai_controller/basic_controller/human/ranged/rusher // shotguns, laser ones too
	if(ispath(gun_type, /obj/item/gun/ballistic/automatic/pistol) || ispath(gun_type, /obj/item/gun/ballistic/revolver))
		return /datum/ai_controller/basic_controller/human/ranged/gunslinger
	if(ispath(gun_type, /obj/item/gun/energy) && initial(gun_type.w_class) <= WEIGHT_CLASS_SMALL)
		return /datum/ai_controller/basic_controller/human/ranged/gunslinger

	return /datum/ai_controller/basic_controller/human/ranged

/mob/living/basic/human/proc/setup_melee()
	var/obj/item/weapon = get_melee_weapon()
	if(!weapon)
		return // our fists, then
	var/weapon_sharpness = initial(weapon.sharpness)
	if(sharpness == SHARP_NONE)
		sharpness = weapon_sharpness
	if(!wound_bonus)
		wound_bonus = initial(weapon.wound_bonus)
	if(!bare_wound_bonus)
		bare_wound_bonus = initial(weapon.bare_wound_bonus)
	if(attack_sound == /mob/living/basic/human::attack_sound) // the root's, so a subtype's own sound stays
		if(initial(weapon.hitsound))
			attack_sound = initial(weapon.hitsound)
		else if(ispath(weapon, /obj/item/gun))
			attack_sound = 'sound/weapons/genhit1.ogg' // bashing them with it
	if(attack_verb_continuous != /mob/living/basic/human::attack_verb_continuous)
		return
	switch(weapon_sharpness)
		if(SHARP_POINTY)
			attack_verb_continuous = "stabs"
			attack_verb_simple = "stab"
		if(SHARP_EDGED)
			attack_verb_continuous = "slashes"
			attack_verb_simple = "slash"
		else
			attack_verb_continuous = "bashes"
			attack_verb_simple = "bash"

/mob/living/basic/human/proc/get_melee_weapon()
	for(var/obj/item/held as anything in list(l_hand, r_hand))
		if(ispath(held, /obj/item) && !ispath(held, /obj/item/gun) && !ispath(held, /obj/item/shield)) // a shield's for blocking, not hitting with
			return held
	var/obj/item/gun/gun_type = get_gun_type()
	if(!gun_type)
		return null
	for(var/attachment in get_gun_default_attachments(gun_type))
		if(ispath(attachment, /obj/item/attachment/bayonet))
			return attachment
	return gun_type

/mob/living/basic/human/proc/setup_weapon()
	if(fires_flames)
		AddComponent(/datum/component/ranged_attacks/flamethrower, projectile_sound = projectile_sound, cooldown_time = ranged_cooldown)
		return
	if(!casing_type && !projectile_type)
		return
	var/obj/item/gun/gun_type = get_gun_type()
	var/shot_spread = spread
	if(isnull(shot_spread))
		shot_spread = gun_type ? initial(gun_type.spread) : 2
	shot_spread = max(shot_spread, 0) + aim_spread
	AddComponent(/datum/component/ranged_attacks, casing_type, projectile_type, projectile_sound, burst_shots, burst_interval, ranged_cooldown, shot_spread, first_contact_spread)
	if(gun_type)
		AddComponent(/datum/component/ai_magazine, gun_type) // for reloading

// mobility based on weapon type
/mob/living/basic/human/proc/pick_mobility()
	var/obj/item/gun/gun_type = get_gun_type()
	if(!gun_type)
		return AI_MOBILITY_NORMAL
	if(initial(gun_type.weapon_weight) >= WEAPON_HEAVY)
		return AI_MOBILITY_LOW
	if(initial(gun_type.weapon_weight) == WEAPON_LIGHT && initial(gun_type.w_class) <= WEIGHT_CLASS_NORMAL)
		return AI_MOBILITY_HIGH
	return AI_MOBILITY_NORMAL

/mob/living/basic/human/proc/get_gun_type()
	if(ispath(r_hand, /obj/item/gun))
		return r_hand
	if(ispath(l_hand, /obj/item/gun))
		return l_hand
	return null

// lets them get shoved
/mob/living/basic/human/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(user.a_intent != INTENT_DISARM || stat != CONSCIOUS || user == src)
		return ..()
	var/turf/old_turf = loc
	. = ..()
	if(stat != CONSCIOUS)
		return
	if(loc == old_turf)
		Stun(1.5 SECONDS) // up against something, so we're sent reeling
		return
	if(!has_movespeed_modifier(/datum/movespeed_modifier/shove))
		add_movespeed_modifier(/datum/movespeed_modifier/shove)
		addtimer(CALLBACK(src, PROC_REF(clear_shove_slowdown)), SHOVE_SLOWDOWN_LENGTH)

/mob/living/basic/human/proc/clear_shove_slowdown()
	remove_movespeed_modifier(/datum/movespeed_modifier/shove)

/mob/living/basic/human/MobBump(mob/bumped)
	if(!client && !noncombatant)
		return TRUE
	return ..()

/mob/living/basic/human/proc/setup_ai()
	AddElement(/datum/element/ai_door_opener)
	if(!noncombatant)
		ADD_TRAIT(src, TRAIT_NOMOBSWAP, INNATE_TRAIT)
		status_flags &= ~CANPUSH
	AddElement(/datum/element/ai_reacts_to_harm)
	AddElement(/datum/element/ai_hears_gunfire)
	AddComponent(/datum/component/ai_morale, morale_breaks)
	if(!in_hardsuit && see_in_dark < AI_NIGHT_VISION) // hardsuits have a light of their own
		if(mob_spawner && spawner_has_flashlight(mob_spawner))
			AddComponent(/datum/component/ai_flashlight) // our corpse carries it already
		else if(prob(flashlight_chance))
			AddComponent(/datum/component/ai_flashlight, drops_on_death = TRUE)
	if(isnull(mobility))
		mobility = pick_mobility()
	var/obj/item/melee_weapon = get_melee_weapon()
	// fighting up close with something light, like a knife, we keep up the pressure by sidestepping around them between blows
	var/light_melee_fighter = !noncombatant && !(casing_type || projectile_type || fires_flames) && melee_weapon && !has_heavy_melee_weapon(melee_weapon)
	if(dodging || light_melee_fighter || mobility == AI_MOBILITY_HIGH)
		AddComponent(/datum/component/ai_dodging, dodge_chance, sidesteps, mobility == AI_MOBILITY_HIGH ? 50 : 25)
	if(callout_set || (length(on_aggro_say) && aggro_say_chance))
		// on_aggro_say is what we shout on spotting someone, in place of our callout set's lines for it, rather than as well
		AddComponent(/datum/component/ai_callouts, callout_set || /datum/ai_callout_set, mob_species, length(on_aggro_say) && aggro_say_chance ? on_aggro_say : null, aggro_say_chance)
	if(!ai_controller)
		return
	ai_controller.set_blackboard_key(BB_TARGET_MINIMUM_STAT, stat_attack)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_CAN_CLIMB, TRUE) // over sandbags and the like, as players can
	if(mob_spawner && spawner_has_jetpack(mob_spawner))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_CAN_CROSS_SPACE, TRUE)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_FLANK_PRIORITY, get_flank_priority())
	ai_controller.set_blackboard_key(BB_BASIC_MOB_MOBILITY, mobility)
	if(mobility == AI_MOBILITY_HIGH && (casing_type || projectile_type))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_HIT_AND_RUN, TRUE) // dart in for a few shots, then back off and come again
	if(vision_range)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_VISION_RANGE, vision_range)
	if(alert_range)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_ALERT_RANGE, alert_range)
	if(summons_backup)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_SUMMONS_BACKUP, TRUE)
	if(!r_hand && !l_hand)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_SHOVES_WHEN_CORNERED, TRUE) // nothing to swing, so we push them away to get room to run
	if(speak_chance && (length(speak) || length(emote_hear) || length(emote_see)))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_IDLE_CHATTER_CHANCE, speak_chance)
		if(length(speak))
			ai_controller.set_blackboard_key(BB_BASIC_MOB_IDLE_LINES, string_list(speak))
		if(length(emote_hear) || length(emote_see))
			ai_controller.set_blackboard_key(BB_BASIC_MOB_IDLE_EMOTES, string_list(emote_hear | emote_see))
	if(check_friendly_fire)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_AVOID_FRIENDLY_FIRE, TRUE)
	if(melee_weapon && !ispath(melee_weapon, /obj/item/gun))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_PREFERS_MELEE, TRUE) // a blade as well as a gun, so up close we'd rather use that
	if(!wander)
		QDEL_NULL(ai_controller.idle_behavior)
	if(rapid_melee > 1)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_MELEE_HITS, rapid_melee)
	if(!isnull(retreat_distance))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_RETREAT_DISTANCE, retreat_distance)
	else if(!isnull(engage_distance))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_RETREAT_DISTANCE, 0) // we only said how close to get, so get stuck in
	if(!isnull(engage_distance))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_ENGAGE_DISTANCE, engage_distance)

/mob/living/basic/human/death(gibbed)
	if(human_loot && stat != DEAD && isturf(loc))
		drop_human_loot()
	return ..()

/mob/living/basic/human/proc/drop_human_loot()
	if(mob_spawner)
		var/obj/effect/mob_spawn/spawner = new mob_spawner(loc, mob_species)
		var/mob/living/carbon/human/corpse = spawner.spawned_mob_ref?.resolve()
		if(corpse)
			corpse_ref = WEAKREF(corpse)
			wound_corpse(corpse)
	handle_hand_item_destruction(l_hand)
	handle_hand_item_destruction(r_hand)

// handles behavior for either dropping the held item or damaging it
/mob/living/basic/human/proc/handle_hand_item_destruction(obj/hand)
	if(!hand) // wow look nothing
		return
	if(ispath(hand, /obj/item/gun)) // we always drop guns, the drop chance just makes them functional
		var/obj/item/gun/dropped_gun = new hand(loc)
		modify_dropped_gun(dropped_gun)
	else if(prob(weapon_drop_chance)) // for melee weapons and stuff they just explode into dust
		new hand(loc)
	else
		visible_message(span_danger("[src]'s [initial(hand.name)] is destroyed as they collapse!"))

// applies special stuff to guns that are dropped, which are very special indeed
/mob/living/basic/human/proc/modify_dropped_gun(obj/item/gun/dropped_gun)
	var/good = TRUE
	// break gun and apply broken overlay
	if(!prob(weapon_drop_chance)) // you got the dud!
		good = FALSE
		visible_message(span_danger("[src]'s [dropped_gun.name] is destroyed as they collapse!"))
		dropped_gun.actually_shoots = FALSE
		dropped_gun.desc += span_warning("\nIt appears to be irreparably broken.")
		dropped_gun.glunkify() // broken overlay

	// BALLISTICS - apply wear, mag drop chance, and empty the mag partially
	if(istype(dropped_gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/cosmetic_damage = dropped_gun
		cosmetic_damage.gun_wear = rand(cosmetic_damage.wear_minor_threshold, cosmetic_damage.wear_maximum) //my free gun... it's bowowken...
		if(!prob(weapon_drop_chance) && !cosmetic_damage.internal_magazine)
			qdel(cosmetic_damage.magazine)
			cosmetic_damage.magazine = null
		if(cosmetic_damage.magazine)
			for(var/i in 1 to rand(0, cosmetic_damage.magazine.max_ammo))
				qdel(cosmetic_damage.magazine.get_round()) // feels kludgy but like. how else
			cosmetic_damage.magazine.update_ammo_count()
		cosmetic_damage.update_appearance()

	// ENERGY - drain cell a random amount, cell drop chance
	if(istype(dropped_gun, /obj/item/gun/energy))
		var/obj/item/gun/energy/lazor = dropped_gun
		if(lazor.cell)
			lazor.cell.charge = rand(0, lazor.cell.maxcharge)
			lazor.update_appearance()
			if(!good) // undamaged guns never have dud cells
				lazor.cell.name = "dented [lazor.cell.name]"
				lazor.cell.desc += " It doesn't seem to be in the greatest condition..."
				if(!prob(weapon_drop_chance))
					lazor.cell.rigged = TRUE // smiles warmly
					lazor.cell.show_rigged = FALSE

/mob/living/basic/human/melee_attack(atom/target)
	. = ..()
	if(!melee_knockback || !isliving(target))
		return
	var/mob/living/knocked = target
	if(!knocked.anchored)
		knocked.throw_at(get_edge_target_turf(knocked, dir), rand(1, melee_knockback), 2, src, gentle = gentle_knockback)

/mob/living/basic/human/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, armor_base))
			if(ispath(var_value, /obj/item/clothing))
				armor = get_clothing_armor(var_value)
				datum_flags |= DF_VAR_EDITED
				return TRUE
			return FALSE
	return ..()

/// The attachments a gun of this type spawns with, worked out by making one, once per type, and remembered
/proc/get_gun_default_attachments(gun_type)
	var/static/list/attachments_by_type = list()
	if(!ispath(gun_type, /obj/item/gun))
		return list()
	if(!isnull(attachments_by_type[gun_type]))
		return attachments_by_type[gun_type]
	var/obj/item/gun/gun = new gun_type
	var/list/attachments = gun.default_attachments ? gun.default_attachments.Copy() : list()
	qdel(gun)
	attachments_by_type[gun_type] = attachments
	return attachments

/mob/living/basic/human/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	face_target_while_moving()

/mob/living/basic/human/proc/face_target_while_moving()
	if(noncombatant || !ai_controller)
		return
	// still firing, like a volley back at where shots came from on our way to cover, so keep facing where we're firing
	var/atom/fired_at = ai_controller.blackboard[BB_BASIC_MOB_LAST_FIRED_AT]
	if(!QDELETED(fired_at) && world.time - ai_controller.blackboard[BB_BASIC_MOB_LAST_FIRED_TIME] < 1 SECONDS)
		face_atom(fired_at)
		return
	var/atom/target = ai_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target) && ai_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		face_atom(target)

// wound the corpse the mob spawns
/mob/living/basic/human/proc/wound_corpse(mob/living/carbon/human/corpse)
	// anything we took that slipped past note_damage(), like heat or cold, which hurt basic mobs directly, counts as from all over
	var/noted_damage = untracked_brute + untracked_burn + oxy_damage_taken + tox_damage_taken
	for(var/zone in zone_brute)
		noted_damage += zone_brute[zone]
	for(var/zone in zone_burn)
		noted_damage += zone_burn[zone]
	untracked_brute += max(0, bruteloss - noted_damage) // basic mobs keep all their damage as bruteloss
	if(length(zone_brute) || length(zone_burn) || untracked_brute || untracked_burn)
		var/static/list/all_zones = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		corpse.heal_overall_damage(corpse.getBruteLoss(), corpse.getFireLoss())
		for(var/zone in all_zones)
			var/brute = LAZYACCESS(zone_brute, zone) + untracked_brute / length(all_zones)
			var/burn = LAZYACCESS(zone_burn, zone) + untracked_burn / length(all_zones)
			if(brute > 0)
				corpse.apply_damage(brute, BRUTE, zone, wound_bonus = CANT_WOUND)
			if(burn > 0)
				corpse.apply_damage(burn, BURN, zone, wound_bonus = CANT_WOUND)
	if(oxy_damage_taken)
		corpse.adjustOxyLoss(oxy_damage_taken)
	if(tox_damage_taken)
		corpse.adjustToxLoss(tox_damage_taken)
	if(length(bloodied_clothing_kinds) && blood_volume)
		var/list/blood_dna = get_blood_dna_list()
		for(var/obj/item/clothing/worn in corpse.get_equipped_items())
			if(is_type_in_list(worn, bloodied_clothing_kinds))
				worn.add_blood_DNA(blood_dna) // the blood that got on them, which shows on them and stays on them if they're taken
	corpse.regenerate_icons()
