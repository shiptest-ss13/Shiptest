
#define ZOOM_LOCK_AUTOZOOM_FREEMOVE 0
#define ZOOM_LOCK_AUTOZOOM_ANGLELOCK 1
#define ZOOM_LOCK_CENTER_VIEW 2
#define ZOOM_LOCK_OFF 3

#define AUTOZOOM_PIXEL_STEP_FACTOR 48

// #define AIMING_BEAM_ANGLE_CHANGE_THRESHOLD 0.1

/obj/item/gun/energy/beam_rifle
	name = "particle acceleration rifle"
	desc = "An energy-based anti material marksman rifle that uses highly charged particle beams moving at extreme velocities to decimate whatever is unfortunate enough to be targeted by one. \
		<span class='boldnotice'>Hold down left click while scoped to aim, when weapon is fully aimed (Tracer goes from red to green as it charges), release to fire. Moving while aiming or \
		changing where you're pointing at while aiming will delay the aiming process depending on how much you changed.</span>"
	icon = 'icons/obj/guns/energy.dmi'
	icon_state = "esniper"
	item_state = "esniper"
	fire_sound = 'sound/weapons/beam_sniper.ogg'
	slot_flags = ITEM_SLOT_BACK
	force = 15
	custom_materials = null
	recoil = 4
	ammo_x_offset = 3
	ammo_y_offset = 3
	modifystate = FALSE
	charge_sections = 1
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/beam_rifle/hitscan)
	internal_magazine = FALSE
	default_ammo_type = /obj/item/stock_parts/cell/gun/large
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/large,
	)
	gun_firemodes = list(FIREMODE_AIMED)
	default_firemode = FIREMODE_AIMED
	// var/aiming = FALSE
	// var/aiming_time = 12
	// var/aiming_time_fire_threshold = 5
	// var/aiming_time_left = 12
	// var/aiming_time_increase_user_movement = 3
	// var/scoped_slow = 1
	// var/aiming_time_increase_angle_multiplier = 0.3
	// var/last_process = 0

	// var/lastangle = 0
	// var/aiming_lastangle = 0
	// var/mob/current_user = null
	// var/list/obj/effect/projectile/tracer/current_tracers

	var/structure_piercing = 2				//Amount * 2. For some reason structures aren't respecting this unless you have it doubled. Probably with the objects in question's Bump() code instead of this but I'll deal with this later.
	var/structure_bleed_coeff = 0.7
	var/wall_pierce_amount = 0
	var/wall_devastate = 0
	var/aoe_structure_range = 1
	var/aoe_structure_damage = 50
	var/aoe_fire_range = 2
	var/aoe_fire_chance = 40
	var/aoe_mob_range = 1
	var/aoe_mob_damage = 30
	var/impact_structure_damage = 60
	var/projectile_damage = 30
	var/projectile_stun = 0
	var/projectile_setting_pierce = TRUE
	var/delay = 25

/obj/item/gun/energy/beam_rifle/debug
	delay = 0
	default_ammo_type = /obj/item/stock_parts/cell/infinite
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/infinite,
	)
	aiming_time = 0
	recoil = 0

/obj/item/gun/energy/beam_rifle/unique_action(mob/living/user)
	projectile_setting_pierce = !projectile_setting_pierce
	to_chat(user, span_boldnotice("You set \the [src] to [projectile_setting_pierce? "pierce":"impact"] mode."))

/obj/item/gun/energy/beam_rifle/Initialize()
	. = ..()
	fire_delay = delay

/obj/item/gun/energy/beam_rifle/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chambered = null
	recharge_newshot()

/obj/item/gun/energy/beam_rifle/proc/sync_ammo()
	for(var/obj/item/ammo_casing/energy/beam_rifle/AC in contents)
		AC.sync_stats()

/obj/item/ammo_casing/energy/beam_rifle
	name = "particle acceleration lens"
	desc = "Don't look into barrel!"
	var/wall_pierce_amount = 0
	var/wall_devastate = 0
	var/aoe_structure_range = 1
	var/aoe_structure_damage = 30
	var/aoe_fire_range = 2
	var/aoe_fire_chance = 66
	var/aoe_mob_range = 1
	var/aoe_mob_damage = 20
	var/impact_structure_damage = 50
	var/projectile_damage = 40
	var/projectile_stun = 0
	var/structure_piercing = 2
	var/structure_bleed_coeff = 0.7
	var/do_pierce = TRUE
	var/obj/item/gun/energy/beam_rifle/host

