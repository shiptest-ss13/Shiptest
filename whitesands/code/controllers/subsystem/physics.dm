SUBSYSTEM_DEF(physics)
	name = "Physics"
	// DEBUG FIX -- update this priority to something else
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND
	// there's not much reason to set this lower than 1, as multiple ticks would have the same realtime in ds, resulting in
	// subsystem ticks where all objects are processed but none of actually move (because last_realtime - current_realtime == 0)
	wait = 2

	// copied from SSprocessing
	var/list/processing = list()
	var/list/currentrun = list()

	/// Used to stop physics objects from changing their movement speed even if the subsystem is ticked at a slower speed due to time dilation.
	/// This functionality is disabled during debug mode; the debugger can freeze the client, causing realtime to jump, resulting in significant orbital simulation mistakes.
	var/current_realtime
	var/last_realtime

/datum/controller/subsystem/physics/Initialize()
	last_realtime = REALTIMEOFDAY
	return ..()

/datum/controller/subsystem/physics/stat_entry(msg)
	msg = "PHYS:[length(processing)]"
	return ..()

/datum/controller/subsystem/physics/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
		// we only reset the current_realtime if we're starting a new tick; this keeps objects moving at consistent-ish rates, even if they're jumpy
		current_realtime = REALTIMEOFDAY
	var/delta_time = current_realtime - last_realtime

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun
	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
#ifndef DEBUG
		// uses the amount of time that passed between ticks IRL; means that clientside prediction doesn't need to account for TD
		else if(thing.process(delta_time) == PROCESS_KILL)
#else
		// doesn't use the "true" delta_time, instead using the subsystem's wait -- stops runtime error debugging from causing orbit mispredictions
		else if(thing.process(wait) == PROCESS_KILL)
#endif
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return

	last_realtime = current_realtime

/datum/component/physics_processing
	/// used to "parent" this component's physics location to another, such that the "true" pos / vel / acc are offset by those of the pos_parent.
	var/datum/component/physics_processing/pos_parent

	/// Bool. Whether this physics object is affected by the gravity of its pos_parent.
	var/pulled_by_grav = TRUE
	/// Number; the mass of this object, as used for physics calculations.
	var/mass = 0.00003

	// position relative to position parent
	var/pos_x = 0
	var/pos_y = 0
	// velocity relative to position parent (uses deciseconds)
	var/vel_x = 0
	var/vel_y = 0
	// acceleration relative to position parent (uses deciseconds)
	var/acc_x = 0
	var/acc_y = 0

/datum/component/physics_processing/Initialize(
		datum/component/physics_processing/_pos_parent = null,
		_pulled_by_grav = null,
		_mass = null,
		list/pos_list = null,
		list/vel_list = null,
		list/acc_list = null)

	// if physics parent isn't falsey, but isn't a physics processing component either -- our is ourself
	if(_pos_parent && !istype(_pos_parent) || src == _pos_parent)
		WARNING("Physics processing component initialized with invalid position parent! Cancelling component creation.")
		return COMPONENT_INCOMPATIBLE

	pos_parent = _pos_parent
	// these might be null; if they're not, we use them
	if(_pulled_by_grav != null)
		pulled_by_grav = _pulled_by_grav
	if(_mass != null)
		mass = _mass
	if(pos_list)
		pos_x = pos_list[1]
		pos_y = pos_list[2]
	if(vel_list)
		vel_x = vel_list[1]
		vel_y = vel_list[2]
	if(acc_list)
		acc_x = acc_list[1]
		acc_y = acc_list[2]

	START_PROCESSING(SSphysics, src)

// DEBUG REMOVE -- finish these up
/datum/component/physics_processing/RegisterWithParent()
	return

/datum/component/physics_processing/UnregisterFromParent()
	return

/datum/component/physics_processing/Destroy()
	STOP_PROCESSING(SSphysics, src)
	return ..()

/datum/component/physics_processing/process(d_t)
	pos_x += d_t*(vel_x + (d_t*acc_x/2))
	pos_y += d_t*(vel_y + (d_t*acc_y/2))

	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2
	update_acceleration()
	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2

