/datum/bank_account
	var/account_holder = "Rusty Venture"
	var/account_balance = 0
	var/holder_age = 18
	var/list/bank_cards = list()
	var/add_to_accounts = TRUE
	var/account_id

/datum/bank_account/New(newname, age)
	if(add_to_accounts)
		SSeconomy.bank_accounts += src
	account_holder = newname
	holder_age = age
	account_id = rand(111111,999999)

/datum/bank_account/Destroy()
	if(add_to_accounts)
		SSeconomy.bank_accounts -= src
	for(var/obj/item/card/bank/bank_card as anything in bank_cards)
		bank_card.registered_account = null
	SSeconomy.bank_money -= account_balance
	return ..()

/datum/bank_account/proc/_adjust_money(amt)
	account_balance += amt
	if(account_balance < 0)
		account_balance = 0

/datum/bank_account/proc/has_money(amt)
	return account_balance >= amt

/datum/bank_account/proc/adjust_money(amt, reason = CREDIT_LOG_WITHDRAW)
	if((amt < 0 && has_money(-amt)) || amt > 0)
		SSblackbox.record_feedback("tally", "credits", amt, reason)
		SSeconomy.bank_money += amt
		_adjust_money(amt)
		return TRUE
	return FALSE

/datum/bank_account/proc/transfer_money(datum/bank_account/from, amount)
	if(from.has_money(amount))
		adjust_money(amount, CREDIT_LOG_TRANSFER_IN)
		SSblackbox.record_feedback("amount", "credits_transferred", amount)
		log_econ("[amount] credits were transferred from [from.account_holder]'s account to [src.account_holder]")
		from.adjust_money(-amount, CREDIT_LOG_TRANSFER_OUT)
		return TRUE
	return FALSE

/datum/bank_account/proc/bank_card_talk(message, force)
	if(!message || !bank_cards.len)
		return
	for(var/obj/A in bank_cards)
		var/icon_source = A
		var/mob/card_holder = recursive_loc_check(A, /mob)
		if(ismob(card_holder)) //If on a mob
			if(!card_holder.client || (!(card_holder.client.prefs.chat_toggles & CHAT_BANKCARD) && !force))
				return

			if(card_holder.can_hear())
				card_holder.playsound_local(get_turf(card_holder), 'sound/machines/twobeep_high.ogg', 50, TRUE)
				to_chat(card_holder, "[icon2html(icon_source, card_holder)] <span class='notice'>[message]</span>")
		else if(isturf(A.loc)) //If on the ground
			var/turf/T = A.loc
			for(var/mob/M in hearers(1,T))
				if(!M.client || (!(M.client.prefs.chat_toggles & CHAT_BANKCARD) && !force))
					continue
				if(M.can_hear())
					M.playsound_local(T, 'sound/machines/twobeep_high.ogg', 50, TRUE)
					to_chat(M, "[icon2html(icon_source, M)] <span class='notice'>[message]</span>")
		else
			var/atom/sound_atom
			for(var/mob/M in A.loc) //If inside a container with other mobs (e.g. locker)
				if(!M.client || (!(M.client.prefs.chat_toggles & CHAT_BANKCARD) && !force))
					continue
				if(!sound_atom)
					sound_atom = A.drop_location() //in case we're inside a bodybag in a crate or something. doing this here to only process it if there's a valid mob who can hear the sound.
				if(M.can_hear())
					M.playsound_local(get_turf(sound_atom), 'sound/machines/twobeep_high.ogg', 50, TRUE)
					to_chat(M, "[icon2html(icon_source, M)] <span class='notice'>[message]</span>")

/datum/bank_account/ship
	add_to_accounts = FALSE

/datum/bank_account/ship/New(newname, budget)
	account_holder = newname
	adjust_money(budget, CREDIT_LOG_STARTING_MONEY)
