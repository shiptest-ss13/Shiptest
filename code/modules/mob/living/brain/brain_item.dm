/obj/item/organ/brain
	name = "brain"
	desc = "A piece of juicy meat found in a person's head."
	icon_state = "brain"
	throw_speed = 3
	throw_range = 5
	layer = ABOVE_MOB_LAYER
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_BRAIN
	organ_flags = ORGAN_VITAL
	attack_verb = list("attacked", "slapped", "whacked")

	///The brain's organ variables are significantly more different than the other organs, with half the decay rate for balance reasons, and twice the maxHealth
	decay_factor = STANDARD_VITAL_ORGAN_DECAY

	maxHealth = BRAIN_DAMAGE_DEATH
	low_threshold = 45
	high_threshold = 120

	var/mob/living/brain/brainmob = null
	var/decoy_override = FALSE	//if it's a fake brain with no brainmob assigned. Feedback messages will be faked as if it does have a brainmob. See changelings & dullahans.
	//two variables necessary for calculating whether we get a brain trauma or not
	var/damage_delta = 0


	var/list/datum/brain_trauma/traumas = list()

/obj/item/organ/brain/Insert(mob/living/carbon/C, special = 0,no_id_transfer = FALSE)
	..()

	name = "brain"

	if(C.mind && C.mind.has_antag_datum(/datum/antagonist/changeling) && !no_id_transfer)	//congrats, you're trapped in a body you don't control
		if(brainmob && !(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_DEATHCOMA))))
			to_chat(brainmob, "<span class= danger>You can't feel your body! You're still just a brain!</span>")
		forceMove(C)
		C.update_hair()
		return

	if(brainmob)
		if(C.key)
			C.ghostize()

		if(brainmob.mind)
			brainmob.mind.transfer_to(C)
		else
			C.key = brainmob.key

		QDEL_NULL(brainmob)

	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		BT.owner = owner
		BT.on_gain()

	//Update the body's icon so it doesnt appear debrained anymore
	C.update_hair()

/obj/item/organ/brain/Remove(mob/living/carbon/C, special = 0, no_id_transfer = FALSE)
	if(!special)		//WS Begin - Borers
		if(C.has_brain_worms())
			var/mob/living/simple_animal/borer/B = C.has_brain_worms()
			if(B.controlling)
				B.victim.release_control()
				to_chat(B, span_userdanger("Your probiscis is ripped out as your host's brain is removed!"))
				B.apply_damage(15)
			B.leave_victim()		//WS End
	..()
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		BT.on_lose(TRUE)
		BT.owner = null

	if((!gc_destroyed || (owner && !owner.gc_destroyed)) && !no_id_transfer)
		transfer_identity(C)
	C.update_hair()

/obj/item/organ/brain/proc/transfer_identity(mob/living/L)
	name = "[L.name]'s brain"
	if(brainmob || decoy_override)
		return
	if(!L.mind)
		return
	brainmob = new(src)
	brainmob.name = L.real_name
	brainmob.real_name = L.real_name
	brainmob.timeofhostdeath = L.timeofdeath
	if(L.has_dna())
		var/mob/living/carbon/C = L
		if(!brainmob.stored_dna)
			brainmob.stored_dna = new /datum/dna/stored(brainmob)
		C.dna.copy_dna(brainmob.stored_dna)
		if(HAS_TRAIT(L, TRAIT_BADDNA))
			LAZYSET(brainmob.status_traits, TRAIT_BADDNA, L.status_traits[TRAIT_BADDNA])
	if(L.mind && L.mind.current)
		L.mind.transfer_to(brainmob)
	to_chat(brainmob, span_notice("You feel slightly disoriented. That's normal when you're just a brain."))