/datum/component/physics_processing/proc/update_acceleration()
	var/forces = get_forces()

	acc_x = forces[1] / mass
	acc_y = forces[2] / mass

// DEBUG FIX -- update this to use a signal that attached objects can pick up on to return the forces affecting the body, instead of just gravity
/datum/component/physics_processing/proc/get_forces()
	if(!pulled_by_grav)
		return list(0, 0)

	var/distance = dist_to_pos_parent()
	var/force_of_grav = NORM_GRAV_CONSTANT*pos_parent.mass*mass / (distance * distance)

	// gravity is parallel and opposite to the offset from the attracting parent
	return list(-1*(pos_x/distance)*force_of_grav, -1*(pos_y/distance)*force_of_grav)

/datum/component/physics_processing/proc/dist_to_pos_parent()
	return sqrt(pos_x**2 + pos_y**2)

/**
  * Places the physics component in an orbit around its pos_parent according to the arguments passed; no return value.
  *
  * Sets the component's position, velocity, and acceleration around the pos_parent, according to their correct values
  * for the orbit given. Will throw an error if the component does not have a pos_parent (and thus cannot orbit it), or if eccentricity < 0.
  * This proc still runs if the component's do_grav variable is false; the component will fly off into space.
  * No return value.
  *
  * Arguments:
  * * s_m_axis - Semi-major axis of the orbit, default ONE_AU.
  * * eccentricity - Orbital eccentricity, default 0. e=0 - circular orbit, 0<e<1 - elliptic orbit, 1<=e - escape orbit. eccentricity < 0 will raise an error.
  * * counterclockwise - Bool; orbit is counterclockwise if TRUE and clockwise if FALSE, default TRUE.
  * * arg_of_periapsis - Measurement in degrees of the angle PERIAPSIS-PARENT-X AXIS, default 0. Measured according to arg "counterclockwise".
  * * true_anomaly - Measurement in degrees of the angle OBJECT-PARENT-PERIAPSIS, default 0. Measured according to arg "counterclockwise".
  */
/datum/component/physics_processing/proc/set_up_orbit(
		s_m_axis = ONE_AU,
		eccentricity = 0,
		counterclockwise = TRUE,
		arg_of_periapsis = 0,
		true_anomaly = 0)

	if(!pos_parent)
		CRASH("Tried to set up the orbit of a physics processing component without a pos_parent!")

	if(eccentricity < 0)
		WARNING("Unsupported eccentricity [eccentricity] passed to set_up_orbit()! Eccentricity must be >=0. Assuming 0.")
		eccentricity = 0

	// DEBUG REMOVE -- implement + test the calcs for eccentricity >= 1 (escape) orbits you FUCK
	if(eccentricity >= 1)
		CRASH("I haven't implemented this yet. Fuck.")

	var/norm_dist = (1 - eccentricity**2) / (1 + eccentricity*cos(true_anomaly))

	var/distance = s_m_axis*norm_dist
	// here's where we factor in clockwiseness
	var/pos_angle = (counterclockwise ? 1 : -1)*(true_anomaly + arg_of_periapsis)
	pos_x = cos(pos_angle)*distance
	pos_y = sin(pos_angle)*distance

	var/speed = sqrt(NORM_GRAV_CONSTANT*pos_parent.mass * ((2/distance)-(1/s_m_axis)))
	// gets the angle as measured from the center of the ellipse instead of the locus
	var/central_angle = arctan(norm_dist*sin(true_anomaly)/(norm_dist*cos(true_anomaly) + eccentricity))
	// offsets the central angle by the argument of periapsis, gets the perpendicular vel. unit vector by adding 90, and inverts if we're clockwise
	var/vel_angle = (counterclockwise ? 1 : -1)*(90 + central_angle + arg_of_periapsis)

	vel_x = cos(vel_angle)*speed
	vel_y = sin(vel_angle)*speed

	update_acceleration()
