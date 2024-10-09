#define REVOLVER_ROTATE_LEFT "rotate chamber left"
#define REVOLVER_ROTATE_RIGHT "rotate chamber right"
#define REVOLVER_AUTO_ROTATE_RIGHT_LOADING "auto rotate right when loading ammo"
#define REVOLVER_AUTO_ROTATE_LEFT_LOADING "auto rotate left when loading ammo"
#define REVOLVER_EJECT_CURRENT "eject current bullet"
#define REVOLVER_EJECT_ALL "auto eject all bullets"
#define REVOLVER_FLIP "flip the revolver by the trigger"

/obj/item/gun/ballistic/revolver
	name = "i demand"
	desc = "You feel as if you should make a 'adminhelp' if you see one of these, along with a 'github' report. You don't really understand what this means though."
	icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	rack_sound = 'sound/weapons/gun/revolver/revolver_prime.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0
	manufacturer = MANUFACTURER_SCARBOROUGH

	valid_attachments = list()
	slot_available = list()
	fire_delay = 0.4 SECONDS
	spread_unwielded = 15
	recoil = 0.5
	recoil_unwielded = 2
	semi_auto = FALSE
	bolt_wording = "hammer"
	dry_fire_sound = 'sound/weapons/gun/general/bolt_drop.ogg'
	dry_fire_text = "snap"
	wield_slowdown = 0.3

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	safety_wording = "hammer"

	gunslinger_recoil_bonus = -1
	gunslinger_spread_bonus = -8

	var/gate_loaded = FALSE //for stupid wild west shit
	var/gate_offset = 5 //for wild west shit 2: instead of ejecting the chambered round, eject the next round if 1
	var/gate_load_direction = REVOLVER_AUTO_ROTATE_RIGHT_LOADING //when we load ammo with a box, which direction do we rotate the cylinder? unused with normal revolvers

	COOLDOWN_DECLARE(flip_cooldown)

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	. += "<span class='info'>You can use the revolver with your <b>other empty hand</b> to empty the cylinder.</span>"

/obj/item/gun/ballistic/revolver/update_overlays()
	. = ..()
	if(semi_auto)
		return
	if(current_skin)
		. += "[unique_reskin[current_skin]][safety ? "_hammer_up" : "_hammer_down"]"
	else
		. += "[base_icon_state || initial(icon_state)][safety ? "_hammer_up" : "_hammer_down"]"


/obj/item/gun/ballistic/revolver/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE, atom/shooter)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	return ..()

/obj/item/gun/ballistic/revolver/attack_hand(mob/user)
	if(loc == user && user.is_holding(src))
		var/num_unloaded = unload_all_ammo(user)
		if (num_unloaded)
			to_chat(user, "<span class='notice'>You unload [num_unloaded] [cartridge_wording]\s from [src].</span>")
			if(!gate_loaded)
				playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
			SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
			update_appearance()
			return
		else
			return ..()
	else
		return ..()

/obj/item/gun/ballistic/revolver/proc/unload_all_ammo(mob/living/user)
	var/num_unloaded = 0

	if(!gate_loaded) //"normal" revolvers
		for(var/obj/item/ammo_casing/casing_to_eject in get_ammo_list(FALSE, TRUE))
			if(!casing_to_eject)
				continue
			casing_to_eject.forceMove(drop_location())
			var/angle_of_movement =(rand(-3000, 3000) / 100) + dir2angle(turn(user.dir, 180))
			casing_to_eject.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(450, 550) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = casing_to_eject.bounce_sfx_override)

			num_unloaded++
			SSblackbox.record_feedback("tally", "station_mess_created", 1, casing_to_eject.name)
		chamber_round(FALSE)
		return num_unloaded
	else
		var/num_to_unload = magazine.max_ammo
		if(!get_ammo_list(FALSE))
			return num_unloaded

		for(var/i in 1 to num_to_unload)
			var/doafter_time = 0.4 SECONDS
			if(!do_after(user, doafter_time, user))
				break
			if(!eject_casing(user))
				doafter_time = 0 SECONDS
			else
				num_unloaded++
			if(!do_after(user, doafter_time, user))
				break
			chamber_round(TRUE, TRUE)

	if (num_unloaded)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		update_appearance()
		return num_unloaded

