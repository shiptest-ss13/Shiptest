#define get_dist_euclide_square(A, B) (A && B ? A.z == B.z ? (A.x - B.x)**2 + (A.y - B.y)**2 : INFINITY : INFINITY)
#define get_dist_euclide(A, B) (sqrt(get_dist_euclide_square(A, B)))


/obj/item/binoculars/rangefinder
	name = "rangefinder"
	desc = "A pair of binoculars, with a laser targeting function that will tell you the gps location where you point it."
	icon_state = "rangefinder"


/obj/item/binoculars/rangefinder/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	var/turf/targloc = get_turf(target)
	//laser pointer image
	var/image/I = image('icons/obj/projectiles.dmi',targloc,"red_laser",10)
	var/list/modifiers = params2list(params)
	if(modifiers)
		if(LAZYACCESS(modifiers, ICON_X))
			I.pixel_x = (text2num(LAZYACCESS(modifiers, ICON_X)) - 16)
		if(LAZYACCESS(modifiers, ICON_Y))
			I.pixel_y = (text2num(LAZYACCESS(modifiers, ICON_Y)) - 16)
	else
		I.pixel_x = target.pixel_x + rand(-5,5)
		I.pixel_y = target.pixel_y + rand(-5,5)

	var/datum/virtual_level/our_vlevel = get_virtual_level()
	if(!our_vlevel)
		return
	var/list/coords = our_vlevel.get_relative_coords(targloc)

	to_chat(user, span_notice("COORDINATES: LONGITUDE [coords[1]]. LATITUDE [coords[2]]."))
	playsound(src, 'modular_thabes/modules/artillery/sound/binoctarget.ogg', 35)


/obj/machinery/artillery
	name = "\improper howitzer"
	desc = "A manual, crew-operated and towable howitzer, will rain down shells on any of your foes."
	icon = 'modular_thabes/modules/artillery/icons/howitzer.dmi'
	icon_state = "howitzer_deployed"
	var/fire_sound = 'modular_thabes/modules/artillery/sound/howitzer_fire.ogg'
	var/reload_sound = 'modular_thabes/modules/artillery/sound/tat36_reload.ogg'
	var/fall_sound = 'modular_thabes/modules/artillery/sound/howitzer_whistle.ogg'
	obj_integrity = 400
	max_integrity = 400

	can_be_unanchored = TRUE
	pixel_x = -16
	anchored = FALSE // You can move this.

	/// Number of turfs to offset from target by 1
	var/offset_per_turfs = 15
	///Minimum range to fire
	var/minimum_range = 15
	/// Constant spread on target
	var/spread = 1
	/// Max spread on target
	var/max_spread = 5
	/// Used for deconstruction and aiming sanity
	var/firing = 0
	///Time it takes for the mortar to cool off to fire
	var/cool_off_time = 10 SECONDS
	///Time to load a shell
	var/reload_time = 1 SECONDS
	var/target_x
	var/target_y

	/// What type of shells can we use?
	var/list/allowed_shells = list(
		/obj/item/mortal_shell/howitzer,
		/obj/item/mortal_shell/howitzer/incendiary,
	)

/obj/machinery/artillery/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	var/old_x = target_x
	var/old_y = target_y
	var/inputed

	inputed = input(usr, "Set target X", "Coords", target_x) as num
	if(!inputed)
		return
	target_x = inputed
	inputed = input(usr, "Set target Y", "Coords", target_y) as num
	if(!inputed)
		return
	target_y = inputed

	var/datum/virtual_level/our_vlevel = get_virtual_level()
	if(!our_vlevel)
		return

	var/real_x = our_vlevel.low_x + target_x - 1
	var/real_y = our_vlevel.low_y + target_y - 1

	var/turf/target_turf = locate(real_x, real_y, z)
	var/list/our_coords = our_vlevel.get_relative_coords(target_turf)

	if(!target_turf)
		user.balloon_alert(user, "Invalid location.")
		target_x = old_x
		target_y = old_y

		return

	if(get_dist(loc, target_turf) < minimum_range)
		user.balloon_alert(user, "The target is too close to the gun.")
		target_x = old_x
		target_y = old_y
		return

	if(!isturf(target_turf) || isindestructiblewall(target_turf))
		user.balloon_alert(user, "You cannot fire the gun to this target.")
		target_x = old_x
		target_y = old_y
		return

	if(!target_turf.virtual_z() == virtual_z())
		user.balloon_alert(user, "You cannot fire the gun to this target.")
		target_x = old_x
		target_y = old_y
		return

	to_chat(user, span_notice("TARGET SET: LONGITUDE [our_coords[1]]. LATITUDE [our_coords[2]]."))

