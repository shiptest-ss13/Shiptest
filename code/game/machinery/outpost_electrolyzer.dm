//allows production of hydrogen from ice chunks
#define MOLS_PER_ICE 50 //1 ice = 50 mols
#define MOLS_PER_MERIT 10 //10 mols = 1 merit
#define MERITS_PER_ICE MOLS_PER_ICE / MOLS_PER_MERIT //1 ice = 5 merits
#define MERITS_USED_PER_TICK 2
#define H2_PUMP_SHUTOFF_PRESSURE 4000
#define CREDITS_TO_MERITS 4 // currently 2:5 credits to mols hydrogen. # of credits per merit
#define OUTPOST_HYDROGEN_CUT 0.8
#define HYDROGEN_IDEAL 45000 //used for high and low end of merit multiplier
#define MERIT_EXPONENT 0.95 //used for diminishing returns, values closer to 1 increase returns, lower decrease.

/obj/machinery/mineral/electrolyzer_unloader
	name = "ice unloading machine"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "unloader"
	density = TRUE
	input_dir = WEST
	output_dir = EAST
	needs_item_input = TRUE
	processing_flags = START_PROCESSING_MANUALLY

/obj/machinery/mineral/electrolyzer_unloader/pickup_item(datum/source, atom/movable/target, atom/oldLoc)
	if(istype(target, /obj/structure/ore_box))
		var/obj/structure/ore_box/box = target
		for(var/obj/item/stack/ore/ice/chunk in box)
			unload_mineral(chunk)
	else if(istype(target, /obj/item/stack/ore/ice))
		var/obj/item/stack/ore/chunk = target
		unload_mineral(chunk)

// electrolyzer + console

/obj/machinery/computer/electrolyzer_console
	name = "electrolyzer console"
	desc = "Deposits hydrogen merits, with 20% going to outpost upkeep."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"

	var/obj/machinery/mineral/electrolyzer/linked_electrolyzer

/obj/machinery/computer/electrolyzer_console/proc/electrolyze_item(obj/item/I)
	var/obj/item/stack/ore/ice/S = I
	var/meritval = round(S.get_amount() * MERITS_PER_ICE * OUTPOST_HYDROGEN_CUT,1) // causes a bit of surplus in the "outpost" supply, even if they use all of these merits for hydrogen.
	GLOB.hydrogen_stored +=  S.get_amount() * MOLS_PER_ICE
	new /obj/item/merit/bundle(drop_location(), meritval)
	qdel(I)
	playsound(src, 'sound/items/poster_being_created.ogg', 20, FALSE)

/obj/machinery/computer/electrolyzer_console/attackby(item,mob/user)
	if(istype(item, /obj/item/multitool))
		var/obj/item/multitool/multi = item
		if(istype(multi.buffer, /obj/machinery/mineral/electrolyzer))
			linked_electrolyzer = multi.buffer
			linked_electrolyzer.linked_console = src
			visible_message("Linked to [linked_electrolyzer]!")
		return
	return ..()

/obj/machinery/mineral/electrolyzer
	name = "ice crusher"
	desc = "Breaks down ice into hydrogen and oxygen."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "grinder-o1"
	input_dir = WEST
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000
	max_integrity = 500
	var/crush_damage = 1000
	var/obj/machinery/computer/electrolyzer_console/linked_console
	var/datum/weakref/attached_output

/obj/machinery/mineral/electrolyzer/Initialize()
	. = ..()
	update_appearance()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/machinery/mineral/electrolyzer/proc/find_electrolyzer()
	if(linked_console)
		return TRUE
	for(var/obj/machinery/computer/electrolyzer_console/potential in oview(3,src))
		if(linked_console == null)
			linked_console = potential
			potential.linked_electrolyzer = src
			return TRUE
	return FALSE