/obj/item/gun/ballistic/revolver/proc/eject_casing(mob/living/user, obj/item/ammo_casing/casing_to_eject, casing_index)
	var/list/rounds = magazine.ammo_list()
	if(!casing_to_eject)
		casing_to_eject = rounds[gate_offset+1] //byond arrays start at 1, so we add 1 to get the correct index
	if(!casing_to_eject) //if theres STILL nothing, we cancel this
		if(user)
			to_chat(user, "<span class='warning'>There's nothing in the gate to eject from [src]!</span>")
		return FALSE
	playsound(src, eject_sound, eject_sound_volume, eject_sound_vary)
	casing_to_eject.forceMove(drop_location())
	var/angle_of_movement =(rand(-3000, 3000) / 100) + dir2angle(turn(user.dir, 180))
	casing_to_eject.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(350, 450) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = casing_to_eject.bounce_sfx_override)

	SSblackbox.record_feedback("tally", "station_mess_created", 1, casing_to_eject.name)
	if(!gate_loaded)
		magazine.stored_ammo[casing_index] = null
		chamber_round(FALSE)
	else
		magazine.stored_ammo[gate_offset+1] = null
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	update_appearance()


	if(user)
		to_chat(user, "<span class='notice'>You eject the [cartridge_wording] from [src].</span>")
	return TRUE

/obj/item/gun/ballistic/revolver/proc/insert_casing(mob/living/user, obj/item/ammo_casing/casing_to_insert, allow_ejection)
	if(!casing_to_insert)
		return FALSE

// Check if the bullet's caliber matches the magazine's caliber.If not, send a warning message to the user and return FALSE.
	if(casing_to_insert.caliber != magazine.caliber)
		to_chat(user, "<span class='warning'>\The [casing_to_insert] is not suitable for [src].</span>")
		return FALSE

	var/list/rounds = magazine.ammo_list()
	var/obj/item/ammo_casing/slot = rounds[gate_offset+1] //byond arrays start at 1, so we add 1 to get the correct index
	var/doafter_time = 0.4 SECONDS
	if(!gate_loaded) //"normal" revolvers
		for(var/i in 1 to magazine.stored_ammo.len)
			var/obj/item/ammo_casing/casing_to_eject = magazine.stored_ammo[i]
			if(casing_to_eject)
				if(!casing_to_eject.BB && allow_ejection)
					eject_casing(user, casing_to_eject, i)

			casing_to_eject = magazine.stored_ammo[i] //check again
			if(casing_to_eject)
				continue
			else
				magazine.stored_ammo[i] = casing_to_insert
				casing_to_insert.forceMove(magazine)
				chamber_round(FALSE)
				break
	else
		if(slot)
			if(!slot.BB && allow_ejection)
				if(!do_after(user, doafter_time, user))
					eject_casing(user)

		rounds = magazine.ammo_list()
		slot = rounds[gate_offset+1] //check again
		if(slot)
			to_chat(user, "<span class='warning'>There's already a casing in the gate of [src]!</span>")
			return FALSE

		magazine.stored_ammo[gate_offset+1] = casing_to_insert
		casing_to_insert.forceMove(magazine)

	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	update_appearance()
	if(user)
		to_chat(user, "<span class='notice'>You load the [cartridge_wording] into [src].</span>")
	return TRUE

