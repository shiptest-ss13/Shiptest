/********************************\
|		   Slot Machines		 |
|	  Original code by Glloyd  	 |
|	  Tgstation port by Miauw	 |
|	  Shiptest adjustments by	 |
|	    Flopppi and Geoengi		 |
|      Reworked by cablefish     |
\*******************************/

// NORMAL SLOT MACHINE //
// Odds and prizes based off of the Liberty Bell slot machine from 1894.
/obj/machinery/slot_machine
	name = "slot machine"
	desc = "Kiyatirawkitchi Entertainment's latest and greatest slot machine. A favorite of the antisocial gambler. A printed message on the side reads \"Remember: Play Responsibly, And Have Fun!\""
	icon = 'icons/obj/slotmachine.dmi'
	icon_state = "slots"
	base_icon_state = "slots"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	circuit = /obj/item/circuitboard/machine/slot_machine
	verb_say = "squawks"
	verb_ask = "creels"
	verb_exclaim = "shrieks"
	integrity_failure = 0.5

	// bet multiplier adjustment
	var/can_change_mult = TRUE // can we adjust the bet multiplier
	var/bet_mult = 1 // global multiplier for bets/prizes
	var/min_mult = 1 // minimum selectable bet multiplier
	var/max_mult = 10 // maximum selectable bet multiplier

	// overlay stuff
	var/banner_state = "banner_game" // what our default banner should win
	var/flashing_win = FALSE // if we are currently flashing the WINNER animation
	var/flashing_die = FALSE // if we are currently flashing the DIE animation

	// game vars
	var/spin_time = 1.5 SECONDS // how long a spin takes
	var/cost_to_play = 10 // how much a spin costs
	var/balance = 0 // the player's current balance
	var/spinning = FALSE // are we currently spinning (locked)
	var/list/reels[3] // state of our reels
	var/list/rolls = list( // weighted list of rolls for the first two reels
		"$" = 1, "C" = 1, "L" = 1, "F" = 2, "6" = 5)
	var/list/rolls_third = list( // weighted list of rolls for the third reel
		"$" = 2, "C" = 1, "L" = 3, "F" = 2, "W" = 2)
	var/list/prizes = list( // list of prize states and values
		"$$$" = 200,
		"CCC" = 160,
		"LLL" = 120,
		"FFF" = 80,
		"66W" = 40,
		"66" = 20)

	var/placard_legible = TRUE // whether or not we can double examine this for a prize list

// convert the internal IDs to a display name
/obj/machinery/slot_machine/proc/print_reels()
	var/buf = ""
	for(var/i = 1, i <= 3, i++)
		buf += reels[i]
		if(i != 3)
			buf += "-"
	return buf

/obj/machinery/slot_machine/update_appearance()
	. = ..()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
	else
		icon_state = base_icon_state

/obj/machinery/slot_machine/update_overlays()
	. = ..()

	if(!(machine_stat & BROKEN))
		if(flashing_win)
			. += "banner_win"
		else if(flashing_die)
			. += "banner_die"
		else
			. += banner_state
	else
		return // no reels if we're broken!

	// reels
	var/list/static/prefixes = list("l_", "m_", "r_")
	var/list/real_reels = reels

	// randomize if spinning
	if(spinning)
		real_reels[1] = pick_weight(rolls)
		real_reels[2] = pick_weight(rolls)
		real_reels[3] = pick_weight(rolls_third)

	// translate reel states to icon states
	for(var/i = 1, i <= 3, i++)
		var/reel_state = "UNINITIALIZED"
		switch(reels[i])
			if("$")
				reel_state = "cent"
			if("C")
				reel_state = "cherry"
			if("L")
				reel_state = "lime"
			if("F")
				reel_state = "fish"
			if("6")
				reel_state = "six"
			if("W")
				reel_state = "warra"
			if("GUN")
				reel_state = "zip"
		. += prefixes[i] + reel_state

/obj/machinery/slot_machine/Initialize()
	. = ..()
	reels[1] = pick_weight(rolls)
	reels[2] = pick_weight(rolls)
	reels[3] = pick_weight(rolls_third)

