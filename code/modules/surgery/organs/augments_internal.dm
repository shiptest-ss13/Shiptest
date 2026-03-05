
/obj/item/organ/cyberimp
	name = "cybernetic implant"
	desc = "A state-of-the-art implant that improves a baseline's functionality."
	icon = 'icons/obj/implants/implant.dmi'
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	var/implant_color = "#FFFFFF"
	var/implant_overlay
	var/syndicate_implant = FALSE //Makes the implant invisible to health analyzers and medical HUDs.

/obj/item/organ/cyberimp/New(mob/M = null)
	if(iscarbon(M))
		src.Insert(M)
	if(implant_overlay)
		var/mutable_appearance/overlay = mutable_appearance(icon, implant_overlay)
		overlay.color = implant_color
		add_overlay(overlay)
	return ..()

//[[[[BRAIN]]]]

/obj/item/organ/cyberimp/brain
	name = "cybernetic brain implant"
	desc = "Injectors of extra sub-routines for the brain."
	icon_state = "brain_implant"
	implant_overlay = "brain_implant_overlay"
	zone = BODY_ZONE_HEAD
	w_class = WEIGHT_CLASS_TINY

/obj/item/organ/cyberimp/brain/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	var/stun_amount = 200/severity
	owner.Stun(stun_amount)
	to_chat(owner, span_warning("Your body seizes up!"))


/obj/item/organ/cyberimp/brain/anti_drop
	name = "anti-drop implant"
	desc = "This cybernetic brain implant will allow you to force your hand muscles to contract, preventing item dropping. Twitch ear to toggle."
	var/active = 0
	var/list/stored_items = list()
	implant_color = "#DE7E00"
	slot = ORGAN_SLOT_BRAIN_ANTIDROP
	actions_types = list(/datum/action/item_action/organ_action/toggle)

/obj/item/organ/cyberimp/brain/anti_drop/ui_action_click()
	active = !active
	if(active)
		for(var/obj/item/I in owner.held_items)
			stored_items += I

		var/list/L = owner.get_empty_held_indexes()
		if(LAZYLEN(L) == owner.held_items.len)
			to_chat(owner, span_notice("You are not holding any items, your hands relax..."))
			active = 0
			stored_items = list()
		else
			for(var/obj/item/I in stored_items)
				to_chat(owner, span_notice("Your [owner.get_held_index_name(owner.get_held_index_of_item(I))]'s grip tightens."))
				ADD_TRAIT(I, TRAIT_NODROP, ANTI_DROP_IMPLANT_TRAIT)

	else
		release_items()
		to_chat(owner, span_notice("Your hands relax..."))


/obj/item/organ/cyberimp/brain/anti_drop/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	var/range = severity ? 10 : 5
	var/atom/A
	if(active)
		release_items()
	for(var/obj/item/I in stored_items)
		A = pick(oview(range))
		I.throw_at(A, range, 2)
		to_chat(owner, span_warning("Your [owner.get_held_index_name(owner.get_held_index_of_item(I))] spasms and throws the [I.name]!"))
	stored_items = list()


/obj/item/organ/cyberimp/brain/anti_drop/proc/release_items()
	for(var/obj/item/I in stored_items)
		REMOVE_TRAIT(I, TRAIT_NODROP, ANTI_DROP_IMPLANT_TRAIT)
	stored_items = list()


/obj/item/organ/cyberimp/brain/anti_drop/Remove(mob/living/carbon/M, special = 0)
	if(active)
		ui_action_click()
	..()

/obj/item/organ/cyberimp/brain/anti_stun
	name = "CNS Rebooter implant"
	desc = "This implant will automatically give you back control over your central nervous system, reducing downtime when stunned."
	implant_color = "#FFFF00"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN

	var/static/list/signalCache = list(
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_IMMOBILIZE,
		COMSIG_LIVING_STATUS_PARALYZE,
	)

	var/stun_cap_amount = 40

/obj/item/organ/cyberimp/brain/anti_stun/Remove(mob/living/carbon/M, special = FALSE)
	. = ..()
	UnregisterSignal(M, signalCache)

/obj/item/organ/cyberimp/brain/anti_stun/Insert()
	. = ..()
	RegisterSignal(owner, signalCache, PROC_REF(on_signal))