/obj/machinery/mineral/electrolyzer/attackby(item,mob/user)
	if(istype(item, /obj/item/multitool))
		var/obj/item/multitool/multi = item
		multi.buffer = src
		to_chat(user, "<span class='notice'>[src] stored in [multi].</span>")
		return
	return ..()

/obj/machinery/mineral/electrolyzer/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!anchored)
		return
	if(border_dir == input_dir)
		return TRUE

/obj/machinery/mineral/electrolyzer/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(electrolyze), AM)

/obj/machinery/mineral/electrolyzer/proc/electrolyze(atom/movable/electrolyze_target, sound=TRUE)
	if(!find_electrolyzer())
		visible_message("<span class='danger'>[src] doesn't have a linked console!</span>")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE, 1)
		return
	if(istype(electrolyze_target, /obj/effect) || !linked_console || !isturf(electrolyze_target.loc) || (machine_stat & (BROKEN|NOPOWER)))
		return
	if(!istype(electrolyze_target, /obj/item/stack/ore/ice))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE, 1)
		if(isliving(electrolyze_target))
			crush_living(electrolyze_target)
			return
		if(!ismob(electrolyze_target)) //MULCH IT IF IT AINT ICE
			qdel(electrolyze_target)
			return
	else
		linked_console.electrolyze_item(electrolyze_target)

/obj/machinery/mineral/electrolyzer/proc/crush_living(mob/living/L)

	L.forceMove(loc)

	if(issilicon(L))
		playsound(src, 'sound/items/welder.ogg', 50, TRUE)
	else
		playsound(src, 'sound/effects/splat.ogg', 50, TRUE)

	if(iscarbon(L) && L.stat == CONSCIOUS)
		L.force_scream()

	// Instantly lie down, also go unconscious from the pain, before you die.
	L.Unconscious(100)
	L.adjustBruteLoss(crush_damage)

//Hydrogen pump stuff

/obj/machinery/atmospherics/components/unary/hydrogen_pump
	name = "hydrogen pump"
	desc = "Lets you use merits to buy hydrogen."
	icon = 'icons/obj/atmos.dmi'
	icon_state = "hydrogen_pump"

	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	var/not_processing_bug = TRUE//remove when fixed
	var/merit

/obj/machinery/atmospherics/components/unary/hydrogen_pump/examine(mob/user)
	. = ..()
	if(merit)
		. += "<span class='notice'>[src] has [merit] merits, equaling [merit * MOLS_PER_MERIT] mols of hydrogen.</span>"
	else
		. += "<span class='notice'>[src] has no merits, get some from the electrolyzer or buy them to get hydrogen!</span>"
	. += "<span class='notice'>[src] is currently [on ? "on" : "off"], and shuts off above [H2_PUMP_SHUTOFF_PRESSURE] kPa.</span>"
	. += "<span class='notice'>[src] can be Alt-Clicked to eject merits.</span>"
	if(not_processing_bug == TRUE)
		. += "<span class='warning'>[src] is temporarily disabled. Check back later!</span>"

/obj/machinery/atmospherics/components/unary/hydrogen_pump/process_atmos()
	..()
	var/datum/gas_mixture/air = airs[1] //hydrogen out
	not_processing_bug = FALSE
	if(!on)
		return
	if(!merit || air.return_pressure() > H2_PUMP_SHUTOFF_PRESSURE)
		on = FALSE
		visible_message("<span class='danger'>[src] shuts off!</span>")
		playsound(src, 'sound/machines/switch2.ogg', 10, FALSE)
		return
	var/meritused
	if(merit >= MERITS_USED_PER_TICK)
		merit -= MERITS_USED_PER_TICK
		meritused = MERITS_USED_PER_TICK
	else
		meritused = merit
		merit = 0
		on = FALSE
	air.adjust_moles(GAS_HYDROGEN, meritused * MOLS_PER_MERIT)
	GLOB.hydrogen_stored -= meritused * MOLS_PER_MERIT
	air.set_temperature(T20C) //hydrogen from adjust_mols takes the temp of the container, and if the container is empty it defaults to 0K. this works for now

