// Special objects for shuttle templates go here if nowhere else

// Bar staff, GODMODE mobs(as long as they stay in the shuttle) that just want to make sure people have drinks
// and a good time.

/mob/living/simple_animal/drone/snowflake/bardrone
	name = "Bardrone"
	desc = "A barkeeping drone, a robot built to tend bars."
	hacked = TRUE
	laws = "1. Serve drinks.\n\
		2. Talk to patrons.\n\
		3. Don't get messed up in their affairs."
	unique_name = FALSE // disables the (123) number suffix
	initial_language_holder = /datum/language_holder/universal

/mob/living/simple_animal/drone/snowflake/bardrone/Initialize()
	. = ..()
	access_card.access |= ACCESS_CENT_BAR
	become_area_sensitive(ROUNDSTART_TRAIT)
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(check_barstaff_godmode))
	check_barstaff_godmode()

/mob/living/simple_animal/drone/snowflake/bardrone/Destroy()
	lose_area_sensitivity(ROUNDSTART_TRAIT)
	return ..()

/mob/living/simple_animal/hostile/alien/maid/barmaid
	gold_core_spawnable = NO_SPAWN
	name = "Barmaid"
	desc = "A barmaid, a maiden found in a bar."
	pass_flags = PASSTABLE
	unique_name = FALSE
	AIStatus = AI_OFF
	stop_automated_movement = TRUE
	initial_language_holder = /datum/language_holder/universal

/mob/living/simple_animal/hostile/alien/maid/barmaid/Initialize()
	. = ..()
	access_card = new /obj/item/card/id(src)
	var/datum/job/captain/C = new /datum/job/captain
	access_card.access = C.get_access()
	access_card.access |= ACCESS_CENT_BAR
	ADD_TRAIT(access_card, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	become_area_sensitive(ROUNDSTART_TRAIT)
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(check_barstaff_godmode))
	check_barstaff_godmode()

/mob/living/simple_animal/hostile/alien/maid/barmaid/Destroy()
	qdel(access_card)
	lose_area_sensitivity(ROUNDSTART_TRAIT)
	return ..()

/mob/living/simple_animal/proc/check_barstaff_godmode()
	SIGNAL_HANDLER

	if(istype(get_area(loc), /area/shuttle/escape))
		status_flags |= GODMODE
	else
		status_flags &= ~GODMODE

// Bar table, a wooden table that kicks you in a direction if you're not
// barstaff (defined as someone who was a roundstart bartender or someone
// with CENTCOM_BARSTAFF)

/obj/structure/table/wood/bar
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = NODECONSTRUCT_1
	max_integrity = 1000
	var/boot_dir = 1

/obj/structure/table/wood/bar/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered)
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/table/wood/bar/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(isliving(AM) && !is_barstaff(AM))
		// No climbing on the bar please
		var/mob/living/M = AM
		var/throwtarget = get_edge_target_turf(src, boot_dir)
		M.Paralyze(40)
		M.throw_at(throwtarget, 5, 1)
		to_chat(M, "<span class='notice'>No climbing on the bar please.</span>")

/obj/structure/table/wood/bar/proc/is_barstaff(mob/living/user)
	. = FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.mind && H.mind.assigned_role == "Bartender")
			return TRUE

	var/obj/item/card/id/ID = user.get_idcard(FALSE)
	if(ID && (ACCESS_CENT_BAR in ID.access))
		return TRUE

//Luxury Shuttle Blockers

/obj/machinery/scanner_gate/luxury_shuttle
	name = "luxury shuttle ticket field"
	density = FALSE //allows shuttle airlocks to close, nothing but an approved passenger gets past CanPass
	locked = TRUE
	use_power = FALSE
	var/threshold = 500
	var/static/list/approved_passengers = list()
	var/static/list/check_times = list()
	var/list/payees = list()

/obj/machinery/scanner_gate/luxury_shuttle/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()

	if(mover in approved_passengers)
		set_scanline("scanning", 10)
		return TRUE

	if(!isliving(mover)) //No stowaways
		return FALSE

/obj/machinery/scanner_gate/luxury_shuttle/auto_scan(atom/movable/AM)
	return

/obj/machinery/scanner_gate/luxury_shuttle/attackby(obj/item/W, mob/user, params)
	return

/obj/machinery/scanner_gate/luxury_shuttle/emag_act(mob/user)
	return

