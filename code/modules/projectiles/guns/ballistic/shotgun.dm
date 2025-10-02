/obj/item/gun/ballistic/shotgun
	name = "shotgun"
	desc = "You feel as if you should make a 'adminhelp' if you see one of these, along with a 'github' report. You don't really understand what this means though."
	item_state = "shotgun"
	bad_type = /obj/item/gun/ballistic/shotgun
	fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	rack_sound = 'sound/weapons/gun/shotgun/rack.ogg'
	load_sound = 'sound/weapons/gun/shotgun/insert_shell.ogg'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot,
	)
	semi_auto = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_wording = "pump"
	cartridge_wording = "shell"
	tac_reloads = FALSE
	pickup_sound =  'sound/items/handling/shotgun_pickup.ogg'
	fire_delay = 0.7 SECONDS
	pb_knockback = 2
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	fire_select_icon_state_prefix = "sg_"

	wield_slowdown = SHOTGUN_SLOWDOWN
	aimed_wield_slowdown = SHOTGUN_AIM_SLOWDOWN
	wield_delay = 0.8 SECONDS

	zoom_amt = SHOTGUN_ZOOM

	spread = 3
	spread_unwielded = 9
	recoil = 1
	recoil_unwielded = 4

	gunslinger_recoil_bonus = -1

	min_recoil = 0.1
	wear_rate = 0

	//in an ideal world this would be a component but I don't wanna untangle all the sleeps doors pull
	///can this shotgun breach doors
	var/door_breaching_weapon = TRUE

/obj/item/gun/ballistic/shotgun/attack_obj(obj/O, mob/living/user)
	if(door_breaching_weapon && istype(O, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/breaching = O
		if(chambered && chambered.BB && !is_type_in_list(chambered, list(/obj/item/ammo_casing/shotgun/blank, /obj/item/ammo_casing/shotgun/beanbag, /obj/item/ammo_casing/shotgun/rubbershot)))
			user.visible_message(
				span_warning("[user] put the barrel of [src] to [breaching]'s electronics!"),
				span_warning("You puts the barrel of [src] to [breaching]'s electronics, preparing to shred them!"),
				span_warning("Metal brushes against metal")
			)
			if(do_after(user, 5 SECONDS, breaching))
				if(process_fire(breaching, user, FALSE))
					switch(breaching.security_level)
						if(0)
							EMPTY_BLOCK_GUARD
						if (1) // thin metal plate. blast through it and create debris
							var/obj/item/debris = new /obj/item/stack/ore/salvage/scrapmetal
							debris.safe_throw_at(user, 2, 5, null, 1)
							breaching.security_level = 0
						if(2 to 6) //two shots to break
							var/obj/item/debris = new /obj/item/stack/ore/salvage/scrapmetal
							debris.safe_throw_at(user, 2, 5, null, 1)
							breaching.security_level -= 3
							breaching.security_level = max(breaching.security_level, 0)
							return
					if(!breaching.open())
						update_icon(ALL, 1, 1)
					//im not rewriting the behavior to do exactly what this does with a different name
					breaching.obj_flags |= EMAGGED
					breaching.lights = FALSE
					breaching.locked = TRUE
					breaching.loseMainPower()
					breaching.loseBackupPower()
					return TRUE
				return FALSE
			return FALSE
	. = ..()

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		return TRUE
	for(var/obj/item/ammo_casing/ammo in magazine.stored_ammo)
		if(ammo.BB)
			process_chamber(FALSE, FALSE)
			process_fire(user, user, FALSE)
			return TRUE
	return FALSE

// Automatic Shotguns//
/obj/item/gun/ballistic/shotgun/automatic
	bad_type = /obj/item/gun/ballistic/shotgun/automatic
	spread = 3
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_delay = 0.65 SECONDS
	manufacturer = MANUFACTURER_NANOTRASEN
	semi_auto = TRUE

	gunslinger_recoil_bonus = 1
	wear_rate = 1
	wear_minor_threshold = 60
	wear_major_threshold = 180
	wear_maximum = 300


/obj/item/gun/ballistic/shotgun/automatic/bulldog/inteq
	name = "\improper Mastiff Shotgun"
	desc = "A variation of the Bulldog, seized from Syndicate armories by deserting troopers then modified to IRMG's standards."
	icon_state = "bulldog_inteq"
	item_state = "bulldog_inteq"
	default_ammo_type = /obj/item/ammo_box/magazine/m12g_bulldog
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m12g_bulldog,
	)
	manufacturer = MANUFACTURER_INTEQ

NO_MAG_GUN_HELPER(shotgun/automatic/bulldog/inteq)



// IMPROVISED SHOTGUN //

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	name = "improvised shotgun"
	desc = "A length of pipe and miscellaneous bits of scrap fashioned into a rudimentary single-shot shotgun."
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	mob_overlay_icon = null
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	base_icon_state = "ishotgun"
	icon_state = "ishotgun"
	item_state = "ishotgun"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	slot_flags = null
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/improvised,
	)
	sawn_desc = "I'm just here for the gasoline."
	unique_reskin = null
	var/slung = FALSE

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		var/obj/item/stack/cable_coil/C = A
		if(C.use(10))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, span_notice("You tie the lengths of cable to the shotgun, making a sling."))
			slung = TRUE
			update_appearance()
		else
			to_chat(user, span_warning("You need at least ten lengths of cable if you want to make a sling!"))

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/update_icon_state()
	. = ..()
	if(slung)
		item_state = "ishotgunsling"
	if(sawn_off)
		item_state = "ishotgun_sawn"

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/update_overlays()
	. = ..()
	if(slung)
		. += "ishotgunsling"
	if(sawn_off)
		. += "ishotgun_sawn"

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawoff(forced = FALSE)
	. = ..()
	if(. && slung) //sawing off the gun removes the sling
		new /obj/item/stack/cable_coil(get_turf(src), 10)
		slung = 0
		update_appearance()

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawn
	sawn_off = TRUE

