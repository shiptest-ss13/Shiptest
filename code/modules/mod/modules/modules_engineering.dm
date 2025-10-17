///T-Ray Scan - Scans the terrain for undertile objects.
/obj/item/mod/module/t_ray
	name = "MOD t-ray scan module"
	desc = "A module installed into the visor of the suit, allowing the user to use a pulse of terahertz radiation \
		to essentially echolocate things beneath the floor, mostly cables and pipes. \
		A staple of atmospherics work, and counter-smuggling work."
	icon_state = "tray"
	module_type = MODULE_TOGGLE
	complexity = 1
	active_power_cost = MODULE_CHARGE_DRAIN_LOW
	incompatible_modules = list(/obj/item/mod/module/t_ray)
	cooldown_time = 0.5 SECONDS
	/// T-ray scan range.
	var/range = 4

/obj/item/mod/module/t_ray/on_active_process(seconds_per_tick)
	t_ray_scan(mod.wearer, 0.8 SECONDS, range)

///Magnetic Stability - Gives the user a slowdown but makes them negate gravity and be immune to slips.
/obj/item/mod/module/magboot
	name = "MOD magnetic stability module"
	desc = "These are powerful electromagnets fitted into the suit's boots, allowing users both \
		excellent traction no matter the condition indoors, and to essentially hitch a ride on the exterior of a hull. \
		However, these basic models do not feature computerized systems to automatically toggle them on and off, \
		so numerous users report a certain stickiness to their steps."
	icon_state = "magnet"
	module_type = MODULE_TOGGLE
	complexity = 2
	active_power_cost = MODULE_CHARGE_DRAIN_MEDIUM
	incompatible_modules = list(/obj/item/mod/module/magboot)
	cooldown_time = 0.5 SECONDS
	/// Slowdown added onto the suit.
	var/slowdown_active = 0.5

/obj/item/mod/module/magboot/on_activation()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(mod.wearer, TRAIT_NOSLIPWATER, MOD_TRAIT)
	mod.slowdown += slowdown_active
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/magboot/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(mod.wearer, TRAIT_NOSLIPWATER, MOD_TRAIT)
	mod.slowdown -= slowdown_active
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/magboot/advanced
	name = "MOD advanced magnetic stability module"
	removable = FALSE
	complexity = 0
	slowdown_active = 0

///Emergency Tether - Shoots a grappling hook projectile in 0g that throws the user towards it.
/obj/item/mod/module/tether
	name = "MOD emergency tether module"
	desc = "A custom-built grappling-hook powered by a winch capable of hauling the user. \
		While some older models of cargo-oriented grapples have capacities of a few tons, \
		these are only capable of working in zero-gravity environments, a blessing to some Engineers."
	icon_state = "tether"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = MODULE_CHARGE_DRAIN_LOW
	incompatible_modules = list(/obj/item/mod/module/tether)
	cooldown_time = 1.5 SECONDS

/obj/item/mod/module/tether/used()
	if(mod.wearer.has_gravity(get_turf(src)))
		to_chat(mod.wearer,span_warning("The tether flops uselessly to the ground in the gravity!"))
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 25, TRUE)
		return FALSE
	return ..()

/obj/item/mod/module/tether/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/obj/projectile/tether = new /obj/projectile/tether(mod.wearer.loc)
	tether.preparePixelProjectile(target, mod.wearer)
	tether.firer = mod.wearer
	playsound(src, 'sound/weapons/batonextend.ogg', 25, TRUE)
	INVOKE_ASYNC(tether, TYPE_PROC_REF(/obj/projectile, fire))
	drain_power(use_power_cost)

/obj/projectile/tether
	name = "tether"
	icon_state = "tether_projectile"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	damage = 0
	nodamage = TRUE
	range = 10
	hitsound = 'sound/weapons/batonextend.ogg'
	suppressed = SUPPRESSED_VERY
	//hit_threshhold = LATTICE_LAYER
	/// Reference to the beam following the projectile.
	var/line

/obj/projectile/tether/fire(setAngle)
	if(firer)
		line = firer.Beam(src, "line", 'icons/obj/clothing/modsuit/mod_modules.dmi')
	..()

/obj/projectile/tether/on_hit(atom/target)
	. = ..()
	if(firer)
		firer.throw_at(target, 10, 1, firer, FALSE, FALSE, null, MOVE_FORCE_NORMAL, TRUE)

/obj/projectile/tether/Destroy()
	QDEL_NULL(line)
	return ..()

///Mister - Sprays water over an area.
/obj/item/mod/module/mister
	name = "MOD water mister module"
	desc = "A module containing a mister, able to spray it over areas."
	icon_state = "mister"
	module_type = MODULE_ACTIVE
	complexity = 2
	active_power_cost = MODULE_CHARGE_DRAIN_LOW
	device = /obj/item/reagent_containers/spray/mister
	incompatible_modules = list(/obj/item/mod/module/mister)
	cooldown_time = 0.5 SECONDS
	/// Volume of our reagent holder.
	var/volume = 500

/obj/item/mod/module/mister/Initialize(mapload)
	create_reagents(volume, OPENCONTAINER)
	return ..()

///Resin Mister - Sprays resin over an area.
/obj/item/mod/module/mister/atmos
	name = "MOD resin mister module"
	desc = "An atmospheric resin mister, able to fix up areas quickly."
	device = /obj/item/extinguisher/mini/nozzle/mod
	volume = 250

/obj/item/mod/module/mister/atmos/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/water, volume)

/obj/item/extinguisher/mini/nozzle/mod
	name = "MOD atmospheric mister"
	desc = "An atmospheric resin mister with three modes, mounted as a module."

/obj/item/mod/module/toolset
	name = "MOD mobile toolset module"
	desc = "A module installed in the forearm of the suit, featuring a complete suite of integrated engineering tools."
	module_type = MODULE_ACTIVE
	complexity = 4
	active_power_cost = MODULE_CHARGE_DRAIN_LOW
	toolset = TRUE
	tools_to_create = list(/obj/item/screwdriver/cyborg, /obj/item/wrench/cyborg, /obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/cyborg)
	incompatible_modules = list(/obj/item/mod/module/toolset)
	cooldown_time = 0
	allowed_inactive = TRUE


