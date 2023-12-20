GLOBAL_LIST_EMPTY(donators)
GLOBAL_PROTECT(donators)

#define REWARD_FLAT 1
#define REWARD_CONV 2
#define REWARD_RESK 3
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
	if(donator) // it's possible that a client was qdel'd inside the initializer
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
	)

	/// list of reskin rewards for this donator
	/// Should be an assosciative list indexed by type with a value which is a list of skins
	var/list/reskin_rewards = list(
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

	if("reskin" in json)
		reskin_rewards.Cut()
		for(var/entry in json["reskin"])
			var/atom/etype = text2path(entry)
			if(!etype)
				stack_trace("invalid type in donator json: '[ckey]' = '[entry]'")
				continue

			var/list/subl = json["reskin"][entry]
			if(!islist(subl))
				stack_trace("invalid sublist in donator json: '[ckey]' = '[entry]'")
				continue

			var/list/reskins = subl.Copy()
			for(var/reskin_state in subl)
				if(!icon_exists(initial(etype.icon), reskin_state))
					stack_trace("invalid reskin target in donator json: '[ckey]' = '[entry]' : '[reskin_state]'")
					reskins.Remove(reskin_state)
			reskin_rewards[etype] = reskins

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

/datum/donator/proc/get_valid_reskins(mob/living/user)
	. = list()
	for(var/reskin_type in reskin_rewards)
		var/rinstance = locate(reskin_type) in user.held_items
		if(rinstance)
			. += rinstance

/datum/donator/proc/what_can_i_redeem(mob/user)
	var/resp = list()
	resp += "<span class='fakespan0'>----------</span>"
	resp += "Your current redeemable rewards are as follows:"

	resp += "\tFlat Rewards:"
	for(var/atom/flat as anything in get_valid_flats())
		resp += "\t\t[initial(flat.name)]"
	resp += "<span class='fakespan1'>----------</span>"

	resp += "\tConversion Rewards:"
	for(var/atom/conv as anything in get_valid_conversions(null))
		resp += "\t\t[initial(conv.name)]"
	resp += "<span class='fakespan2'>----------</span>"

	resp += "<b>Note that redeemed rewards will not be present in the above lists!</b>"
	resp += "<span class='fakespan3'>----------</span>"

	resp += "\tReskinnable Items:"
	for(var/atom/reskin as anything in reskin_rewards)
		resp += "\t\t[initial(reskin.name)]"
	resp += "<span class='fakespan4'>----------</span>"

	for(var/line in resp)
		to_chat(user, "<span class='donator'>[line]</span>")

/datum/donator/proc/handle_redemption(mob/user)
	var/client/user_client = user?.client
	var/turf/user_turf = get_turf(user)
	if(!user_client || user_client.ckey != ckey)
		message_admins("[user] attempted to acces the donator menu of [ckey]")
		return FALSE

	var/list/flats = get_valid_flats()
	var/list/converts = get_valid_conversions(user)
	var/list/reskins = get_valid_reskins(user)

	var/r_flat = !!length(flats)
	var/r_conv = !!length(converts)
	var/r_resk = !!length(reskins)
	var/r_all = r_flat + r_conv + r_resk

	if(!r_all)
		to_chat(user, "<span class='notice'>You do not have any rewards able to be redeemed currently.</span>")
		return FALSE

	var/choice

	var/list/available = list()
	if(r_flat)
		available += "Flat"
	if(r_conv)
		available += "Conversion"
	if(r_resk)
		available += "Reskin"
	available += "Cancel"

	switch(tgui_alert(user, "Type of Reward?", "Choice Time", available))
		if("Flat")
			choice = REWARD_FLAT

		if("Conversion")
			choice = REWARD_CONV

		if("Reskin")
			choice = REWARD_RESK

		if("Cancel", null)
			return FALSE

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

		if(REWARD_RESK)
			var/list/choices = list()
			for(var/atom/rtype as anything in reskins)
				choices[rtype.name] = rtype
			choices["Cancel"] = TRUE

			var/resp = tgui_input_list(user, "What do you want to reskin?", "Chance Time", choices)
			if(!resp || resp == "Cancel")
				return FALSE

			var/obj/item/reward = choices[resp]
			if(!(reward.type in reskin_rewards))
				message_admins("Error handling reward conversion for [ckey]. Attempted to redeem an invalid reskin: [reward.type]")
				return FALSE

			var/reskin_target = tgui_input_list(user, "What do you want it to reskin into?", "Chance Time", reskin_rewards[reward.type] + list("Cancel"))
			if(!reskin_target || reskin_target == "Cancel")
				return FALSE

			reward.icon = initial(reward.icon)
			reward.icon_state = reskin_target
			reward.update_appearance()
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
#undef REWARD_RESK
#undef REWARD_JSON_PATH

/obj/item/clothing
	var/donator_key
	var/donator_allow_other_usage = FALSE

/obj/item/clothing/mob_can_equip(mob/living/target, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, swap)
	if(!donator_key || donator_allow_other_usage || check_donator(equipper) || check_donator(target))
		return ..()

	to_chat(target, "<span class='warning'>A strange force prevents you from equipping [src]...</span>")
	return FALSE

/obj/item/clothing/examine(mob/user)
	. = ..()
	if(!donator_key) // Github I demand you run the checks on this PR
		return .
	if(check_donator(user))
		. += "<span class='notice'><ul>This is one of your donator items, to <b>[(donator_allow_other_usage ? "allow" : "disallow")]</b> sharing <b>CtrlShiftClick</b> it.</ul></span>"
	else
		if(!donator_allow_other_usage)
			. += "<span class='warning'>A strange force prevents you from making eye contact with it.</span>"

/obj/item/clothing/proc/check_donator(mob/user)
	return ckey(user.key) == ckey(donator_key)

/obj/item/clothing/CtrlShiftClick(mob/user)
	if(!donator_key || !check_donator(user))
		return ..()

	donator_allow_other_usage = !donator_allow_other_usage
	to_chat(user, "<span class='notice'>You <b>[(donator_allow_other_usage ? "allow" : "disallow")]</b> sharing of [src].</span>")
	return TRUE
