/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. While good for concealing your identity, it isn't good for blocking gas flow." //More accurate
	icon_state = "gas_alt"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_NORMAL
	item_state = "gas_alt"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH | PEPPERPROOF | SEALS_EYES
	resistance_flags = NONE
	supports_variations = KEPORI_VARIATION | SNOUTED_VARIATION | VOX_VARIATION

	equip_sound = 'sound/items/equip/armor_equip.ogg'
	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_MASK
	equip_delay_other = EQUIP_DELAY_MASK * 1.5
	strip_delay = EQUIP_DELAY_MASK * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

/obj/item/clothing/mask/gas/atmos
	name = "atmospheric gas mask"
	desc = "Improved gas mask utilized by atmospheric technicians. Still not very good at blocking gas flow, but it's flameproof!"
	icon_state = "gas_atmos"
	item_state = "gas_atmos"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 20, "acid" = 10)
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.001 //cargo cult time, this var does nothing but just in case someone actually makes it do something
	permeability_coefficient = 0.001
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/atmos/captain
	name = "captain's gas mask"
	desc = "Nanotrasen cut corners and repainted a spare atmospheric gas mask, but don't tell anyone."
	icon_state = "gas_cap"
	item_state = "gas_cap"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/mask/gas/atmos/centcom
	name = "\improper CentCom gas mask"
	desc = "Oooh, gold and green. Fancy! This should help as you sit in your office."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "gas_centcom"
	item_state = "gas_centcom"
	resistance_flags = FIRE_PROOF | ACID_PROOF

// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "welding mask"
	desc = "A gas mask with built-in welding goggles and a face shield. Looks like a skull - clearly designed by a nerd."
	icon_state = "weldingmask"
	flash_protect = FLASH_PROTECTION_WELDER
	custom_materials = list(/datum/material/iron=4000, /datum/material/glass=2000)
	tint = 2
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 55)
	actions_types = list(/datum/action/item_action/toggle)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = MASKCOVERSEYES
	visor_flags_inv = HIDEEYES
	visor_flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/mask/gas/welding/up

/obj/item/clothing/mask/gas/welding/up/Initialize()
	. = ..()
	visor_toggling()

// ********************************************************************

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "plague doctor mask"
	desc = "A modernised version of the classic design, this mask will not only filter out toxins but it can also be connected to an air supply."
	icon_state = "plaguedoctor"
	item_state = "gas_mask"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 2,"energy" = 2, "bomb" = 0, "bio" = 75, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/mask/gas/syndicate
	name = "syndicate mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "syndicate"
	strip_delay = 60
	supports_variations = SNOUTED_VARIATION | KEPORI_VARIATION | VOX_VARIATION

/obj/item/clothing/mask/gas/syndicate/voicechanger
	desc = "A close-fitting tactical mask that can be connected to an air supply. This one has an integrated voice changer."
	var/voice_change = 1

/obj/item/clothing/mask/gas/monkeymask
	name = "monkey mask"
	desc = "A mask used when acting as a monkey."
	clothing_flags = ALLOWINTERNALS
	icon_state = "monkeymask"
	item_state = "monkeymask"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop."
	icon_state = "death"
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/owl_mask
	name = "owl mask"
	desc = "Twoooo!"
	icon_state = "owl"
	clothing_flags = ALLOWINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/carp
	name = "carp mask"
	desc = "Gnash gnash."
	icon_state = "carp_mask"

/obj/item/clothing/mask/gas/tiki_mask
	name = "tiki mask"
	desc = "A creepy wooden mask. Surprisingly expressive for a poorly carved bit of wood."
	icon_state = "tiki_eyebrow"
	item_state = "tiki_eyebrow"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.25)
	resistance_flags = FLAMMABLE
	max_integrity = 100
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = null
	var/list/tikimask_designs = list()

/obj/item/clothing/mask/gas/tiki_mask/Initialize(mapload)
	.=..()
	tikimask_designs = list(
		"Original Tiki" = image(icon = src.icon, icon_state = "tiki_eyebrow"),
		"Happy Tiki" = image(icon = src.icon, icon_state = "tiki_happy"),
		"Confused Tiki" = image(icon = src.icon, icon_state = "tiki_confused"),
		"Angry Tiki" = image(icon = src.icon, icon_state = "tiki_angry")
		)

/obj/item/clothing/mask/gas/tiki_mask/ui_action_click(mob/user)
	var/mob/M = usr
	var/list/options = list()
	options["Original Tiki"] = "tiki_eyebrow"
	options["Happy Tiki"] = "tiki_happy"
	options["Confused Tiki"] = "tiki_confused"
	options["Angry Tiki"] ="tiki_angry"

	var/choice = show_radial_menu(user,src, tikimask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(M, span_notice("The Tiki Mask has now changed into the [choice] Mask!"))
		return 1

/obj/item/clothing/mask/gas/tiki_mask/yalp_elor
	icon_state = "tiki_yalp"
	actions_types = list()

/obj/item/clothing/mask/gas/hunter
	name = "bounty hunting mask"
	desc = "A custom tactical mask with decals added."
	icon_state = "hunter"
	item_state = "hunter"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR

/obj/item/clothing/mask/foggy
	desc = "wow. fov. so cool"

/obj/item/clothing/mask/foggy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_fov_visor, FOV_90_DEGREES)