/obj/item/gun/ballistic/revolver/attackby(obj/item/attacking_obj, mob/user, params)
	if (istype(attacking_obj, /obj/item/ammo_casing) || istype(attacking_obj, /obj/item/ammo_box))
		if(istype(attacking_obj, /obj/item/ammo_casing))
			insert_casing(user, attacking_obj, TRUE)
		else
			var/obj/item/ammo_box/attacking_box = attacking_obj
			var/num_loaded = 0
			var/num_to_load = magazine.max_ammo
			var/list/ammo_list_no_empty = get_ammo_list(FALSE)
			listclearnulls(ammo_list_no_empty)

			if(ammo_list_no_empty.len >= num_to_load)
				to_chat(user, "<span class='warning'>There's no empty space in [src]!</span>")
				return TRUE

			if(!gate_loaded) //"normal" revolvers
				var/i = 0
				for(var/obj/item/ammo_casing/casing_to_insert in attacking_box.stored_ammo)
					if(!casing_to_insert || (magazine.caliber && casing_to_insert.caliber != magazine.caliber) || (!magazine.caliber && casing_to_insert.type != magazine.ammo_type))
						break
					var/doafter_time = 0.8 SECONDS
					if(magazine.instant_load && attacking_box.instant_load)
						doafter_time = 0 SECONDS
					if(!do_after(user, doafter_time, user))
						break
					if(!insert_casing(user, casing_to_insert, FALSE))
						break
					else
						num_loaded++
						attacking_box.update_appearance()
						attacking_box.stored_ammo -= casing_to_insert
					i++
					if(i >= num_to_load)
						break
			else
				var/i = 0
				for(var/obj/item/ammo_casing/casing_to_insert in attacking_box.stored_ammo)
					if(!casing_to_insert || (magazine.caliber && casing_to_insert.caliber != magazine.caliber) || (!magazine.caliber && casing_to_insert.type != magazine.ammo_type))
						break
					var/doafter_time = 0.4 SECONDS
					if(!do_after(user, doafter_time, user))
						break
					if(!insert_casing(null, casing_to_insert, FALSE))
						doafter_time = 0 SECONDS
					else
						num_loaded++
						attacking_box.update_appearance()
						attacking_box.stored_ammo -= casing_to_insert
					if(!do_after(user, doafter_time, user))
						break
					switch(gate_load_direction)
						if(REVOLVER_AUTO_ROTATE_RIGHT_LOADING)
							chamber_round(TRUE)
						if(REVOLVER_AUTO_ROTATE_LEFT_LOADING)
							chamber_round(TRUE, TRUE)
					i++
					if(i >= num_to_load)
						break

			if(num_loaded)
				to_chat(user, "<span class='notice'>You load [num_loaded] [cartridge_wording]\s into [src].</span>")
				attacking_box.update_appearance()
				update_appearance()
			return TRUE
	else
		return ..()

/obj/item/gun/ballistic/revolver/unique_action(mob/living/user)
	rack(user)
	return

