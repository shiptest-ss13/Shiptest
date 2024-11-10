/obj/item/gun/ballistic/shotgun
	name = "shotgun"
	desc = "You feel as if you should make a 'adminhelp' if you see one of these, along with a 'github' report. You don't really understand what this means though."
	item_state = "shotgun"
	fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	rack_sound = 'sound/weapons/gun/shotgun/rack.ogg'
	load_sound = 'sound/weapons/gun/shotgun/insert_shell.ogg'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
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

	wield_slowdown = 0.45
	wield_delay = 0.8 SECONDS

	spread = 4
	spread_unwielded = 10
	recoil = 1
	recoil_unwielded = 4

	gunslinger_recoil_bonus = -1

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

// BRIMSTONE SHOTGUN //

/obj/item/gun/ballistic/shotgun/brimstone
	name = "HP Brimstone"
	desc = "A simple and sturdy pump-action shotgun sporting a 5-round capacity, manufactured by Hunter's Pride. Found widely throughout the Frontier in the hands of hunters, pirates, police, and countless others. Chambered in 12g."
	sawn_desc = "A stockless and shortened pump-action shotgun. The worsened recoil and accuracy make it a poor sidearm anywhere beyond punching distance."
	fire_sound = 'sound/weapons/gun/shotgun/brimstone.ogg'
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	icon_state = "brimstone"
	item_state = "brimstone"

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/lethal
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/lethal,
	)
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	fire_delay = 0.05 SECONDS //slamfire
	rack_delay = 0.2 SECONDS

	can_be_sawn_off = TRUE


/obj/item/gun/ballistic/shotgun/brimstone/sawoff(forced = FALSE)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM
		wield_slowdown = 0.25
		wield_delay = 0.3 SECONDS //OP? maybe

		spread = 18
		spread_unwielded = 25
		recoil = 5 //your punishment for sawing off an short shotgun
		recoil_unwielded = 8
		item_state = "illestren_factory_sawn" // i couldnt care about making another sprite, looks close enough
		mob_overlay_state = item_state

EMPTY_GUN_HELPER(shotgun/brimstone)

// HELLFIRE SHOTGUN //

/obj/item/gun/ballistic/shotgun/hellfire
	name = "HP Hellfire"
	desc = "A hefty pump-action riot shotgun with a seven-round tube, manufactured by Hunter's Pride. Especially popular among the Frontier's police forces. Chambered in 12g."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	icon_state = "hellfire"
	item_state = "hellfire"

	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/riot
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/riot,
	)
	sawn_desc = "Come with me if you want to live."
	can_be_sawn_off = TRUE
	rack_sound = 'sound/weapons/gun/shotgun/rack_alt.ogg'
	fire_delay = 0.1 SECONDS

/obj/item/gun/ballistic/shotgun/hellfire/sawoff(forced = FALSE)
	. = ..()
	if(.)
		var/obj/item/ammo_box/magazine/internal/tube = magazine
		tube.max_ammo = 5 //this makes the gun so much worse

		weapon_weight = WEAPON_MEDIUM
		wield_slowdown = 0.25
		wield_delay = 0.3 SECONDS //OP? maybe

		spread = 8
		spread_unwielded = 15
		recoil = 3 //or not
		recoil_unwielded = 5
		item_state = "dshotgun_sawn" // ditto
		mob_overlay_state = item_state

EMPTY_GUN_HELPER(shotgun/hellfire)

// Automatic Shotguns//
/obj/item/gun/ballistic/shotgun/automatic
	spread = 4
	spread_unwielded = 16
	recoil = 1
	recoil_unwielded = 4
	wield_delay = 0.65 SECONDS
	manufacturer = MANUFACTURER_NANOTRASEN
	semi_auto = TRUE

//Dual Feed Shotgun

