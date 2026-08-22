/*
The goal: A machine at the Outpost that allows players without an onboard doctor to get back into the round when they’ve been killed, and no medships are in the game.

I think it would be something like 1,000 credits, just a bit more than a current defib, and doesn’t price medships out of the round.

It would involve a 1-2 tile machine in the outpost medbay. This machine would, at the least, fix all brute/bruise on a patient and revive them.
I can see arguments for it being more comprehensive and curing husking or organ damage or wounds. I think there should be things it can’t do, like fixing broken limbs, to keep medical gameplay relevant.

The process would take about 1-3 minutes. Long enough to feel like a wait, not long enough to meaningfully add to time out of the round.

There would be a minimal speech interface (like phrases coming up for treatments, etc). Other elements could be more or less complex
I think it would be best to make one without worrying too much about balance, and then tweak time, prices, services provided, etc. as needed
Ideally for coding ease, it would be very simple, not even interface with tgui
Perhaps punchcards for different services could be bought from a vendor and used to select treatments

I think ideally, the niche that medships serve with an autodoc present is turning ruin failures into a situation where players can continue attempting a ruin, where as an autodoc usually means you are retreating
-Ficrab (Ideas Guy)
*/

/*TO-DO:
-Create procedure disk vendor, work out pricing. Bonus points if you can pay extra for more uses. Idk how to do that with regular vendor UI.
-Map changes
-Voucher system (low priority. Would be funny.)
-Sound stuff
*/

#define DO_BRUTE (1<<0) // 00000001 = 1 in binary
#define DO_BURN (1<<1) // 00000010 = 2 in binary
#define DO_TOX (1<<2) // 00000100 = 4 in binary
#define DO_OXY (1<<3) // 00001000 = 8 in binary
#define DO_CLONE (1<<4) // 00010000 = 16 in binary
#define DO_ORGANS (1<<5) // 00100000 = 32 in binary
#define DO_WOUNDS (1<<6) // 01000000 = 64 in binary
#define DO_REVIVE (1<<7) // 10000000 = 128 in binary

/obj/machinery/autodoc
	name = "\improper Autodoc"
	desc = "Waow just like Fallout New Vegas"
	icon = 'icons/obj/machines/borgcharger.dmi'
	icon_state = "borgcharger0"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_LOW
	active_power_usage = ACTIVE_DRAW_MEDIUM
	occupant_typecache = /mob/living/carbon
	processing_flags = START_PROCESSING_MANUALLY

	var/obj/item/disk/autodoc/proc_disk

	///Used to check whether the machine is actively working.
	var/operating = FALSE
	///Toggled on when post_procedure is called. This only exists so damage applied at this point isn't factored into operation length.
	var/post_procedure = FALSE
	///Message once operation has ended.
	var/end_message = "Operation concluded."
	///Changes depending on outcome.
	var/end_sound = 'sound/machines/defib_success.ogg'
	///Amount healed per second
	var/heal_amount = -3
	///What gets dropped when dropContents() is called.
	var/list/subset = null
	///Total damage calculated by heal_tick()
	var/total_damage = 0

/obj/item/disk/autodoc
	name = "generic autodoc procedure"
	desc = "Waow just like Falout New Vegas"
	illustration = "autodoc"
	var/heal_flags = DO_BRUTE
	var/uses = 1

/obj/item/disk/autodoc/test
	name = "everything disk"
	heal_flags = DO_BRUTE | DO_BURN | DO_TOX | DO_OXY | DO_CLONE | DO_WOUNDS | DO_ORGANS | DO_REVIVE //collect my flags
	uses = 100