///updates a bunch of racking related stuff and also handles the sound effects and the like
/obj/item/gun/ballistic/revolver/rack(mob/user = null, toggle_hammer = TRUE)
	if(user && !semi_auto)
		if(safety && toggle_hammer)
			toggle_safety(user, FALSE, FALSE)
		else if(toggle_hammer)
			to_chat(user, "<span class='warning'>The [safety_wording] is already [safety ? "<span class='green'>UP</span>" : "<span class='red'>DOWN</span>"]! Use Ctrl-Click to disengage the [safety_wording]!</span>")
			return
	else if(!semi_auto)
		if(safety && toggle_hammer)
			toggle_safety(null, FALSE, FALSE)
		else if (toggle_hammer)
			return
	if(user && semi_auto)
		to_chat(user, "<span class='notice'>You rack the [bolt_wording] of \the [src].</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)

	if(!safety && !semi_auto)
		chamber_round(TRUE)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	update_appearance()

/obj/item/gun/ballistic/revolver/chamber_round(spin_cylinder = TRUE, counter_clockwise = FALSE)
	if(spin_cylinder)
		chambered = magazine.get_round(TRUE, counter_clockwise)
		playsound(src, 'sound/weapons/gun/revolver/spin_single.ogg', 100, FALSE)
	else
		chambered = magazine.stored_ammo[1]
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/revolver/AltClick(mob/user)
	if (unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return ..()

	var/chamber_options = list(
		REVOLVER_ROTATE_LEFT = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_left"),
		REVOLVER_ROTATE_RIGHT = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_right"),
		REVOLVER_AUTO_ROTATE_LEFT_LOADING = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_auto_left"),
		REVOLVER_EJECT_ALL = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_eject_all"),
		REVOLVER_EJECT_CURRENT = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_eject_one"),
		REVOLVER_AUTO_ROTATE_RIGHT_LOADING = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_auto_right"),
		REVOLVER_FLIP = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_revolver_flip"),
		)

	var/image/editing_image = chamber_options[gate_load_direction]
	editing_image.icon_state = "radial_revolver_auto_[gate_load_direction == REVOLVER_AUTO_ROTATE_RIGHT_LOADING ? "right":"left"]_on"

	if(!HAS_TRAIT(user, TRAIT_GUNSLINGER)) //only gunslingers are allowed to flip
		chamber_options -= REVOLVER_FLIP

	if(!gate_loaded) //these are completely redundant  if you can reload everything with a speedloader
		chamber_options -= REVOLVER_AUTO_ROTATE_LEFT_LOADING
		chamber_options -= REVOLVER_AUTO_ROTATE_RIGHT_LOADING
		chamber_options -= REVOLVER_EJECT_CURRENT


	var/pick = show_radial_menu(user, src, chamber_options, custom_check = CALLBACK(src, PROC_REF(can_use_radial), user), require_near = TRUE)
	switch(pick)
		if(REVOLVER_ROTATE_LEFT)
			chamber_round(TRUE, TRUE)
		if(REVOLVER_ROTATE_RIGHT)
			chamber_round(TRUE)
		if(REVOLVER_AUTO_ROTATE_RIGHT_LOADING)
			gate_load_direction = REVOLVER_AUTO_ROTATE_RIGHT_LOADING
		if(REVOLVER_AUTO_ROTATE_LEFT_LOADING)
			gate_load_direction = REVOLVER_AUTO_ROTATE_LEFT_LOADING
		if(REVOLVER_EJECT_ALL)
			unload_all_ammo(user)
			return
		if(REVOLVER_EJECT_CURRENT)
			eject_casing(user)
		if(REVOLVER_FLIP)
			tryflip(user)
		if(null)
			return
	AltClick(user)

/obj/item/gun/ballistic/revolver/proc/can_use_radial(mob/user)
	if(QDELETED(src))
		return FALSE
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "Spin Chamber"
	set category = "Object"
	set desc = "Click to spin your revolver's chamber."

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, "revolver_spin", 30, FALSE)
		usr.visible_message("<span class='notice'>[usr] spins [src]'s chamber.</span>", "<span class='notice'>You spin [src]'s chamber.</span>")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/toggle_safety(mob/user, silent=FALSE, rack_gun=TRUE)
	if(semi_auto)//apogee said double actions should have normal safeties, so...
		return ..()
	safety = !safety

	if(!silent)
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		if(user)
			user.visible_message(
				span_notice("[user] pulls the [safety_wording] on [src] [safety ? "<span class='green'>UP</span>" : "<span class='red'>DOWN</span>"]."),
				span_notice("You pull the [safety_wording] on [src] [safety ? "<span class='green'>UP</span>" : "<span class='red'>DOWN</span>"]."),
			)

	update_appearance()

	if(rack_gun)
		rack(toggle_hammer= FALSE)

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
	if (current_skin)
		. += "It can be spun with <b>alt+click</b>"

/obj/item/gun/ballistic/revolver/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/fan = FALSE
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER) && !semi_auto && !wielded && loc == user && !safety && !user.get_inactive_held_item())
		fan = TRUE
		fire_delay = 0 SECONDS
	. = ..()
	fire_delay = src::fire_delay
	if(fan)
		rack()
		to_chat(user, span_notice("You fan the [bolt_wording] of \the [src]!"))
		balloon_alert_to_viewers("fans revolver!")
		fire_delay = 0 SECONDS

