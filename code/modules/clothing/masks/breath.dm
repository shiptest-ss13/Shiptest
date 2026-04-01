/obj/item/clothing/mask/breath
	desc = "A close-fitting mask that can be connected to an air supply."
	name = "breath mask"
	icon_state = "breath"
	item_state = "m_mask"
	body_parts_covered = 0
	clothing_flags = ALLOWINTERNALS //WS Port - Cit Internals
	supports_variations = SNOUTED_VARIATION | KEPORI_VARIATION | VOX_VARIATION
	visor_flags = ALLOWINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.1
	permeability_coefficient = 0.5
	actions_types = list(/datum/action/item_action/adjust)
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

	equip_sound = 'sound/items/equip/straps_equip.ogg'
	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_MASK
	equip_delay_other = EQUIP_DELAY_MASK * 1.5
	strip_delay = EQUIP_DELAY_MASK * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

/obj/item/clothing/mask/breath/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/breath/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		adjustmask(user)

/obj/item/clothing/mask/breath/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to adjust it.")

/obj/item/clothing/mask/breath/medical
	desc = "A close-fitting sterile mask that can be connected to an air supply."
	name = "medical mask"
	icon_state = "medical"
	item_state = "m_mask"
	permeability_coefficient = 0.01
	equip_delay_other = 10
	supports_variations = SNOUTED_VARIATION | KEPORI_VARIATION | VOX_VARIATION

/obj/item/clothing/mask/breath/facemask
	name = "face mask"
	desc = "A face mask that covers the nose, mouth and neck of those who wear it. It can be connected to an air supply."
	icon_state = "facemask"
	item_state = "facemask"
	mob_overlay_icon = 'icons/mob/clothing/mask.dmi'
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION | KEPORI_VARIATION
	alternate_worn_layer = BELT_LAYER
