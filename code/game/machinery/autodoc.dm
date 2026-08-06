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
-Consider adding organ/rad/blood treatment? Maybe on an advanced variant for event use.
-Create procedure disk vendor, work out pricing. Bonus points if you can pay extra for more uses. Idk how to do that with regular vendor UI.
-Map changes
-Voucher system (low priority. Would be funny.)
-Sound stuff
*/

#define DO_BRUTE (1<<0) // 000001 = 1 in binary
#define DO_BURN (1<<1) // 000010 = 2 in binary
#define DO_TOX (1<<2) // 000100 = 4 in binary
#define DO_OXY (1<<3) // 001000 = 8 in binary
#define DO_CLONE (1<<4) // 010000 = 16 in binary
#define DO_REVIVE (1<<5) // 100000 = 32 in binary

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
	///Message once operation has ended.
	var/end_message = "Operation concluded."
	///Changes depending on outcome.
	var/end_sound = 'sound/machines/defib_success.ogg'
	///Health threshold at which machine will attempt revival of patient.
	var/revive_threshold = HEALTH_THRESHOLD_FULLCRIT
	///Stops us from attempting revival more than once, in case the initial revival goes wrong somehow.
	var/revival_attempted = FALSE
	///This also needs to be here I guess.
	var/attempting_revive = FALSE
	///Amount healed per second
	var/heal_amount = -4
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
	heal_flags = DO_BRUTE | DO_BURN | DO_TOX | DO_OXY | DO_CLONE | DO_REVIVE //collect my flags
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
	if(heal_flags & DO_REVIVE)
		flag_list += span_boldnotice("Resuscitation")
	return jointext(flag_list, span_notice(", "))

/obj/item/disk/autodoc/examine()
	. = ..()
	if(heal_flags)
		. += span_notice("The following procedures are stored on the disk: [get_heal_flags_string()]")

/obj/machinery/autodoc/examine(mob/user)
	. = ..()
	var/mob/living/carbon/patient = occupant
	if(proc_disk)
		if(!operating)
			. += span_notice("Alt-click to eject [icon2html(proc_disk, user)] [proc_disk].")
		else if(proc_disk.heal_flags)
			. += span_notice("[src] is currently operating with settings: [proc_disk.get_heal_flags_string()]")
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

//Remove procedure disk
/obj/machinery/autodoc/AltClick(mob/living/carbon/user)
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

		if(!heal_tick() && !(proc_disk.heal_flags & DO_REVIVE && !patient.stat == DEAD)) //Don't bother with people we can't heal.
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
				end_procedure()
				end_message = "Manual stop engaged. Operation concluded."
				end_sound = 'sound/machines/defib_success.ogg'

		else
			to_chat(user, span_notice("You start turning [src] on."))
			heal_tick()
			if(do_after(user, 20, target = src))
				operating = TRUE
				proc_disk.uses -= 1
				end_message = "Operation concluded."
				end_sound = 'sound/machines/defib_success.ogg'
				say("Commencing operation. Estimated time to completion: [get_operation_length()].")
				begin_processing()

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/autodoc/proc/get_operation_length()
	var/time
	time = (total_damage / heal_amount) * -1 + SSmachines.wait
	if(round(time) > 60)
		time = time / 60
		if(round(time) <= 1)
			return "[round(time)] minute"
		return "[round(time)] minutes"
	else
		if(round(time) <= 1)
			return "[round(time)] second"
		return "[round(time)] seconds"

//Runs through our healing flags and acts accordingly. Kills the process if we have nothing to do.
/obj/machinery/autodoc/process(seconds_per_tick)
	var/mob/living/carbon/patient = occupant
	if(!is_operational || !occupant || !operating)
		return PROCESS_KILL

	if(patient.stat == DEAD) //To-do: Add a check for ckey.
		if(proc_disk.heal_flags & DO_REVIVE && !revival_attempted && patient.get_organic_health() > revive_threshold) //get_organic_health() Used here as we can't heal prosthetics and will get in a loop otherwise.
			attempting_revive = TRUE
			revival_attempted = TRUE
			addtimer(CALLBACK(src, PROC_REF(attempt_revive)), 30)
			playsound(src, 'sound/machines/defib_charge.ogg', 50, FALSE)
			patient.notify_ghost_cloning("You're being revived in an autodoc!")
			patient.grab_ghost()

		else if(!attempting_revive && revival_attempted)
			end_message = "Revival failed, stopping procedure. A voucher will be dispensed as compensation." //There is no voucher.
			end_sound = 'sound/machines/defib_failed.ogg'
			end_procedure()
			return

	if(heal_tick(seconds_per_tick))
		playsound(src, 'sound/surgery/retractor2.ogg', 50, FALSE)

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
		total_damage += patient.getFireLoss(BODYTYPE_ORGANIC)
		. = TRUE

	if(proc_disk.heal_flags & DO_TOX && patient.getToxLoss() > 0)
		if(operating)
			patient.adjustToxLoss(heal_amount * seconds_per_tick)
		total_damage += patient.getToxLoss()
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

/obj/machinery/autodoc/proc/attempt_revive() //Must be a separate proc because timer. Grrrr. My eyes turn red.
	var/mob/living/carbon/patient = occupant
	attempting_revive = FALSE
	if(!patient)
		return FALSE
	playsound(src, 'sound/machines/defib_zap.ogg', 50, FALSE)
	if(!patient.mind)
		return FALSE
	patient.set_heartattack(FALSE)
	patient.revive(full_heal = FALSE, admin_revive = FALSE)
	patient.emote("gasp")
	patient.set_timed_status_effect(200 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	SEND_SIGNAL(occupant, COMSIG_LIVING_MINOR_SHOCK)
	if (patient.health > HEALTH_THRESHOLD_FULLCRIT) //Call me when you can be awake and unconscious at the same time. This will always be true unless the patient has prosthetics.
		to_chat(patient, span_notice("<b>You suddenly jolt awake in the cold darkness of an Autodoc.</b> Innumerous small instruments surround you, attentively tending to your wounds."))

/obj/machinery/autodoc/proc/end_procedure()
	end_processing()
	operating = FALSE
	playsound(src, end_sound, 100)
	say("[end_message]")
	revival_attempted = FALSE
	open_machine()

/obj/effect/spawner/structure/aaaaa
	name = "debug autodoc spawner"
	icon = 'icons/obj/salvage_structure.dmi'
	icon_state = "computer_broken"
	spawn_list = list(/obj/machinery/autodoc, /obj/item/disk/autodoc/test, /obj/item/melee/sledgehammer/gorlex)
