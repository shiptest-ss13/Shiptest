//THEY ARENT LASERS
//THEYRE PLASMA GUNS
//USING LORENTZ FORCE

/obj/item/gun/energy/cybersun
	name = "cybersun gun master type"
	desc = ""
	icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/cybersun/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/cybersun/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/cybersun/onmob.dmi'

	icon_state = "troubleshooter"

	ammo_type = list()

	vary_fire_sound = FALSE

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun
	ammo_type = list(/obj/item/ammo_casing/energy/ionization)

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/heavy,
		/obj/item/stock_parts/cell/gun/cybersun/mini,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/heavy/empty,
		/obj/item/stock_parts/cell/gun/cybersun/mini/empty,
	)

	muzzleflash_iconstate = null
	light_color = COLOR_MAROON

	modifystate = FALSE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_CYBERSUN
	w_class = WEIGHT_CLASS_NORMAL

	bad_type = /obj/item/gun/energy/cybersun

//ionization pistol
/obj/item/gun/energy/cybersun/troubleshooter
	name = "\improper IT22 Troubleshooter"
	desc = "A compact energy pistol functioning off ionization principles. A low-powered laser provides a path of least resistance for a low-intensity plasma bolt to travel through. Typically issued to Virtual Solutions support staff."

	icon_state = "troubleshooter"
	item_state = "small"

	w_class = WEIGHT_CLASS_TINY
	weapon_weight = WEAPON_LIGHT

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/ionization)

	shaded_charge = FALSE
	modifystate = FALSE

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	min_recoil = 0
	recoil = 0.1

	spread = -2
	spread_unwielded = 2

	muzzleflash_iconstate = ""

/obj/item/gun/energy/cybersun/trouble/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/cybersun/troubleshooter/bridge_safe/Initialize(mapload, spawn_empty)
	name = "Ship's Aide"
	desc = "A custom-engraved IT22 Troubleshooter Ionization Pistol. An engraving of two [pick("women", "men", "kepori sloppily")] kissing has been delicately engraved into the barrel. Below it, \"Absolute power, absolute destiny\" has been written in Galactic Common."
	. = ..()

/obj/item/gun/energy/cybersun/troubleshooter/lensman
	name = "\improper Lensman-5"
	desc = "A high-powered conversion of the IT22 Troubleshooter typically used by paramilitary organizations in CLIP space. Despite Tadeusz Armories not manufacturing them officially, an ever-growing amount seems to exist."

	icon_state = "lensman"
	item_state = "lensman"

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/ionization/sniper)

	zoom_amt = DMR_ZOOM
	zoom_out_amt = -1

	recoil = 1

	spread = 0
	spread_unwielded = 2

	muzzleflash_iconstate = ""

/obj/item/gun/energy/cybersun/trouble/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/cybersun/galvanizer
	name = "\improper IT34 Galvanizer"
	desc = "A marksman rifle functioning off ionization principles. A low powered laser makes a clear path for a high intensity plasma bolt to near-instantly travel. The integrated scope allows for accurate fire at long distances."

	icon_state = "galvanizer"
	item_state = "galvanizer"

	ammo_type = list(/obj/item/ammo_casing/energy/ionization/sniper)

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/heavy,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/heavy/empty,
	)


	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

	zoomable = TRUE
	zoom_amt = DMR_ZOOM

	wield_delay = 1 SECONDS
	fire_delay = 0.8 SECONDS

	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN
	aimed_wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	spread = 0
	spread_unwielded = 12

	min_recoil = 0
	min_recoil_aimed = 0
	recoil = 0.5

//parent type for lorentz guns since they have snowflake behavior
/obj/item/gun/energy/cybersun/lorentz
	name = "cybersun lawrence gun supertype"
	desc = "hey if you guys see this can you tell my mom i'm like really busy right now so i cant watch for it"

	//ammo_type = list(/obj/item/ammo_casing/energy/lorentz, /obj/item/ammo_casing/energy/flare)

	latch_icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	latch_icon_state = "opportunist"

	always_show_latch = TRUE

	min_recoil = 0.1
	min_recoil_aimed = 0

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz, /obj/item/ammo_casing/energy/flare)

	bad_type = /obj/item/gun/energy/cybersun/lorentz

