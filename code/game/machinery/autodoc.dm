	//Basic procedures = Brute, Burn, etc.
	//Complex procedures = Revival, Wounds, and Clone (is that even used anywhere?)
	//Organ repair has a higher cost to incentivise prosthetic use. Oxygen recovery is cheaper because it's Ephemeral.
	#define COST_BASIC = 250
	#define COST_COMPLEX = 500
	#define COST_ORGANS = 800

//Primary machine. This is where our patient and procedure disk goes.
/obj/machinery/autodoc
	name = "\improper Autodoc"
	desc = "Waow just like Fallout New Vegas"
	icon = 'icons/obj/machines/autodoc.dmi'
	icon_state = "autodoc0"
	base_icon_state = "autodoc"
	density = TRUE
	use_power = ACTIVE_DRAW_MEDIUM
	occupant_typecache = /mob/living/carbon
	processing_flags = START_PROCESSING_MANUALLY

	var/obj/item/disk/autodoc/proc_disk

	///Used to check whether the machine is actively working.
	var/operating = FALSE
	///Whether we're dispensing compensation.
	var/voucher = FALSE
	///Toggled on when post_procedure is called. This only exists so damage applied at this point isn't factored into operation length.
	var/post_procedure = FALSE
	///Message once operation has ended.
	var/end_message = "Operation concluded."
	///If we don't meet conditions for starting an operation, say this.
	var/error_message = "Unknown."
	///Changes depending on outcome.
	var/end_sound = 'sound/machines/defib_success.ogg'
	///Amount healed per second
	var/heal_amount = -4
	///Amount of delay for organ replacements / wound heals post-procedure.
	var/post_delay = 3 SECONDS
	///What gets dropped when dropContents() is called.
	var/list/subset
	///If we're replacing organs, missing organs are added to this list.
	var/list/replacing_organs
	///If we're replacing limbs, missing limbs are added to this list.
	var/list/replacing_limbs
	///Total damage calculated by heal_tick()
	var/total_damage = 0

/obj/machinery/autodoc/dark
	base_icon_state = "autodoc-dark"
	icon_state = "autodoc-dark0"

//Procedure disk. Purchased from an autodoc vendor, lists available procedures as heal flags.
/obj/item/disk/autodoc
	name = "generic autodoc procedure"
	desc = "Waow just like Falout New Vegas"
	illustration = "autodoc"
	var/heal_flags = 0
	var/uses = 0
	var/cost = 0 //Amount of credits spent to print the disk. Used by vouchers.

/obj/item/disk/autodoc/Initialize(mapload, flags, init_uses, init_cost)
	. = ..()
	if(flags)
		heal_flags = flags
	if(init_uses)
		uses = init_uses
	if(init_cost)
		cost = init_cost

/obj/item/disk/autodoc/test
	name = "everything disk"
	heal_flags = DO_BRUTE | DO_BURN | DO_TOX | DO_REPLACE | DO_CLONE | DO_WOUNDS | DO_ORGANS | DO_REVIVE //collect my flags
	uses = 100

//Examine behaviour

//Returns flags on a disk as a string. Used for examine text.
/obj/item/disk/autodoc/proc/get_heal_flags_string()
	if(!heal_flags)
		return
	var/flag_list = list()
	if(heal_flags & DO_BRUTE)
		flag_list += span_boldnotice("Tissue Damage")
	if(heal_flags & DO_BURN)
		flag_list += span_boldnotice("Burn Treatment")
	if(heal_flags & DO_TOX)
		flag_list += span_boldnotice("Toxin Purge")
	if(heal_flags & DO_CLONE)
		flag_list += span_boldnotice("Cellular Damage")
	if(heal_flags & DO_WOUNDS)
		flag_list += span_boldnotice("Complex Wounds")
	if(heal_flags & DO_ORGANS)
		flag_list += span_boldnotice("Organ Repair")
	if(heal_flags & DO_REPLACE)
		flag_list += span_boldnotice("Prosthetic Replacement")
	if(heal_flags & DO_REVIVE)
		flag_list += span_boldnotice("Resuscitation")
	return english_list(flag_list, null, span_notice(", "))

