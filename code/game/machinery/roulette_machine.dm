#define ROULETTE_SINGLES_PAYOUT 36
#define ROULETTE_SIMPLE_PAYOUT 2
#define ROULETTE_DOZ_COL_PAYOUT 3

#define ROULETTE_BET_ODD "odd"
#define ROULETTE_BET_EVEN "even"
#define ROULETTE_BET_1TO18 "s1-18" //adds s to prevent text2num from working
#define ROULETTE_BET_19TO36 "s19-36" //adds s to prevent text2num from working
#define ROULETTE_BET_1TO12 "s1-12"
#define ROULETTE_BET_13TO24 "s13-24"
#define ROULETTE_BET_25TO36 "s25-36"
#define ROULETTE_BET_2TO1_FIRST "s1st col"
#define ROULETTE_BET_2TO1_SECOND "s2nd col"
#define ROULETTE_BET_2TO1_THIRD "s3rd col"
#define ROULETTE_BET_BLACK "black"
#define ROULETTE_BET_RED "red"

#define ROULETTE_JACKPOT_AMOUNT 1000

///Machine that lets you play roulette. Odds are pre-defined to be the same as European Roulette without the "En Prison" rule
/obj/machinery/roulette
	name = "Roulette Table"
	desc = "A computerized roulette table. Swipe your cash card to play or register yourself as the owner!"
	icon = 'icons/obj/machines/roulette.dmi'
	icon_state = "idle"
	density = TRUE
	use_power = IDLE_POWER_USE
	anchored = FALSE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = ACTIVE_DRAW_MINIMAL
	max_integrity = 500
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 10, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	var/static/list/numbers = list("0" = "green", "1" = "red", "3" = "red", "5" = "red", "7" = "red", "9" = "red", "12" = "red", "14" = "red", "16" = "red",\
	"18" = "red", "19" = "red", "21" = "red", "23" = "red", "25" = "red", "27" = "red", "30" = "red", "32" = "red", "34" = "red", "36" = "red",\
	"2" = "black", "4" = "black", "6" = "black", "8" = "black", "10" = "black", "11" = "black", "13" = "black", "15" = "black", "17" = "black", "20" = "black",\
	"22" = "black", "24" = "black", "26" = "black", "28" = "black", "29" = "black", "31" = "black", "33" = "black", "35" = "black")

	var/chosen_bet_amount = 10
	var/chosen_bet_type = "0"
	var/last_anti_spam = 0
	var/anti_spam_cooldown = 20
	var/obj/item/card/bank/my_card
	var/playing = FALSE
	var/locked = FALSE
	var/drop_dir = SOUTH
	var/static/list/cash_values = list(/obj/item/spacecash/bundle/c100 = 100, /obj/item/spacecash/bundle/c50 = 50, /obj/item/spacecash/bundle/c10 = 10, /obj/item/spacecash/bundle/c1 = 1) //Make sure this is ordered from left to right.
	var/list/bundles_to_dispense = list()
	var/datum/looping_sound/jackpot/jackpot_loop
	var/on = TRUE
	var/last_spin = 13

/obj/machinery/roulette/Initialize()
	. = ..()
	jackpot_loop = new(list(src), FALSE)
	wires = new /datum/wires/roulette(src)

/obj/machinery/roulette/Destroy()
	QDEL_NULL(jackpot_loop)
	QDEL_NULL(wires)
	return ..()

/obj/machinery/roulette/atom_break(damage_flag)
	prize_theft(0.05)
	. = ..()

/obj/machinery/roulette/ui_interact(mob/user, datum/tgui/ui)
	if(machine_stat & MAINT)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Roulette", name)
		ui.open()

/obj/machinery/roulette/ui_data(mob/user)
	var/list/data = list()
	data["IsAnchored"] = anchored
	data["BetAmount"] = chosen_bet_amount
	data["BetType"] = chosen_bet_type
	data["HouseBalance"] = my_card?.registered_account.account_balance
	data["LastSpin"] = last_spin
	data["Spinning"] = playing
	if(ishuman(user))
		var/mob/living/carbon/human/player = user
		var/obj/item/card/bank/card = player.get_bankcard()
		if(card)
			data["AccountBalance"] = card.registered_account.account_balance
		else
			data["AccountBalance"] = 0
	return data

