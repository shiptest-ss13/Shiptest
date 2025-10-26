/obj/item/ammo_casing/proc/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from, misfire = FALSE)
	distro += variance
	var/targloc = get_turf(target)
	ready_proj(target, user, quiet, zone_override, fired_from, misfire)
	if(pellets == 1)
		if(distro) //We have to spread a pixel-precision bullet. throw_proj was called before so angles should exist by now...
			if(randomspread)
				spread = round((rand() - 0.5) * distro)
			else //Smart spread
				spread = round(1 - 0.5) * distro
		if(!throw_proj(target, targloc, user, params, spread, fired_from))
			return FALSE
	else
		if(isnull(BB))
			return FALSE
		AddComponent(/datum/component/pellet_cloud, projectile_type, pellets)
		SEND_SIGNAL(src, COMSIG_PELLET_CLOUD_INIT, target, user, fired_from, randomspread, spread, zone_override, params, distro)
	if(user)
		if(click_cooldown_override)
			user.changeNext_move(click_cooldown_override)

		user.newtonian_move(get_dir(target, user))
	var/obj/item/gun/ballistic/foulmouth = fired_from
	if(istype(foulmouth))
		foulmouth.adjust_wear(wear_modifier)
	update_appearance()
	return TRUE

/obj/item/ammo_casing/proc/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from, misfire = FALSE)
	if (!BB)
		return
	BB.original = target
	BB.firer = user
	BB.misfire = misfire
	BB.fired_from = fired_from
	if (zone_override)
		BB.def_zone = zone_override
	else
		if(user)
			BB.def_zone = user.zone_selected
	BB.suppressed = quiet

	if(isgun(fired_from))
		var/obj/item/gun/G = fired_from
		BB.damage *= G.projectile_damage_multiplier

	if(reagents && BB.reagents)
		reagents.trans_to(BB, reagents.total_volume, transfered_by = user) //For chemical darts/bullets
		qdel(reagents)

/obj/item/ammo_casing/proc/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread, atom/fired_from)
	var/modifiers = params2list(params)
	var/turf/curloc
	if(user)
		curloc = get_turf(user)
	else
		curloc = get_turf(src)
	if (!istype(targloc) || !istype(curloc) || !BB)
		return FALSE

	var/firing_dir
	if(BB.firer)
		firing_dir = BB.firer.dir
	if(!BB.suppressed && firing_effect_type)
		new firing_effect_type(get_turf(src), firing_dir)

	var/direct_target
	if(targloc == curloc)
		if(target) //if the target is right on our location we'll skip the travelling code in the proj's fire()
			direct_target = target
	if(!direct_target)
		if(user)
			BB.preparePixelProjectile(target, user, modifiers, spread)
		else
			BB.preparePixelProjectile(target, curloc, modifiers, spread)
	BB.fire(null, direct_target)
	BB = null
	return TRUE

#define BULLET_POP_CHANCE 30

/obj/item/ammo_casing/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(!prob(BULLET_POP_CHANCE) || !BB)
		return
	ready_proj()
	var/fire_dir = pick(GLOB.alldirs)
	var/turf/target = get_ranged_target_turf(get_turf(src),fire_dir,6)
	fire_casing(target,null, null, null, FALSE, ran_zone(BODY_ZONE_CHEST, 50), 0, src,TRUE)
	playsound(src, 'sound/weapons/gun/pistol/shot.ogg', 100, TRUE)
	update_appearance()
	return TRUE

/obj/item/ammo_casing/proc/spread(turf/target, turf/current, distro)
	var/dx = abs(target.x - current.x)
	var/dy = abs(target.y - current.y)
	return locate(target.x + round(gaussian(0, distro) * (dy+2)/8, 1), target.y + round(gaussian(0, distro) * (dx+2)/8, 1), target.z)
