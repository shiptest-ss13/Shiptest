GLOBAL_LIST_EMPTY(donators)
GLOBAL_PROTECT(donators)

#define REWARD_FLAT 1
#define REWARD_CONV 2
#define REWARD_JSON_PATH "config/donators/"

/client/var/datum/donator/donator

/client/New(TopicData)
	. = ..()
	donator = GLOB.donators[ckey] || new /datum/donator(src)
	donator.owner = src
	add_verb(src, .proc/do_donator_redemption)
	add_verb(src, .proc/do_donator_wcir)

/client/Destroy()
	. = ..()
	donator.owner = null
	donator = null

/client/proc/do_donator_redemption()
	set name = "Redeem Donator Reward"
	set category = "Donator"
	set desc = "Redeem a reward"

	var/mob/client_mob = mob

	if(client_mob.next_move > world.time)
		return
	if(!isliving(client_mob))
		to_chat(client_mob, "<span class='notice'>You must be alive to use this!</span>")
		return
	if(!donator?.handle_redemption(client_mob))
		client_mob.changeNext_move(CLICK_CD_MELEE)

/client/proc/do_donator_wcir()
	set name = "What Can I Redeem"
	set category = "Donator"
	set desc = "Currently available redemptions"

	donator?.what_can_i_redeem(src.mob)

/datum/donator
	/// ckey of the client who this datum belongs to
	var/ckey
	/// reference to the client
	var/client/owner

	/// typecache of eligible rewards for this donator
	var/list/flat_rewards = list(
		/obj/item/reagent_containers/food/snacks/cookie = TRUE
	)

	/// list of conversion rewards for this donator
	/// Expected format: base type -> list of convertible types
	var/list/conversion_rewards = list(
		/obj/item/screwdriver = list(/obj/item/screwdriver/old, /obj/item/screwdriver/caravan),
	)

	/// list of redeemed conversion types
	var/list/conversions_redeemed = list()

/datum/donator/New(client/owner)
	. = ..()
	src.ckey = owner.ckey
	src.owner = owner
	load_information()
	GLOB.donators[ckey] = src

/datum/donator/Destroy(force, ...)
	if(!force)
		return QDEL_HINT_LETMELIVE
	. = ..()
	GLOB.donators -= ckey
	owner.donator = null
	owner = null

/datum/donator/proc/load_information() //todo: db support with config files being a backup method
	var/json_file = file(REWARD_JSON_PATH + "[ckey].json")
	if(!fexists(json_file))
		return
	var/list/json = safe_json_decode(file2text(json_file))

	if(!json || !("ckey" in json))
		stack_trace("invalid donator json format in '[json_file]'")
		return

	if(json["ckey"] != ckey)
		message_admins("possibly invalid donator json for '[ckey]'. Expected ckey '[json["ckey"]]'")

	if("flat" in json)
		flat_rewards.Cut()
		for(var/entry in json["flat"])
			var/etype = text2path(entry)
			if(!etype)
				stack_trace("invalid type in donator json: '[ckey]' = '[entry]'")
				continue
			flat_rewards[etype] = TRUE

	if("convert" in json)
		conversion_rewards.Cut()
		conversions_redeemed.Cut()
		for(var/entry in json["convert"])
			var/etype = text2path(entry)
			if(!etype)
				stack_trace("invalid type in donator json: '[ckey]' = '[entry]'")
				continue

			var/list/subl = json["convert"][entry]
			if(!islist(subl))
				stack_trace("invalid sublist in donator json: '[ckey]' = '[entry]'")
				continue

			var/list/targets = list()
			for(var/target in subl)
				var/stype = text2path(target)
				if(!stype)
					stack_trace("invalid target type in donator json: '[ckey]' = '[entry]'")
					continue
				targets += stype

			if(!length(targets))
				continue
			conversion_rewards[etype] = targets

/datum/donator/proc/get_valid_flats()
	. = list()
	for(var/flat in flat_rewards)
		if(flat_rewards[flat])
			. += flat