/obj/item/disk/autodoc/proc/get_heal_flags_string()
	if(!heal_flags)
		return
	var/flag_list = list()
	if(heal_flags & DO_BRUTE)
		flag_list += span_boldnotice("Tissue Damage")
	if(heal_flags & DO_BURN)
		flag_list += span_boldnotice("Burns")
	if(heal_flags & DO_TOX)
		flag_list += span_boldnotice("Toxin Purge")
	if(heal_flags & DO_OXY)
		flag_list += span_boldnotice("Respiratory")
	if(heal_flags & DO_CLONE)
		flag_list += span_boldnotice("Cellular Damage")
	if(heal_flags & DO_WOUNDS)
		flag_list += span_boldnotice("Complex Wounds")
	if(heal_flags & DO_ORGANS)
		flag_list += span_boldnotice("Internal Damage")
	if(heal_flags & DO_REVIVE)
		flag_list += span_boldnotice("Resuscitation")
	return english_list(flag_list, null, span_notice(", "))

/obj/item/disk/autodoc/examine()
	. = ..()
	if(heal_flags)
		. += span_notice("The following procedures are stored on the disk: [get_heal_flags_string()]")

/obj/machinery/autodoc/examine(mob/user)
	. = ..()
	var/mob/living/carbon/patient = occupant
	if(!proc_disk)
		return
	if(!operating)
		. += span_notice("Alt-click to eject [icon2html(proc_disk, user)] [proc_disk].")
	if(proc_disk.heal_flags && operating)
		. += span_notice("[src] is currently operating with settings: [proc_disk.get_heal_flags_string()]")
		. += span_notice("Estimated time until completion: [span_boldnotice("[get_operation_length()]")].")
	if(patient)
		healthscan(user, patient, FALSE, FALSE)

//Insert procedure disk
/obj/machinery/autodoc/attackby(obj/item/thing, mob/user, params)
	if(istype(thing, /obj/item/disk/autodoc))
		if(!proc_disk)
			if(!user.transferItemToLoc(thing, src))
				return
			proc_disk = thing
			to_chat(user, span_notice("You insert [thing] into [src]."))
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
			return
	else
		return ..()

//Remove procedure disk
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
	if(!is_operational)
		icon_state = "borgcharger-u[state_open ? 0 : 1]"
		return ..()
	icon_state = "borgcharger[state_open ? 0 : (operating ? 1 : 2)]"
	return ..()

//Right click to start operation. Machine needs to be closed, powered, with a patient, and a disk inserted. If machine is currently operating, attempt to shut down.
/obj/machinery/autodoc/attack_hand_secondary(mob/user, modifiers)
	var/mob/living/carbon/patient = occupant
	if(is_operational && !state_open)
		user.changeNext_move(CLICK_CD_MELEE)
		if(!patient)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: No valid patient found")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(!proc_disk)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: No procedure disk found")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(!ishuman(patient) || !patient.check_organic_parts()) //Don't accept non-sapient carbons, or robots.
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: Patient is not compatible.")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(!heal_tick() && !(proc_disk.heal_flags & DO_REVIVE && patient.stat == DEAD)) //Don't bother with people we can't heal.
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: Patient cannot be tended by current procedure.")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(proc_disk.uses < 1)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			say("ERROR: Procedure disk is out of uses.")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(operating)
			if(user == patient)
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

		else
			to_chat(user, span_notice("You start turning [src] on."))
			if(do_after(user, 20, target = src))
				if(operating)
					return
				operating = TRUE
				proc_disk.uses -= 1
				end_message = initial(end_message)
				end_sound = initial(end_sound)
				say("Commencing operation. Estimated time to completion: [get_operation_length()].")
				begin_processing()

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/autodoc/proc/get_operation_length()
	var/time
	var/mob/living/carbon/patient = occupant
	if(!post_procedure)
		heal_tick(0)
	time = (total_damage / heal_amount) * -10
	if(patient && patient.all_wounds)
		time += (30 * patient.all_wounds.len + 1)
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
		end_procedure()

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
			patient.radiation -= min(patient.radiation, heal_amount * (seconds_per_tick * 2) * -1)
		total_damage += patient.getToxLoss() + patient.radiation / 2
		. = TRUE

	if(proc_disk.heal_flags & DO_OXY && patient.getOxyLoss() > 0)
		if(operating)
			patient.adjustOxyLoss(heal_amount * seconds_per_tick)
		total_damage += patient.getOxyLoss()
		. = TRUE

	if(proc_disk.heal_flags & DO_CLONE && patient.getCloneLoss() > 0)
		if(operating)
			patient.adjustCloneLoss(heal_amount * seconds_per_tick)
		total_damage += patient.getCloneLoss()
		. = TRUE

	if(proc_disk.heal_flags & DO_ORGANS) //This should probably require a replacement organ, but this works for now. (Totally Not A Permanent Solution)
		var/highest_damage = 0
		for(var/thing in patient.internal_organs)
			var/obj/item/organ/target = thing
			if(target.organ_flags & ORGAN_SYNTHETIC || target.damage <= 1)
				continue
			if(target.damage > highest_damage)
				highest_damage = target.damage
			target.applyOrganDamage(heal_amount * seconds_per_tick)
			total_damage += highest_damage
			. = TRUE

