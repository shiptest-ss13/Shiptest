/// Check the tragectory of a simulated projectile and return what it hits
/proc/get_firing_line_object(atom/source, atom/target, obj/projectile/model_projectile, strict_length=FALSE)
	var/datum/testbeam/beam = new /datum/testbeam
	return beam.fire(source, target, model_projectile, strict_length)

/datum/testbeam
	var/atom/hit

/datum/testbeam/proc/set_hit(beam, firer, atom/target, angle)
	SIGNAL_HANDLER
	hit = target

/datum/testbeam/proc/fire(atom/source, atom/target, obj/projectile/model_projectile, strict_length=FALSE)
	var/obj/projectile/beam = new /obj/projectile/testbeam
	if(istype(model_projectile))
		beam.pass_flags = model_projectile.pass_flags
		beam.range = model_projectile.pass_flags

	beam.preparePixelProjectile(target, source)
	if(strict_length)
		beam.range = sqrt((source.x-target.x)**2+(source.y-target.y)**2)

	RegisterSignal(beam, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(set_hit))
	beam.fire()
	return hit

/obj/projectile/testbeam
	name = ""
	icon_state = ""
	damage = 0
	armour_penetration = 0
	hitsound = ""
	pass_flags = NONE
	ignore_concealment = TRUE
	hitscan = TRUE

	hitscan_light_intensity = 0
	hitscan_light_range = 0
	muzzle_flash_intensity = 0
	muzzle_flash_range = 0
	impact_light_intensity = 0
	impact_light_range = 0

/obj/projectile/testbeam/process_hit(turf/T, atom/target, hit_something)
	SEND_SIGNAL(src, COMSIG_PROJECTILE_SELF_ON_HIT, firer, target, Angle)
	qdel(src)
