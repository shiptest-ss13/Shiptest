

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
	speed_is_move_delay = TRUE
	// stunned, knocked down and knocked out as a player is, which basic mobs otherwise aren't. Take one out to make a mob immune to that kind
	status_flags = CANSTUN | CANKNOCKDOWN | CANUNCONSCIOUS | CANPUSH
	rotate_on_lying = TRUE // so you can see we're down
	stamina_regen_delay = STAMINA_REGEN_BLOCK_TIME // as long as a player waits before getting their breath back
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 1, OXY = 1) // stamina too, so stingballs, batons and disablers wear us down as they would a player
	speed = 1.8 // a touch slower than a running player, see RUN_DELAY, so they can be outrun, slightly slower than the simplemobs used to be I think

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
	/// Typepath of the grenade we throw, for grenadiers, and how many we carry. Any we've not thrown we can drop when we die, at weapon_drop_chance each
	var/obj/item/grenade/grenade_type
	var/grenade_count = 0
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
	/// If TRUE, what would knock us down or out only staggers us, slowing us for as long instead, capped, so we stay on our feet. For the likes of juiced-up brutes
	var/knockdowns_slow_instead = FALSE
	/// Until when we're staggered, with knockdowns_slow_instead
	var/staggered_until = 0
	/// How long stuns, knockdowns, paralysis and being knocked out last on us, as a multiplier, like 0.5 for a tough boss, or 0 to shrug them all off
	var/stun_multiplier = 1
	/// Until when we're off balance from being shoved away, and can't swing at anyone, and until when we can't be put off balance again, so we can't be shoved about forever
	var/off_balance_until = 0
	var/off_balance_immune_until = 0
	/// If TRUE, we wear a helmet or mask made to keep out tear gas and pepper spray, so they don't get to us
	var/pepper_proof = FALSE
	/// How well our helmet, glasses and mask shield our eyes from flashes, as a player's add up. A flashbang's flash takes 1 or more to stop
	var/flash_protection = 0

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
	/// Percent chance we throw a grenade that lands by us back, rather than running from it
	var/throw_back_chance = 5
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
	/// How far from home the mob chases someone before letting them go, twice that while they're fighting. 0 for no leash. Null leaves it to their AI
	var/leash_distance
	/// If FALSE, the mob stands still rather than wandering about when there's nothing to do, like sentries
	var/wander = TRUE
	/// If TRUE, the mob holds the spot it's put on, like a guard post or a sniper's nest, rather than flanking or going after anyone. Those with guns fight from within post_radius of it, taking cover there, those without only go a few tiles for anyone close. Always on for those that don't wander with a marksman's rifle
	var/holds_post = FALSE
	/// For those holding a post, how many tiles from it they'll go to take cover or get a shot. 0 to stay right on it
	var/post_radius = 3
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
	/// Chance each 2 seconds of a line, ours from speak or our callout set's, or one of emote_hear or emote_see, while there's nobody to fight
	var/speak_chance = 5
	/// What our archetype had on the blackboard for the keys our vars have set, as list(key = value), so setting one of those vars back to null restores the original archetype value
	var/list/archetype_blackboard

/mob/living/basic/human/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_pre_melee))
	// what we wear and carry slows us as much as it would a player: a hardsuit, or a heavy gun held ready
	var/move_delay = speed + (mob_spawner ? get_spawner_slowdown(mob_spawner) : 0)
	var/obj/item/gun/gun_type = get_gun_type()
	if(gun_type)
		move_delay += initial(gun_type.wield_slowdown)
		var/obj/item/attachment/foldable_stock/stock = get_gun_folding_stock(gun_type)
		if(stock)
			move_delay += initial(stock.toggled_slowdown) // add stock delay, same as carbons/player
	else
		// melee folks move FAST
		move_delay = AI_MELEE_MOVE_DELAY
	if(move_delay != speed)
		set_varspeed(move_delay)
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
	pepper_proof = in_hardsuit || (mob_spawner && spawner_is_pepper_proof(mob_spawner))
	if(mob_spawner)
		flash_protection = get_spawner_flash_protection(mob_spawner)
	if(in_hardsuit)
		flash_protection = max(flash_protection, hardsuit_helmet_flash_protection(armor_base)) // the hardsuit we're armoured as, if our outfit doesn't say
	if(length(loot))
		AddElement(/datum/element/death_drops, string_list(loot))
	setup_blood()
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_SHOE)
	setup_melee()
	setup_weapon()
	setup_ai()

