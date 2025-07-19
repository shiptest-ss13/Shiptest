/* reagents that primarily interface with organ damage.
** Things like oculine, incausiate
*/


/datum/reagent/medicine/oculine
	name = "Oculine"
	description = "Quickly restores eye damage, cures nearsightedness, and has a chance to restore vision to the blind."
	reagent_state = LIQUID
	color = "#404040" //oculine is dark grey, inacusiate is light grey
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "dull toxin"

/datum/reagent/medicine/oculine/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	eyes.applyOrganDamage(-2)
	if(HAS_TRAIT_FROM(M, TRAIT_BLIND, EYE_DAMAGE))
		if(prob(20))
			to_chat(M, span_warning("Your vision slowly returns..."))
			M.cure_blind(EYE_DAMAGE)
			M.cure_nearsighted(EYE_DAMAGE)
			M.blur_eyes(35)

	else if(HAS_TRAIT_FROM(M, TRAIT_NEARSIGHT, EYE_DAMAGE))
		to_chat(M, span_warning("The blackness in your peripheral vision fades."))
		M.cure_nearsighted(EYE_DAMAGE)
		M.blur_eyes(10)
	else if(M.eye_blind || M.eye_blurry)
		M.set_blindness(0)
		M.set_blurriness(0)
	..()

/datum/reagent/medicine/inacusiate
	name = "Inacusiate"
	description = "Rapidly restores hearing to a patient, assuming the loss of hearing is not chronic."
	color = "#606060" // ditto

/datum/reagent/medicine/inacusiate/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/ears/ears = M.get_organ_slot(ORGAN_SLOT_EARS)
	if(!ears)
		return
	ears.adjustEarDamage(-4 * REM * seconds_per_tick, -4 * REM * seconds_per_tick)
	return ..()
