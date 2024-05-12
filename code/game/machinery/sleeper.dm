/obj/machinery/sleep_console
	name = "sleeper console"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "console"
	density = FALSE

/obj/machinery/sleeper
	name = "sleeper"
	desc = "An enclosed machine used to stabilize and heal patients."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	base_icon_state = "sleeper"
	density = FALSE
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/sleeper
	clicksound = 'sound/machines/pda_button1.ogg'

	var/efficiency = 1
	var/can_stasis = FALSE
	///Minimum health carbon must have to be able to inject chems besides epi. MUST BE NEGATIVE.
	var/min_health = -25
	///Possible granularity of injections
	var/list/transfer_amounts
	///List in which all currently dispensable reagents go
	var/list/dispensable_reagents

	var/list/starting_beakers = list(
		/obj/item/reagent_containers/glass/bottle/antitoxin/sleeper,
		/obj/item/reagent_containers/glass/bottle/bicaridine/sleeper,
		/obj/item/reagent_containers/glass/bottle/dexalin/sleeper,
		/obj/item/reagent_containers/glass/bottle/epinephrine/sleeper,
		/obj/item/reagent_containers/glass/bottle/kelotane/sleeper,
		/obj/item/reagent_containers/glass/bottle/morphine/sleeper)

	///Chembag which holds all the beakers, don't look at me like that
	var/obj/item/storage/bag/chemistry/chembag
	///If the sleeper can be used from the inside
	var/controls_inside = FALSE
	///If the stasis function is enabled
	var/stasis_enabled = FALSE
	///The amount of reagent that is to be dispensed currently
	var/amount = 10
	var/open_sound = 'sound/machines/podopen.ogg'
	var/close_sound = 'sound/machines/podclose.ogg'

/obj/machinery/sleeper/Initialize(mapload)
	. = ..()
	occupant_typecache = GLOB.typecache_living
	update_appearance()
	if(mapload && starting_beakers)
		chembag = new(src)
		for(var/beaker in starting_beakers)
			new beaker(chembag)
	update_contents()

/obj/machinery/sleeper/RefreshParts()
	var/E
	for(var/obj/item/stock_parts/matter_bin/B in component_parts)
		E += B.rating
	var/I
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		I += M.rating
	var/O
	for(var/obj/item/stock_parts/capacitor/M in component_parts)
		O += M.rating

	efficiency = initial(efficiency)* E
	min_health = initial(min_health) * I
	can_stasis = (O > 3)
	if(efficiency > 2)
		transfer_amounts = list(5, 10, 20, 30, 50)
	else
		transfer_amounts = list(10, 20, 30)
	update_contents()

/obj/machinery/sleeper/update_icon_state()
	icon_state = "[base_icon_state][state_open ? "-open" : null]"
	return ..()

/obj/machinery/sleeper/container_resist_act(mob/living/user)
	visible_message("<span class='notice'>[occupant] emerges from [src]!</span>",
		"<span class='notice'>You climb out of [src]!</span>")
	open_machine()

/obj/machinery/sleeper/Exited(atom/movable/user)
	. = ..()
	if (!state_open && user == occupant)
		container_resist_act(user)

/obj/machinery/sleeper/relaymove(mob/living/user, direction)
	if (!state_open)
		container_resist_act(user)

/obj/machinery/sleeper/proc/stasis_running()
	return can_stasis && stasis_enabled && is_operational

/obj/machinery/sleeper/proc/chill_out(mob/living/target)
	if(target != occupant || !can_stasis)
		return
	playsound(src, 'sound/machines/synth_yes.ogg', 50, TRUE, frequency = rand(5120, 8800))
	target.apply_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
	target.ExtinguishMob()
	use_power = ACTIVE_POWER_USE

/obj/machinery/sleeper/proc/thaw_them(mob/living/target)
	if(IS_IN_STASIS(target))
		target.remove_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
		playsound(src, 'sound/machines/synth_no.ogg', 50, TRUE, frequency = rand(5120, 8800))

/obj/machinery/sleeper/process()
	if(!occupant || !isliving(occupant))
		use_power = IDLE_POWER_USE
		return
	var/mob/living/L_occupant = occupant
	if(stasis_running())
		if(!IS_IN_STASIS(L_occupant))
			chill_out(L_occupant)
	else if(IS_IN_STASIS(L_occupant))
		thaw_them(L_occupant)

/obj/machinery/sleeper/open_machine()
	if(occupant)
		occupant.forceMove(get_turf(src))
		if(isliving(occupant))
			var/mob/living/L = occupant
			if(stasis_running())
				thaw_them(L)
				stasis_enabled = FALSE
		occupant = null
	if(!state_open && !panel_open)
		flick("[initial(icon_state)]-anim", src)
		if(open_sound)
			playsound(src, open_sound, 40)
		..(FALSE) //Don't drop the chem bag