/obj/item/organ/brain/attackby(obj/item/O, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)

	if(istype(O, /obj/item/organ_storage))
		return //Borg organ bags shouldn't be killing brains

	if((organ_flags & ORGAN_FAILING) && O.is_drainable() && O.reagents.has_reagent(/datum/reagent/medicine/mannitol)) //attempt to heal the brain
		. = TRUE //don't do attack animation.
		if(brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else we can do for it!"))
			return

		if(!O.reagents.has_reagent(/datum/reagent/medicine/mannitol, 10))
			to_chat(user, span_warning("There's not enough mannitol in [O] to restore [src]!"))
			return

		user.visible_message(span_notice("[user] starts to pour the contents of [O] onto [src]."), span_notice("You start to slowly pour the contents of [O] onto [src]."))
		if(!do_after(user, 60, src))
			to_chat(user, span_warning("You failed to pour [O] onto [src]!"))
			return

		user.visible_message(span_notice("[user] pours the contents of [O] onto [src], causing it to reform its original shape and turn a slightly brighter shade of pink."), span_notice("You pour the contents of [O] onto [src], causing it to reform its original shape and turn a slightly brighter shade of pink."))
		var/healby = O.reagents.get_reagent_amount(/datum/reagent/medicine/mannitol)
		setOrganDamage(damage - healby*2)	//heals 2 damage per unit of mannitol, and by using "setorgandamage", we clear the failing variable if that was up
		O.reagents.clear_reagents()
		return

	if(brainmob) //if we aren't trying to heal the brain, pass the attack onto the brainmob.
		O.attack(brainmob, user) //Oh noooeeeee

	if(O.force != 0 && !(O.item_flags & NOBLUDGEON))
		setOrganDamage(maxHealth) //fails the brain as the brain was attacked, they're pretty fragile.
		visible_message(span_danger("[user] hits [src] with [O]!"))
		to_chat(user, span_danger("You hit [src] with [O]!"))

/obj/item/organ/brain/examine(mob/user)
	. = ..()
	if((brainmob && (brainmob.client || brainmob.get_ghost())) || decoy_override)
		if(organ_flags & ORGAN_FAILING)
			. += span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to restore it with some <b>mannitol</b>.")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			. += span_info("You can feel the small spark of life still left in this one, but it's got some bruises. You may be able to restore it with some <b>mannitol</b>.")
		else
			. += span_info("You can feel the small spark of life still left in this one.")
	else
		. += span_info("This one is completely devoid of life.")

/obj/item/organ/brain/attack(mob/living/carbon/C, mob/user)
	if(!istype(C))
		return ..()

	add_fingerprint(user)

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/target_has_brain = C.getorgan(/obj/item/organ/brain)

	if(!target_has_brain && C.is_eyes_covered())
		to_chat(user, span_warning("You're going to need to remove [C.p_their()] head cover first!"))
		return

//since these people will be dead M != usr

	if(!target_has_brain)
		if(!C.get_bodypart(BODY_ZONE_HEAD) || !user.temporarilyRemoveItemFromInventory(src))
			return
		var/msg = "[C] has [src] inserted into [C.p_their()] head by [user]."
		if(C == user)
			msg = "[user] inserts [src] into [user.p_their()] head!"

		C.visible_message(span_danger("[msg]"),
						span_userdanger("[msg]"))

		if(C != user)
			to_chat(C, span_notice("[user] inserts [src] into your head."))
			to_chat(user, span_notice("You insert [src] into [C]'s head."))
		else
			to_chat(user, span_notice("You insert [src] into your head.")	)

		Insert(C)
	else
		..()

/obj/item/organ/brain/Destroy() //copypasted from MMIs.
	if(brainmob)
		QDEL_NULL(brainmob)
	QDEL_LIST(traumas)

	if(owner?.mind) //You aren't allowed to return to brains that don't exist
		owner.mind.set_current(null)
	return ..()

/obj/item/organ/brain/on_life()
	if(damage >= BRAIN_DAMAGE_DEATH) //rip
		to_chat(owner, span_userdanger("The last spark of life in your brain fizzles out..."))
		owner.death()

/obj/item/organ/brain/check_damage_thresholds(mob/M)
	. = ..()
	//if we're not more injured than before, return without gambling for a trauma
	if(damage <= prev_damage)
		return
	damage_delta = damage - prev_damage
	if(damage > BRAIN_DAMAGE_MILD)
		if(prob(damage_delta * (1 + max(0, (damage - BRAIN_DAMAGE_MILD)/100)))) //Base chance is the hit damage; for every point of damage past the threshold the chance is increased by 1% //learn how to do your bloody math properly goddamnit
			gain_trauma_type(BRAIN_TRAUMA_MILD, natural_gain = TRUE)

	var/is_boosted = (owner && HAS_TRAIT(owner, TRAIT_SPECIAL_TRAUMA_BOOST))
	if(damage > BRAIN_DAMAGE_SEVERE)
		if(prob(damage_delta * (1 + max(0, (damage - BRAIN_DAMAGE_SEVERE)/100)))) //Base chance is the hit damage; for every point of damage past the threshold the chance is increased by 1%
			if(prob(20 + (is_boosted * 30)))
				gain_trauma_type(BRAIN_TRAUMA_SPECIAL, is_boosted ? TRAUMA_RESILIENCE_SURGERY : null, natural_gain = TRUE)
			else
				gain_trauma_type(BRAIN_TRAUMA_SEVERE, natural_gain = TRUE)

	if (owner)
		if(owner.stat < UNCONSCIOUS) //conscious or soft-crit
			var/brain_message
			if(prev_damage < BRAIN_DAMAGE_MILD && damage >= BRAIN_DAMAGE_MILD)
				brain_message = span_warning("You feel lightheaded.")
			else if(prev_damage < BRAIN_DAMAGE_SEVERE && damage >= BRAIN_DAMAGE_SEVERE)
				brain_message = span_warning("You feel less in control of your thoughts.")
			else if(prev_damage < (BRAIN_DAMAGE_DEATH - 20) && damage >= (BRAIN_DAMAGE_DEATH - 20))
				brain_message = span_warning("You can feel your mind flickering on and off...")

			if(.)
				. += "\n[brain_message]"
			else
				return brain_message

/obj/item/organ/brain/alien
	name = "alien brain"
	desc = "We barely understand the brains of terrestial animals. Who knows what we may find in the brain of such an advanced species?"
	icon_state = "brain-x"

/obj/item/organ/brain/mmi_holder //MMI brain for IPC
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	remove_on_qdel = FALSE
	var/mmi_type = /obj/item/mmi/ipc
	var/obj/item/mmi/stored_mmi

/obj/item/organ/brain/mmi_holder/Initialize(mapload, obj/item/mmi/M)
	. = ..()
	if(M && istype(M))
		stored_mmi = M
		M.forceMove(src)
	else
		stored_mmi = new mmi_type(src)

/obj/item/organ/brain/mmi_holder/Destroy()
	QDEL_NULL(stored_mmi)
	return ..()

/obj/item/organ/brain/mmi_holder/Insert(mob/living/carbon/C, special = 0, no_id_transfer = FALSE)
	if(special)
		return ..()
	if(!stored_mmi)
		qdel(src)
		return
	brainmob = stored_mmi.brainmob
	return ..()

/obj/item/organ/brain/mmi_holder/Remove(mob/living/user, special = 0)
	if(special)
		return ..()
	if(!stored_mmi)
		. = ..()
		qdel(src)
		return
	stored_mmi.forceMove(get_turf(owner)) // so we can get the turf of the owner
	..()
	stored_mmi = null
	qdel(src)

/obj/item/organ/brain/mmi_holder/transfer_identity(mob/living/L)
	. = ..()
	brainmob.loc = null
	brainmob.forceMove(stored_mmi) //moves the brainmob to the stored mmi
	stored_mmi.set_brainmob(brainmob) //sets the mmi's brainmob to the current one
	brainmob.container = stored_mmi
	stored_mmi.brain = L // for the mmi icon
	stored_mmi.name = "\improper Man-Machine Interface: [L.real_name]"
	stored_mmi.icon_state = "mmi_brain" //renames mmi and switches it to the right icon
	stored_mmi.update_overlays()
	brainmob.set_stat(CONSCIOUS) //mmis are conscious
	brainmob.remove_from_dead_mob_list()
	brainmob.add_to_alive_mob_list() //mmis are technically alive I guess?
	stored_mmi.update_appearance() //update it because the brain is alive now
	brainmob.reset_perspective() //resets perspective to the mmi
	brainmob = null //clears the brainmob var so it doesn't get deleted when the holder is destroyed

/obj/item/organ/brain/mmi_holder/posibrain
	name = "positronic brain"
	mmi_type = /obj/item/mmi/posibrain/ipc

/obj/item/organ/brain/mmi_holder/posibrain/transfer_identity(mob/living/L)
	..()
	stored_mmi.brain = null //can't remove this one
	stored_mmi.name = "positronic brain ([L.real_name])"
	stored_mmi.icon_state = "posibrain-occupied" //switches it to the "activated" icon

////////////////////////////////////TRAUMAS////////////////////////////////////////

/obj/item/organ/brain/proc/has_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (BT.resilience <= resilience))
			return BT