/obj/machinery/roulette/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/human/player = usr
	switch(action)
		if("anchor")
			if(my_card == player.get_bankcard())
				set_anchored(!anchored)
			. = TRUE
		if("ChangeBetAmount")
			chosen_bet_amount = clamp(text2num(params["amount"]), 10, 500)
			. = TRUE
		if("ChangeBetType")
			chosen_bet_type = params["type"]
			. = TRUE
	update_appearance() // Not applicable to all objects.

///Handles setting ownership and the betting itself.
/obj/machinery/roulette/attackby(obj/item/held, mob/user, params)
	if(machine_stat & MAINT && is_wire_tool(held))
		wires.interact(user)
		return
	if(playing)
		return ..()
	if(istype(held, /obj/item/card/bank))
		playsound(src, 'sound/machines/card_slide.ogg', 50, TRUE)

		if(!powered())
			to_chat(user, span_warning("The machine is unpowered!"))
			return FALSE
		else if(machine_stat & MAINT || !on || locked)
			to_chat(user, span_notice("The machine appears to be disabled."))
			return FALSE

		if(my_card)
			var/obj/item/card/bank/player_card = held
			if(player_card.registered_account.account_balance < chosen_bet_amount) //Does the player have enough funds
				audible_message(span_warning("You do not have the funds to play! Lower your bet or get more money."))
				playsound(src, 'sound/machines/buzz-two.ogg', 30, TRUE)
				return FALSE
			if(!chosen_bet_amount || isnull(chosen_bet_type))
				return FALSE

			//double to nothing bets
			var/list/doubles = list(
				ROULETTE_BET_2TO1_FIRST,
				ROULETTE_BET_2TO1_SECOND,
				ROULETTE_BET_2TO1_THIRD,
				ROULETTE_BET_1TO12,
				ROULETTE_BET_13TO24,
				ROULETTE_BET_25TO36
			)
			//result of text2num is null if text starts with a character, meaning it's not a singles bet
			var/single = !isnull(text2num(chosen_bet_type))
			var/potential_payout_mult
			if (single)
				potential_payout_mult = ROULETTE_SINGLES_PAYOUT
			else
				if (chosen_bet_type in doubles)
					potential_payout_mult = ROULETTE_DOZ_COL_PAYOUT
				else
					potential_payout_mult = ROULETTE_SIMPLE_PAYOUT
			var/potential_payout = chosen_bet_amount * potential_payout_mult

			if(!check_bartender_funds(potential_payout))
				return FALSE	 //bartender is too poor

			if(last_anti_spam > world.time) //do not cheat me
				return FALSE

			last_anti_spam = world.time + anti_spam_cooldown

			icon_state = "rolling" //Prepare the new icon state for rolling before hand.
			flick("flick_up", src)
			playsound(src, 'sound/machines/piston_raise.ogg', 70)
			playsound(src, 'sound/machines/chime.ogg', 50)

			addtimer(CALLBACK(src, PROC_REF(play), user, player_card, chosen_bet_type, chosen_bet_amount, potential_payout), 4) //Animation first
			return TRUE
		else
			var/obj/item/card/bank/new_card = held
			if(new_card.registered_account)
				var/msg = stripped_input(user, "Name of your roulette wheel:", "Roulette Naming", "Roulette Machine")
				if(!msg)
					return
				name = msg
				desc = "Owned by [new_card.registered_account.account_holder]. The wheel draws directly from [user.p_their()] account."
				my_card = new_card
				to_chat(user, span_notice("You link the wheel to your account."))
				power_change()
				return
	return ..()

///Proc called when player is going to try and play
/obj/machinery/roulette/proc/play(mob/user, obj/item/card/bank/player_id, bet_type, bet_amount, potential_payout)

	var/payout = potential_payout

	my_card.registered_account.transfer_money(player_id.registered_account, bet_amount)

	playing = TRUE
	update_appearance()
	set_light(0)

	var/rolled_number = rand(0, 36)

	playsound(src, 'sound/machines/roulettewheel.ogg', 50)
	addtimer(CALLBACK(src, PROC_REF(finish_play), player_id, bet_type, bet_amount, payout, rolled_number), 34) //4 deciseconds more so the animation can play
	addtimer(CALLBACK(src, PROC_REF(finish_play_animation)), 30)

/obj/machinery/roulette/proc/finish_play_animation()
	icon_state = "idle"
	flick("flick_down", src)
	playsound(src, 'sound/machines/piston_lower.ogg', 70)

