///A special category for goods placed on the market by station by someone with the LTSRBT.
/datum/blackmarket_item/local_good
	category = "Local Goods"
	stock = 1
	availability_prob = 100
	//restockable = FALSE
	var/datum/bank_account/seller

/datum/blackmarket_item/local_good/New(atom/movable/thing, datum/bank_account/seller, id_num)
	..()
	//set_item(thing)
	item = thing
	src.seller = seller
	if(id_num)
		key = "[id_num]"
	if(seller)
		RegisterSignal(seller, COMSIG_QDELETING, PROC_REF(delete_reference))

/datum/blackmarket_item/local_good/buy(obj/item/blackmarket_uplink, mob/buyer, shipping_method, legal_status)
	. = ..()
	if(. && seller)
		seller.adjust_money(round(cost * (1 - MARKET_WITHHOLDING_TAX)), "Market: [name] sold for [cost].")
		seller.bank_card_talk("Market: [name] sold for [cost].")
	QDEL_IN(src, 10 MINUTES) //This category cannot hold more than 40 items at a time, so we need to clear sold items.

/datum/blackmarket_item/local_good/proc/delete_reference(datum/source)
	SIGNAL_HANDLER
	seller = null