/obj/machinery/artillery/proc/perform_firing_visuals()
	SHOULD_NOT_SLEEP(TRUE)
	return

/obj/machinery/artillery/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(firing)
		user.balloon_alert(user, "The barrel is steaming hot. Wait till it cools off")
		return

	if(istype(I, /obj/item/mortal_shell))
		var/obj/item/mortal_shell/mortar_shell = I

//		if(!(I.type in allowed_shells))
//			user.balloon_alert(user, "This shell doesn't fit")
//			return

		user.visible_message(span_notice("[user] starts loading \a [mortar_shell.name] into [src]."),
		span_notice("You start loading \a [mortar_shell.name] into [src]."))
		playsound(loc, reload_sound, 50, 1)
		if(!do_after(user, reload_time, src, NONE))
			return

		var/datum/virtual_level/our_vlevel = get_virtual_level()
		if(!our_vlevel)
			return

		var/real_x = our_vlevel.low_x + target_x - 1
		var/real_y = our_vlevel.low_y + target_y - 1

		var/turf/target_turf = locate(real_x, real_y, z)
		//var/list/our_coords = our_vlevel.get_relative_coords(target_turf)

		var/max_offset = round(abs((get_dist_euclide(src,target_turf)))/offset_per_turfs)
		var/firing_spread = max_offset + spread
		if(firing_spread > max_spread)
			firing_spread = max_spread

		var/list/turf_list = list()
		for(var/turf/spread_turf in RANGE_TURFS(firing_spread, target_turf))
			turf_list += spread_turf
		var/turf/impact_turf = pick(turf_list)
		mortar_shell.forceMove(src)
		begin_fire(impact_turf, mortar_shell)


///Start firing the gun on target and increase tally
/obj/machinery/artillery/proc/begin_fire(atom/target, obj/item/mortal_shell/arty_shell)
	firing = TRUE
	for(var/mob/M in GLOB.player_list)
		if(get_dist(M , src) <= 7)
			shake_camera(M, 1, 1)

	playsound(loc, fire_sound, 50, 1)
	flick(icon_state + "_fire", src)
	var/obj/projectile/shell = new arty_shell.ammo_type(get_turf(src))

	var/shell_range = min(get_dist_euclide(src, target), shell.range)

	shell.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	shell.firer = src
	shell.range = shell_range
	shell.fire(Get_Angle(src,target))

	perform_firing_visuals()

	var/fall_time = (shell_range/(shell.speed * 5)) - 0.5 SECONDS
	//prevent runtime
	if(fall_time < 0.5 SECONDS)
		fall_time = 0.5 SECONDS
	addtimer(CALLBACK(src, PROC_REF(falling), target, shell), fall_time)
	addtimer(VARSET_CALLBACK(src, firing, FALSE), cool_off_time)

///Begins fall animation for projectile and plays fall sound
/obj/machinery/artillery/proc/falling(turf/T, obj/projectile/shell)
	flick(shell.icon_state + "_falling", shell)
	playsound(T, fall_sound, 75, 1)

/obj/machinery/artillery/mortar
	name = "\improper mortar"
	desc = "A manual, crew-operated mortar system intended to rain down shells on anything it's aimed at. Less accurate than a howitzer, but still useful neverless. Needs to be set down first to fire. Ctrl+Click on a tile to deploy, drag the mortar's sprites to mob's sprite to undeploy."
	icon = 'modular_thabes/modules/artillery/icons/mortar.dmi'
	icon_state = "mortar_deployed"
	obj_integrity = 200
	max_integrity = 200
	fire_sound = 'modular_thabes/modules/artillery/sound/mortar_fire.ogg'
	reload_sound = 'modular_thabes/modules/artillery/sound/mortar_reload.ogg' // Our reload sound.
	fall_sound = 'modular_thabes/modules/artillery/sound/mortar_long_whistle.ogg' //The sound the shell makes when falling.
	/// Max spread on target
	max_spread = 5
	/// Used for deconstruction and aiming sanity
	firing = 0
	///Time it takes for the mortar to cool off to fire
	cool_off_time = 1 SECONDS
	///Time to load a shell
	reload_time = 0.5 SECONDS

	allowed_shells = list(
		/obj/item/mortal_shell/he,
		/obj/item/mortal_shell/incendiary,
		/obj/item/mortal_shell/smoke,
	)