/obj/item/autodoc_voucher
	name = "\proper refund voucher"
	desc = "A voucher printed as compensation for a failed AutoDoc procedure. Insert into your nearest AutoDoc vendor."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paperbiscuit_cracked"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	pressure_resistance = 0
	resistance_flags = FLAMMABLE
	max_integrity = 130
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	var/refund_amount = 0

/obj/item/autodoc_voucher/Initialize(mapload, amount)
	. = ..()
	if(amount)
		refund_amount = amount
	update_icon()

/obj/item/autodoc_voucher/update_overlays()
	. = ..()
	if(refund_amount)
		. += "paperbiscuit_paper"

//Examines
/obj/item/disk/autodoc/examine()
	. = ..()
	if(heal_flags)
		. += span_notice("The following procedures are stored on the disk: [get_heal_flags_string()]")
	if(!uses)
		. += span_info("It has 0 uses left.")
	else
		. += span_info("It has [uses] uses left.")

/obj/item/autodoc_voucher/examine(mob/user)
	. = ..()
	. += span_notice("It can be redeemed for [span_boldnotice("[refund_amount]")] credits.")

/obj/machinery/autodoc/examine(mob/user)
	. = ..()
	var/mob/living/carbon/patient = occupant
	if(proc_disk)
		if(proc_disk.heal_flags && operating)
			. += span_notice("[src] is currently operating with settings: [proc_disk.get_heal_flags_string()]")
			. += span_notice("Estimated time until completion: [span_boldnotice("[get_operation_length()]")].")
		else
			. += span_info("Right click to start [src].")
			. += span_info("Alt-click to eject [icon2html(proc_disk, user)] [proc_disk].")
	else
		. += span_notice("There is no procedure disk inserted.")
	if(patient && user.Adjacent(src))
		healthscan(user, patient, FALSE, FALSE)

//Interactions: attackby (insert disk), AltClick (remove disk), interact (open/close)
// mousedrop_T, (drag/drop patient), attack_hand_secondary (begin/stop procedure)

//Insert procedure disk
/obj/machinery/autodoc/attackby(obj/item/thing, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(thing, /obj/item/disk/autodoc))
		if(proc_disk)
			to_chat(user, span_warning("Remove the other procedure disk first!"))
		else
			if(!user.transferItemToLoc(thing, src))
				return
			proc_disk = thing
			to_chat(user, span_notice("You insert [thing] into [src]."))
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
			return
	else
		return ..()

//Remove procedure disk. Not allowed if we're currently operating.
/obj/machinery/autodoc/AltClick(mob/living/carbon/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE) || occupant == user)
		return
	if(!proc_disk)
		to_chat(user, span_warning("There's nothing inside [src]'s disk slot."))
		return
	if(operating)
		to_chat(user, span_warning("The disk won't come out until you stop the procedure!"))
		return
	if(!user.put_in_hands(proc_disk))
		to_chat(user, span_warning("You need a free hand!"))
		return
	user.visible_message(span_notice("[user] removes [proc_disk] from [src]."), \
	span_notice("You slide [proc_disk] out from [src]'s disk slot."))
	proc_disk = null
	playsound(src, 'sound/machines/click.ogg', 50, FALSE)

//Left click to open/close machine.
/obj/machinery/autodoc/interact(mob/user)
	. = ..()
	if(issiliconoradminghost(user))
		attack_hand_secondary(user)
		return TRUE
	toggle_open(user)
	return TRUE

//Behaviour for dragging & dropping patients.
/obj/machinery/autodoc/MouseDrop_T(mob/living/carbon/target, mob/user)
	if(!istype(target) || user.incapacitated() || !target.Adjacent(user) || !Adjacent(user) || !ismob(target) || (!ishuman(user) && !iscyborg(user)) || !istype(user.loc, /turf) || target.buckled)
		return

	if(!state_open)
		to_chat(user, span_warning("[src] needs to be opened first!"))
		return

	if(target == user)
		user.visible_message(span_notice("[user] climbs into [src]."), \
		span_notice("You climb into [src]."))
	else
		user.visible_message(span_notice("[user] inserts [target] into [src]."), \
		span_notice("You insert [target] into [src]."))
	close_machine(target)
	LAZYADD(subset, occupant)

