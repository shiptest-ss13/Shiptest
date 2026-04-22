/obj/item/card/bank
	name = "cash card"
	desc = "Managed by a bank outside the sector."
	icon_state = "data_1"
	var/mining_points = 0 //For redeeming at mining equipment vendors

	var/registered_name = null // The name registered_name on the card
	var/datum/bank_account/registered_account
	var/obj/machinery/paystand/my_store

/obj/item/card/bank/Destroy()
	if (registered_account)
		registered_account.bank_cards -= src
	if (my_store && my_store.my_card == src)
		my_store.my_card = null
	return ..()

/obj/item/card/bank/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/holochip))
		insert_money(W, user)
		return
	else if(istype(W, /obj/item/spacecash/bundle))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/coin))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents

		var/money_added = mass_insert_money(money_contained, user)

		if (money_added)
			to_chat(user, span_notice("You stuff the contents into the card! They disappear in a puff of bluespace smoke, adding [money_added] worth of credits to the linked account."))
		return
	else
		return ..()

/obj/item/card/bank/proc/insert_money(obj/item/I, mob/user, physical_currency)
	var/cash_money = I.get_item_credit_value()
	if(!cash_money)
		to_chat(user, span_warning("[I] doesn't seem to be worth anything!"))
		return

	if(!registered_account)
		to_chat(user, span_warning("[src] doesn't have a linked account to deposit [I] into!"))
		return

	registered_account.adjust_money(cash_money, CREDIT_LOG_DEPOSIT)
	SSblackbox.record_feedback("amount", "credits_inserted", cash_money)
	log_econ("[cash_money] credits were inserted into [src] owned by [src.registered_name]")
	if(physical_currency)
		to_chat(user, span_notice("You stuff [I] into [src]. It disappears in a small puff of bluespace smoke, adding [cash_money] credits to the linked account."))
	else
		to_chat(user, span_notice("You insert [I] into [src], adding [cash_money] credits to the linked account."))

	to_chat(user, span_notice("The linked account now reports a balance of [registered_account.account_balance] cr."))
	qdel(I)

/obj/item/card/bank/proc/mass_insert_money(list/money, mob/user)
	if (!money || !money.len)
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		var/cash_money = physical_money.get_item_credit_value()

		total += cash_money

		registered_account.adjust_money(cash_money, CREDIT_LOG_DEPOSIT)
	SSblackbox.record_feedback("amount", "credits_inserted", total)
	log_econ("[total] credits were inserted into [src] owned by [src.registered_name]")
	QDEL_LIST(money)

	return total

/obj/item/card/bank/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

// Returns true if new account was set.
/obj/item/card/bank/proc/set_new_account(mob/living/user)
	. = FALSE
	var/datum/bank_account/old_account = registered_account

	var/new_bank_id = input(user, "Enter your account ID number.", "Account Reclamation", 111111) as num | null

	if (isnull(new_bank_id))
		return

	if(!alt_click_can_use_id(user))
		return
	if(!new_bank_id || new_bank_id < 111111 || new_bank_id > 999999)
		to_chat(user, span_warning("The account ID number needs to be between 111111 and 999999."))
		return
	if (registered_account && registered_account.account_id == new_bank_id)
		to_chat(user, span_warning("The account ID was already assigned to this card."))
		return

	for(var/A in SSeconomy.bank_accounts)
		var/datum/bank_account/B = A
		if(B.account_id == new_bank_id)
			if (old_account)
				old_account.bank_cards -= src

			B.bank_cards += src
			registered_account = B
			to_chat(user, span_notice("The provided account has been linked to this ID card."))

			return TRUE

	to_chat(user, span_warning("The account ID number provided is invalid."))
	return

/obj/item/card/bank/AltClick(mob/living/user)
	if(!alt_click_can_use_id(user))
		return

	if(!registered_account)
		set_new_account(user)
		return

	var/amount_to_remove =  FLOOR(input(user, "How much do you want to withdraw? Current Balance: [registered_account.account_balance]", "Withdraw Funds", 5) as num|null, 1)

	if(!amount_to_remove || amount_to_remove < 0)
		return
	if(!alt_click_can_use_id(user))
		return
	if(registered_account.adjust_money(-amount_to_remove, CREDIT_LOG_WITHDRAW))
		var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, span_notice("You withdraw [amount_to_remove] credits into a holochip."))
		SSblackbox.record_feedback("amount", "credits_removed", amount_to_remove)
		log_econ("[amount_to_remove] credits were removed from [src] owned by [registered_account.account_holder]")
		return
	else
		var/difference = amount_to_remove - registered_account.account_balance
		registered_account.bank_card_talk(span_warning("ERROR: The linked account requires [difference] more credit\s to perform that withdrawal."), TRUE)

/obj/item/card/bank/examine(mob/user)
	. = ..()
	if(registered_account)
		. += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of <B>[registered_account.account_balance] cr</B>."
		. += "The card indicates that the holder is <B>[registered_account.holder_age] years old</b>. [(registered_account.holder_age < AGE_DRINKING) ? "There's a holographic stripe that reads <b>[span_danger("'DO NOT SERVE ALCOHOL OR TOBACCO'")]</b> along the bottom of the card." : ""]"
		. += span_info("Alt-Click the ID to pull money from the linked account in the form of holochips.")
		. += span_info("You can insert credits into the linked account by pressing holochips, cash, or coins against the ID.")
		. += span_boldnotice("If you lose this ID card, you can reclaim your account by Alt-Clicking a blank ID card while holding it and entering your account ID number.")
	else
		. += span_info("There is no registered account linked to this card. Alt-Click to add one.")
	if(mining_points)
		. += "There's [mining_points] mining equipment redemption point\s loaded onto this card."

/obj/item/card/bank/GetBankCard()
	return src
