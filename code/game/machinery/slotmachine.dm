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
	icon = 'icons/obj/economy.dmi'
	icon_state = "slots1"
	base_icon_state = "slots"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	circuit = /obj/item/circuitboard/machine/slot_machine
	verb_say = "squawks"
	verb_ask = "creels"
	verb_exclaim = "shrieks"

	var/spin_time = 1.5 SECONDS // how long a spin takes
	var/cost_to_play = 10 // how much a spin costs
	var/balance = 0 // the player's current balance
	var/spinning = FALSE // are we currently spinning (locked)
	var/list/reels[3] // state of our reels
	var/list/rolls = list( // weighted list of rolls for the first two reels
		"B" = 1, "H" = 1, "D" = 1, "S" = 2, "U" = 5)
	var/list/rolls_third = list( // weighted list of rolls for the third reel
		"B" = 2, "H" = 1, "D" = 3, "S" = 2, "X" = 2)
	var/list/prizes = list( // list of prize states and values
		"BBB" = 200,
		"HHH" = 160,
		"DDD" = 120,
		"SSS" = 80,
		"UUX" = 40,
		"UU" = 20)
	var/extended_description = "A small placard reads:\n<b>PRIZES!</b>\nB-B-B: <b>200 CR!</b>\nH-H-H: <b>160 CR!</b>\nD-D-D: <b>120 CR!</b>\nS-S-S: <b>80 CR!</b>\nU-U-X: <b>40 CR!</b>\nU-U: <b>20 CR!</b>\nPAYOUT IMMEDIATELY! GOOD LUCK AND HAVE FUN!" // text to show on examine_more

/obj/machinery/slot_machine/Initialize()
	. = ..()
	reels[1] = pick_weight(rolls)
	reels[2] = pick_weight(rolls)
	reels[3] = pick_weight(rolls_third)

/obj/machinery/slot_machine/examine(mob/examiner)
	. = ..()
	. += span_notice("The machine reports a balance of <b>[balance]</b> credits. It costs <b>[cost_to_play]</b> to play.")
	. += span_notice("You can <b>left click</b> the machine to pull the lever and <b>right click</b> it to eject your winnings.")
	. += span_notice("The reels read: <b>[reels[1]]-[reels[2]]-[reels[3]]</b>.")
	. += span_notice("There is an explanation of prizes you can read by <b>examining this closely</b>.")
	. += span_notice("The maintenance panel is [panel_open ? "opened" : "closed"].")

/obj/machinery/slot_machine/examine_more(mob/examiner)
	. = ..()
	. += extended_description

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
	if(balance < cost_to_play)
		speak("INSERT MORE MONEY TO PLAY!", prob(50))
		return
	// we're good. spin!
	Shake(2, 2, spin_time)
	play_click_sound('sound/machines/switch2.ogg')
	user.visible_message(
		span_notice("[user] pulls the lever on [src]."),
		span_notice("You pull the lever on [src]."))
	spinning = TRUE
	balance -= cost_to_play
	addtimer(CALLBACK(src, PROC_REF(done_spinning)), spin_time)

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
			cash_prize = prizes[prize]
			break

	balance += cash_prize
	visible_message(span_notice("The machine stops on <b>[reels[1]]-[reels[2]]-[reels[3]]</b>."), vision_distance = 1)
	if(cash_prize)
		visible_message(span_notice("The machine blinks: YOU'VE WON [cash_prize] CREDITS!"), vision_distance = 1)
		speak("WINNER! WINNER!", prob(50))
		playsound(src, 'sound/machines/roulettejackpot.ogg', 50, FALSE)
	else
		visible_message(span_notice("The machine blinks: TRY AGAIN!"), vision_distance = 1)
		playsound(src, 'sound/machines/scanbuzz.ogg', 30, FALSE) // aw dang it

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

	spin_time = 2 SECONDS
	cost_to_play = 50
	prizes = list( // for this one we take type paths
		"BBB" = /obj/item/gun/ballistic/automatic/assault/e40,
		"HHH" = /obj/item/gun/energy/laser/e50,
		"DDD" = /obj/item/gun/energy/laser/e20,
		"SSS" = /obj/item/gun/energy/laser/e10,
		"UUX" = /obj/item/gun/energy/e_gun/e11,
		"UU" = /obj/item/storage/box/disposable_gun_gacha)
	extended_description = "The prize placard is completely illegible. You're on your own, good luck."
	var/zippy_prob = 0.000001 // probability of getting The Zippy

// special prize calculation proc because we dispense items not cash
// little bit of copy paste but oh well
/obj/machinery/slot_machine/gun/calc_prize()
	// prizes we are winning
	var/gun_prize = null
	var/first_two = reels[1] + reels[2]
	var/all_three = reels[1] + reels[2] + reels[3]
	var/special_prize = FALSE

	for (var/prize in prizes)
		if ((length(prize) == 2 && first_two == prize) || all_three == prize)
			gun_prize = prizes[prize]
			break

	if(prob(zippy_prob))
		special_prize = TRUE
		reels[1] = "G"
		reels[2] = "U"
		reels[3] = "N"
		gun_prize = /obj/item/gun/ballistic/automatic/pistol/disposable/infinite_ammo
		message_admins("An infinite ammo zippy has been won! [ADMIN_LOOKUPFLW(src)]")
	visible_message(span_notice("The machine stops on <b>[reels[1]]-[reels[2]]-[reels[3]]</b>."), vision_distance = 1)

	if(gun_prize)
		new gun_prize(loc)
		if(special_prize)
			visible_message(span_notice("The machine blares an alarm and dispenses... A disposable gun?"))
			speak("JACKPOT!! JACKPOT!!", prob(50))
			playsound(src, 'sound/machines/engine_alert2.ogg', 50, FALSE)
		else
			visible_message(span_notice("The machine blinks a light and dispenses a gun!"), vision_distance = 1)
			speak("WIN!", prob(50))
			playsound(src, 'sound/machines/roulettejackpot.ogg', 50, FALSE)
	else
		visible_message(span_notice("The machine blinks: NO PRIZE."), vision_distance = 1)
		playsound(src, 'sound/machines/scanbuzz.ogg', 30, FALSE)

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