/obj/machinery/slot_machine/examine(mob/examiner)
	. = ..()
	. += span_notice("The machine reports a balance of <b>[balance]</b> credits. It costs <b>[cost_to_play * bet_mult]</b> to play.")
	. += span_notice("You can <b>left click</b> the machine to pull the lever and <b>right click</b> it to eject your winnings.")
	. += span_notice("The reels read: <b>[print_reels()]</b>.")
	. += span_notice("There is an explanation of prizes you can read by <b>examining this closely</b>.")
	. += span_notice("The maintenance panel is [panel_open ? "opened" : "closed"].")
	if(panel_open && can_change_mult)
		. += span_notice("You could adjust the bet multiplier with a <b>multitool</b>.")

/obj/machinery/slot_machine/examine_more(mob/examiner)
	. = ..()
	if(placard_legible)
		. += "A small placard reads:\n<b>PRIZES!</b>"
		for(var/prize in prizes)
			var/buf = ""
			if(length(prize) == 2)
				buf += "[prize[1]]-[prize[2]]: "
			else
				buf += "[prize[1]]-[prize[2]]-[prize[3]]: "
			if(ispath(prizes[prize]))
				var/obj/oprize = prizes[prize]
				buf += "<b>[oprize.name] x[bet_mult]!</b>"
			else
				buf += "<b>[prizes[prize] * bet_mult] CR!</b>"
			. += buf
		. += "PAYOUT IMMEDIATELY! GOOD LUCK AND HAVE FUN."
	else
		. += "The prize placard is completely illegible. You're on your own, good luck."

// money insertion
/obj/machinery/slot_machine/attackby(obj/item/object, mob/living/user, params)
	if(istype(object, /obj/item/spacecash/bundle))
		var/obj/item/spacecash/bundle/credits = object
		if(!user.temporarilyRemoveItemFromInventory(credits))
			return
		to_chat(user, span_notice("You insert [credits.value] credits into [src]'s slot."))
		balance += credits.value
		qdel(credits)
	else if(istype(object, /obj/item/holochip))
		var/obj/item/holochip/our_chip = object
		if(!user.temporarilyRemoveItemFromInventory(our_chip))
			return
		to_chat(user, span_notice("You hold up the holochip to [src]'s scanner and it flickers away after a brief moment. [our_chip.credits] credits have been deposited."))
		balance += our_chip.credits
		qdel(our_chip)
	else if(default_unfasten_wrench(user, object))
		power_change()
		return
	else if(!spinning && default_deconstruction_screwdriver(user, icon_state, icon_state, object))
		return TRUE
	else if(!spinning && default_deconstruction_crowbar(object))
		return TRUE
	else
		return ..()

/obj/machinery/slot_machine/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(panel_open && !spinning && can_change_mult)
		var/picked_mult = clamp(input(user, "Change bet multiplier: Valid Range ([min_mult], [max_mult])", "Change Bet Multiplier", 0) as num, min_mult, max_mult)
		if(!user.canUseTopic(src, BE_CLOSE) || !panel_open || spinning)
			return TRUE
		bet_mult = picked_mult
		to_chat(user, span_notice("You change the machine's bet multiplier to [bet_mult]."))
		return TRUE

// left click... spin the slot machine if we are able to
/obj/machinery/slot_machine/attack_hand(mob/user, list/modifiers)
	. = ..()
	// we do all the right click shit in a separate proc
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(machine_stat & NOPOWER)
		to_chat(user, span_warning("It's off..."))
		return
	if(machine_stat & BROKEN)
		audible_message(span_warning("The machine emits a few sparks."))
		play_click_sound('sound/effects/light_flicker.ogg')
		return
	if(panel_open)
		audible_message(span_warning("Close the panel first!"))
		return
	if(spinning)
		to_chat(user, span_boldwarning("It's still spinning! Be patient."))
		return
	if(balance < cost_to_play * bet_mult)
		speak("INSERT MORE MONEY TO PLAY!", prob(50))
		return
	// we're good. spin!
	Shake(1, 1, min(spin_time, 10 SECONDS)) // min prevents server crash if spin_time is vv'd to be very high because this proc is apparently evil
	play_click_sound('sound/machines/switch2.ogg')
	user.visible_message(
		span_notice("[user] pulls the lever on [src]."),
		span_notice("You pull the lever on [src]."))
	spinning = TRUE
	balance -= cost_to_play * bet_mult
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(spinny)), 1)
	addtimer(CALLBACK(src, PROC_REF(done_spinning)), spin_time)