/obj/machinery/atmospherics/components/unary/hydrogen_pump/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/merit/bundle))
		var/obj/item/merit/bundle/C = I
		merit += C.value
		to_chat(user, "<span class='notice'>You deposit [I], for a total of [merit] merits.</span>")
		qdel(I)
		return
	return ..()

/obj/machinery/atmospherics/components/unary/hydrogen_pump/attack_hand(mob/user)
	if(..())
		return
	on = !on
	if(on)
		SSair.start_processing_machine(src)
	playsound(src, 'sound/machines/switch3.ogg', 10, FALSE)
	to_chat(user, "<span class='notice'>You toggle the pump [on ? "on" : "off"].</span>")
	investigate_log("was turned [on ? "on" : "off"] by [key_name(user)]", INVESTIGATE_ATMOS)
	update_appearance()

/obj/machinery/atmospherics/components/unary/hydrogen_pump/AltClick(mob/user)
	if(merit)
		new /obj/item/merit/bundle(drop_location(), merit)
		merit = FALSE
		playsound(src, 'sound/items/poster_being_created.ogg', 10, FALSE)
		to_chat(user, "<span class='notice'>You retrieve the hydrogen merits.</span>")
	else
		to_chat(user, "<span class='notice'>There were no merits left to retrieve.</span>")


//Hydrogen exchange

/obj/machinery/computer/hydrogen_exchange
	name = "Hydrogen Exchange"
	desc = "Credits to Merits at reasonable rates!"
	icon_screen = "exchange"
	icon_keyboard = "power_key"

	//GLOB.total_merits_exchanged starts at 0
	var/merits = NONE
	var/credits = NONE

/obj/machinery/computer/hydrogen_exchange/attackby(obj/item/I, mob/user)
	var/value = 0
	if(istype(I, /obj/item/spacecash/bundle))
		var/obj/item/spacecash/bundle/C = I
		value = C.value
	else if(istype(I, /obj/item/holochip))
		var/obj/item/holochip/H = I
		value = H.credits
	if(value)
		credits += value
		to_chat(user, "<span class='notice'>You deposit [I], for a total of [credits] credits.</span>")
		qdel(I)
		return
	if(istype(I, /obj/item/merit/bundle))
		var/obj/item/merit/bundle/C = I
		merits += C.value
		to_chat(user, "<span class='notice'>You deposit [I], for a total of [merits] merits.</span>")
		qdel(I)
		return
	return ..()

/obj/machinery/computer/hydrogen_exchange/proc/meritmultiplier()
	var/extra = clamp(((GLOB.hydrogen_stored / HYDROGEN_IDEAL) + 1), 0, 2) * 0.3 //results in a number between 0 and .6
	var/actual = round((0.4 + extra), 0.01) //.4 on low end, 1 on high end
	return actual

/obj/machinery/computer/hydrogen_exchange/proc/dispense_funds()
	var/makenoise
	if(merits)
		new /obj/item/merit/bundle(drop_location(), merits)
		merits = 0
		makenoise = TRUE
	if(credits)
		new /obj/item/spacecash/bundle(drop_location(), credits)
		credits = 0
		makenoise = TRUE
	if(makenoise)
		playsound(src, 'sound/machines/coindrop.ogg', 20, FALSE)

/obj/machinery/computer/hydrogen_exchange/proc/resetmerits() //debug proc
	GLOB.total_merits_exchanged = 0

/obj/machinery/computer/hydrogen_exchange/proc/convert_to_credits()
	if(merits)
		playsound(src, 'sound/machines/pda_button1.ogg', 20, FALSE)
		var/oldtotal = GLOB.total_merits_exchanged ** MERIT_EXPONENT
		var/newtotal = (GLOB.total_merits_exchanged + merits) ** MERIT_EXPONENT
		var/reducedmerits = newtotal - oldtotal
		GLOB.total_merits_exchanged += merits
		credits += round(reducedmerits * CREDITS_TO_MERITS, 1)
		merits = 0
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 20, FALSE)