// pressure check for damage
/mob/living/basic/human/handle_environment(datum/gas_mixture/environment, seconds_per_tick, times_fired)
	. = ..()
	if(stat == DEAD || pressure_sealed || !isturf(loc))
		return
	if(environment.return_pressure() < HAZARD_LOW_PRESSURE)
		adjustBruteLoss(LOW_PRESSURE_DAMAGE)

/mob/living/basic/human/InitializeAIController()
	if(!ai_controller)
		if(noncombatant)
			ai_controller = /datum/ai_controller/basic_controller/human/noncombatant
		else if(casing_type || projectile_type || fires_flames)
			var/ranged_controller = pick_ranged_controller()
			if(!wander && ranged_controller == /datum/ai_controller/basic_controller/human/ranged/marksman)
				holds_post = TRUE // a rifleman put somewhere to stand, like a bunker, is there to hold it
			ai_controller = holds_post ? pick_post_controller() : ranged_controller
		else
			ai_controller = pick_melee_controller()
	return ..()

/mob/living/basic/human/proc/pick_melee_controller()
	if(has_heavy_melee_weapon())
		return /datum/ai_controller/basic_controller/human/brute
	return /datum/ai_controller/basic_controller/human

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

// one holding a post, which only cares whether our gun's one to pin people down with
/mob/living/basic/human/proc/pick_post_controller()
	if(pick_ranged_controller() == /datum/ai_controller/basic_controller/human/ranged/support_gunner)
		return /datum/ai_controller/basic_controller/human/ranged/post/support_gunner
	return /datum/ai_controller/basic_controller/human/ranged/post

/mob/living/basic/human/MobBump(mob/bumped)
	if(!client && !noncombatant)
		return TRUE
	return ..()

/mob/living/basic/human/proc/setup_ai()
	setup_ai_components()
	if(!ai_controller)
		return
	setup_ai_blackboard()

/mob/living/basic/human/proc/setup_ai_components()
	AddElement(/datum/element/ai_door_opener)
	if(!noncombatant)
		ADD_TRAIT(src, TRAIT_NOMOBSWAP, INNATE_TRAIT)
		status_flags &= ~CANPUSH
	AddElement(/datum/element/ai_reacts_to_harm)
	AddElement(/datum/element/ai_hears_gunfire)
	AddComponent(/datum/component/ai_morale, morale_breaks)
	if(!in_hardsuit && see_in_dark < AI_NIGHT_VISION && !GetComponent(/datum/component/ai_flashlight)) // hardsuits have a light of their own
		if(mob_spawner && spawner_has_flashlight(mob_spawner))
			AddComponent(/datum/component/ai_flashlight) // our corpse carries it already
		else if(prob(flashlight_chance))
			AddComponent(/datum/component/ai_flashlight, drops_on_death = TRUE)
	if(isnull(mobility))
		mobility = pick_mobility()
	var/obj/item/melee_weapon = get_melee_weapon()
	// fighting up close with something light, like a knife, we keep up the pressure by sidestepping around them between blows
	var/light_melee_fighter = !noncombatant && !(casing_type || projectile_type || fires_flames) && melee_weapon && !has_heavy_melee_weapon(melee_weapon)
	if(!holds_post && (dodging || light_melee_fighter || mobility == AI_MOBILITY_HIGH))
		AddComponent(/datum/component/ai_dodging, dodge_chance, sidesteps, mobility == AI_MOBILITY_HIGH ? 50 : 25)
	if(callout_set || (length(on_aggro_say) && aggro_say_chance))
		// on_aggro_say is what we shout on spotting someone, in place of our callout set's lines for it, rather than as well
		AddComponent(/datum/component/ai_callouts, callout_set || /datum/ai_callout_set, mob_species, length(on_aggro_say) && aggro_say_chance ? on_aggro_say : null, aggro_say_chance, length(speak) ? string_list(speak) : null)

