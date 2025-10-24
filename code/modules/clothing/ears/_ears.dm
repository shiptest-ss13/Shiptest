
//Ears: currently only used for headsets and earmuffs
/obj/item/clothing/ears
	name = "ears"
	lefthand_file = 'icons/mob/inhands/clothing/ears_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/ears_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = ITEM_SLOT_EARS
	resistance_flags = NONE

	supports_variations = VOX_VARIATION

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	strip_delay = 15
	equip_delay_other = 25
	resistance_flags = FLAMMABLE
	custom_price = 250
	alternate_worn_layer = UNDER_HEAD_LAYER
	actions_types = list(/datum/action/item_action/adjust_earmuffs)
	var/adjusted = TRUE //whether we're wearing it "properly" around our ears
	var/ear_protection = 3

/obj/item/clothing/ears/earmuffs/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS), ear_protection)

/obj/item/clothing/ears/earmuffs/attack_self(mob/user)
	. = ..()
	adjust(user)

/obj/item/clothing/ears/earmuffs/proc/adjust(mob/living/user)
	if(user && user.incapacitated())
		return
	var/datum/component/wearertargeting/earprotection/ear_prot = GetComponent(/datum/component/wearertargeting/earprotection)
	adjusted = !adjusted
	if(adjusted)
		src.icon_state = initial(icon_state)
		to_chat(user, span_notice("You push \the [src] back into place."))
		slot_flags = initial(slot_flags)
		ear_prot.protection_amount = ear_protection
	else
		icon_state += "_down"
		to_chat(user, span_notice("You push \the [src] out of the way."))
		ear_prot.protection_amount = 0
	user.update_inv_ears()
	adjust_hearing(user)

/obj/item/clothing/ears/earmuffs/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && slot == ITEM_SLOT_EARS && adjusted)
		ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)

/obj/item/clothing/ears/earmuffs/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)

/obj/item/clothing/ears/earmuffs/proc/adjust_hearing(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/our_guy = user
		if(our_guy.ears == src)
			if(adjusted)
				ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
			else
				REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)