/obj/item/gun/ballistic/revolver/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	if(!semi_auto)
		toggle_safety(silent = TRUE, rack_gun = FALSE)

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if(!safety)
		to_chat(user, "<span class='danger'>*[dry_fire_text]*</span>")
		playsound(src, dry_fire_sound, 30, TRUE)
		if(!semi_auto)
			toggle_safety(silent = TRUE, rack_gun = FALSE)
		return
	to_chat(user, "<span class='danger'>The hammer is up on [src]! Pull it down to fire!</span>")

/obj/item/gun/ballistic/revolver/pickup(mob/user)
	. = ..()
	tryflip(user)

/obj/item/gun/ballistic/revolver/proc/tryflip(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER))
		if(COOLDOWN_FINISHED(src, flip_cooldown))
			COOLDOWN_START(src, flip_cooldown, 0.3 SECONDS)
			SpinAnimation(5,1)
			user.visible_message("<span class='notice'>[user] spins the [src] around their finger by the trigger. That’s pretty badass.</span>")
			playsound(src, 'sound/items/handling/ammobox_pickup.ogg', 20, FALSE)
			return

/obj/item/gun/ballistic/revolver/detective
	name = "\improper HP Detective Special"
	desc = "A small law enforcement firearm. Originally commissioned by Nanotrasen for their Private Investigation division, it has become extremely popular among independent civilians as a cheap, compact sidearm. Uses .38 Special rounds."
	fire_sound = 'sound/weapons/gun/revolver/shot_light.ogg'
	icon_state = "detective"
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	obj_flags = UNIQUE_RENAME
	semi_auto = TRUE //double action
	safety_wording = "safety"
	unique_reskin = list("Default" = "detective",
		"Stainless Steel" = "detective_stainless",
		"Gold Trim" = "detective_gold",
		"Leopard Spots" = "detective_leopard",
		"The Peacemaker" = "detective_peacemaker",
		"Black Panther" = "detective_panther"
		)
	w_class = WEIGHT_CLASS_SMALL
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	recoil = 0 //weaker than normal revolver, no recoil
	fire_delay = 0.2 SECONDS

EMPTY_GUN_HELPER(revolver/detective)

/obj/item/gun/ballistic/revolver/detective/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/revolver) //note that the hud at the moment only supports 6 round revolvers, 7 or 5 isn't supported rn
//...why...?
/obj/item/gun/ballistic/revolver/detective/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, burst_firing = FALSE, spread_override = 0, iteration = 0)
	if(magazine.caliber != initial(magazine.caliber))
		if(prob(100 - (magazine.ammo_count() * 5)))	//minimum probability of 70, maximum of 95
			playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
			to_chat(user, "<span class='userdanger'>[src] blows up in your face!</span>")
			user.take_bodypart_damage(0,20)
			explosion(src, 0, 0, 1, 1)
			user.dropItemToGround(src)
			return 0
	..()