/obj/machinery/computer/hydrogen_exchange/proc/convert_to_merits()
	if(credits)
		playsound(src, 'sound/machines/pda_button1.ogg', 20, FALSE)
		merits += round(credits * meritmultiplier() / CREDITS_TO_MERITS, 1)
		credits = 0
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 20, FALSE)

/obj/machinery/computer/hydrogen_exchange/AltClick(mob/user)
	dispense_funds()
	to_chat(user, "<span class='notice'>You force the credits and merits out of the machine.</span>")

/obj/machinery/computer/hydrogen_exchange/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HydrogenExchange", name)
		ui.open()

/obj/machinery/computer/hydrogen_exchange/ui_data(mob/user)
	var/next_merit_rate
	if(GLOB.total_merits_exchanged)
		next_merit_rate = round((GLOB.total_merits_exchanged ** MERIT_EXPONENT) / GLOB.total_merits_exchanged * CREDITS_TO_MERITS, 0.01)
	else
		next_merit_rate = CREDITS_TO_MERITS
	var/list/data = list()
	data["credits"] = credits
	data["merits"] = merits
	data["next_merit_rate"] = next_merit_rate
	data["credits_to_merits"] = CREDITS_TO_MERITS
	data["credit_tax"] = (1 - meritmultiplier()) * 100
	return data

/obj/machinery/computer/hydrogen_exchange/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("convert_to_credits")
			convert_to_credits()
			. = TRUE
		if("convert_to_merits")
			convert_to_merits()
			. = TRUE
		if("dispense")
			dispense_funds()
			. = TRUE

//SCRIP!

/obj/item/merit
	name = "hydrogen?"
	desc = "If you can see this, please make a bug report. If you're a mapper, use the bundle subtype!"
	icon = 'icons/obj/economy.dmi'
	icon_state = "merit0"
	throwforce = 1
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	var/value = 0
	grind_results = list(/datum/reagent/iron = 10)

/obj/item/merit/Initialize(mapload, amount)
	. = ..()
	if(amount)
		value = amount
	update_appearance()

/obj/item/merit/attackby(obj/item/I, mob/user)
	if(!istype(I, /obj/item/merit))
		return
	var/obj/item/merit/bundle/bundle
	if(istype(I, /obj/item/merit/bundle))
		bundle = I
	else
		var/obj/item/merit/cash = I
		bundle = new (loc)
		bundle.value = cash.value
		user.dropItemToGround(cash)
		qdel(cash)

	bundle.value += value
	bundle.update_appearance()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.dropItemToGround(src)
		H.dropItemToGround(bundle)
		H.put_in_hands(bundle)
	to_chat(user, "<span class='notice'>You add [value] merits worth of money to the bundle.<br>It now holds [bundle.value] merits.</span>")
	qdel(src)

/obj/item/merit/Destroy()
	. = ..()
	value = 0 // Prevents money from be duplicated anytime.//I'll trust eris on this one

/obj/item/merit/bundle
	icon_state = "merit16"

/obj/item/merit/bundle/Initialize()
	. = ..()
	update_appearance()