/obj/item/gun/energy/cybersun/lorentz/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	var/flaring = FALSE
	if(istype(chambered, /obj/item/ammo_casing/energy/flare))
		if(!latch_closed)
			return FALSE
		flaring = TRUE
		var/obj/projectile/beam/flare/bang = chambered.BB
		var/cell_charge = cell.percent()/100
		if(cell_charge < 0.5)
			return FALSE
		bang.damage = bang.damage * cell_charge * cell.rating
		fire_sound_volume = 150 * cell_charge
		bang.range = round(bang.range * cell_charge)
		recoil = recoil * 2
	. = ..()
	if(flaring)
		recoil = recoil / 2
		explosive_cell_eject(user)

/obj/item/gun/energy/cybersun/lorentz/proc/explosive_cell_eject(atom/shooter)
	cell.charge = 0
	cell.rigged = TRUE
	playsound(loc, 'sound/effects/empulse.ogg', 25, TRUE)

	//snowflake casing ejection
	cell.burning_particles = new(cell, /particles/smoke/burning/cell_smoke)
	QDEL_IN(cell.burning_particles, 3 SECONDS)

	latch_closed = FALSE
	cell.forceMove(drop_location())
	cell.pixel_x = rand(-4, 4)
	cell.pixel_y = rand(-4, 4)
	cell.pixel_z = 8
	var/angle_of_movement = !isnull(shooter) ? (rand(-3000, 3000) / 100) + dir2angle(turn(shooter.dir, 180)) : rand(-3000, 3000) / 100
	cell.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(400, 450) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = 'sound/weapons/gun/general/bulletcasing_shotgun_bounce.ogg')

	cell = null
	update_appearance()

//flare pistol
/obj/item/gun/energy/cybersun/lorentz/opportunist
	name = "\improper LS209 Opportunist"
	//rewrite
	desc = "A bulky brute of revolver intended to neutralize any threat in close range. Lorentz mode rapidly ionizes air and fills it with plasma to melt through targets, while plasma flare dumps the entire plasma cell into one ferocious shot."

	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "opportunist"
	item_state = "opportunist"
	latch_icon_state = "opportunist"

	recoil = 1
	recoil_unwielded = 2

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/mini,
		/obj/item/stock_parts/cell/gun/cybersun/mini/empty,
	)

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz, /obj/item/ammo_casing/energy/flare)

/obj/item/gun/energy/cybersun/lorentz/opportunist/empty_cell
	spawn_no_ammo = TRUE

//flare shotgun
/obj/item/gun/energy/cybersun/lorentz/impactor
	name = "\improper LS126 Impactor"
	desc = "A divisor lens makes the LS126 Impactor into a proper shotgun, allowing it to cast multiple Lorentz beams at a time. While not as powerful as an individual beam can be, combined the massed impact causes much more damage to a target. A close quarters combat tool to be reckoned with. "

	icon_state = "impactor"
	item_state = "impactor"

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz/scatter, /obj/item/ammo_casing/energy/flare)

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/heavy,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/heavy/empty,
	)

	latch_icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	latch_icon_state = "impactor"

	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_BULKY

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	wield_delay = 0.8 SECONDS

	wield_slowdown = LASER_RIFLE_SLOWDOWN

	default_firemode = FIREMODE_SEMIAUTO

	recoil = 2
	recoil_unwielded = 12

/obj/item/gun/energy/cybersun/lorentz/impactor/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/cybersun/lorentz/catalyzer
	name = "\improper LS451 Catalyzer"
	desc = "Fitting into the role of light machine gun, the LS451 Catalyzer is the heaviest weapon currently sold by Tadeusz Armory (Discounting the LS9K Anti Starship Battery). An efficient conversion lens allows for the rifle to put down a consistent rain of Lorentz Bolts, or incinerate an opponent with a plasmaflare."

	base_icon_state = "catalyzer"
	icon_state = "catalyzer"
	item_state = "catalyzer"
	latch_icon_state = "catalyzer"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz/mg, /obj/item/ammo_casing/energy/flare)

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun/heavy

	//she never did generalize bipod behavior as an attachment.
	actions_types = list(/datum/action/item_action/deploy_bipod)

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun/heavy,
		/obj/item/stock_parts/cell/gun/cybersun/heavy/empty
	)

	zoom_amt = RIFLE_ZOOM
	wield_slowdown = LASER_SNIPER_SLOWDOWN
	aimed_wield_slowdown = LASER_SNIPER_SLOWDOWN
	wield_delay = 1.5 SECONDS

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	recoil = 2

	spread = 12
	spread_unwielded = 10

	///is the bipod deployed?
	var/bipod_deployed = FALSE
	///how long do we need to deploy the bipod?
	var/deploy_time = 0.5 SECONDS

	///we add these two values to recoi/spread when we have the bipod deployed
	var/deploy_recoil_bonus = -2
	var/deploy_spread_bonus = -8

	var/list/deployable_on_structures = list(
		/obj/structure/table,
		/obj/structure/barricade,
		/obj/structure/bed,
		/obj/structure/chair,
		/obj/structure/railing
	)