/obj/item/organ/brain/proc/get_traumas_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	. = list()
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (BT.resilience <= resilience))
			. += BT

/obj/item/organ/brain/proc/can_gain_trauma(datum/brain_trauma/trauma, resilience, natural_gain = FALSE)
	if(!ispath(trauma))
		trauma = trauma.type
	if(!initial(trauma.can_gain))
		return FALSE
	if(!resilience)
		resilience = initial(trauma.resilience)

	var/resilience_tier_count = 0
	for(var/X in traumas)
		if(istype(X, trauma))
			return FALSE
		var/datum/brain_trauma/T = X
		if(resilience == T.resilience)
			resilience_tier_count++

	var/max_traumas
	switch(resilience)
		if(TRAUMA_RESILIENCE_BASIC)
			max_traumas = TRAUMA_LIMIT_BASIC
		if(TRAUMA_RESILIENCE_SURGERY)
			max_traumas = TRAUMA_LIMIT_SURGERY
		if(TRAUMA_RESILIENCE_WOUND)
			max_traumas = TRAUMA_LIMIT_WOUND
		if(TRAUMA_RESILIENCE_LOBOTOMY)
			max_traumas = TRAUMA_LIMIT_LOBOTOMY
		if(TRAUMA_RESILIENCE_MAGIC)
			max_traumas = TRAUMA_LIMIT_MAGIC
		if(TRAUMA_RESILIENCE_ABSOLUTE)
			max_traumas = TRAUMA_LIMIT_ABSOLUTE

	if(natural_gain && resilience_tier_count >= max_traumas)
		return FALSE
	return TRUE