//If we meet can_operate() checks, begin a do_after to start operating. If machine is currently operating, attempt to shut down.
/obj/machinery/autodoc/attack_hand_secondary(mob/user, modifiers)
	if(is_operational && !state_open)
		user.changeNext_move(CLICK_CD_MELEE)
		if(operating && occupant)
			if(user == occupant)
				to_chat(user, span_notice("You begin enabling the manual stop from [src]'s interior screen."))
			else
				user.visible_message(span_notice("You see [user] tapping on [src]'s interface."), \
				span_notice("You begin enabling the manual stop on [src]'s interface."), \
				span_hear("You hear a series of taps coming from [src]'s direction."))
			if(do_after(user, 30, target = src))
				if(operating) //check again, in case the operation has ended.
					end_message = "Manual stop engaged. Operation concluded."
					end_sound = 'sound/machines/defib_success.ogg'
					end_procedure()

		if(can_operate())
			to_chat(user, span_notice("You start turning [src] on."))
			if(do_after(user, 20, target = src, extra_checks = CALLBACK(src, PROC_REF(can_operate))))
				begin_procedure()
		else
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: [error_message]")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

//Open/close behaviour
/obj/machinery/autodoc/proc/toggle_open(mob/user)
	if(state_open)
		close_machine()
		LAZYADD(subset, occupant)
		return
	else if(operating)
		to_chat(user, span_warning("You attempt to open [src], but it appears to be locked!"))
		return
	open_machine()
	if(occupant)
		dropContents(subset)
		LAZYREMOVE(subset, occupant)

/obj/machinery/autodoc/open_machine()
	. = ..(drop = FALSE)
	if(occupant)
		dropContents(subset)
		subset -= occupant

/obj/machinery/autodoc/update_icon_state()
	//Open: autodoc0 Closed: autodoc1 Closed & Operating: autodoc2
	icon_state = "[base_icon_state][state_open ? 0 : (operating ? 2 : 1)]"
	return ..()

//Operation procs

/obj/machinery/autodoc/proc/can_operate()
	var/mob/living/carbon/patient = occupant
	if(!is_operational || state_open)
		return FALSE

	if(!patient)
		error_message = "No valid patient found."
		return FALSE

	//Check whether we have a procedure disk inserted.
	if(!proc_disk)
		error_message = "No procedure disk found."
		return FALSE

	//Don't accept a drained procedure disk.
	if(proc_disk.uses < 1)
		error_message = "Procedure disk is out of uses."
		return FALSE

	//Don't accept non-sapient carbons, or robots.
	if(!ishuman(patient) || !patient.check_organic_parts())
		error_message = "Patient is not compatible."
		return FALSE

	//Check whether we're capable of directly restoring health.
	if(!heal_tick())
		//If we're dead and revive flag enabled. 						//If replace flag is enabled and we have valid organ/limb replacements
		if((proc_disk.heal_flags & DO_REVIVE) && patient.stat == DEAD || (proc_disk.heal_flags & DO_REPLACE) && get_replacements())
			return TRUE
		error_message = "Patient cannot be tended by current procedure."
		return FALSE

	return TRUE

//If our patient mysteriously departs, stop operating.
/obj/machinery/autodoc/Exited(atom/movable/AM, atom/newloc)
	if(AM == occupant && operating)
		end_message = "Patient not found. Ending procedure."
		end_sound = 'sound/machines/defib_failed.ogg'
		end_procedure(occupant)
	LAZYCLEARLIST(replacing_organs)
	. = ..()