/mob/living/basic/human/proc/setup_ai_blackboard()
	ai_controller.set_blackboard_key(BB_BASIC_MOB_CAN_CLIMB, TRUE) // over sandbags and the like, as players can
	apply_ai_vars()
	if(holds_post)
		var/turf/post = get_turf(src)
		if(post && !is_bare_space(post))
			ai_controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, post) // post holders go back to their spawn post
	if(ispath(grenade_type, /obj/item/grenade) && grenade_count > 0)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_TYPE, grenade_type)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_GRENADES_LEFT, grenade_count)
	if(mob_spawner && spawner_has_jetpack(mob_spawner))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_CAN_CROSS_SPACE, TRUE)
	if(!casing_type && !projectile_type)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_FLANK_PRIORITY, 0) // melee and flamers, the archetypes on the blackboard are for who flanks first with a gun
	ai_controller.set_blackboard_key(BB_BASIC_MOB_MOBILITY, mobility)
	if(mobility == AI_MOBILITY_HIGH && (casing_type || projectile_type))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_HIT_AND_RUN, TRUE) // dart in for a few shots, then back off and come again
	if(!r_hand && !l_hand)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_SHOVES_WHEN_CORNERED, TRUE) // nothing to swing, so we push them away to get room to run
	var/obj/item/melee_weapon = get_melee_weapon()
	if(melee_weapon && !ispath(melee_weapon, /obj/item/gun))
		ai_controller.set_blackboard_key(BB_BASIC_MOB_PREFERS_MELEE, TRUE) // a blade as well as a gun, so up close we'd rather use that
	if(!wander || holds_post)
		QDEL_NULL(ai_controller.idle_behavior)

// proc for putting our vars onto the blackboard, so we can use it both at spawn and when rebuilding AI
/mob/living/basic/human/proc/apply_ai_vars()
	ai_controller.set_blackboard_key(BB_TARGET_MINIMUM_STAT, stat_attack)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_THROW_BACK_CHANCE, noncombatant ? 0 : throw_back_chance)
	var/leash = leash_distance
	if(isnull(leash) && holds_post)
		leash = max(3, post_radius)
	set_ai_var_key(BB_BASIC_MOB_LEASH_DISTANCE, leash)
	set_ai_var_key(BB_BASIC_MOB_POST_RADIUS, holds_post ? max(0, post_radius) : null)
	set_ai_var_key(BB_BASIC_MOB_VISION_RANGE, vision_range || null)
	set_ai_var_key(BB_BASIC_MOB_ALERT_RANGE, alert_range || null)
	set_ai_var_key(BB_BASIC_MOB_SUMMONS_BACKUP, summons_backup || null)
	set_ai_var_key(BB_BASIC_MOB_IDLE_CHATTER_CHANCE, speak_chance || null)
	var/list/idle_emotes
	if(speak_chance && (length(emote_hear) || length(emote_see)))
		idle_emotes = string_list((emote_hear || list()) | (emote_see || list()))
	set_ai_var_key(BB_BASIC_MOB_IDLE_EMOTES, idle_emotes)
	set_ai_var_key(BB_BASIC_MOB_AVOID_FRIENDLY_FIRE, check_friendly_fire || null)
	set_ai_var_key(BB_BASIC_MOB_MELEE_HITS, rapid_melee > 1 ? rapid_melee : null)
	var/retreat = retreat_distance
	if(isnull(retreat) && !isnull(engage_distance))
		retreat = 0
	set_ai_var_key(BB_BASIC_MOB_RETREAT_DISTANCE, retreat)
	set_ai_var_key(BB_BASIC_MOB_ENGAGE_DISTANCE, engage_distance)

// Sets a blackboard key from one of our vars. Null restores the original archetype value, if it had one.
/mob/living/basic/human/proc/set_ai_var_key(key, value)
	if(isnull(value))
		if(!(key in archetype_blackboard))
			return // never set it, so it's still our archetype's
		value = archetype_blackboard[key]
	else if(!(key in archetype_blackboard))
		LAZYSET(archetype_blackboard, key, ai_controller.blackboard[key])
	if(islist(ai_controller.blackboard[key]) || isnull(value))
		ai_controller.clear_blackboard_key(key) // set_blackboard_key won't set over a list
	if(!isnull(value))
		ai_controller.set_blackboard_key(key, value)