//Proc to use when directly adding a trauma to the brain, so extra args can be given
/obj/item/organ/brain/proc/gain_trauma(datum/brain_trauma/trauma, resilience, natural_gain = FALSE, ...)
	var/list/arguments = list()
	if(args.len > 3)
		arguments = args.Copy(4)
	. = brain_gain_trauma(trauma, resilience, natural_gain, arguments)

//Direct trauma gaining proc. Necessary to assign a trauma to its brain. Avoid using directly.
/obj/item/organ/brain/proc/brain_gain_trauma(datum/brain_trauma/trauma, resilience, list/arguments, natural_gain = FALSE)
	if(!can_gain_trauma(trauma, resilience))
		return

	var/datum/brain_trauma/actual_trauma
	if(ispath(trauma))
		if(!LAZYLEN(arguments))
			actual_trauma = new trauma() //arglist with an empty list runtimes for some reason
		else
			actual_trauma = new trauma(arglist(arguments))
	else
		actual_trauma = trauma

	if(actual_trauma.brain) //we don't accept used traumas here
		WARNING("gain_trauma was given an already active trauma.")
		return

	traumas += actual_trauma
	actual_trauma.brain = src
	if(owner)
		actual_trauma.owner = owner
		actual_trauma.on_gain()
	if(natural_gain)
		if(actual_trauma.resilience >= TRAUMA_RESILIENCE_LOBOTOMY)
			actual_trauma.resilience = TRAUMA_RESILIENCE_SURGERY
	else if(resilience)
		actual_trauma.resilience = resilience
	. = actual_trauma
	if(owner?.client)
		SSblackbox.record_feedback("tally", "traumas", 1, actual_trauma.type)

//Add a random trauma of a certain subtype
/obj/item/organ/brain/proc/gain_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience, natural_gain = FALSE)
	var/list/datum/brain_trauma/possible_traumas = list()
	for(var/T in subtypesof(brain_trauma_type))
		var/datum/brain_trauma/BT = T
		if(can_gain_trauma(BT, resilience, natural_gain) && initial(BT.random_gain))
			possible_traumas += BT

	if(!LAZYLEN(possible_traumas))
		return

	var/trauma_type = pick(possible_traumas)
	return gain_trauma(trauma_type, resilience, natural_gain)
//Cure a random trauma of a certain resilience level
/obj/item/organ/brain/proc/cure_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_BASIC)
	var/list/traumas = get_traumas_type(brain_trauma_type, resilience)
	if(LAZYLEN(traumas))
		qdel(pick(traumas))

/obj/item/organ/brain/proc/cure_all_traumas(resilience = TRAUMA_RESILIENCE_BASIC)
	var/amount_cured = 0
	var/list/traumas = get_traumas_type(resilience = resilience)
	for(var/X in traumas)
		qdel(X)
		amount_cured++
	return amount_cured
