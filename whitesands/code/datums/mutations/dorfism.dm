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
	owner.transform = owner.transform.Scale(1, 0.8)
	owner.visible_message("<span class='danger'>[owner] suddenly shrinks!</span>", "<span class='notice'>Everything around you seems to grow..</span>")

/datum/mutation/human/dorfism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.transform = owner.transform.Scale(1, 1.25)
	owner.visible_message("<span class='danger'>[owner] suddenly grows!</span>", "<span class='notice'>Everything around you seems to shrink..</span>")