//god fucking bless brazil
/obj/item/gun/ballistic/shotgun/doublebarrel/brazil
	name = "six-barreled \"TRABUCO\" shotgun"
	desc = "Dear fucking god, what the fuck even is this!? The recoil caused by the sheer act of firing this thing would probably kill you, if the gun itself doesn't explode in your face first! Theres a green flag with a blue circle and a yellow diamond around it. Some text in the circle says: \"ORDEM E PROGRESSO.\""
	base_icon_state = "shotgun_brazil"
	icon_state = "shotgun_brazil"
	icon = 'icons/obj/guns/48x32guns.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	item_state = "shotgun_qb"
	w_class = WEIGHT_CLASS_BULKY
	force = 15 //blunt edge and really heavy
	attack_verb = list("bludgeoned", "smashed")
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/sex
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/sex,
	)
	burst_size = 6
	burst_delay = 0.04 SECONDS //?? very weird number
	pb_knockback = 12
	unique_reskin = null
	recoil = 10
	recoil_unwielded = 30
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/shotgun/quadfire.ogg'
	rack_sound = 'sound/weapons/gun/shotgun/quadrack.ogg'
	load_sound = 'sound/weapons/gun/shotgun/quadinsert.ogg'
	fire_sound_volume = 50
	rack_sound_volume = 50
	can_be_sawn_off = FALSE
	manufacturer = MANUFACTURER_BRAZIL
	gun_firemodes = list(FIREMODE_BURST)
	default_firemode = FIREMODE_BURST

/obj/item/gun/ballistic/shotgun/doublebarrel/brazil/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(0 + (magazine.ammo_count() * 10)))
		if(prob(10))
			to_chat(user, "<span class='userdanger'>Something isn't right. \the [src] doesn't fire for a brief moment. Then, the following words come to mind: \
			Ó Pátria amada, \n\
			Idolatrada, \n\
			Salve! Salve!</span>")

			message_admins("A [src] misfired and exploded at [ADMIN_VERBOSEJMP(src)], which was fired by [user].") //logging
			log_admin("A [src] misfired and exploded at [ADMIN_VERBOSEJMP(src)], which was fired by [user].")
			user.take_bodypart_damage(0,50)
			explosion(src, 0, 2, 4, 6, TRUE, TRUE)
	..()
/obj/item/gun/ballistic/shotgun/doublebarrel/brazil/death
	name = "Force of Nature"
	desc = "So you have chosen death."
	base_icon_state = "shotgun_e"
	icon_state = "shotgun_e"
	burst_size = 100
	fire_delay = 0.01 SECONDS
	pb_knockback = 40
	recoil = 100
	recoil_unwielded = 200
	recoil_backtime_multiplier = 1
	fire_sound_volume = 100
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/hundred
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/hundred,
	)