//Let's do the procedure for real now
/obj/machinery/autodoc/proc/begin_procedure()
	var/mob/living/carbon/patient = occupant
	if(operating)
		return
	operating = TRUE
	proc_disk.uses -= 1
	end_message = initial(end_message)
	end_sound = initial(end_sound)
	//Freeze our patient
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)
	patient.apply_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
	patient.extinguish_mob()
	say("Commencing operation. Estimated time to completion: [get_operation_length()].")
	update_icon()
	begin_processing()

//Calculate total length of procedure in minutes & seconds.
/obj/machinery/autodoc/proc/get_operation_length()
	var/time
	var/mob/living/carbon/patient = occupant

	if(!post_procedure) //Don't bother re-calculating total_damage if we're not healing anymore.
		heal_tick(0)
	time = (total_damage / heal_amount) * -10 //Calculate the amount of seconds it'd take to heal, then convert that to deciseconds. Flip the negative because heal_amount is negative.
	if(proc_disk.heal_flags & DO_WOUNDS && patient && patient.all_wounds)
		time += (post_delay * patient.all_wounds.len + 1)
	if(proc_disk.heal_flags & DO_ORGANS && patient && get_replacements())
		time += (post_delay * replacing_organs + 1)
	return DisplayTimeText(time, 1)

//Runs through our healing flags and acts accordingly. Kills the process if we have nothing to do.
/obj/machinery/autodoc/process(seconds_per_tick)
	if(!is_operational || !occupant || !operating)
		return PROCESS_KILL

	if(heal_tick(seconds_per_tick))
		playsound(src, 'sound/surgery/retractor2.ogg', 50, FALSE)
		return

	if(proc_disk.heal_flags & DO_REVIVE || DO_WOUNDS)
		post_procedure()
	else
		get_replacements()
		end_procedure()

//Used to check whether we're capable of healing, and also executing that healing. Organ and wound stuff is handled in post procedure.
//Total_damage is used in procedure length calculations.
/obj/machinery/autodoc/proc/heal_tick(seconds_per_tick)
	var/mob/living/carbon/patient = occupant
	total_damage = 0
	if(!patient)
		return
	if(proc_disk.heal_flags & DO_BRUTE && patient.getBruteLoss(BODYTYPE_ORGANIC) > 0)
		if(operating)
			patient.adjustBruteLoss(heal_amount * seconds_per_tick)
		total_damage += patient.getBruteLoss(BODYTYPE_ORGANIC)
		. = TRUE

	if(proc_disk.heal_flags & DO_BURN && patient.getFireLoss(BODYTYPE_ORGANIC) > 0)
		if(operating)
			patient.adjustFireLoss(heal_amount * seconds_per_tick)
			if(HAS_TRAIT(patient, TRAIT_HUSK) && patient.getFireLoss() < THRESHOLD_UNHUSK)
				patient.cure_husk()
		total_damage += patient.getFireLoss(BODYTYPE_ORGANIC)
		. = TRUE

	if(proc_disk.heal_flags & DO_TOX && patient.getToxLoss() > 0 || patient.radiation > 0)
		if(operating)
			patient.adjustToxLoss(heal_amount * seconds_per_tick)
			patient.radiation -= min(patient.radiation, heal_amount * (seconds_per_tick * 2) * -1) //Debatable whether we should heal radiation here. Remind me to get an opinion on this later.
		total_damage += patient.getToxLoss() + patient.radiation / 2
		. = TRUE

	if(proc_disk.heal_flags & DO_CLONE && patient.getCloneLoss() > 0)
		if(operating)
			patient.adjustCloneLoss(heal_amount * seconds_per_tick)
		total_damage += patient.getCloneLoss()
		. = TRUE

	if(proc_disk.heal_flags & DO_ORGANS)
		var/highest_damage = 0
		for(var/thing in patient.internal_organs)
			var/obj/item/organ/target = thing
			if(!target)
				continue
			if(target.organ_flags & ORGAN_SYNTHETIC || target.damage <= 1)
				continue
			if(target.damage > highest_damage)
				highest_damage = target.damage
			target.applyOrganDamage(heal_amount * seconds_per_tick)
			total_damage += highest_damage
			. = TRUE

