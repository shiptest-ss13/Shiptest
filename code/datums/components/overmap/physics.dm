/datum/component/overmap/physics
	overmap_ui_comp_id = OVER_COMP_ID_PHYSICS

	/// Reference to the entity whose gravity acts upon ourself. Can be null.
	var/datum/overmap_ent/attractor = null
	/// Number; the mass of the attached entity, as used for physics calculations.
	var/mass = 1*MASS_TON

	// velocity (uses deciseconds)
	var/vel_x = 0
	var/vel_y = 0
	// acceleration (uses deciseconds)
	var/acc_x = 0
	var/acc_y = 0

/datum/component/overmap/physics/Initialize(
		_mass = null,
		list/vel_list = null,
		list/acc_list = null
	)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return

	// these might be null; if they're not, we use them
	if(_mass != null)
		mass = _mass
	if(vel_list)
		vel_x = vel_list[1]
		vel_y = vel_list[2]
	if(acc_list)
		acc_x = acc_list[1]
		acc_y = acc_list[2]

	START_PROCESSING(SSphysics, src)

// DEBUG FIX -- finish these up
/datum/component/overmap/physics/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_OVERMAP_GET_FORCES, .proc/add_grav_vec)

/datum/component/overmap/physics/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_OVERMAP_GET_FORCES)

/datum/component/overmap/physics/Destroy()
	STOP_PROCESSING(SSphysics, src)
	return ..()

/datum/component/overmap/physics/get_ui_data(datum/D, list/data)
	// the physics system uses deciseconds as its native units; the display does not.
	// to compensate, we convert velocity and acceleration to their respective values in seconds.
	. = ..()
	data[overmap_ui_comp_id]["velocity"] = list(vel_x SECONDS, vel_y SECONDS)
	data[overmap_ui_comp_id]["acceleration"] = list(acc_x SECONDS SECONDS, acc_y SECONDS SECONDS)

/datum/component/overmap/physics/process(d_t)
	// casting so the compiler shuts up
	var/datum/overmap_ent/e_parent = parent
	e_parent.pos_x += d_t*(vel_x + (d_t*acc_x/2))
	e_parent.pos_y += d_t*(vel_y + (d_t*acc_y/2))

	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2
	update_acceleration()
	vel_x += d_t*acc_x/2
	vel_y += d_t*acc_y/2

/datum/component/overmap/physics/proc/update_acceleration()
	var/list/force = list(0,0)
	SEND_SIGNAL(parent, COMSIG_OVERMAP_GET_FORCES, force)

	acc_x = force[1] / mass
	acc_y = force[2] / mass

/datum/component/overmap/physics/proc/add_grav_vec(datum/D, list/force_vec)
	if(!attractor)
		return
	var/datum/component/overmap/physics/att_phys = attractor.GetComponent(/datum/component/overmap/physics)
	if(!att_phys)
		return
	// casting so the compiler shuts up
	var/datum/overmap_ent/e_parent = parent

	var/distance = e_parent.get_dist_to(attractor)
	var/force_of_grav = NORM_GRAV_CONSTANT*att_phys.mass*mass / (distance * distance)

	// gravity is parallel and opposite to the offset from the attractor
	// note that the orbiter's pos is subtracted from the attractor's pos, not vice-versa; this gives us the opposite of the offset vector
	var/f_x = force_of_grav*((attractor.pos_x - e_parent.pos_x)/distance)
	var/f_y = force_of_grav*((attractor.pos_y - e_parent.pos_y)/distance)

	// get the attractor's acting force and combines them with our own; this is cheating but it makes things simpler

	var/list/att_force = list(0, 0)
	SEND_SIGNAL(attractor, COMSIG_OVERMAP_GET_FORCES, att_force)

	force_vec[1] += f_x + att_force[1]/att_phys.mass
	force_vec[2] += f_y + att_force[2]/att_phys.mass

/**
  * Places the component and associated entity in an orbit around a given entity according to args. No return value.
  *
  * Sets the entity's position, velocity, and acceleration around the attractor, according to the correct
  * values for the orbit given. Will throw an error if eccentricity < 0. Does not preserve current position.
  * No return value.
  *
  * Arguments:
  * * _attractor - The entity to orbit around. The called-upon component's "attractor" will be set to this.
  * * s_m_axis - Semi-major axis of the orbit, default DIST_AU.
  * * eccentricity - Orbital eccentricity, default 0. e=0 - circular orbit, 0<e<1 - elliptic orbit, 1<=e - escape orbit. eccentricity < 0 will raise an error.
  * * counterclockwise - Bool; orbit is counterclockwise if TRUE and clockwise if FALSE, default TRUE.
  * * arg_of_periapsis - Measurement in degrees of the angle PERIAPSIS-ATTRACTOR-X AXIS, default 0. Measured according to arg "counterclockwise".
  * * true_anomaly - Measurement in degrees of the angle ENTITY-ATTRACTOR-PERIAPSIS, default 0. Measured according to arg "counterclockwise".
  */
/datum/component/overmap/physics/proc/set_up_orbit(
		datum/overmap_ent/_attractor = null,
		s_m_axis = DIST_AU,
		eccentricity = 0,
		counterclockwise = TRUE,
		arg_of_periapsis = 0,
		true_anomaly = 0)

	if(eccentricity < 0)
		WARNING("Unsupported eccentricity [eccentricity] passed to set_up_orbit()! Eccentricity must be >=0. Assuming 0.")
		eccentricity = 0

	// DEBUG REMOVE -- implement + test the calcs for eccentricity >= 1 (escape) orbits you FUCK
	if(eccentricity >= 1)
		CRASH("I haven't implemented this yet. Fuck.")

	// casting so the compiler shuts up
	var/datum/overmap_ent/e_parent = parent

	attractor = _attractor
	var/datum/component/overmap/physics/att_phys = attractor.GetComponent(/datum/component/overmap/physics)

	// copying over variables from the attractor; we'll then offset these, but we need them as a base
	e_parent.pos_x = attractor.pos_x
	e_parent.pos_y = attractor.pos_y
	vel_x = att_phys.vel_x
	vel_y = att_phys.vel_y
	// note that we don't need to copy over acceleration, as that gets handled in update_acceleration

	var/norm_dist = (1 - eccentricity**2) / (1 + eccentricity*cos(true_anomaly))

	var/distance = s_m_axis*norm_dist
	// here's where we factor in clockwiseness
	var/pos_angle = (counterclockwise ? 1 : -1)*(true_anomaly + arg_of_periapsis)
	e_parent.pos_x += cos(pos_angle)*distance
	e_parent.pos_y += sin(pos_angle)*distance

	var/speed = sqrt(NORM_GRAV_CONSTANT*att_phys.mass * ((2/distance)-(1/s_m_axis)))
	// gets the angle tangent to the ellipse
	var/mi_over_ma = sqrt(1-(eccentricity**2))
	var/tangent_angle = arctan(-norm_dist*sin(true_anomaly)/mi_over_ma, mi_over_ma*(norm_dist*cos(true_anomaly)+eccentricity))
	// offsets the tangent angle by the argument of periapsis and inverts if we're clockwise
	var/vel_angle = (counterclockwise ? 1 : -1)*(tangent_angle + arg_of_periapsis)

	vel_x += cos(vel_angle)*speed
	vel_y += sin(vel_angle)*speed

	update_acceleration()