// Shells themselves //

/obj/item/mortal_shell
	name = "\improper 80mm mortar shell"
	desc = "An unlabeled 80mm mortar shell, probably a casing."
	icon = 'modular_thabes/modules/artillery/icons/mortar.dmi'
	icon_state = "mortar_ammo_cas"
	w_class = WEIGHT_CLASS_SMALL
	///Ammo projectile typepath that the shell uses
	var/obj/projectile/bullet/ammo_type

/obj/item/mortal_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "An 80mm mortar shell, loaded with a high explosive charge."
	icon_state = "mortar_ammo_he"
	ammo_type = /obj/projectile/bullet/mortar

/obj/item/mortal_shell/incendiary
	name = "\improper 80mm incendiary mortar shell"
	desc = "An 80mm mortar shell, loaded with a napalm charge."
	icon_state = "mortar_ammo_inc"
	ammo_type = /obj/projectile/bullet/mortar/incend

/obj/item/mortal_shell/smoke
	name = "\improper 80mm smoke mortar shell"
	desc = "An 80mm mortar shell, loaded with smoke dispersal agents. Can be fired at marines more-or-less safely. Way slimmer than your typical 80mm."
	icon_state = "mortar_ammo_smk"
	ammo_type = /obj/projectile/bullet/mortar/smoke


/obj/item/mortal_shell/howitzer
	name = "\improper 150mm artillery shell"
	desc = "An unlabeled 150mm shell, probably a casing."
	icon = 'modular_thabes/modules/artillery/icons/howitzer.dmi'
	icon_state = "howitzer"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/mortal_shell/howitzer/incendiary
	name = "\improper 150mm incendiary artillery shell"
	desc = "An 150mm artillery shell, loaded with explosives to punch through light structures then burn out whatever is on the other side. Will ruin their day and skin."
	icon_state = "howitzer_incend"
	ammo_type = /obj/projectile/bullet/mortar/howi/incend

/obj/projectile/bullet/mortar
	name = "80mm shell"
	icon = 'modular_thabes/modules/artillery/icons/projectile.dmi'
	icon_state = "mortar"

	movement_type = PHASING
	pass_flags = PASSTABLE | PASSGRILLE | PASSGRILLE | PASSMOB | PASSCLOSEDTURF | LETPASSTHROW | PASSPLATFORM

	speed = 2
	damage = 0
	range = 1000
	light_color = COLOR_VERY_SOFT_YELLOW
	light_range = 1.5
	near_miss_sound = FALSE

/obj/projectile/bullet/mortar/proc/payload()
	explosion(get_turf(src), 1, 2, 5, 0, flame_range = 3)

/obj/projectile/bullet/mortar/on_range()
	payload()
	return ..()

/obj/projectile/bullet/mortar/incend/payload()
	explosion(get_turf(src), 0, 2, 3, 0, flame_range = 7)
	flame_radius(get_turf(src), 4)
	playsound(get_turf(src), pick('sound/weapons/gun/flamethrower/flamethrower1.ogg','sound/weapons/gun/flamethrower/flamethrower2.ogg','sound/weapons/gun/flamethrower/flamethrower3.ogg'), 35, 1, 4)

/obj/projectile/bullet/mortar/smoke
	///the smoke effect at the point of detonation
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread

/obj/projectile/bullet/mortar/smoke/payload()
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(get_turf(src), 0, 0, 1, 0,  flame_range = 3)
	playsound(get_turf(src), 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(10, get_turf(src), 11)
	smoke.start()

/obj/projectile/bullet/mortar/howi
	name = "150mm shell"
	icon_state = "howi"


/obj/projectile/bullet/mortar/howi/payload()
	explosion(get_turf(src), 1, 6, 7, 0, flame_range = 7)

/obj/projectile/bullet/mortar/howi/incend/payload()
	explosion(get_turf(src), 0, 3, 0, 0, 0, 3)
	flame_radius(5, get_turf(src))
	playsound(get_turf(src), pick('sound/weapons/gun/flamethrower/flamethrower1.ogg','sound/weapons/gun/flamethrower/flamethrower2.ogg','sound/weapons/gun/flamethrower/flamethrower3.ogg'), 35, 1, 4)

/obj/projectile/bullet/mortar/howi/smoke
	name = "150mm shell"
	icon_state = "howi"