/datum/donator/proc/get_valid_conversions(mob/living/user)
	var/turf/user_turf = user ? get_turf(user) : null
	. = list()
	for(var/conv in conversion_rewards)
		for(var/ctype in conversion_rewards)
			if(ctype in conversions_redeemed)
				continue
			if(user_turf == null)
				. += ctype // if its null return the valid types
				continue
			// pull from their hands first, turf otherwise
			var/cinstance = locate(ctype) in user.held_items || locate(ctype) in user_turf
			if(!cinstance)
				continue
			. += cinstance

/datum/donator/proc/what_can_i_redeem(mob/user)
	var/resp = list()
	resp += "Your current redeemable rewards are as follows:"
	resp += "\tFlat Rewards:"
	for(var/atom/flat as anything in get_valid_flats())
		resp += "\t\t[initial(flat.name)]"
	resp += "----------"
	resp += "\tConversion Rewards:"
	for(var/atom/conv as anything in get_valid_conversions(null))
		resp += "\t\t[initial(conv.name)]"
	resp += "----------"
	resp += "<b>Note that redeemed rewards will not be present in these lists!</b>"

	for(var/line in resp)
		to_chat(user, "<span class='donator'>[line]</span>")

/datum/donator/proc/handle_redemption(mob/user)
	var/client/user_client = user?.client
	var/turf/user_turf = get_turf(user)
	if(!user_client || user_client.ckey != ckey)
		message_admins("[user] attempted to acces the donator menu of [ckey]")
		return FALSE

	var/list/flats = get_valid_flats()
	var/list/converts = get_valid_conversions()

	var/r_flat = length(flats)
	var/r_conv = length(converts)

	if(!r_flat && !r_conv)
		to_chat(user, "<span class='notice'>You do not have any rewards able to be redeemed currently.</span>")
		return FALSE

	var/choice = r_flat ? REWARD_FLAT : REWARD_CONV

	if(r_flat && r_conv)
		var/resp = tgui_alert(user, "Type of Reward?", "Choice Time", list("Flat", "Conversion", "Cancel"))
		switch(resp)
			if(null, "Cancel")
				return FALSE
			if("Conversion")
				choice = REWARD_CONV

	switch(choice)
		if(REWARD_FLAT)
			var/list/choices = list()
			for(var/atom/ftype as anything in flats)
				choices[initial(ftype.name)] = ftype
			choices["Cancel"] = TRUE

			var/resp = tgui_input_list(user, "Select your Reward", "Chance Time", choices)
			if(!resp || resp == "Cancel")
				return FALSE

			var/reward = choices[resp]
			if(!(reward in flat_rewards) || !flat_rewards[reward])
				message_admins("Error handling reward redemption for [ckey]. Attempted to redeem an invalid reward: [reward]")
				return FALSE
			flat_rewards[reward] = FALSE

			user.put_in_hands(new reward(user_turf))
			return TRUE

		if(REWARD_CONV)
			var/list/choices = list()
			for(var/atom/ctype as anything in converts)
				choices[ctype.name] = ctype
			choices["Cancel"] = TRUE

			var/resp = tgui_input_list(user, "What do you want to convert?", "Chance Time", choices)
			if(!resp || resp == "Cancel")
				return FALSE

			var/obj/item/reward = choices[resp]
			if(!(reward.type in conversion_rewards) || (reward.type in conversions_redeemed))
				message_admins("Error handling reward conversion for [ckey]. Attempted to redeem an invalid conversion: [reward.type]")
				return FALSE

			var/list/convs = list()
			for(var/atom/conv_target as anything in conversion_rewards[reward.type])
				convs[initial(conv_target.name)] = conv_target
			convs["Cancel"] = TRUE

			var/conv_target = tgui_input_list(user, "What do you want it to convert into?", "Chance Time", convs)
			if(!conv_target || conv_target == "Cancel")
				return FALSE

			var/actual_target = convs[conv_target]
			if(!(actual_target in conversion_rewards[reward.type]))
				message_admins("Error handling target conversion for [ckey]. Attempted to target invalid type [actual_target]")
				return FALSE
			conversions_redeemed += reward.type

			user.put_in_hands(new actual_target(user_turf))
			qdel(reward)
			return TRUE

	stack_trace("invalid reward choice, somehow? [choice]")
	return FALSE

#undef REWARD_FLAT
#undef REWARD_CONV
#undef REWARD_JSON_PATH