/obj/machinery/autodoc/proc/attempt_revive() //Must be a separate proc because timer. Grrrr. My eyes turn red.
	var/mob/living/carbon/patient = occupant
	//If patient has a ckey, and revive() is called successfully, do a bunch of things I stole from defib code.
	if(patient)
		playsound(src, 'sound/machines/defib_zap.ogg', 50, FALSE)
		if(patient.mind)
			patient.revive()
			patient.set_heartattack(FALSE)
			patient.emote("gasp")
			patient.set_timed_status_effect(200 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
			patient.adjustOxyLoss(60)
			SEND_SIGNAL(occupant, COMSIG_LIVING_MINOR_SHOCK)
			say("Rescusitation successful.")
			if (patient.health > HEALTH_THRESHOLD_FULLCRIT) //Call me when you can be awake and unconscious at the same time. This will always be true unless the patient has prosthetics.
				to_chat(patient, span_notice("<b>You suddenly jolt awake in the cold darkness of an Autodoc.</b> Innumerous small instruments surround you, attentively tending to your wounds."))
	//Dramatic pause. Revved is true to prevent infinite loops.
	if(operating)
		post_procedure(20, TRUE)

//Update replacing organs list.
/obj/machinery/autodoc/proc/get_replacements(vitals)
	var/mob/living/carbon/patient = occupant
	if(replacing_organs) //Clear existing lists to quell duplicates.
		LAZYCLEARLIST(replacing_organs)
	if(replacing_limbs)
		LAZYCLEARLIST(replacing_limbs)
	if(patient)
		if(patient.get_missing_organs(vitals)) //Check whether we're missing organs
			for(var/slot in patient.get_missing_organs(vitals))
				if(patient.dna.species.prosthetic_style && (slot in patient.dna.species.prosthetic_style.replacement_organs)) //If we can't get a prosthetic, don't add the organ to our replacement list.
					LAZYADD(replacing_organs, slot)
		if(patient.get_missing_limbs())
			for(var/slot in patient.get_missing_limbs())
				LAZYADD(replacing_limbs, slot)
	var/replace_list = replacing_organs + replacing_limbs
	return replace_list

/obj/machinery/autodoc/proc/post_procedure(delay, revved)
	var/mob/living/carbon/patient = occupant
	end_processing()
	post_procedure = TRUE

//If any of our internal organs are missing, insert prosthetic replacements. This probably shouldn't manifest organs from thin air, but it's functional.
	if(proc_disk.heal_flags & DO_REPLACE && replacing_organs || replacing_limbs)
		if(replacing_organs)
			var/missing_organ = pick(replacing_organs) //Pick a random missing organ from our available candidates.
			var/obj/item/organ/new_organ = patient.new_organ(missing_organ, TRUE, patient.dna.species)
			new_organ.Insert(patient, TRUE, FALSE)
			LAZYREMOVE(replacing_organs, missing_organ) //Insert the new organ into the patient, and remove it from the to-do list.
		else if(replacing_limbs)
			var/missing_limb = pick(replacing_limbs)
			patient.regenerate_limb(missing_limb, robotic = TRUE)
			LAZYREMOVE(replacing_limbs, missing_limb) //Insert the new organ into the patient, and remove it from the to-do list.
		playsound(src, pick('sound/surgery/organ1.ogg','sound/surgery/organ2.ogg'), 30, FALSE)
		addtimer(CALLBACK(src, PROC_REF(post_procedure)), post_delay)
		return

//Cycle through and repair patient's wounds.
	if(proc_disk.heal_flags & DO_WOUNDS)
		patient.remove_status_effect(STATUS_EFFECT_DETERMINED)
		for(var/datum/wound/current_wound in patient.all_wounds)
			current_wound.remove_wound()
			playsound(src, pick('sound/surgery/bone1.ogg','sound/surgery/bone2.ogg','sound/surgery/bone3.ogg'), 30, FALSE)
			say("[current_wound] repaired.")
			addtimer(CALLBACK(src, PROC_REF(post_procedure)), post_delay)
			return

//Attempt revival. If we've already made an attempt, give it up.
	if(patient && patient.stat == DEAD)
		if(proc_disk.heal_flags & DO_REVIVE && !revved)
			addtimer(CALLBACK(src, PROC_REF(attempt_revive)), 30)
			say("Attempting rescusitation.")
			playsound(src, 'sound/machines/defib_charge.ogg', 50, FALSE)
			patient.notify_ghost_cloning("You're being revived in an autodoc!")
			patient.grab_ghost()
			return

		else if(revved)
			end_message = "Revival failed, stopping procedure. [proc_disk.cost ? "Dispensing voucher as compensation." : ""]"
			voucher = TRUE
			end_sound = 'sound/machines/defib_failed.ogg'
	addtimer(CALLBACK(src, PROC_REF(end_procedure)), delay)

/obj/machinery/autodoc/proc/end_procedure(mob/living/carbon/patient)
	if(occupant)
		patient = occupant
	end_processing()
	if(patient && IS_IN_STASIS(patient))
		patient.remove_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
	if(voucher && proc_disk.cost)
		var/refund_amount = COST_COMPLEX / 2
		if(proc_disk.uses > 1)
			refund_amount = COST_COMPLEX / (0.8 * proc_disk.uses)
		print_voucher(round(refund_amount))
	operating = FALSE
	post_procedure = FALSE
	playsound(src, end_sound, 100)
	say("[end_message]")
	open_machine()

/obj/machinery/autodoc/proc/print_voucher(amount)
	new /obj/item/autodoc_voucher(get_turf(src), amount)
	playsound(src, 'sound/items/taperecorder/taperecorder_print.ogg', 30, FALSE)
	voucher = FALSE

/obj/effect/spawner/structure/aaaaa
	name = "debug autodoc spawner"
	icon = 'icons/obj/machines/borgcharger.dmi'
	icon_state = "borgcharger0"
	spawn_list = list(/obj/machinery/autodoc, /obj/item/disk/autodoc/test, /obj/item/melee/sledgehammer/gorlex, /obj/effect/mob_spawn/human/corpse, /obj/effect/mob_spawn/human/corpse/damaged)


//												Now entering: Vendor Hell												//
//to-do: procedure list doesnt wrap nicely

/obj/machinery/autodoc_vendor
	name = "autodoc vendor"
	desc = "vends autodocs"
	icon = 'icons/obj/vending.dmi'
	icon_state = "robotics"
	density = TRUE
	use_power = IDLE_POWER_USE
	///Times printed disk can be used.
	var/uses = 1
	///Procedures on our printed disk. All = 128.
	var/heal_flags = 0
	///Total cost to print
	var/cost = 0
	///Total cost of procedures, minus multipliers. Used for cost scaling.
	var/base_cost = 0
	///Whether we're ignoring cost.
	var/free = FALSE

/obj/machinery/autodoc_vendor/ui_interact(mob/user, datum/tgui/ui)
	if(machine_stat & BROKEN)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AutodocVendor", name)
		ui.open()

/obj/machinery/autodoc_vendor/ui_data(mob/user)
	var/list/data = list()
	data["uses"] = uses
	data["heal_flags"] = heal_flags
	data["cost"] = adjust_cost()
	data["free"] = free

	if(ishuman(user))
		var/mob/living/carbon/human/carbon = user
		var/obj/item/card/bank/card = carbon.get_bankcard()
		if(card && card.registered_account)
			data["user"] = list()
			data["user"]["name"] = card.registered_account.account_holder
			data["user"]["cash"] = card.registered_account.account_balance

	data["cost_basic"] = COST_BASIC
	data["cost_complex"] = COST_COMPLEX
	data["cost_organs"] = COST_ORGANS

	data["do_brute"] = DO_BRUTE
	data["do_burn"] = DO_BURN
	data["do_tox"] = DO_TOX
	data["do_clone"] = DO_CLONE

	data["do_organs"] = DO_ORGANS
	data["do_replace"] = DO_REPLACE
	data["do_wounds"] = DO_WOUNDS
	data["do_revive"] = DO_REVIVE
	return data

/obj/machinery/autodoc_vendor/ui_act(action, params)
	. = ..()
	var/custom_clicksound = 'sound/machines/terminal_prompt_deny.ogg'

	if(.)
		return

	switch(action)
		if("toggle-procedure")
			var/flag = text2num(params["flag"]) //Bitflag of the procedure we're toggling.
			var/toggle = text2num(params["toggle"]) //Whether we're switching it on or off.
			var/adjustcost = text2num(params["adjustcost"]) //Value of the procedure
			custom_clicksound = 'sound/machines/terminal_select.ogg'
			if(toggle) //If we're toggling on, add the procedure to our heal flags. Otherwise, remove it.
				heal_flags &= ~flag
				adjust_cost(-adjustcost)
			else
				heal_flags |= flag
				adjust_cost(adjustcost)
			. = TRUE

		if("less-uses")
			if(uses > 1)
				custom_clicksound = 'sound/machines/terminal_select.ogg'
				uses--
				adjust_cost()
				. = TRUE
		if("more-uses")
			if(uses < 12)
				custom_clicksound = 'sound/machines/terminal_select.ogg'
				uses++
				adjust_cost()
				. = TRUE

		if("print")
			var/canafford = text2num(params["canafford"])
			if(canafford && heal_flags > 0) //If we're too poor or no flags are toggled, skip this part.
				custom_clicksound = 'sound/machines/pda_button1.ogg'
				var/obj/item/disk/autodoc/printed_disk = new /obj/item/disk/autodoc(get_turf(src), heal_flags, uses, free ? 0 : cost) //Generate a proc disk with our selected uses and procedures.
				var/mob/living/carbon/human/carbon = usr
				var/obj/item/card/bank/card = carbon.get_bankcard()

				if(card)
					var/datum/bank_account/account = card.registered_account
					account.adjust_money(-cost, CREDIT_LOG_VENDOR_PURCHASE)
					log_econ("[cost] credits were spent by [carbon] on an AutoDoc procedure disk.")
				if(!issiliconoradminghost(usr) && usr.CanReach(src) && usr.put_in_hands(printed_disk))
					to_chat(usr, span_notice("You take [printed_disk.name] out of the slot."))
				else
					to_chat(usr, span_warning("[printed_disk.name] slides out of the [src]'s disk slot."))
			else if(!heal_flags)
				say("No procedures selected.")
			else
				say("User funds insufficient.")
	play_click_sound(custom_clicksound)

/obj/machinery/autodoc_vendor/proc/adjust_cost(amount)
	if(amount)
		base_cost += amount
	if(uses > 1)
		cost = base_cost * (0.8 * uses)
	else
		cost = base_cost
	return cost

/obj/machinery/autodoc_vendor/attackby(obj/item/thing, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(thing, /obj/item/disk/autodoc))
		var/obj/item/disk/autodoc/proc_disk = thing
		if(proc_disk.uses <= 0)
			qdel(proc_disk)
			playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 40, TRUE)
			to_chat(user, span_notice("You insert [proc_disk] into [src]'s return slot."))
		else
			to_chat(user, span_warning("That disk still has [span_boldwarning("[proc_disk.uses]")] uses!"))
	if(istype(thing, /obj/item/autodoc_voucher))
		var/obj/item/autodoc_voucher/voucher = thing
		if(voucher.refund_amount > 0)
			qdel(voucher)
			new /obj/item/spacecash/bundle(get_turf(src), voucher.refund_amount)
			playsound(src, pick('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg'), 40, TRUE)
			to_chat(user, span_notice("You insert [voucher] into [src]."))
		else
			to_chat(user, span_warning("You try inserting the voucher into [src], but the machine rejects it!"))
	else
		return ..()

/obj/machinery/autodoc_vendor/examine(mob/user)
	. = ..()
	. += span_notice("[src] has a return slot for discarding used disks.")
