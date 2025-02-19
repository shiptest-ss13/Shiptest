#define PHYSICS_GRAV_STANDARD 9.80665

///Remove the component as soon as there's zero velocity, useful for movables that will no longer move after being initially moved (blood splatters)
#define QDEL_WHEN_NO_MOVEMENT (1<<0)

///Stores information related to the movable's physics and keeping track of relevant signals to trigger movement
/datum/component/movable_physics
	///Modifies the pixel_x/pixel_y of an object every process()
	var/horizontal_velocity
	///Modifies the pixel_z of an object every process(), movables aren't Move()'d into another turf if pixel_z exceeds 16, so try not to supply a super high vertical value if you don't want the movable to clip through multiple turfs
	var/vertical_velocity
	///The horizontal_velocity is reduced by this every process(), this doesn't take into account the object being in the air vs gravity pushing it against the ground
	var/horizontal_friction
	///The vertical_velocity is reduced by this every process()
	var/z_gravity
	///The pixel_z that the object will no longer be influenced by gravity for a 32x32 turf, keep this value between -16 to 0 so it's visuals matches up with it physically being in the turf
	var/z_floor
	///The angle of the path the object takes on the x/y plane
	var/angle_of_movement
	///Flags for turning on certain physic properties, see the top of the file for more information on flags
	var/physic_flags
	///The cached animate_movement of the parent; any kind of gliding when doing Move() makes the physics look derpy, so we'll just make Move() be instant
	var/cached_animate_movement
	///The sound effect to play when bouncing off of something
	var/bounce_sound

	var/numbounce = 1

/datum/component/movable_physics/Initialize(_horizontal_velocity = 0, _vertical_velocity = 0, _horizontal_friction = 0, _z_gravity = 0, _z_floor = 0, _angle_of_movement = 0, _physic_flags = 0, _bounce_sound)
	. = ..()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_MOVABLE_IMPACT, PROC_REF(throw_impact_ricochet), override = TRUE)
	horizontal_velocity = _horizontal_velocity
	vertical_velocity = _vertical_velocity
	horizontal_friction = _horizontal_friction
	z_gravity = _z_gravity
	z_floor = _z_floor
	angle_of_movement = _angle_of_movement
	physic_flags = _physic_flags
	bounce_sound = _bounce_sound
	if(vertical_velocity || horizontal_velocity)
		start_movement()

///Let's get moving
/datum/component/movable_physics/proc/start_movement()
	var/atom/movable/moving_atom = parent
	cached_animate_movement = moving_atom.animate_movement
	moving_atom.animate_movement = NO_STEPS
	START_PROCESSING(SSmovablephysics, src)
	moving_atom.SpinAnimation(speed = 1 SECONDS, loops = 1)

///Alright it's time to stop
/datum/component/movable_physics/proc/stop_movement()
	var/atom/movable/moving_atom = parent
	moving_atom.animate_movement = cached_animate_movement
	STOP_PROCESSING(SSmovablephysics, src)
	if(physic_flags & QDEL_WHEN_NO_MOVEMENT)
		qdel(src)

/datum/component/movable_physics/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_IMPACT)

/datum/component/movable_physics/proc/throw_impact_ricochet(datum/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	var/atom/movable/atom_source = source
	ricochet(atom_source, Get_Angle(atom_source, throwingdatum.target_turf))

/datum/component/movable_physics/proc/z_floor_bounce(atom/movable/moving_atom)
	angle_of_movement += rand(-3000, 3000) / 100
	var/turf/a_turf = get_turf(moving_atom)
	if(istype(moving_atom, /obj/item/ammo_casing) && !bounce_sound)
		playsound(moving_atom, a_turf.bullet_bounce_sound, 50, TRUE)
	else
		playsound(moving_atom, bounce_sound, 50, TRUE)
	moving_atom.SpinAnimation(speed = 1 SECONDS / numbounce, loops = 1)
	moving_atom.pixel_z = z_floor
	horizontal_velocity = max(0, horizontal_velocity + (vertical_velocity * -0.8))
	vertical_velocity = max(0, ((vertical_velocity * -0.8) - 0.2))
	numbounce += 0.5

/datum/component/movable_physics/proc/ricochet(atom/movable/moving_atom, bounce_angle)
	angle_of_movement = ((180 - bounce_angle) - angle_of_movement)
	if(angle_of_movement < 0)
		angle_of_movement += 360
	//var/turf/a_turf = get_turf(moving_atom)
	//playsound(src, a_turf.bullet_bounce_sound, 50, TRUE)

/datum/component/movable_physics/proc/fix_angle(angle, atom/moving_atom)//fixes an angle below 0 or above 360
	if(!(angle_of_movement > 360) && !(angle_of_movement < 0))
		return angle //early return if it doesn't need to change
	var/new_angle
	if(angle_of_movement > 360)
		new_angle = angle_of_movement - 360
	if(angle_of_movement < 0)
		new_angle = angle_of_movement + 360
	return new_angle

/datum/component/movable_physics/process(delta_time)
	var/atom/movable/moving_atom = parent
	var/turf/location = get_turf(moving_atom)

	angle_of_movement = fix_angle(angle_of_movement, moving_atom)
	if(horizontal_velocity <= 0 && moving_atom.pixel_z == 0)
		horizontal_velocity = 0
		stop_movement()
		return

	moving_atom.pixel_x += (horizontal_velocity * (sin(angle_of_movement)))
	moving_atom.pixel_y += (horizontal_velocity * (cos(angle_of_movement)))

	horizontal_velocity = max(0, horizontal_velocity - horizontal_friction)

	moving_atom.pixel_z = max(z_floor, moving_atom.pixel_z + vertical_velocity)
	if(moving_atom.pixel_z > z_floor)
		vertical_velocity -= (z_gravity * 0.05)

	if(moving_atom.pixel_z <= z_floor && (vertical_velocity != 0) && moving_atom.has_gravity(location)) //z bounce
		z_floor_bounce(moving_atom)

	if(moving_atom.pixel_x > 16)
		if(moving_atom.Move(get_step(moving_atom, EAST)))
			moving_atom.pixel_x = -16
		else
			moving_atom.pixel_x = 16
			ricochet(moving_atom, 0)
		return

	if(moving_atom.pixel_x < -16)
		if(moving_atom.Move(get_step(moving_atom, WEST)))
			moving_atom.pixel_x = 16
		else
			moving_atom.pixel_x = -16
			ricochet(moving_atom, 0)
		return

	if(moving_atom.pixel_y > 16)
		if(moving_atom.Move(get_step(moving_atom, NORTH)))
			moving_atom.pixel_y = -16
		else
			moving_atom.pixel_y = 16
			ricochet(moving_atom, 180)
		return

	if(moving_atom.pixel_y < -16)
		if(moving_atom.Move(get_step(moving_atom, SOUTH)))
			moving_atom.pixel_y = 16
		else
			moving_atom.pixel_y = -16
			ricochet(moving_atom, 180)