/obj/item/gun/ballistic/revolver/detective/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(magazine.caliber == "38")
		to_chat(user, "<span class='notice'>You begin to reinforce the barrel of [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//you know the drill
			user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='userdanger'>[src] goes off in your face!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>You can't modify it!</span>")
				return TRUE
			magazine.caliber = ".357"
			fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
			desc = "The barrel and chamber assembly seems to have been modified."
			to_chat(user, "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .357 rounds.</span>")
	else
		to_chat(user, "<span class='notice'>You begin to revert the modifications to [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//and again
			user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='userdanger'>[src] goes off in your face!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>You can't modify it!</span>")
				return
			magazine.caliber = ".38"
			fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
			desc = initial(desc)
			to_chat(user, "<span class='notice'>You remove the modifications on [src]. Now it will fire .38 rounds.</span>")
	return TRUE

/obj/item/gun/ballistic/revolver/detective/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/viper/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 auto-revolver"
	desc = "A high-powered revolver with a unique auto-reloading system. Uses .357 ammo."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "mateba"
	manufacturer = MANUFACTURER_NONE
	semi_auto = TRUE
	safety_wording = "safety"
	spread = 0
	spread_unwielded = 7

/obj/item/gun/ballistic/revolver/golden
	name = "\improper Golden revolver"
	desc = "This ain't no game, ain't never been no show, And I'll gladly gun down the oldest lady you know. Uses .357 ammo."
	icon_state = "goldrevolver"
	fire_sound = 'sound/weapons/resonator_blast.ogg'
	recoil = 8
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/ballistic/revolver/montagne
	name = "\improper HP Montagne"
	desc = "An ornate break-open revolver issued to high-ranking members of the Saint-Roumain Militia. Chambered in .44."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	icon_state = "montagne"
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	spread_unwielded = 15
	recoil = 0

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44/montagne

/obj/item/gun/ballistic/revolver/montagne/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/revolver)

/obj/item/gun/ballistic/revolver/montagne/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/ashhand
	name = "HP Ashhand"
	desc = "A massive, long-barreled revolver often used by the Saint-Roumain Militia as protection against big game. Can only be reloaded one cartridge at a time due to its reinforced frame. Uses .45-70 ammo."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	icon_state = "ashhand"
	item_state = "ashhand"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev4570
	fire_sound = 'sound/weapons/gun/revolver/shot_hunting.ogg'
	rack_sound = 'sound/weapons/gun/revolver/viper_prime.ogg'
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	gate_loaded = TRUE
	fire_delay = 0.6 SECONDS
	wield_slowdown = 0.5
	spread_unwielded = 20
	spread = 6
	recoil = 2
	recoil_unwielded = 4

/obj/item/gun/ballistic/revolver/ashhand/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/revolver)

/obj/item/gun/ballistic/revolver/firebrand
	name = "\improper HP Firebrand"
	desc = "An archaic precursor to revolver-type firearms, this gun was rendered completely obsolete millennia ago. While fast to fire, it is extremely inaccurate. Uses .357 ammo."
	icon_state = "pepperbox"
	item_state = "hp_generic_fresh"
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/pepperbox
	spread = 20
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	spread_unwielded = 50
	fire_delay = 0 SECONDS
	gate_offset = 4
	semi_auto = TRUE
	safety_wording = "safety"

/obj/item/gun/ballistic/revolver/firebrand/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/shadow
	name = "\improper HP Shadow"
	desc = "A mid-size revolver. Despite the antiquated design, it is cheap, reliable, and stylish, making it a favorite among fast-drawing spacers and the officers of various militaries, as well as small-time police units. Chambered in .44."
	fire_sound = 'sound/weapons/gun/revolver/cattleman.ogg'
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	icon_state = "shadow"
	item_state = "shadow"

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	manufacturer = MANUFACTURER_HUNTERSPRIDE
	obj_flags = UNIQUE_RENAME
	gate_loaded = TRUE
	unique_reskin = list(\
		"Shadow" = "shadow",
		"Cattleman" = "shadow_cattleman",
		"General" = "shadow_general",
		"Sheriff" = "shadow_sheriff",
		"Cobra" = "shadow_cobra",
		"Hired Gun" = "shadow_hiredgun",
		"Buntline" = "shadow_buntline",
		"Cavalry" = "shadow_cavalry",
		"Lanchester Special" = "shadow_lanchester"
		)

	recoil = 0 //weaker than normal revolver, no recoil
	spread_unwielded = 10

/obj/item/gun/ballistic/revolver/shadow/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/revolver)

/obj/item/gun/ballistic/revolver/shadow/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/revolver/shadow/reskin_obj(mob/M)
	. = ..()
	if(current_skin)
		item_state = unique_reskin[current_skin]