///Ran after a while to check if the player won or not.
/obj/machinery/roulette/proc/finish_play(obj/item/card/bank/player_id, bet_type, bet_amount, potential_payout, rolled_number)
	last_spin = rolled_number

	var/is_winner = check_win(bet_type, bet_amount, rolled_number) //Predetermine if we won
	var/color = numbers["[rolled_number]"] //Weird syntax, but dict uses strings.
	var/result = "[rolled_number] [color]" //e.g. 31 black

	audible_message(span_notice("The result is: [result]."))

	playing = FALSE
	update_icon(ALL, potential_payout, color, rolled_number, is_winner)
	handle_color_light(color)

	if(!is_winner)
		audible_message(span_warning("You lost! Better luck next time!"))
		playsound(src, 'sound/machines/synth_no.ogg', 50)
		return FALSE

	audible_message(span_notice("You have won [potential_payout] credits! Congratulations!"))
	playsound(src, 'sound/machines/synth_yes.ogg', 50)

	dispense_prize(potential_payout)

///Fills a list of bundles that should be dropped.
/obj/machinery/roulette/proc/dispense_prize(payout)


	if(payout >= ROULETTE_JACKPOT_AMOUNT)
		jackpot_loop.start()

	var/remaining_payout = payout

	my_card.registered_account.adjust_money(-payout, CREDIT_LOG_WITHDRAW)

	for(var/cash_type in cash_values) //Loop through all bundles from most valuable to least valuable. Try to give as much of that bundle as possible until you can't anymore, then move to the next.
		var/value = cash_values[cash_type] //Change this to use initial value once we change to the right bundle
		var/cash_count = round(remaining_payout / value)

		if(!cash_count) //Cant make bundles of this type, as we can't reach it's value.
			continue

		remaining_payout -= value * cash_count
		bundles_to_dispense[cash_type] += cash_count

	drop_cash() //Start recursively dropping bundles

///Recursive function that runs until it runs out of bundles to drop.
/obj/machinery/roulette/proc/drop_cash()
	var/bundle_to_drop

	for(var/i in bundles_to_dispense) //Find which bundle to drop
		if(bundles_to_dispense[i] <= 0) //Less than 1? go to next potential bundle.
			continue
		bundle_to_drop = i
		break

	if(!bundle_to_drop) //No more bundles, stop recursion.
		jackpot_loop.stop()
		return FALSE

	bundles_to_dispense[bundle_to_drop] -= 1

	var/turf/drop_loc = get_step(loc, drop_dir)
	var/obj/item/cash = new bundle_to_drop(drop_loc)
	playsound(cash, pick(list('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg')), 40, TRUE)

	addtimer(CALLBACK(src, PROC_REF(drop_cash)), 3) //Recursion time


///Fills a list of bundles that should be dropped.
/obj/machinery/roulette/proc/prize_theft(percentage)
	if(locked)
		return
	locked = TRUE
	var/stolen_cash = my_card.registered_account.account_balance * percentage
	dispense_prize(stolen_cash)


///Returns TRUE if the player bet correctly.
/obj/machinery/roulette/proc/check_win(bet_type, bet_amount, rolled_number)
	var/actual_bet_number = text2num(bet_type) //Only returns the numeric bet types, AKA singles.
	if(!isnull(actual_bet_number)) //This means we're playing singles
		return rolled_number == actual_bet_number

	switch(bet_type) //Otherwise, we are playing a "special" game, switch on all the cases so we can check.
		if(ROULETTE_BET_ODD)
			return ISODD(rolled_number)
		if(ROULETTE_BET_EVEN)
			return ISEVEN(rolled_number)
		if(ROULETTE_BET_1TO18)
			return (rolled_number >= 1 && rolled_number <= 18) //between 1 to 18
		if(ROULETTE_BET_19TO36)
			return rolled_number > 18 //between 19 to 36, no need to check bounds because we wont go higher anyways
		if(ROULETTE_BET_BLACK)
			return "black" == numbers["[rolled_number]"]//Check if our number is black in the numbers dict
		if(ROULETTE_BET_RED)
			return "red" == numbers["[rolled_number]"] //Check if our number is black in the numbers dict
		if(ROULETTE_BET_1TO12)
			return (rolled_number >= 1 && rolled_number <= 12)
		if(ROULETTE_BET_13TO24)
			return (rolled_number >= 13 && rolled_number <= 24)
		if(ROULETTE_BET_25TO36)
			return (rolled_number >= 25 && rolled_number <= 36)
		if(ROULETTE_BET_2TO1_FIRST)
			//You could do this mathematically but w/e this is easy to understand
			//numbers in the first column
			var/list/winners = list(1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34)
			return (rolled_number in winners)
		if(ROULETTE_BET_2TO1_SECOND)
			//numbers in the second column
			var/list/winners = list(2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35)
			return (rolled_number in winners)
		if(ROULETTE_BET_2TO1_THIRD)
			//numbers in the third column
			var/list/winners = list(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36)
			return (rolled_number in winners)


