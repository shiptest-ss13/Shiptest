// **** Security gas mask ****

/obj/item/clothing/mask/gas/sechailer
	name = "security gas mask"
	desc = "A standard issue Security gas mask. It doesn't cover the eyes."
	actions_types = list(/datum/action/item_action/adjust)
	icon_state = "sechailer"
	item_state = "sechailer"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDEFACE
	w_class = WEIGHT_CLASS_SMALL
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF

/obj/item/clothing/mask/gas/sechailer/swat
	name = "\improper SWAT mask"
	desc = "A close-fitting tactical mask with an especially aggressive Compli-o-nator 3000."
	icon_state = "swat"
	item_state = "swat"
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDEHAIR
	visor_flags_inv = 0

/obj/item/clothing/mask/gas/sechailer/swat/spacepol
	name = "spacepol mask"
	desc = "A close-fitting tactical mask created in cooperation with a certain megacorporation, comes with an especially aggressive Compli-o-nator 3000."
	icon_state = "spacepol"
	item_state = "spacepol"

/obj/item/clothing/mask/gas/sechailer/cyborg
	name = "security hailer"
	desc = "A set of recognizable pre-recorded messages for cyborgs to use when apprehending criminals."
	icon = 'icons/obj/device.dmi'
	icon_state = "taperecorder_idle"
	mob_overlay_state = "sechailer"

/obj/item/clothing/mask/gas/sechailer/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/adjust))
		adjustmask(user)

/obj/item/clothing/mask/whistle
	name = "police whistle"
	desc = "A police whistle for when you need to make sure the criminals hear you."
	icon_state = "whistle"
	item_state = "whistle"
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_NECK
	custom_price = 150
	var/blown_sound = 'sound/misc/whistle.ogg'
	actions_types = list(/datum/action/item_action/halt)
	COOLDOWN_DECLARE(whistle_cooldown)

/datum/action/item_action/halt
	name = "Blow on the whistle!"

/obj/item/clothing/mask/whistle/ui_action_click(mob/user, action)
	if(!COOLDOWN_FINISHED(src, whistle_cooldown))
		return
	user.audible_message("<font color='red' size='2'><b>[user] blows on the [src]!</b></font>")
	playsound(src, blown_sound, 80, FALSE, 4)
	COOLDOWN_START(src, whistle_cooldown, 5 SECONDS)

/obj/item/clothing/mask/whistle/trench
	name = "trench whistle"
	desc = "A long and unusual looking whistle that makes a distinctive sound. Useful for charging into fortified positions with low chances of survival."
	icon_state = "whistle"
	item_state = "whistle"
	blown_sound = 'sound/misc/trenchwhistle.ogg'

/obj/item/clothing/mask/gas/sechailer/balaclava
	name = "combat balaclava"
	desc = "A surprisingly advanced balaclava. while it doesn't muffle your voice it has a miniature rebreather for internals. Comfy to boot!"
	icon_state = "combat_balaclava"
	item_state = "combat_balaclava"
	strip_delay = 60
	alternate_worn_layer = BODY_LAYER
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEARS|HIDEHAIR
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION

/obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	desc = "A surprisingly advanced balaclava. while it doesn't muffle your voice it has a miniature rebreather for internals. Comfy to boot! This one is a variataion commonly used by the IRMG to protect it's members idenites."
	icon_state = "inteq_balaclava"
	item_state = "inteq_balaclava"
