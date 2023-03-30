/client/proc/process_endround_metacoin()
	if(!mob)	return
	var/mob/M = mob
	if(M.mind && !isnewplayer(M))
		if(M.stat != DEAD && !isbrain(M))
			inc_metabalance(METACOIN_ESCAPE_REWARD, reason="Survived the shift.")
		else
			inc_metabalance(METACOIN_NOTSURVIVE_REWARD, reason="You tried.")

/client/proc/process_ten_minute_living()
	inc_metabalance(METACOIN_TENMINUTELIVING_REWARD, FALSE)

/client/proc/get_metabalance()
	var/datum/DBQuery/query_get_metacoins = SSdbcore.NewQuery(
		"SELECT metacoins FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	var/mc_count = 0
	if(query_get_metacoins.warn_execute())
		if(query_get_metacoins.NextRow())
			mc_count = query_get_metacoins.item[1]

	qdel(query_get_metacoins)
	return text2num(mc_count)

/client/proc/set_metacoin_count(mc_count, ann=TRUE)
	var/datum/DBQuery/query_set_metacoins = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET metacoins = :mc_count WHERE ckey = :ckey",
		list("mc_count" = mc_count, "ckey" = ckey)
	)
	query_set_metacoins.warn_execute()
	qdel(query_set_metacoins)
	if(ann)
		to_chat(src, "<span class='nicegreen bold'>Your new metacoin balance is [mc_count]!</span>")

/client/proc/inc_metabalance(mc_count, ann=TRUE, reason=null)
	if(mc_count >= 0 && !CONFIG_GET(flag/grant_metacurrency))
		return
	var/datum/DBQuery/query_inc_metacoins = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET metacoins = metacoins + :mc_count WHERE ckey = :ckey",
		list("mc_count" = mc_count, "ckey" = ckey)
	)
	query_inc_metacoins.warn_execute()
	qdel(query_inc_metacoins)
	if(ann)
		if(reason)
			to_chat(src, "<span class='nicegreen bold'>[abs(mc_count)] [CONFIG_GET(string/metacurrency_name)]\s have been [mc_count >= 0 ? "deposited to" : "withdrawn from"] your account! Reason: [reason]</span>")
		else
			to_chat(src, "<span class='nicegreen bold'>[abs(mc_count)] [CONFIG_GET(string/metacurrency_name)]\s have been [mc_count >= 0 ? "deposited to" : "withdrawn from"] your account!</span>")

//Physical MetaCoins
/obj/item/metacoin
	icon = 'code/modules/metacoin/metacoin.dmi'
	name = "Zeta-coin"
	var/mc_contains = 0
	icon_state = "metacoin"
	flags_1 = CONDUCT_1
	force = 1
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	drop_sound = 'sound/items/handling/coin_drop.ogg'
	pickup_sound =  'sound/items/handling/coin_pickup.ogg'

/obj/item/metacoin/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Here's [mc_contains] Zeta-coin[(mc_contains > 1) ? "s" : ""]</span>\n"

/obj/item/metacoin/attack_self(mob/user)
	//inc_metabalance(mc_contains, reason="You used Zeta-coins.")
	var/datum/DBQuery/query_inc_metacoins = SSdbcore.NewQuery(
		"UPDATE ["ss13_player"] SET metacoins = metacoins + :mc_count WHERE ckey = :ckey",
		list("mc_count" = mc_contains, "ckey" = user.ckey)
	)
	query_inc_metacoins.warn_execute()
	qdel(query_inc_metacoins)
	to_chat(user, "<span class='nicegreen bold'>You used Zeta-coins. You got [mc_contains] ZetaCoins.</span>")
	qdel(src)

/client/verb/withdrawmetacoin(curr as num)
	set name = "Withdraw Zeta-coins"
	set desc = "Withdraw Zeta-coins into coin in your hand."
	set category = "OOC"

	var/mob/user = usr

	var/datum/DBQuery/query_get_metacoins = SSdbcore.NewQuery(
		"SELECT metacoins FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	var/mc_count = 0
	if(query_get_metacoins.warn_execute())
		if(query_get_metacoins.NextRow())
			mc_count = query_get_metacoins.item[1]

	qdel(query_get_metacoins)
	mc_count = text2num(mc_count)

	if(!(isliving(user)))
		to_chat(src, "<span class='warning'>You should be a human.</span>")
		return
	else if((curr<0 || curr>mc_count))
		to_chat(src, "<span class='warning'>Incorrect value (lesser than 0 or more than balance).</span>")
		return
	else
		var/obj/item/metacoin/P = new /obj/item/metacoin
		P.mc_contains=curr
		inc_metabalance(-curr, reason="You withdrew Zeta-coins.")
		user.put_in_hands(P)

	/*else
		to_chat(src, "<span class='warning'>You should have any empty hand for withdrawing.</span>")
		return*/