/obj/item/merit/bundle/update_appearance()
	icon_state = "nothing"
	cut_overlays()
	var/remaining_value = value
	var/iteration = 0
	var/coins_only = TRUE
	var/list/coin_denominations = list(16, 4, 1)
	var/list/banknote_denominations = list(4096, 1024, 256, 64)
	for(var/i in banknote_denominations)
		while(remaining_value >= i && iteration < 50)
			remaining_value -= i
			iteration++
			var/image/banknote = image('icons/obj/economy.dmi', "merit[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			banknote.transform = M
			overlays += banknote
			coins_only = FALSE

	if(remaining_value)
		for(var/i in coin_denominations)
			while(remaining_value >= i && iteration < 50)
				remaining_value -= i
				iteration++
				var/image/coin = image('icons/obj/economy.dmi', "merit[i]")
				var/matrix/M = matrix()
				M.Translate(rand(-6, 6), rand(-4, 8))
				coin.transform = M
				overlays += coin

	if(coins_only)
		if(value == 1)
			name = "one hydrogen merit"
			desc = "Heavier then it looks."
			drop_sound = 'sound/items/handling/coin_drop.ogg'
			pickup_sound =  'sound/items/handling/coin_pickup.ogg'
		else
			name = "[value] hydrogen merits"
			desc = "Heavier than they look."
			gender = PLURAL
			drop_sound = 'sound/items/handling/coin_drop.ogg'
			pickup_sound =  'sound/items/handling/coin_pickup.ogg'
	else
		if(value <= 3000)
			name = "[value] hydrogen merits"
			gender = NEUTER
			desc = "Some cold, hard cash."
			drop_sound = 'sound/items/handling/dosh_drop.ogg'
			pickup_sound =  'sound/items/handling/dosh_pickup.ogg'
		else
			name = "[value] hydrogen merit"
			gender = NEUTER
			desc = "That's a lot of dosh."
			drop_sound = 'sound/items/handling/dosh_drop.ogg'
			pickup_sound =  'sound/items/handling/dosh_pickup.ogg'
	return ..()

/obj/item/merit/bundle/attack_self(mob/user)
	if(!Adjacent(user))
		to_chat(user, "<span class='warning'>You need to be in arm's reach for that!</span>")
		return

	var/cashamount = input(user, "How many merits do you want to take? (0 to [value])", "Take Merits", 20) as num
	cashamount = round(clamp(cashamount, 0, value))
	if(!cashamount)
		return

	value -= cashamount
	if(!value)
		user.dropItemToGround(src)
		qdel(src)

	var/obj/item/merit/bundle/bundle = new (user.loc)
	bundle.value = cashamount
	bundle.update_appearance()
	user.put_in_hands(bundle)
	update_appearance()

/obj/item/merit/bundle/AltClick(mob/living/user)
	if(!Adjacent(user))
		to_chat(user, "<span class='warning'>You need to be in arm's reach for that!</span>")
		return

	var/cashamount = input(user, "How many merits do you want to take? (0 to [value])", "Take Merits", 20) as num
	cashamount = round(clamp(cashamount, 0, value))
	if(!cashamount)
		return

	value -= cashamount
	if(!value)
		user.dropItemToGround(src)
		qdel(src)

	var/obj/item/merit/bundle/bundle = new (user.loc)
	bundle.value = cashamount
	bundle.update_appearance()
	user.put_in_hands(bundle)
	update_appearance()

/obj/item/merit/bundle/attack_hand(mob/user)
	if(user.get_inactive_held_item() != src)
		return ..()
	if(value == 0)//may prevent any edge case duping
		qdel(src)
		return
	value--
	user.put_in_hands(new /obj/item/merit/bundle(loc, 1))
	update_appearance()

//bundles for mapping + testing

/obj/item/merit/bundle/m1
	value = 1
	icon_state = "merit1"

/obj/item/merit/bundle/m4
	value = 4
	icon_state = "merit4"

/obj/item/merit/bundle/m16
	value = 16
	icon_state = "merit16"

/obj/item/merit/bundle/m64
	value = 64
	icon_state = "merit64"

/obj/item/merit/bundle/m256
	value = 256
	icon_state = "merit256"

/obj/item/merit/bundle/m1024
	value = 1024
	icon_state = "merit1024"

/obj/item/merit/bundle/m4096
	value = 4096
	icon_state = "merit4096"

#undef MOLS_PER_ICE
#undef MOLS_PER_MERIT
#undef MERITS_PER_ICE
#undef MERITS_USED_PER_TICK
#undef H2_PUMP_SHUTOFF_PRESSURE
#undef CREDITS_TO_MERITS
#undef MERIT_EXPONENT