/obj/item/gun/ballistic/shotgun/automatic/dual_tube
	name = "cycler shotgun"
	desc = "An advanced shotgun with two separate magazine tubes, allowing you to quickly toggle between ammo types."

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "cycler"

	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/tube
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/tube,
	)
	w_class = WEIGHT_CLASS_HUGE
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine
	semi_auto = TRUE

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to pump it.</span>"

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/Initialize()
	. = ..()
	if (!alternate_magazine)
		alternate_magazine = new default_ammo_type(src)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/attack_self(mob/living/user)
	if(!chambered && magazine.contents.len)
		rack()
	else
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "<span class='notice'>You switch to tube B.</span>")
	else
		to_chat(user, "<span class='notice'>You switch to tube A.</span>")

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/AltClick(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	rack()

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


/////////////////////////////
// DOUBLE BARRELED SHOTGUN //
/////////////////////////////

/obj/item/gun/ballistic/shotgun/doublebarrel
	name = "double-barreled shotgun"
	desc = "A classic break action shotgun, hand-made in a Hunter's Pride workshop. Both barrels can be fired in quick succession or even simultaneously. Guns like this have been popular with hunters, sporters, and criminals for millennia. Chambered in 12g."
	sawn_desc = "A break action shotgun cut down to the size of a sidearm. While the recoil is even harsher, it offers a lot of power in a very small package. Chambered in 12g."

	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	base_icon_state = "dshotgun"

	icon_state = "dshotgun"
	item_state = "dshotgun"

	rack_sound = 'sound/weapons/gun/shotgun/dbshotgun_break.ogg'
	bolt_drop_sound = 'sound/weapons/gun/shotgun/dbshotgun_close.ogg'

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/dual
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/dual,
	)

	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "dshotgun",
						"Stainless Steel" = "dshotgun_white",
						"Stained Green" = "dshotgun_green"
						)
	semi_auto = TRUE
	can_be_sawn_off = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	pb_knockback = 3 // it's a super shotgun!
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	bolt_wording = "barrel"

	burst_delay = 0.05 SECONDS
	burst_size = 2
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/ballistic/shotgun/doublebarrel/unique_action(mob/living/user)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You snap open the [bolt_wording] of \the [src].</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		chambered = null
		var/num_unloaded = 0
		for(var/obj/item/ammo_casing/casing_bullet in get_ammo_list(FALSE, TRUE))
			casing_bullet.forceMove(drop_location())
			var/angle_of_movement =(rand(-3000, 3000) / 100) + dir2angle(turn(user.dir, 180))
			casing_bullet.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(450, 550) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = casing_bullet.bounce_sfx_override)

			num_unloaded++
			SSblackbox.record_feedback("tally", "station_mess_created", 1, casing_bullet.name)
		if (num_unloaded)
			playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
			update_appearance()
		bolt_locked = TRUE
		update_appearance()
		return
	drop_bolt(user)

/obj/item/gun/ballistic/shotgun/doublebarrel/drop_bolt(mob/user = null)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	if (user)
		to_chat(user, "<span class='notice'>You snap the [bolt_wording] of \the [src] closed.</span>")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/shotgun/doublebarrel/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/shotgun/doublebarrel/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		to_chat(user, "<span class='notice'>The [bolt_wording] is shut closed!</span>")
		return
	return ..()

/obj/item/gun/ballistic/shotgun/doublebarrel/update_icon_state()
	. = ..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "_sawn" : ""][bolt_locked ? "_open" : ""]"
	else
		icon_state = "[base_icon_state || initial(icon_state)][sawn_off ? "_sawn" : ""][bolt_locked ? "_open" : ""]"


/obj/item/gun/ballistic/shotgun/doublebarrel/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && (!bolt_locked))
		reskin_obj(user)

/obj/item/gun/ballistic/shotgun/doublebarrel/sawoff(forced = FALSE)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM
		wield_slowdown = 0.25
		wield_delay = 0.3 SECONDS //OP? maybe

		spread = 8
		spread_unwielded = 15
		recoil = 3 //or not
		recoil_unwielded = 5
		item_state = "dshotgun_sawn"
		mob_overlay_state = item_state

EMPTY_GUN_HELPER(shotgun/doublebarrel)

