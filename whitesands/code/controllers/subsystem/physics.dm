// orbital period of an object w/ semi-major axis of 1 AU around an object of 1 solar mass
#define STD_ORBIT_TIME (1 MINUTES)

// the relative mass of the sun compared to "1" mass
#define SOLAR_MASS 1

#define ONE_AU 1

// we can calculate G using our choice of units like so
#define NORM_GRAV_CONSTANT (((2 * PI / STD_ORBIT_TIME)**2)/SOLAR_MASS)

SUBSYSTEM_DEF(physics)
	name = "Physics"
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND
	wait = 2

	// copied from SSprocessing
	var/list/processing = list()
	var/list/currentrun = list()

	// used to stop physics objects from changing their movement speed regardless of the subsystem's status
	var/last_realtime
	var/current_realtime

	var/datum/physics_object/sun
	var/list/outputs = list()

/datum/controller/subsystem/physics/Initialize()
	last_realtime = REALTIMEOFDAY
	return ..()

/datum/controller/subsystem/physics/stat_entry(msg)
	msg = "PHYS:[length(processing)]"
	return ..()

/datum/controller/subsystem/physics/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
		current_realtime = REALTIMEOFDAY
	var/delta_time = current_realtime - last_realtime

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun
	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
		else if(thing.process(wait) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return

	last_realtime = current_realtime

/datum/controller/subsystem/physics/proc/test_system(max_planets)
	if(sun)
		qdel(sun)

	for(var/O in processing)
		qdel(O)

	sun = new(attractor = null)
	sun.mass = 1

	var/num_planets = 0
	while(num_planets < max_planets)
		num_planets++
//		var/semi_major = pick(list(0.3871, 0.7233, 1, 1.5273, 5.2028, 9.5388, 19.1914, 30.0611))
		var/semi_major = 1
		var/eccentricity = rand(0, 10) / 100
		if(eccentricity == 1)
			eccentricity = 0
		var/periapsis_angle = rand(0, 359)

		var/datum/physics_object/planet = new(semi_major, eccentricity, periapsis_angle, sun)


/datum/physics_object
	// position relative to parent
	var/pos_x = 0
	var/pos_y = 0
	// velocity relative to parent
	var/vel_x = 0
	var/vel_y = 0
	// acceleration relative to parent
	var/acc_x = 0
	var/acc_y = 0

	var/affected_by_grav = TRUE
	var/mass = 0.00003
	var/datum/physics_object/parent

/// Argument of periapsis should be passed in degrees.
/datum/physics_object/New(s_m_axis = 1, eccentricity = 0, arg_of_periapsis = 0, datum/physics_object/attractor)
	if(!attractor)
		return
	parent = attractor

	if(eccentricity < 0 || eccentricity >= 1)
		WARNING("Unsupported eccentricity '[eccentricity]' passed to orbiter! Assuming 0.")
		eccentricity = 0

	// we place it at periapsis	for now because that's easier
	var/radius = s_m_axis * (1 - eccentricity**2)
	pos_x = cos(arg_of_periapsis)*radius
	pos_y = sin(arg_of_periapsis)*radius

	var/speed = sqrt(NORM_GRAV_CONSTANT*parent.mass * ((2/radius)-(1/s_m_axis)))
	// since we're at periapsis the velocity vector is perpendicular to the position vector
	vel_x = -sin(arg_of_periapsis)*speed
	vel_y =  cos(arg_of_periapsis)*speed

	update_acceleration()

	START_PROCESSING(SSphysics, src)

/datum/physics_object/Destroy()
	STOP_PROCESSING(SSphysics, src)
	return ..()

/datum/physics_object/process(d_t)
	pos_x += d_t*(vel_x + (d_t*acc_x/2))
	pos_y += d_t*(vel_y + (d_t*acc_y/2))

	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2
	update_acceleration()
	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2

/datum/physics_object/proc/update_acceleration()
	if(!affected_by_grav)
		return

	var/radius = get_distance_to_parent()
	var/acc = NORM_GRAV_CONSTANT*parent.mass / (radius**2)

	// acceleration is parallel and opposite to offset from parent
	acc_x = -(pos_x/radius)*acc
	acc_y = -(pos_y/radius)*acc

/datum/physics_object/proc/total_energy()
	return mass*((vel_x**2 + vel_y**2)/2 - NORM_GRAV_CONSTANT*parent.mass/get_distance_to_parent())

/datum/physics_object/proc/get_distance_to_parent()
	return sqrt(pos_x**2 + pos_y**2)