// Throws our AI away and builds it again from our vars, for bits that only get read as it's set up
/mob/living/basic/human/proc/rebuild_ai(new_controller_type)
	if(stat == DEAD)
		return
	var/turf/home
	var/grenades_left
	if(istype(ai_controller, /datum/ai_controller))
		home = ai_controller.blackboard[BB_BASIC_MOB_HOME_TURF]
		grenades_left = ai_controller.blackboard[BB_BASIC_MOB_GRENADES_LEFT]
		ai_drop_held_grenade(ai_controller)
		qdel(ai_controller)
	ai_controller = null
	archetype_blackboard = null
	remove_status_effect(/datum/status_effect/ai_peppered)
	for(var/component_type in list(/datum/component/ai_morale, /datum/component/ai_dodging, /datum/component/ai_callouts, /datum/component/ranged_attacks, /datum/component/ai_magazine))
		qdel(GetComponent(component_type))
	RemoveElement(/datum/element/ai_door_opener)
	RemoveElement(/datum/element/ai_reacts_to_harm)
	RemoveElement(/datum/element/ai_hears_gunfire)
	REMOVE_TRAIT(src, TRAIT_NOMOBSWAP, INNATE_TRAIT)
	status_flags |= initial(status_flags) & CANPUSH
	ai_controller = new_controller_type
	InitializeAIController()
	setup_weapon()
	setup_ai()
	if(!ai_controller)
		return
	if(home)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, home)
	if(!isnull(grenades_left) && ai_controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE])
		ai_controller.set_blackboard_key(BB_BASIC_MOB_GRENADES_LEFT, grenades_left)

/mob/living/basic/human/death(gibbed)
	if(ai_controller)
		ai_drop_held_grenade(ai_controller) // drop the potato
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
	var/grenades_left = ai_controller?.blackboard[BB_BASIC_MOB_GRENADES_LEFT] || 0
	for(var/grenade_number in 1 to grenades_left)
		if(prob(weapon_drop_chance))
			new grenade_type(loc)

/mob/living/basic/human/vv_edit_var(var_name, var_value)
	// the vars apply_ai_vars() puts on the blackboard, so editing one actually affects a mob that already exists
	var/static/list/live_ai_vars
	if(!live_ai_vars)
		live_ai_vars = list(
			NAMEOF(src, stat_attack),
			NAMEOF(src, leash_distance),
			NAMEOF(src, post_radius),
			NAMEOF(src, throw_back_chance),
			NAMEOF(src, vision_range),
			NAMEOF(src, alert_range),
			NAMEOF(src, summons_backup),
			NAMEOF(src, speak_chance),
			NAMEOF(src, emote_hear),
			NAMEOF(src, emote_see),
			NAMEOF(src, check_friendly_fire),
			NAMEOF(src, rapid_melee),
			NAMEOF(src, retreat_distance),
			NAMEOF(src, engage_distance),
		)
	if(var_name in live_ai_vars)
		. = ..()
		if(istype(ai_controller, /datum/ai_controller))
			apply_ai_vars()
		return
	switch(var_name)
		if(NAMEOF(src, ai_controller))
			if(!ispath(var_value, /datum/ai_controller))
				return FALSE // a path to swap to, as a mapper would set it. Anything else would leave our old one running with nothing pointing at it
			rebuild_ai(var_value)
			datum_flags |= DF_VAR_EDITED
			return TRUE
		if(NAMEOF(src, grenade_type), NAMEOF(src, grenade_count))
			. = ..()
			if(ispath(grenade_type, /obj/item/grenade) && grenade_count > 0)
				ai_controller?.set_blackboard_key(BB_BASIC_MOB_GRENADE_TYPE, grenade_type) // so a mob that already exists can throw them
				ai_controller?.set_blackboard_key(BB_BASIC_MOB_GRENADES_LEFT, grenade_count)
			else
				ai_controller?.clear_blackboard_key(BB_BASIC_MOB_GRENADES_LEFT)
			return
		if(NAMEOF(src, armor_base))
			if(ispath(var_value, /obj/item/clothing))
				armor = get_clothing_armor(var_value)
				datum_flags |= DF_VAR_EDITED
				return TRUE
			return FALSE
	return ..()

/mob/living/basic/human/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_AI_REBUILD, "Rebuild AI")

/mob/living/basic/human/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_AI_REBUILD] && check_rights(R_DEBUG))
		rebuild_ai()
		log_admin("[key_name(usr)] rebuilt the AI of [key_name(src)].")
		to_chat(usr, span_notice("Rebuilt [src]'s AI from its vars."))

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