/obj/item/gun/energy/cybersun/lorentz/catalyzer/ComponentInitialize()
	. = ..()
	RegisterSignals(src, list(COMSIG_ITEM_EQUIPPED,COMSIG_MOVABLE_MOVED), PROC_REF(retract_bipod))

/obj/item/gun/energy/cybersun/lorentz/catalyzer/ui_action_click(mob/user, action)
	if(!istype(action, /datum/action/item_action/deploy_bipod))
		return ..()
	if(!bipod_deployed)
		deploy_bipod(user)
	else
		retract_bipod(user=user)

/obj/item/gun/energy/cybersun/lorentz/catalyzer/calculate_recoil(mob/user, recoil_bonus = 0)
	var/total_recoil = recoil_bonus

	if(bipod_deployed)
		total_recoil += deploy_recoil_bonus

	return ..(user, total_recoil)

/obj/item/gun/energy/cybersun/lorentz/catalyzer/calculate_spread(mob/user, bonus_spread)
	var/total_spread = bonus_spread

	if(bipod_deployed)
		total_spread += deploy_spread_bonus

	return ..(user, total_spread)

/obj/item/gun/energy/cybersun/lorentz/catalyzer/proc/deploy_bipod(mob/user)
	//we check if we can actually deploy the thing
	var/can_deploy = TRUE
	var/mob/living/wielder = user

	if(!wielder)
		return

	if(!wielded_fully)
		to_chat(user, span_warning("You need to fully grip [src] to deploy it's bipod!"))
		return

	if(wielder.body_position != LYING_DOWN) //are we braced against the ground? if not, we check for objects to brace against
		can_deploy = FALSE

		for(var/direction_to_check as anything in GLOB.cardinals) //help
			var/turf/open/turf_to_check = get_step(get_turf(src),direction_to_check)
			for(var/obj/structure/checked_struct as anything in turf_to_check.contents) //while you can fire in non-braced directions, this makes it so you have to get good positioning to fire standing up.
				for(var/checking_allowed as anything in deployable_on_structures)
					if(istype(checked_struct, checking_allowed)) //help if you know how to write this better
						can_deploy = TRUE
						break


	if(!can_deploy)
		to_chat(user, span_warning("You need to brace against something to deploy [src]'s bipod! Either lie on the floor or stand next to a waist high object like a table!"))
		return
	if(!do_after(user, deploy_time, src, NONE, TRUE, CALLBACK(src, PROC_REF(is_wielded))))
		to_chat(user, span_warning("You need to hold still to deploy [src]'s bipod!"))
		return
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("You deploy [src]'s bipod."))
	bipod_deployed = TRUE

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(retract_bipod))
	update_appearance()

/obj/item/gun/energy/cybersun/lorentz/catalyzer/proc/retract_bipod(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!bipod_deployed)
		return
	if(!user || !ismob(user))
		user = loc
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("The bipod undeploys itself."))
	bipod_deployed = FALSE

	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	update_appearance()


/obj/item/gun/energy/cybersun/lorentz/catalyzer/on_unwield(obj/item/source, mob/user)
	. = ..()
	retract_bipod(user=user)

/obj/item/gun/energy/cybersun/lorentz/catalyzer/update_icon_state()
	. = ..()

/obj/item/gun/energy/cybersun/lorentz/catalyzer/update_overlays()
	. = ..()
	. += "[base_icon_state]-grip-[bipod_deployed]"

/obj/item/gun/energy/cybersun/lorentz/catalyzer/empty_cell
	spawn_no_ammo = TRUE