// while spinning we keep flicking through the reels
/obj/machinery/slot_machine/proc/spinny()
	update_appearance()
	if(spinning)
		addtimer(CALLBACK(src, PROC_REF(spinny)), 1)

// callback to reset the banner to normal
/obj/machinery/slot_machine/proc/go_back_to_normal_banner()
	flashing_win = FALSE
	flashing_die = FALSE
	if(!spinning)
		update_appearance()

// we are done spinning - roll prize
/obj/machinery/slot_machine/proc/done_spinning()
	spinning = FALSE
	reels[1] = pick_weight(rolls)
	reels[2] = pick_weight(rolls)
	reels[3] = pick_weight(rolls_third)
	calc_prize()

// roll the prize
/obj/machinery/slot_machine/proc/calc_prize()
	// prizes we are winning
	var/cash_prize = 0
	var/first_two = reels[1] + reels[2]
	var/all_three = reels[1] + reels[2] + reels[3]
	for (var/prize in prizes)
		if ((length(prize) == 2 && first_two == prize) || all_three == prize)
			cash_prize = prizes[prize] * bet_mult
			break

	balance += cash_prize
	visible_message(span_notice("The machine stops on <b>[print_reels()]</b>."))
	if(cash_prize)
		visible_message(span_notice("The machine blinks: YOU'VE WON [cash_prize] CREDITS!"))
		speak("WINNER! WINNER!", prob(50))
		playsound(src, 'sound/machines/roulettejackpot.ogg', 50, FALSE)
		flashing_win = TRUE
		addtimer(CALLBACK(src, PROC_REF(go_back_to_normal_banner)), spin_time - 1)
	else
		visible_message(span_notice("The machine blinks: TRY AGAIN!"))
		playsound(src, 'sound/machines/scanbuzz.ogg', 30, FALSE) // aw dang it
	update_appearance()

// right click - eject money
/obj/machinery/slot_machine/attack_hand_secondary(mob/user)
	. = ..()
	if(spinning)
		to_chat(user, span_boldwarning("It's still spinning! Be patient."))
		return
	if(balance)
		var/obj/item/holochip/winnings = new (user.drop_location(), balance)
		to_chat(user, span_notice("You eject [balance] credits from the slot machine."))
		user.put_in_hands(winnings)
		play_click_sound('sound/machines/copier.ogg')
		balance = 0
	else
		speak("NO MONEY!", prob(50))
		play_click_sound('sound/machines/buzz-sigh.ogg')

// spit out balance when deconstructed - we aren't THAT evil
/obj/machinery/slot_machine/Destroy()
	if(balance)
		new /obj/item/holochip (loc, balance)
	return ..()

// wrapper for saying stuff. this thing speaks common and vox.
/obj/machinery/slot_machine/proc/speak(thing_to_say, vox = FALSE)
	say(thing_to_say, FALSE, null, TRUE, vox ? /datum/language/vox_pidgin : /datum/language/galactic_common)

// GUN SLOT MACHINE //
// Same prize odds, just dispenses guns instead of cash.
/obj/machinery/slot_machine/gun
	name = "slot machine (gun)"
	desc = "A strange looking slot machine with a large slot for dispensing items. It looks to be extensively modified. A disposable gun is painted on the side alongside what appears to be some Eoehoma firearms."
	circuit = /obj/item/circuitboard/machine/slot_machine/gun

	banner_state = "banner_gun"
	spin_time = 2 SECONDS
	cost_to_play = 50
	prizes = list( // for this one we take type paths
		"$$$" = /obj/item/gun/ballistic/automatic/assault/e40,
		"CCC" = /obj/item/gun/energy/laser/e50,
		"LLL" = /obj/item/gun/energy/laser/e20,
		"FFF" = /obj/item/gun/energy/laser/e10,
		"66W" = /obj/item/gun/energy/e_gun/e11,
		"66" = /obj/item/storage/box/disposable_gun_gacha)
	can_change_mult = FALSE
	placard_legible = FALSE

	// SNOWFLAKE PROBS (override the actual reels rolling)
	var/zippy_prob = 0.000001 // probability of getting The Zippy
	var/bullet_prob = 1 // probability of the machine shooting you