/obj/machinery/sleeper/close_machine(mob/user)
	if((isnull(user) || istype(user)) && state_open && !panel_open)
		flick("[initial(icon_state)]-anim", src)
		if(close_sound)
			playsound(src, close_sound, 40)
		..(user)
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, "<span class='notice'><b>You feel cool air surround you. You go numb as your senses turn inward.</b></span>")

/obj/machinery/sleeper/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(is_operational && occupant)
		open_machine()


/obj/machinery/sleeper/MouseDrop_T(mob/target, mob/user)
	if(HAS_TRAIT(user, TRAIT_UI_BLOCKED) || !Adjacent(user) || !user.Adjacent(target) || !iscarbon(target) || !user.IsAdvancedToolUser())
		return

	close_machine(target)

/obj/machinery/sleeper/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/storage/bag/chemistry))
		. = TRUE //no afterattack
		replace_chembag(user, W)
	else if(chembag && istype(W, /obj/item/reagent_containers) && !(W.item_flags & ABSTRACT) && W.is_open_container())
		user.transferItemToLoc(W, chembag)
		to_chat(user, "<span class='notice'>You put [W] into [src]'s [chembag].</span>")
		update_contents()
	return ..()

/obj/machinery/sleeper/CtrlClick(mob/user)
	replace_chembag(user)
	..()

/obj/machinery/sleeper/proc/replace_chembag(mob/living/user, obj/item/storage/bag/chemistry/new_bag)
	if(!user)
		return FALSE
	if(chembag)
		to_chat(user, "<span class='notice'>You remove the [chembag] from [src].</span>")
		user.put_in_hands(chembag)
		chembag = null
	if(new_bag && user.transferItemToLoc(new_bag, src))
		to_chat(user, "<span class='notice'>You slot the [new_bag] into [src]'s chemical storage slot.</span>")
		chembag = new_bag
	update_contents()
	return TRUE

/obj/machinery/sleeper/screwdriver_act(mob/living/user, obj/item/I)
	. = TRUE
	if(..())
		return
	if(occupant)
		to_chat(user, "<span class='warning'>[src] is currently occupied!</span>")
		return
	if(state_open)
		to_chat(user, "<span class='warning'>[src] must be closed to [panel_open ? "close" : "open"] its maintenance hatch!</span>")
		return
	if(default_deconstruction_screwdriver(user, "[initial(icon_state)]-o", initial(icon_state), I))
		return
	return FALSE

/obj/machinery/sleeper/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(default_change_direction_wrench(user, I))
		return TRUE

/obj/machinery/sleeper/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(default_pry_open(I))
		return TRUE
	if(default_deconstruction_crowbar(I))
		return TRUE

/obj/machinery/sleeper/default_pry_open(obj/item/I) //wew
	. = !(state_open || panel_open || (flags_1 & NODECONSTRUCT_1)) && I.tool_behaviour == TOOL_CROWBAR
	if(.)
		I.play_tool_sound(src, 50)
		visible_message("<span class='notice'>[usr] pries open [src].</span>", "<span class='notice'>You pry open [src].</span>")
		open_machine()

/obj/machinery/sleeper/ui_interact(mob/user, datum/tgui/ui)
	if(src.contains(user) && !controls_inside)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Sleeper", name)
		ui.open()

/obj/machinery/sleeper/ui_state(mob/user)
	if(controls_inside)
		return GLOB.notcontained_state
	return GLOB.default_state

