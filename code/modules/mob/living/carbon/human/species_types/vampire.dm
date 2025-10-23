/datum/species/vampire
	name = "\improper Vampire"
	id = SPECIES_VAMPIRE
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,DRINKSBLOOD)
	inherent_traits = list(TRAIT_NOHUNGER,TRAIT_NOBREATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	default_features = list("mcolor" = "FFF", "tail_human" = "None", "ears" = "None", "wings" = "None")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	examine_limb_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
	var/info_text = "You are a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates

/datum/species/vampire/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	. = ..()
	to_chat(C, "[info_text]")
	C.skin_tone = "albino"
	C.update_body(0)
	if(isnull(batform))
		batform = new
		C.AddSpell(batform)

/datum/species/vampire/on_species_loss(mob/living/carbon/C)
	. = ..()
	if(!isnull(batform))
		C.RemoveSpell(batform)
		QDEL_NULL(batform)

/datum/species/vampire/spec_life(mob/living/carbon/human/C)
	. = ..()
	if(istype(C.loc, /obj/structure/closet/crate/coffin))
		C.heal_overall_damage(4,4,0, BODYTYPE_ORGANIC)
		C.adjustToxLoss(-4)
		C.adjustOxyLoss(-4)
		C.adjustCloneLoss(-4)
		return
	C.blood_volume -= 0.25
	if(C.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(C, span_danger("You ran out of blood!"))
		var/obj/shapeshift_holder/H = locate() in C
		if(H)
			H.shape.dust() //make sure we're killing the bat if you are out of blood, if you don't it creates weird situations where the bat is alive but the caster is dusted.
		C.dust()
	var/area/A = get_area(C)
	if(istype(A, /area/ship/crew/chapel))
		to_chat(C, span_warning("You don't belong here!"))
		C.adjustFireLoss(20)
		C.adjust_fire_stacks(6)
		C.IgniteMob()

/obj/item/organ/tongue/vampire
	name = "vampire tongue"
	actions_types = list(/datum/action/item_action/organ_action/vampire)
	color = "#1C1C1C"
	var/drain_cooldown = 0

#define VAMP_DRAIN_AMOUNT 50

/datum/action/item_action/organ_action/vampire
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."

/datum/action/item_action/organ_action/vampire/Trigger()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		var/obj/item/organ/tongue/vampire/V = target
		if(V.drain_cooldown >= world.time)
			to_chat(H, span_warning("You just drained blood, wait a few seconds!"))
			return
		if(H.pulling && iscarbon(H.pulling))
			var/mob/living/carbon/victim = H.pulling
			if(H.blood_volume >= BLOOD_VOLUME_MAXIMUM)
				to_chat(H, span_warning("You're already full!"))
				return
			if(victim.stat == DEAD)
				to_chat(H, span_warning("You need a living victim!"))
				return
			if(!victim.blood_volume || (victim.dna && ((NOBLOOD in victim.dna.species.species_traits) || victim.dna.species.exotic_blood)))
				to_chat(H, span_warning("[victim] doesn't have blood!"))
				return
			V.drain_cooldown = world.time + 30
			if(victim.anti_magic_check(FALSE, TRUE, FALSE, 0))
				to_chat(victim, span_warning("[H] tries to bite you, but stops before touching you!"))
				to_chat(H, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
				return
			if(victim?.reagents?.has_reagent(/datum/reagent/consumable/garlic))
				to_chat(victim, span_warning("[H] tries to bite you, but recoils in disgust!"))
				to_chat(H, span_warning("[victim] reeks of garlic! you can't bring yourself to drain such tainted blood."))
				return
			if(!do_after(H, 30, target = victim))
				return
			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - H.blood_volume //How much capacity we have left to absorb blood
			var/drained_blood = min(victim.blood_volume, VAMP_DRAIN_AMOUNT, blood_volume_difference)
			to_chat(victim, span_danger("[H] is draining your blood!"))
			to_chat(H, span_notice("You drain some blood!"))
			playsound(H, 'sound/items/drink.ogg', 30, TRUE, -2)
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			H.blood_volume = clamp(H.blood_volume + drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			if(!victim.blood_volume)
				to_chat(H, span_notice("You finish off [victim]'s blood supply."))

#undef VAMP_DRAIN_AMOUNT


/mob/living/carbon/get_status_tab_items()
	. = ..()
	var/obj/item/organ/heart/vampire/darkheart = getorgan(/obj/item/organ/heart/vampire)
	if(darkheart)
		. += span_notice("Current blood level: [blood_volume]/[BLOOD_VOLUME_MAXIMUM].")


/obj/item/organ/heart/vampire
	name = "vampire heart"
	color = "#1C1C1C"


/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape a space bat."
	invocation = "Squeak!"
	charge_max = 50
	cooldown_min = 50
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat

/obj/item/organ/internal/heart/vampire/Insert(mob/living/carbon/receiver, special, drop_if_replaced)
	. = ..()
	RegisterSignal(receiver, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

/obj/item/organ/internal/heart/vampire/Remove(mob/living/carbon/heartless, special)
	. = ..()
	UnregisterSignal(heartless, COMSIG_MOB_GET_STATUS_TAB_ITEMS)

/obj/item/organ/internal/heart/vampire/proc/get_status_tab_item(mob/living/carbon/source, list/items)
	SIGNAL_HANDLER
	items += "Blood Level: [source.blood_volume]/[BLOOD_VOLUME_MAXIMUM]"