/obj/item/ammo_casing/energy/beam_rifle/proc/sync_stats()
	var/obj/item/gun/energy/beam_rifle/BR = loc
	if(!istype(BR))
		stack_trace("Beam rifle syncing error")
	host = BR
	do_pierce = BR.projectile_setting_pierce
	wall_pierce_amount = BR.wall_pierce_amount
	wall_devastate = BR.wall_devastate
	aoe_structure_range = BR.aoe_structure_range
	aoe_structure_damage = BR.aoe_structure_damage
	aoe_fire_range = BR.aoe_fire_range
	aoe_fire_chance = BR.aoe_fire_chance
	aoe_mob_range = BR.aoe_mob_range
	aoe_mob_damage = BR.aoe_mob_damage
	impact_structure_damage = BR.impact_structure_damage
	projectile_damage = BR.projectile_damage
	projectile_stun = BR.projectile_stun
	delay = BR.delay
	structure_piercing = BR.structure_piercing
	structure_bleed_coeff = BR.structure_bleed_coeff

/obj/item/ammo_casing/energy/beam_rifle/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	. = ..()
	var/obj/projectile/beam/beam_rifle/hitscan/HS_BB = BB
	if(!istype(HS_BB))
		return
	HS_BB.impact_direct_damage = projectile_damage
	HS_BB.stun = projectile_stun
	HS_BB.impact_structure_damage = impact_structure_damage
	HS_BB.aoe_mob_damage = aoe_mob_damage
	HS_BB.aoe_mob_range = clamp(aoe_mob_range, 0, 15)				//Badmin safety lock
	HS_BB.aoe_fire_chance = aoe_fire_chance
	HS_BB.aoe_fire_range = aoe_fire_range
	HS_BB.aoe_structure_damage = aoe_structure_damage
	HS_BB.aoe_structure_range = clamp(aoe_structure_range, 0, 15)	//Badmin safety lock
	HS_BB.wall_devastate = wall_devastate
	HS_BB.wall_pierce_amount = wall_pierce_amount
	HS_BB.structure_pierce_amount = structure_piercing
	HS_BB.structure_bleed_coeff = structure_bleed_coeff
	HS_BB.do_pierce = do_pierce
	HS_BB.gun = host

// /obj/item/ammo_casing/energy/beam_rifle/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread)
// 	var/turf/curloc = get_turf(user)
// 	if(!istype(curloc) || !BB)
// 		return FALSE
// 	var/obj/item/gun/energy/beam_rifle/gun = loc
// 	if(!targloc && gun)
// 		targloc = get_turf_in_angle(gun.lastangle, curloc, 10)
// 	else if(!targloc)
// 		return FALSE
// 	var/firing_dir
// 	if(BB.firer)
// 		firing_dir = BB.firer.dir
// 	if(!BB.suppressed && firing_effect_type)
// 		new firing_effect_type(get_turf(src), firing_dir)
// 	var/modifiers = params2list(params)
// 	BB.preparePixelProjectile(target, user, modifiers, spread)
// 	BB.fire(gun? gun.lastangle : null, null)
// 	BB = null
// 	return TRUE

/obj/item/ammo_casing/energy/beam_rifle/hitscan
	projectile_type = /obj/projectile/beam/beam_rifle/hitscan
	select_name = "beam"
	e_cost = 10000
	fire_sound = 'sound/weapons/beam_sniper.ogg'

/obj/projectile/beam/beam_rifle
	name = "particle beam"
	icon = null
	hitsound = 'sound/effects/explosion3.ogg'
	damage = 0				//Handled manually.
	damage_type = BURN
	flag = "energy"
	range = 150
	jitter = 10 SECONDS
	var/obj/item/gun/energy/beam_rifle/gun
	var/structure_pierce_amount = 0				//All set to 0 so the gun can manually set them during firing.
	var/structure_bleed_coeff = 0
	var/structure_pierce = 0
	var/do_pierce = TRUE
	var/wall_pierce_amount = 0
	var/wall_pierce = 0
	var/wall_devastate = 0
	var/aoe_structure_range = 0
	var/aoe_structure_damage = 0
	var/aoe_fire_range = 0
	var/aoe_fire_chance = 0
	var/aoe_mob_range = 0
	var/aoe_mob_damage = 0
	var/impact_structure_damage = 0
	var/impact_direct_damage = 0
	var/list/pierced = list()