// sawn off beforehand
/obj/item/gun/ballistic/shotgun/doublebarrel/presawn
	name = "sawn-off double-barreled shotgun"
	desc = "A break action shotgun cut down to the size of a sidearm. While the recoil is even harsher, it offers a lot of power in a very small package. Chambered in 12g."
	sawn_off = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

	wield_slowdown = 0.25
	wield_delay = 0.3 SECONDS //OP? maybe

	spread = 8
	spread_unwielded = 15
	recoil = 3 //or not
	recoil_unwielded = 5
	item_state = "dshotgun_sawn"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/dual/lethal
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/dual/lethal,
	)

EMPTY_GUN_HELPER(shotgun/doublebarrel/presawn)

/obj/item/gun/ballistic/shotgun/doublebarrel/roumain
	name = "HP antique double-barreled shotgun"
	desc = "A special-edition shotgun hand-made by Hunter's Pride with a high-quality walnut stock inlaid with brass scrollwork. Shotguns like this are very rare outside of the Saint-Roumain Militia's ranks. Otherwise functionally identical to a common double-barreled shotgun. Chambered in 12g."
	sawn_desc = "A special-edition Hunter's Pride shotgun, cut down to the size of a sidearm by some barbarian. The brass inlay on the stock and engravings on the barrel have been obliterated in the process, destroying any value beyond its use as a crude sidearm."
	base_icon_state = "dshotgun_srm"
	icon_state = "dshotgun_srm"
	item_state = "dshotgun_srm"
	unique_reskin = null

/obj/item/gun/ballistic/shotgun/doublebarrel/roumain/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "dshotgun_srm_sawn"

// IMPROVISED SHOTGUN //

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	name = "improvised shotgun"
	desc = "A length of pipe and miscellaneous bits of scrap fashioned into a rudimentary single-shot shotgun."
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	mob_overlay_icon = null

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
			to_chat(user, "<span class='notice'>You tie the lengths of cable to the shotgun, making a sling.</span>")
			slung = TRUE
			update_appearance()
		else
			to_chat(user, "<span class='warning'>You need at least ten lengths of cable if you want to make a sling!</span>")

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

//Lever-Action Rifles
/obj/item/gun/ballistic/shotgun/flamingarrow
	name = "HP Flaming Arrow"
	desc = "A sturdy and lightweight lever-action rifle with hand-stamped Hunter's Pride marks on the receiver. A popular choice among Frontier homesteaders for hunting small game and rudimentary self-defense. Chambered in .38."
	sawn_desc = "A lever-action rifle that has been sawed down and modified for extra portability. While surprisingly effective as a sidearm, the more important benefit is how much cooler it looks."
	base_icon_state = "flamingarrow"
	icon_state = "flamingarrow"
	item_state = "flamingarrow"
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/winchester
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/winchester,
	)
	fire_sound = 'sound/weapons/gun/rifle/flamingarrow.ogg'
	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	bolt_wording = "lever"
	cartridge_wording = "bullet"
	can_be_sawn_off = TRUE

	wield_slowdown = 0.5
	wield_delay = 0.65 SECONDS

	spread = -5
	spread_unwielded = 7

	recoil = 0
	recoil_unwielded = 2

EMPTY_GUN_HELPER(shotgun/flamingarrow)

/obj/item/gun/ballistic/shotgun/flamingarrow/update_icon_state()
	. = ..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "_sawn" : ""]"
	else
		icon_state = "[base_icon_state || initial(icon_state)][sawn_off ? "_sawn" : ""]"


/obj/item/gun/ballistic/shotgun/flamingarrow/rack(mob/user = null)
	. = ..()
	if(!wielded)
		SpinAnimation(7,1)

/obj/item/gun/ballistic/shotgun/flamingarrow/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/fan = FALSE
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER) && !semi_auto && wielded_fully && loc == user && !safety)
		fan = TRUE
		fire_delay = 0.35 SECONDS
	. = ..()
	fire_delay = src::fire_delay
	if(fan)
		rack()
		to_chat(user, "<span class='notice'>You quickly rack the [bolt_wording] of \the [src]!</span>")
		balloon_alert_to_viewers("quickly racks!")
		fire_delay = 0 SECONDS