#define LUXURY_MESSAGE_COOLDOWN 100
/obj/machinery/scanner_gate/luxury_shuttle/Bumped(atom/movable/AM)
	if(!isliving(AM))
		alarm_beep()
		return ..()

	var/datum/bank_account/account
	if(istype(AM.pulling, /obj/item/card/id))
		var/obj/item/card/id/I = AM.pulling
		if(I.registered_account)
			account = I.registered_account
		else if(!check_times[AM] || check_times[AM] < world.time) //Let's not spam the message
			to_chat(AM, "<span class='notice'>This ID card doesn't have an owner associated with it!</span>")
			check_times[AM] = world.time + LUXURY_MESSAGE_COOLDOWN
	else if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.get_bank_account())
			account = H.get_bank_account()

	if(account)
		if(account.account_balance < threshold - payees[AM])
			account.adjust_money(-account.account_balance, "luxury_shuttle")
			payees[AM] += account.account_balance
		else
			var/money_owed = threshold - payees[AM]
			account.adjust_money(-money_owed)
			payees[AM] += money_owed

	var/list/counted_money = list()

	for(var/obj/item/coin/C in AM.GetAllContents())
		if(payees[AM] >= threshold)
			break
		payees[AM] += C.value
		counted_money += C
	for(var/obj/item/spacecash/bundle/S in AM.GetAllContents())
		if(payees[AM] >= threshold)
			break
		payees[AM] += S.value
		counted_money += S
	for(var/obj/item/holochip/H in AM.GetAllContents())
		if(payees[AM] >= threshold)
			break
		payees[AM] += H.credits
		counted_money += H

	if(payees[AM] < threshold && istype(AM.pulling, /obj/item/coin))
		var/obj/item/coin/C = AM.pulling
		payees[AM] += C.value
		counted_money += C

	else if(payees[AM] < threshold && istype(AM.pulling, /obj/item/spacecash/bundle))
		var/obj/item/spacecash/bundle/S = AM.pulling
		payees[AM] += S.value
		counted_money += S

	else if(payees[AM] < threshold && istype(AM.pulling, /obj/item/holochip))
		var/obj/item/holochip/H = AM.pulling
		payees[AM] += H.credits
		counted_money += H

	if(payees[AM] < threshold)
		var/armless
		if(!ishuman(AM) && !istype(AM, /mob/living/simple_animal/slime))
			armless = TRUE
		else
			var/mob/living/carbon/human/H = AM
			if(!H.get_bodypart(BODY_ZONE_L_ARM) && !H.get_bodypart(BODY_ZONE_R_ARM))
				armless = TRUE

		if(armless)
			if(!AM.pulling || !iscash(AM.pulling) && !istype(AM.pulling, /obj/item/card/id))
				if(!check_times[AM] || check_times[AM] < world.time) //Let's not spam the message
					to_chat(AM, "<span class='notice'>Try pulling a valid ID, space cash, holochip or coin into \the [src]!</span>")
					check_times[AM] = world.time + LUXURY_MESSAGE_COOLDOWN

	if(payees[AM] >= threshold)
		for(var/obj/I in counted_money)
			qdel(I)
		payees[AM] -= threshold

		var/change = FALSE
		if(payees[AM] > 0)
			change = TRUE
			var/obj/item/holochip/HC = new /obj/item/holochip(AM.loc)
			HC.credits = payees[AM]
			HC.name = "[HC.credits] credit holochip"
			if(istype(AM, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = AM
				if(!H.put_in_hands(HC))
					AM.pulling = HC
			else
				AM.pulling = HC
			payees[AM] -= payees[AM]

		say("<span class='robot'>Welcome to first class, [AM]![change ? " Here is your change." : ""]</span>")
		approved_passengers += AM

		check_times -= AM
		return
	else if (payees[AM] > 0)
		for(var/obj/I in counted_money)
			qdel(I)
		if(!check_times[AM] || check_times[AM] < world.time) //Let's not spam the message
			to_chat(AM, "<span class='notice'>[payees[AM]] cr received. You need [threshold-payees[AM]] cr more.</span>")
			check_times[AM] = world.time + LUXURY_MESSAGE_COOLDOWN
		alarm_beep()
		return ..()
	else
		alarm_beep()
		return ..()

/mob/living/simple_animal/hostile/bear/fightpit
	name = "fight pit bear"
	desc = "This bear's trained through ancient Solarian secrets to fear the walls of its glass prison."
	environment_smash = ENVIRONMENT_SMASH_NONE

/obj/effect/decal/hammerandsickle
	name = "hammer and sickle"
	desc = "Communism powerful force."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "communist"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_x = -32
	pixel_y = -32

/obj/effect/decal/hammerandsickle/shuttleRotate(rotation)
	setDir(angle2dir(rotation+dir2angle(dir))) // No parentcall, rest of the rotate code breaks the pixel offset.