/obj/projectile/beam/beam_rifle/proc/AOE(turf/epicenter)
	if(!epicenter)
		return
	new /obj/effect/temp_visual/explosion/fast(epicenter)
	for(var/mob/living/L in range(aoe_mob_range, epicenter))		//handle aoe mob damage
		L.adjustFireLoss(aoe_mob_damage)
		to_chat(L, span_userdanger("\The [src] sears you!"))
	for(var/turf/T in range(aoe_fire_range, epicenter))		//handle aoe fire
		if(prob(aoe_fire_chance))
			new /obj/effect/hotspot(T)
	for(var/obj/O in range(aoe_structure_range, epicenter))
		if(!isitem(O))
			O.take_damage(aoe_structure_damage * get_damage_coeff(O), BURN, "laser", FALSE)

/obj/projectile/beam/beam_rifle/prehit_pierce(atom/A)
	if(isclosedturf(A) && (wall_pierce < wall_pierce_amount))
		if(prob(wall_devastate))
			if(iswallturf(A))
				var/turf/closed/wall/W = A
				W.dismantle_wall(devastated = TRUE)
			else
				SSexplosions.medturf += A
		++wall_pierce
		return PROJECTILE_PIERCE_PHASE			// yeah this gun is a snowflakey piece of garbage
	if(isobj(A) && (structure_pierce < structure_pierce_amount))
		++structure_pierce
		var/obj/O = A
		O.take_damage((impact_structure_damage + aoe_structure_damage) * structure_bleed_coeff * get_damage_coeff(A), BURN, "energy", FALSE)
		return PROJECTILE_PIERCE_PHASE			// ditto and this could be refactored to on_hit honestly
	return ..()

/obj/projectile/beam/beam_rifle/proc/get_damage_coeff(atom/target)
	if(istype(target, /obj/machinery/door))
		return 0.4
	if(istype(target, /obj/structure/window))
		return 0.5
	return 1

/obj/projectile/beam/beam_rifle/proc/handle_impact(atom/target)
	if(isobj(target))
		var/obj/O = target
		O.take_damage(impact_structure_damage * get_damage_coeff(target), BURN, "laser", FALSE)
	if(isliving(target))
		var/mob/living/L = target
		L.adjustFireLoss(impact_direct_damage)
		L.force_scream()

/obj/projectile/beam/beam_rifle/proc/handle_hit(atom/target, piercing_hit = FALSE)
	set waitfor = FALSE
	if(nodamage)
		return FALSE
	playsound(src, 'sound/effects/explosion3.ogg', 100, TRUE)
	if(!piercing_hit)
		AOE(get_turf(target) || get_turf(src))
	if(!QDELETED(target))
		handle_impact(target)

/obj/projectile/beam/beam_rifle/on_hit(atom/target, blocked = FALSE, piercing_hit = FALSE)
	handle_hit(target, piercing_hit)
	return ..()

/obj/projectile/beam/beam_rifle/hitscan
	icon_state = ""
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/tracer/beam_rifle
	var/constant_tracer = FALSE

/obj/projectile/beam/beam_rifle/hitscan/generate_hitscan_tracers(cleanup = TRUE, duration = 5, impacting = TRUE, highlander)
	set waitfor = FALSE
	var/datum/component/aimed_fire/aiming = GetComponent(/datum/component/aimed_fire)
	if(isnull(highlander))
		highlander = constant_tracer
	if(highlander && istype(gun))
		QDEL_LIST(aiming.current_tracers)
		for(var/datum/point/p in beam_segments)
			aiming.current_tracers += generate_tracer_between_points(p, beam_segments[p], tracer_type, color, 0, hitscan_light_range, hitscan_light_color_override, hitscan_light_intensity)
	else
		for(var/datum/point/p in beam_segments)
			generate_tracer_between_points(p, beam_segments[p], tracer_type, color, duration, hitscan_light_range, hitscan_light_color_override, hitscan_light_intensity)
	if(cleanup)
		QDEL_LIST(beam_segments)
		beam_segments = null
		QDEL_NULL(beam_index)

/obj/projectile/beam/beam_rifle/hitscan/aiming_beam
	tracer_type = /obj/effect/projectile/tracer/tracer/aiming
	name = "aiming beam"
	hitsound = null
	hitsound_non_living = null
	nodamage = TRUE
	damage = 0
	constant_tracer = TRUE
	hitscan_light_range = 0
	hitscan_light_intensity = 0
	hitscan_light_color_override = "#99ff99"
	reflectable = REFLECT_FAKEPROJECTILE
	near_miss_sound = null
	ricochet_sound = null

/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/prehit_pierce(atom/target)
	return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/on_hit()
	qdel(src)
	return BULLET_ACT_BLOCK