/obj/item/gun/ballistic/shotgun/flamingarrow/sawoff(forced = FALSE)
	. = ..()
	if(.)
		var/obj/item/ammo_box/magazine/internal/tube = magazine
		tube.max_ammo = 7

		item_state = "flamingarrow_sawn"
		mob_overlay_state = item_state
		weapon_weight = WEAPON_MEDIUM

		wield_slowdown = 0.25
		wield_delay = 0.2 SECONDS //THE COWBOY RIFLE

		spread = 4
		spread_unwielded = 12

		recoil = 0
		recoil_unwielded = 3

/obj/item/gun/ballistic/shotgun/flamingarrow/factory
	desc = "A sturdy and lightweight lever-action rifle with hand-stamped Hunter's Pride marks on the receiver. This example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in .38."
	icon_state = "flamingarrow_factory"
	base_icon_state = "flamingarrow_factory"
	item_state = "flamingarrow_factory"

/obj/item/gun/ballistic/shotgun/flamingarrow/factory/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "flamingarrow_factory_sawn"
		mob_overlay_state = item_state

/obj/item/gun/ballistic/shotgun/flamingarrow/bolt
	name = "HP Flaming Bolt"
	desc = "A sturdy, excellently-made lever-action rifle. This one appears to be a genuine antique, kept in incredibly good condition despite its advanced age. Chambered in .38."
	base_icon_state = "flamingbolt"
	icon_state = "flamingbolt"
	item_state = "flamingbolt"

/obj/item/gun/ballistic/shotgun/flamingarrow/bolt/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "flamingbolt_sawn"
		mob_overlay_state = item_state

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution
	name = "HP Absolution"
	base_icon_state = "absolution"
	icon_state = "absolution"
	item_state = "absolution"
	fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	desc = "A large lever-action rifle with hand-stamped Hunter's Pride marks on the receiver and an 8 round ammunition capacity. More powerful than the Flaming Arrow, the Absolution is a popular pick for hunting larger fauna like bears and goliaths, especially when a bolt action's slower rate of fire would be a liability. Chambered in .357."
	sawn_desc = "A large lever-action rifle, sawn down for portability. It looks much cooler, but you should probably be using a revolver..."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/winchester/absolution
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/winchester/absolution,
	)

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution/sawoff(forced = FALSE)
	. = ..()
	if(.)
		var/obj/item/ammo_box/magazine/internal/tube = magazine
		tube.max_ammo = 8

		item_state = "illestren_sawn"
		mob_overlay_state = item_state
		weapon_weight = WEAPON_MEDIUM

		wield_slowdown = 0.25
		wield_delay = 0.2 SECONDS

		spread = 4
		spread_unwielded = 12

		recoil = 0
		recoil_unwielded = 3

/obj/item/gun/ballistic/shotgun/flamingarrow/conflagration
	name = "HP Conflagration"
	base_icon_state = "conflagration"
	icon_state = "conflagration"
	item_state = "conflagration"
	fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'
	desc = "A lightweight lever-action shotgun with a 5 round ammunition capacity. The lever action allows it to be cycled quickly and acurrately. In theory, you could ever operate it one-handed. Chambered in 12g."
	sawn_desc = "A lever action shotgun that's been sawed down for portability. The recoil makes it mostly useless outside of point-blank range, but it hits hard for its size and, more importantly, can be flipped around stylishly."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/winchester/conflagration
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/winchester/conflagration,
	)

/obj/item/gun/ballistic/shotgun/flamingarrow/conflagration/sawoff(forced = FALSE)
	. = ..()
	if(.)
		var/obj/item/ammo_box/magazine/internal/tube = magazine
		tube.max_ammo = 5

		item_state = "beacon_factory_sawn"
		mob_overlay_state = item_state
		weapon_weight = WEAPON_MEDIUM

		wield_slowdown = 0.25
		wield_delay = 0.2 SECONDS

		spread = 4
		spread_unwielded = 12

		recoil = 0
		recoil_unwielded = 3