/obj/item/organ/cyberimp/brain/anti_stun/proc/on_signal(datum/source, amount)
	if(!(organ_flags & ORGAN_FAILING) && amount > 0)
		addtimer(CALLBACK(src, PROC_REF(clear_stuns)), stun_cap_amount, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/item/organ/cyberimp/brain/anti_stun/proc/clear_stuns()
	if(owner || !(organ_flags & ORGAN_FAILING))
		owner.SetStun(0)
		owner.SetKnockdown(0)
		owner.SetImmobilized(0)
		owner.SetParalyzed(0)

/obj/item/organ/cyberimp/brain/anti_stun/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	ADD_TRAIT(src, TRAIT_ORGAN_FAILING, EMP_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(reboot)), 90 / severity)

/obj/item/organ/cyberimp/brain/anti_stun/proc/reboot()
	REMOVE_TRAIT(src, TRAIT_ORGAN_FAILING, EMP_TRAIT)

/obj/item/organ/cyberimp/brain/joywire
	name = "\improper Midi-Sed pleasure vivifier"
	desc = "A widely popular (and addictive) implant produced by Miditeke-Sedari Tokoce that stimulates the brain's pleasure centers. Dramatically increases mood, but interferes with taste reception even if uninstalled."
	implant_color = "#FFABE0"
	slot = ORGAN_SLOT_BRAIN_JOYWIRE

/obj/item/organ/cyberimp/brain/joywire/on_life()
	if(owner || !(organ_flags & ORGAN_FAILING))
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "joywire", /datum/mood_event/joywire)
		ADD_TRAIT(owner, TRAIT_AGEUSIA, TRAIT_GENERIC)

/obj/item/organ/cyberimp/brain/joywire/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	ADD_TRAIT(src, TRAIT_ORGAN_FAILING, DAMAGE_TRAIT)
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "joywire")
	SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "joywire_emp", /datum/mood_event/joywire_emp)
	to_chat(owner, span_boldwarning("That feeling of dream-like, distilled joy is suddenly diluted. Misery sets in..."))

/obj/item/organ/cyberimp/brain/mindscrew
	name = "\improper Midi-Sed MNDFCK implant"
	desc = "A horrific after-market modification of Midi-Sed's pleasure vivifier that stimulates intense pain in the brain. Dramatically hurts a user's mood and mental state, and lingers for a time after removal."
	implant_color = "#5E1108"
	slot = ORGAN_SLOT_BRAIN_JOYWIRE

/obj/item/organ/cyberimp/brain/mindscrew/on_life()
	if(owner || !(organ_flags & ORGAN_FAILING))
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "mindscrew", /datum/mood_event/mindscrew)

/obj/item/organ/cyberimp/brain/datachip
	name = "Nanotrasen brain datachip"
	desc = "Covered in serial codes and warnings. That data must be important."

/obj/item/organ/cyberimp/brain/datachip/Insert()
	. = ..()
	to_chat(owner, span_notice("you feel well versed in the sales of donkpockets and other Donk Co. products"))

//[[[[MOUTH]]]]
/obj/item/organ/cyberimp/mouth
	zone = BODY_ZONE_PRECISE_MOUTH

/obj/item/organ/cyberimp/mouth/breathing_tube
	name = "breathing tube implant"
	desc = "This simple implant adds an internals connector to your back, allowing you to use internals without a mask and protecting you from being choked."
	icon_state = "implant_mask"
	slot = ORGAN_SLOT_BREATHING_TUBE
	w_class = WEIGHT_CLASS_TINY

/obj/item/organ/cyberimp/mouth/breathing_tube/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	if(prob(60/severity))
		to_chat(owner, span_warning("Your breathing tube suddenly closes!"))
		owner.losebreath += 2

//BOX O' IMPLANTS

/obj/item/storage/box/cyber_implants
	name = "boxed cybernetic implants"
	desc = "A sleek, sturdy box."
	icon_state = "cyber_implants"
	var/list/boxed = list(
		/obj/item/autosurgeon/syndicate/thermal_eyes,
		/obj/item/autosurgeon/syndicate/xray_eyes,
		/obj/item/autosurgeon/syndicate/anti_stun,
		/obj/item/autosurgeon/syndicate/reviver)
	var/amount = 5

/obj/item/storage/box/cyber_implants/PopulateContents()
	var/implant
	while(contents.len <= amount)
		implant = pick(boxed)
		new implant(src)