///Returns TRUE if the owner has enough funds to payout
/obj/machinery/roulette/proc/check_bartender_funds(payout)
	if(my_card.registered_account.account_balance >= payout)
		return TRUE //We got the betting amount
	audible_message(span_warning("The bank account of [my_card.registered_account.account_holder] does not have enough funds to pay out the potential prize, contact them to fill up their account or lower your bet!"))
	playsound(src, 'sound/machines/buzz-two.ogg', 30, TRUE)
	return FALSE

/obj/machinery/roulette/update_overlays()
	. = ..()

	if(machine_stat & MAINT)
		return

	if(playing)
		remove_overlays += overlays
		. += "random_numbers"

/obj/machinery/roulette/update_icon(updates=ALL, payout, color, rolled_number, is_winner = FALSE)
	. = ..()
	if(machine_stat & MAINT)
		return

	if(!payout || !color || isnull(rolled_number)) //Don't fall for tricks.
		return

	//Overlay for ring
	if(is_winner && payout >= ROULETTE_JACKPOT_AMOUNT)
		add_overlay("jackpot")
	else
		add_overlay(color)

	var/numberright = rolled_number % 10 //Right hand number
	var/numberleft = (rolled_number - numberright) / 10 //Left hand number

	var/shift_amount = 2 //How much the icon moves left/right

	if(numberleft != 0) //Don't make the number if we are 0.
		var/mutable_appearance/number1 = mutable_appearance(icon, "[numberleft]")
		number1.pixel_x = -shift_amount
		add_overlay(number1)
	else
		shift_amount = 0 //We can stay centered.

	var/mutable_appearance/number2 = mutable_appearance(icon, "[numberright]")
	number2.pixel_x = shift_amount
	add_overlay(number2)

/obj/machinery/roulette/proc/handle_color_light(color)
	switch(color)
		if("green")
			set_light(2,2, LIGHT_COLOR_GREEN)
		if("red")
			set_light(2,2, COLOR_SOFT_RED)

/obj/machinery/roulette/welder_act(mob/living/user, obj/item/welder)
	. = ..()
	if(machine_stat & MAINT)
		to_chat(user, span_notice("You start re-attaching the top section of [src]..."))
		if(welder.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You re-attach the top section of [src]."))
			set_machine_stat(machine_stat & ~MAINT)
			icon_state = "idle"
	else
		to_chat(user, span_notice("You start welding the top section from [src]..."))
		if(welder.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You removed the top section of [src]."))
			set_machine_stat(machine_stat | MAINT)
			icon_state = "open"
	return TRUE

/obj/machinery/roulette/proc/shock(mob/user, prb)
	if(!on)		// unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE //you lucked out, no shock for you
	do_sparks(5, TRUE, src)
	if(electrocute_mob(user, get_area(src), src, 1, TRUE))
		return TRUE
	else
		return FALSE

/obj/item/roulette_wheel_beacon
	name = "roulette wheel beacon"
	desc = "An NT-approved roulette wheel beacon. Toss it down, and a complementary roulette wheel will be delivered to you."
	icon = 'icons/obj/objects.dmi'
	icon_state = "floor_beacon"
	var/used

/obj/item/roulette_wheel_beacon/attack_self()
	if(used)
		return
	loc.visible_message(span_warning("The [src] begins to beep loudly!"))
	playsound(get_turf(src), 'sound/machines/triple_beep.ogg', 50, TRUE)
	used = TRUE
	addtimer(CALLBACK(src, PROC_REF(launch_payload)), 40)

/obj/item/roulette_wheel_beacon/proc/launch_payload()
	var/obj/structure/closet/supplypod/centcompod/toLaunch = new()

	new /obj/machinery/roulette(toLaunch)

	new /obj/effect/pod_landingzone(drop_location(), toLaunch)
	qdel(src)

#undef ROULETTE_SINGLES_PAYOUT
#undef ROULETTE_SIMPLE_PAYOUT

#undef ROULETTE_BET_ODD
#undef ROULETTE_BET_EVEN
#undef ROULETTE_BET_1TO18
#undef ROULETTE_BET_19TO36
#undef ROULETTE_BET_BLACK
#undef ROULETTE_BET_RED

#undef ROULETTE_JACKPOT_AMOUNT