// special prize calculation proc because we dispense items not cash
// little bit of copy paste but oh well
/obj/machinery/slot_machine/gun/calc_prize()
	// prizes we are winning
	var/gun_prize = null
	var/first_two = reels[1] + reels[2]
	var/all_three = reels[1] + reels[2] + reels[3]
	var/special_prize = FALSE
	var/die_prize = FALSE

	for (var/prize in prizes)
		if ((length(prize) == 2 && first_two == prize) || all_three == prize)
			gun_prize = prizes[prize]
			break

	// special Super Zippy
	if(prob(zippy_prob))
		special_prize = TRUE
		reels[1] = "GUN"
		reels[2] = "GUN"
		reels[3] = "GUN"
		gun_prize = /obj/item/gun/ballistic/automatic/pistol/disposable/infinite_ammo
		message_admins("An infinite ammo zippy has been won! [ADMIN_LOOKUPFLW(src)]")

	// snowflake chance to roll a bullet
	if(prob(bullet_prob) && !special_prize)
		die_prize = TRUE
		reels[1] = "6"
		reels[2] = "6"
		reels[3] = "6"
		gun_prize = /obj/item/ammo_casing/c22lr/prefired

	visible_message(span_notice("The machine stops on <b>[reels[1]]-[reels[2]]-[reels[3]]</b>."))

	if(gun_prize)
		var/obj/item/our_prize
		for(var/i = 1, i <= bet_mult, i++)
			our_prize = new gun_prize(loc)
		if(special_prize)
			visible_message(span_notice("The machine blares an alarm and dispenses... [our_prize]?"))
			speak("JACKPOT!! JACKPOT!!", prob(50))
			playsound(src, 'sound/machines/engine_alert2.ogg', 50, FALSE)
		else
			visible_message(span_notice("The machine blinks a light and dispenses [our_prize]!"))
			speak("WIN!", prob(50))
			playsound(src, 'sound/machines/roulettejackpot.ogg', 50, FALSE)
		if(die_prize)
			flashing_die = TRUE
		else
			flashing_win = TRUE
		addtimer(CALLBACK(src, PROC_REF(go_back_to_normal_banner)), spin_time - 1)
	else
		visible_message(span_notice("The machine blinks: NO PRIZE."))
		playsound(src, 'sound/machines/scanbuzz.ogg', 30, FALSE)
	update_appearance()

// SLOT MACHINE CONSTRUCTION FLUFF ITEMS //
/obj/item/gambling_link
	name = "LRPOST"
	desc = "A Long Range Point of Sale Tranciever chip capable of processing financial transactions on a secure, private bluespace frequency. A close relative of the LTSRBT. This one has a stamp on it reading: \"Kiyatirawkitchi Manufacturing Model 5701-"
	icon = 'icons/obj/module.dmi'
	icon_state = "boris"
	w_class = WEIGHT_CLASS_SMALL

// overengineered description generator
/obj/item/gambling_link/Initialize()
	. = ..()
	var/leading_zero = rand(1, 4)
	if(prob(1))
		leading_zero = rand(5, 6)
	for(var/i = 0, i < leading_zero, i++)
		desc += "0"
	for(var/i = 0, i < 8 - leading_zero, i++)
		desc += "[rand(0,9)]"
	desc += ". DO NOT TAMPER!\""

/obj/item/gun_slot_machine_link
	name = "Antenna Thing"
	desc = "Some kind of bluespace communications circuitry. Most of the identifying markings on the board have been scraped off and many components appear to be hand-soldered together. It buzzes ominously."
	icon = 'icons/obj/module.dmi'
	icon_state = "boris_recharging"
	w_class = WEIGHT_CLASS_SMALL

// SNOWFLAKE AMMO CASING THAT IMMEDIATELY TRIES TO SHOOT SOMEONE //
/obj/item/ammo_casing/c22lr/prefired
	name = "prefired bullet"
	desc = "YOU LOSE!"

/obj/item/ammo_casing/c22lr/prefired/Initialize()
	. = ..()
	var/target
	for(var/mob/living/loser in range(6, get_turf(src)))
		if(!isInSight(src, loser))
			continue
		target = loser
		break
	if(!target)
		var/fire_dir = pick(GLOB.alldirs)
		target = get_ranged_target_turf(get_turf(src),fire_dir,6)
	fire_casing(target, null, null, null, FALSE, null, 0, src, TRUE)
	qdel(src) // do not leave a casing