EMPTY_GUN_HELPER(shotgun/flamingarrow/conflagration)

//Elephant Gun
/obj/item/gun/ballistic/shotgun/doublebarrel/twobore
	name = "HP Huntsman"
	desc = "A comically huge double-barreled rifle replete with brass inlays depicting flames and naturalistic scenes, clearly meant for the nastiest monsters the Frontier has to offer. If you want an intact trophy, don't aim for the head. Chambered in two-bore."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	base_icon_state = "huntsman"
	icon_state = "huntsman"
	item_state = "huntsman"
	unique_reskin = null
	attack_verb = list("bludgeoned", "smashed")
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/twobore
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/twobore,
	)
	w_class = WEIGHT_CLASS_BULKY
	force = 20 //heavy ass elephant gun, why wouldnt it be
	recoil = 4
	pb_knockback = 12
	fire_sound = 'sound/weapons/gun/shotgun/quadfire.ogg'
	rack_sound = 'sound/weapons/gun/shotgun/quadrack.ogg'
	load_sound = 'sound/weapons/gun/shotgun/quadinsert.ogg'

	can_be_sawn_off = FALSE
	fire_sound_volume = 80
	rack_sound_volume = 50
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	gun_firemodes = list(FIREMODE_SEMIAUTO) //no dual burst for you
	default_firemode = FIREMODE_SEMIAUTO

//Break-Action Rifle
/obj/item/gun/ballistic/shotgun/doublebarrel/beacon
	name = "HP Beacon"
	desc = "A single-shot break-action rifle made by Hunter's Pride and sold to civilian hunters. Boasts excellent accuracy and stopping power. Uses .45-70 ammo."
	sawn_desc= "A single-shot break-action pistol chambered in .45-70. A bit difficult to aim."
	base_icon_state = "beacon"
	icon_state = "beacon"
	item_state = "beacon"
	unique_reskin = null
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/beacon
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/beacon,
	)
	fire_sound = 'sound/weapons/gun/revolver/shot_hunting.ogg'
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	obj_flags = UNIQUE_RENAME
	semi_auto = TRUE
	can_be_sawn_off = TRUE
	pb_knockback = 3
	wield_slowdown = 0.7
	spread_unwielded = 15
	spread = 0
	recoil = 0
	recoil_unwielded = 5

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/ballistic/shotgun/doublebarrel/beacon/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "beacon_sawn"
		mob_overlay_state = item_state
		wield_slowdown = 0.5
		wield_delay = 0.5 SECONDS

		spread_unwielded = 20 //mostly the hunting revolver stats
		spread = 6
		recoil = 2
		recoil_unwielded = 4

EMPTY_GUN_HELPER(shotgun/doublebarrel/beacon)

/obj/item/gun/ballistic/shotgun/doublebarrel/beacon/factory
	desc = "A single-shot break-action rifle made by Hunter's Pride and sold to civilian hunters. This example has been kept in excellent shape and may as well be fresh out of the workshop. Uses .45-70 ammo."
	sawn_desc= "A single-shot break-action pistol chambered in .45-70. A bit difficult to aim."
	base_icon_state = "beacon_factory"
	icon_state = "beacon_factory"
	item_state = "beacon_factory"

/obj/item/gun/ballistic/shotgun/doublebarrel/beacon/factory/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "beacon_factory_sawn"
		mob_overlay_state = item_state

//pre sawn off beacon
/obj/item/gun/ballistic/shotgun/doublebarrel/beacon/presawn
	name = "sawn-off HP Beacon"
	sawn_desc= "A single-shot break-action pistol chambered in .45-70. A bit difficult to aim."
	sawn_off = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

	weapon_weight = WEAPON_MEDIUM

	item_state = "beacon_sawn"
	mob_overlay_state = "beacon_sawn"
	wield_slowdown = 0.5
	wield_delay = 0.5 SECONDS

	spread_unwielded = 20 //mostly the hunting revolver stats
	spread = 6
	recoil = 2
	recoil_unwielded = 4