/obj/machinery/autodoc/proc/attempt_revive() //Must be a separate proc because timer. Grrrr. My eyes turn red.
	var/mob/living/carbon/patient = occupant
	if(patient)
		playsound(src, 'sound/machines/defib_zap.ogg', 50, FALSE)
		if(patient.mind && patient.revive())
			patient.set_heartattack(FALSE)
			patient.emote("gasp")
			patient.set_timed_status_effect(200 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
			patient.adjustOxyLoss(30)
			patient.adjustStaminaLoss(40)
			SEND_SIGNAL(occupant, COMSIG_LIVING_MINOR_SHOCK)
			if (patient.health > HEALTH_THRESHOLD_FULLCRIT) //Call me when you can be awake and unconscious at the same time. This will always be true unless the patient has prosthetics.
				to_chat(patient, span_notice("<b>You suddenly jolt awake in the cold darkness of an Autodoc.</b> Innumerous small instruments surround you, attentively tending to your wounds."))
	if(operating)
		post_procedure(20, TRUE)

/obj/machinery/autodoc/proc/post_procedure(delay, revved)
	var/mob/living/carbon/patient = occupant
	end_processing()
	post_procedure = TRUE
	if(proc_disk.heal_flags & DO_WOUNDS)
		patient.remove_status_effect(STATUS_EFFECT_DETERMINED)
		for(var/datum/wound/current_wound in patient.all_wounds)
			current_wound.remove_wound()
			playsound(src, pick('sound/surgery/bone1.ogg','sound/surgery/bone2.ogg','sound/surgery/bone3.ogg'), 30, FALSE)
			if(patient.getOxyLoss() <= 50)
				patient.adjustOxyLoss(10)
			say("[current_wound] repaired.")
			addtimer(CALLBACK(src, PROC_REF(post_procedure)), 30)
			return
	if(patient && patient.stat == DEAD)
		if(proc_disk.heal_flags & DO_REVIVE && !revved)
			addtimer(CALLBACK(src, PROC_REF(attempt_revive)), 30)
			playsound(src, 'sound/machines/defib_charge.ogg', 50, FALSE)
			patient.notify_ghost_cloning("You're being revived in an autodoc!")
			patient.grab_ghost()

			return
		else if(revved)
			end_message = "Revival failed, stopping procedure. A voucher will be dispensed as compensation." //There is no voucher.
			end_sound = 'sound/machines/defib_failed.ogg'
	addtimer(CALLBACK(src, PROC_REF(end_procedure)), delay)

/obj/machinery/autodoc/proc/end_procedure()
	end_processing()
	operating = FALSE
	post_procedure = FALSE
	playsound(src, end_sound, 100)
	say("[end_message]")
	open_machine()

/obj/effect/spawner/structure/aaaaa
	name = "debug autodoc spawner"
	icon = 'icons/obj/salvage_structure.dmi'
	icon_state = "computer_broken"
	spawn_list = list(/obj/machinery/autodoc, /obj/item/disk/autodoc/test, /obj/item/melee/sledgehammer/gorlex, /obj/effect/mob_spawn/human/corpse, /obj/effect/mob_spawn/human/corpse/damaged)
