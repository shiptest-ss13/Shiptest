/datum/mutation/human/dorfism
	name = "Dwarfism"
	desc = "A mutation only present in true dwarves."
	quality = POSITIVE
	difficulty = 16
	instability = 0
	conflicts = list(GIGANTISM, DWARFISM)
	locked = TRUE    // Default intert species for now, so locked from regular pool.

/datum/mutation/human/dorfism/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner] suddenly shrinks!"), span_notice("Everything around you seems to grow.."))

/datum/mutation/human/dorfism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner] suddenly grows!"), span_notice("Everything around you seems to shrink.."))
