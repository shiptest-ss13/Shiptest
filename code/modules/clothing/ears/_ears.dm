
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


/obj/item/clothing/ears/headlamp
	name = "headlamp"
	desc = "A flashlight that fits on your head. Very convenient. Sometimes"
	icon = 'icons/obj/clothing/headlamp.dmi'
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	icon_state = "headlamp"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_color = COLOR_LIGHT_ORANGE
	light_range = 4
	light_power = 0.8
	light_on = FALSE

	pickup_sound = 'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'

	var/on = FALSE
	var/toggle_on_sound = 'sound/items/flashlight_on.ogg'
	var/toggle_off_sound = 'sound/items/flashlight_off.ogg'

/obj/item/clothing/ears/headlamp/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/ears/headlamp/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/ears/headlamp/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(toggle_helmet_light(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/ears/headlamp/attackby_secondary(mob/user, params)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(toggle_helmet_light(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/ears/headlamp/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(toggle_helmet_light(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/ears/headlamp/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_appearance()
	return TRUE //necessary for SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN to run properly

/obj/item/clothing/ears/headlamp/update_icon_state()
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/clothing/ears/headlamp/proc/turn_on(mob/user)
	set_light_on(TRUE)

/obj/item/clothing/ears/headlamp/proc/turn_off(mob/user)
	set_light_on(FALSE)