/obj/machinery/sleeper/AltClick(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if(state_open)
		close_machine()
	else
		open_machine()

/obj/machinery/sleeper/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click [src] to [state_open ? "close" : "open"] it.</span>"
	. += "<span class='notice'>[chembag ? "There is a chembag in the chemical storage slot. It can be removed by Ctrl-clicking." : "It looks like a chembag can be attached to the chemical storage slot."]</span>"

/obj/machinery/sleeper/ui_data(mob/user)
	if(src.contains(user) && !controls_inside)
		return
	var/list/data = list()
	data["occupied"] = occupant ? 1 : 0
	data["open"] = state_open
	data["amount"] = amount
	data["transferAmounts"] = transfer_amounts
	data["canStasis"] = can_stasis
	data["stasis"] = stasis_enabled && can_stasis
	var/chemicals[0]
	var/is_hallucinating = user.hallucinating()
	if(user.hallucinating())
		is_hallucinating = TRUE
	for(var/re in dispensable_reagents)
		var/value = dispensable_reagents[re]
		var/datum/reagent/temp = GLOB.chemical_reagents_list[re]
		if(temp)
			var/chemname = temp.name
			var/total_volume = 0
			for (var/datum/reagents/rs in value["reagents"])
				total_volume += rs.total_volume
			if(is_hallucinating && prob(5))
				chemname = "[pick_list_replacements("hallucination.json", "chemicals")]"
			chemicals.Add(list(list("title" = chemname, "id" = ckey(temp.name), "volume" = total_volume, "allowed" = chem_allowed(temp))))
	data["chemicals"] = chemicals
	data["occupant"] = list()
	var/mob/living/mob_occupant = occupant
	if(mob_occupant)
		data["occupant"]["name"] = mob_occupant.name
		switch(mob_occupant.stat)
			if(CONSCIOUS)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "good"
			if(SOFT_CRIT)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "average"
			if(UNCONSCIOUS, HARD_CRIT)
				data["occupant"]["stat"] = "Unconscious"
				data["occupant"]["statstate"] = "average"
			if(DEAD)
				data["occupant"]["stat"] = "Dead"
				data["occupant"]["statstate"] = "bad"
		data["occupant"]["health"] = mob_occupant.health
		data["occupant"]["maxHealth"] = mob_occupant.maxHealth
		data["occupant"]["minHealth"] = HEALTH_THRESHOLD_DEAD
		data["occupant"]["bruteLoss"] = mob_occupant.getBruteLoss()
		data["occupant"]["oxyLoss"] = mob_occupant.getOxyLoss()
		data["occupant"]["toxLoss"] = mob_occupant.getToxLoss()
		data["occupant"]["fireLoss"] = mob_occupant.getFireLoss()
		data["occupant"]["cloneLoss"] = mob_occupant.getCloneLoss()
		data["occupant"]["brainLoss"] = mob_occupant.getOrganLoss(ORGAN_SLOT_BRAIN)
		data["occupant"]["reagents"] = list()
		if(mob_occupant.reagents && mob_occupant.reagents.reagent_list.len)
			for(var/datum/reagent/R in mob_occupant.reagents.reagent_list)
				data["occupant"]["reagents"] += list(list("name" = R.name, "volume" = R.volume))
	return data

/obj/machinery/sleeper/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/mob_occupant = occupant
	switch(action)
		if("amount")
			var/target = text2num(params["target"])
			amount = target
			. = TRUE
		if("toggleStasis")
			if(occupant && can_stasis)
				stasis_enabled = !stasis_enabled
		if("inject")
			var/reagent_name = params["reagent"]
			var/datum/reagent/chem = GLOB.name2reagent[reagent_name]
			if(!is_operational || !mob_occupant || isnull(chem))
				return
			if(mob_occupant.health < min_health && chem != /datum/reagent/medicine/epinephrine)
				return
			if(inject_chem(chem, usr))
				. = TRUE

/obj/machinery/sleeper/proc/inject_chem(datum/reagents/chem, mob/user)
	if((chem in dispensable_reagents) && chem_allowed(chem))
		var/entry = dispensable_reagents[chem]
		if(occupant)
			var/datum/reagents/R = occupant.reagents
			var/actual = min(amount, 1000, R.maximum_volume - R.total_volume)
			// todo: add check if we have enough reagent left
			for (var/datum/reagents/source in entry["reagents"])
				var/to_transfer = min(source.total_volume, actual)
				source.trans_to(occupant, to_transfer)
				actual -= to_transfer
				if (actual <= 0)
					break
			playsound(src, pick('sound/items/hypospray.ogg','sound/items/hypospray2.ogg'), 50, TRUE, 2)
			log_combat(user, occupant, "injected [amount - actual] [chem] into", addition = "via [src]")
		return TRUE

/obj/machinery/sleeper/proc/chem_allowed(chem)
	var/mob/living/mob_occupant = occupant
	if(!mob_occupant || !mob_occupant.reagents)
		return
	var/amount = mob_occupant.reagents.get_reagent_amount(chem) + 10 <= 20 * efficiency
	var/occ_health = mob_occupant.health > min_health || chem == /datum/reagent/medicine/epinephrine
	return amount && occ_health

/obj/machinery/sleeper/proc/update_contents()
	LAZYCLEARLIST(dispensable_reagents)
	LAZYINITLIST(dispensable_reagents)

	for (var/obj/item/reagent_containers/B in chembag)
		if((B.item_flags & ABSTRACT) || !B.is_open_container())
			continue
		var/key = B.reagents.get_master_reagent_id()
		if (!(key in dispensable_reagents))
			dispensable_reagents[key] = list()
			dispensable_reagents[key]["reagents"] = list()
		dispensable_reagents[key]["reagents"] += B.reagents
	return

/obj/machinery/sleeper/syndie
	icon_state = "sleeper_s"
	controls_inside = TRUE
	base_icon_state = "sleeper_s"

/obj/machinery/sleeper/old
	icon_state = "oldpod"
	base_icon_state = "oldpod"
