// SCRATCH TICKETS //

/obj/item/scratch_ticket
	name = "evil basetype scratch ticket"
	desc = "HELP ME!! *does a little dance to get you to report this on the github*"
	icon = 'icons/obj/fliers.dmi'
	icon_state = "vitcom"
	w_class = WEIGHT_CLASS_TINY
	bad_type = /obj/item/scratch_ticket

	var/scratched_off = FALSE // are we scratched off
	var/list/prize_chances = list(50, 50) // ordered chance list per prize
	var/list/prize_amounts = list(100, 1) // ordered prize list (same size as above)
	var/force_prize = null // set this to rig the ticket to this value
	var/redeem_value = null // current sell value

/obj/item/scratch_ticket/proc/scratch_off()
	scratched_off = TRUE
	// if this has a forced value, use it
	if(force_prize != null)
		redeem_value = force_prize
		return
	// rolls each chance in order
	for(var/i = 1, i <= prize_chances.len, i++)
		if(prob(prize_chances[i]))
			redeem_value = prize_amounts[i]
			break
	// fallback
	if(redeem_value == null)
		redeem_value = 0

/obj/item/scratch_ticket/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(scratched_off)
		return
	if(istype(attacking_item, /obj/item/screwdriver) || istype(attacking_item, /obj/item/coin))
		user.visible_message(span_notice("[user] begins scratching off the [src]..."))
		if(do_after(user, 3 SECONDS, target = src))
			user.visible_message(span_notice("[user] scratches off the [src]!"))
			scratch_off()
			if(redeem_value == prize_amounts[1]) // jackpot!
				to_chat(user, span_notice("HOLY SHIT! You've won a prize of [redeem_value] credits!"))
				message_admins("[ADMIN_LOOKUPFLW(user)] just won a jackpot of [redeem_value] credits! [ADMIN_LOOKUPFLW(src)]")
			else if(redeem_value)
				to_chat(user, span_notice("You've won a prize of [redeem_value] credits!"))
			else
				to_chat(user, span_notice("That ticket wasn't a winner."))

/obj/item/scratch_ticket/examine(mob/user)
	. = ..()
	if(!scratched_off)
		. += span_notice("It has not been scratched off yet. You could scratch it with a <b>coin</b> or a <b>screwdriver</b>")
	else if(redeem_value != 0)
		. += span_notice("It has been scratched off, revealing a prize of [redeem_value] credits.")
	else
		. += span_notice("It has been scratched off, and is not a winner. Bummer.")

/obj/item/scratch_ticket/small
	name = "FAST CASH ticket"
	desc = "A lottery ticket, advertising a jackpot of 100,000 credits. The artwork depicts a rain of various denominations of paper credits. Official ticket of Kiyatirawkitchi Lottery. Please play responsibly."
	icon_state = "vitcom"
	custom_price = 10
	prize_chances = list(0.0001, 0.01, 1, 5, 10, 10, 10)
	prize_amounts = list(100000, 10000, 100, 50, 20, 10, 5)

/obj/item/scratch_ticket/med
	name = "GOLD GOLD GOLD ticket"
	desc = "A lottery ticket, advertising a jackpot of 1,000,000 credits. The artwork depicts a spray of golden coins erupting from a fountain. Official ticket of Kiyatirawkitchi Lottery. Please play responsibly."
	icon_state = "gec"
	custom_price = 100
	prize_chances = list(0.0001, 0.01, 1, 5, 10, 10, 10)
	prize_amounts = list(1000000, 50000, 1000, 500, 200, 100, 60)

/obj/item/scratch_ticket/large
	name = "LUCKY NUMBER 12 ticket"
	desc = "A lottery ticket, advertising a jackpot of 12,000,000 credits. The artwork depicts a large pile of traditional Shoal luck charms. Official ticket of Kiyatirawkitchi Lottery. Please play responsibly."
	icon_state = "vanity"
	custom_price = 200
	prize_chances = list(0.0001, 0.01, 1, 5, 10, 10, 10)
	prize_amounts = list(12000000, 100000, 2000, 1000, 400, 200, 150)

/obj/item/scratch_ticket/xl
	name = "BLUESPACE BOUNTY ticket"
	desc = "A lottery ticket, advertising a jackpot of 100,000,000 credits. The artwork depicts a burning spaceship jumping into the \"Money Dimension\". Official ticket of Kiyatirawkitchi Lottery. Please play responsibly."
	icon_state = "cliptour"
	custom_price = 500
	prize_chances = list(0.0001, 0.01, 1, 5, 10, 10, 10,)
	prize_amounts = list(100000000, 1000000, 25000, 5000, 1000, 500, 120)
