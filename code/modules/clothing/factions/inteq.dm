// Uniforms

/obj/item/clothing/under/syndicate/inteq
	name = "inteq turtleneck"
	desc = "A rich brown turtleneck with black pants, it has a small 'IRMG' embroidered onto the shoulder."
	icon = 'icons/obj/clothing/faction/inteq/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/uniforms.dmi'
	icon_state = "inteq"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	roll_sleeves = TRUE
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/clothing/under/syndicate/inteq/skirt
	name = "inteq skirtleneck"
	desc = "A rich brown turtleneck with a free flowing black skirt, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq_skirt"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/inteq/artificer
	name = "inteq artificer overalls"
	desc = "A black set of overalls atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/artificer/skirt
	name = "inteq artificer overall skirt"
	desc = "A black set of overalls in the likeness of a skirt atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/corpsman
	name = "inteq corpsman turtleneck"
	desc = "A sterile white turtleneck with tactical cargo pants, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/corpsman/skirt
	name = "inteq corpsman skirtleneck"
	desc = "A sterile white turtleneck with a free flowing black skirt, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/honorable
	name = "inteq midnight turtleneck"
	desc = "A midnight black turtleneck worn by command of the IRMG."
	icon_state = "inteq_honorable"
	item_state = "inteq_honorable"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/syndicate/inteq/sneaksuit
	name = "inteq sneaksuit"
	desc = "A tactical sneaksuit developed for usage in the IRMG's covert elements. Maximizes stealth by minimizing friction."
	icon_state = "inteq_sneak"
	item_state = "inteq_sneak"
	roll_sleeves = TRUE
	roll_down = TRUE

// Oversuits // can someone like. change the vanguard and maa armors to be subtypes of armor/inteq. please

/obj/item/clothing/suit/armor/hos/inteq
	name = "inteq battle coat"
	desc = "A luxurious brown coat made from a crossweave of kevlar and ballistic fibre, the collar and wrist trims are made from genuine wolf fur. As protective as it is stylish."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "armor_inteq_battlecoat"
	item_state = "inteq_battlecoat"
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/clothing/suit/armor/hos/inteq/honorable //Basically CC higherup clothing for inteq
	name = "honorable vanguard battlecoat"
	desc = "A sleek black coat with snow white fur trims made to order for honorable vanguards of the IRMG. It feels even tougher than the typical battlecoat."
	icon_state = "armor_inteq_honorable_battlecoat"
	item_state = "inteq_honorable_battlecoat"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/suit/armor/vest/security/warden/inteq
	name = "master at arms' armored coat"
	desc = "A brown armored coat with a bulletproof vest over it, usually worn by the Master At Arms of the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'
	icon_state = "maacoat"
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/suit/armor/inteq/corpsman
	name = "inteq corpsman vest"
	desc = "A shortened brown labcoat with an armor vest under it, for the IRMG's support division Corpsmen."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "armor_inteq_labcoat"
	item_state = "inteq_labcoat"
	supports_variations = VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

	allowed = list(
		/obj/item/analyzer,
		/obj/item/stack/medical,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/flashlight/pen,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/soap,
		/obj/item/sensor_device,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/ammo_box,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/hooded/wintercoat/security/inteq
	name = "inteq winter coat"
	desc = "An armored wintercoat in the colors of the IRMG, the zipper tab is the golden shield of the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "coatinteq"
	item_state = "coatinteq"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/inteq
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/clothing/head/hooded/winterhood/security/inteq
	icon_state = "hood_inteq"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt
	name = "inteq hooded coat"
	desc = "A hooded coat with a fur trim around the hood, comfy! It has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "coatinteq_alt"
	item_state = "coatinteq_alt"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/inteq/alt

/obj/item/clothing/head/hooded/winterhood/security/inteq/alt
	name = "inteq hood"
	desc = "A comfortable looking brown hood."
	icon_state = "hood_inteq_alt"
	item_state = "hood_inteq_alt"

/obj/item/clothing/suit/space/inteq
	name = "inteq space suit"
	desc = "A lightly armored space suit for IRMG personnel for EVA operations, it seems more flexible than most space suits."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	item_state = "space-inteq"
	icon_state = "space-inteq"
	slowdown = 0.8
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/head/helmet/space/inteq
	name = "inteq space helmet"
	desc = "A black space helmet with an opaque yellow visor, there is a small 'IRMG' written on the earpad."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	item_state = "space-inteq"
	icon_state = "space-inteq"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/head/helmet/space/hardsuit/security/inteq
	name = "inteq hardsuit helmet"
	desc = "A somewhat boxy, monocular visored helmet designed for hazardous, low pressure environments. It has the letters 'IRMG' imprinted onto the earpad."
	icon_state = "hardsuit0-inteq"
	item_state = "hardsuit-inteq"
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	hardsuit_type = "inteq"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/security/inteq
	name = "inteq hardsuit"
	desc = "A heavy-duty looking suit that protects against hazardous, low pressure environments. It's bulk provides ample protection, if not a bit cumbersome to wear."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "hardsuit-inteq"
	item_state = "hardsuit-inteq"
	hardsuit_type = "inteq"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/inteq
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/suit/space/hardsuit/bomb/inteq
	name = "Inteq EOD hardsuit"
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "hardsuit-inteqeod"
	hardsuit_type = "inteqeod"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/bomb/inteq

/obj/item/clothing/head/helmet/space/hardsuit/bomb/inteq
	name = "Inteq EOD hardsuit helmet"
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "hardsuit0-inteqeod"
	hardsuit_type = "inteqeod"

//Boulder Hardsuit
/obj/item/clothing/suit/space/hardsuit/security/inteq/boulder
	name = "Boulder hardsuit"
	desc = "An extreme EOD-suit modification created by a group of unsupervised IRMG artificers, a few nights, and far too much Vimukti. The ingenuity of the conversion, as well as relatively low production cost has lead it to adaptation by the IRMG. Extreme bulk guaranteed."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "hardsuit-boulder"
	hardsuit_type = "boulder"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/inteq/boulder
	slowdown = 1.5
	armor = list("melee" = 60, "bullet" = 70, "laser" = 50, "energy" = 40, "bomb" = 100, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 50)

/obj/item/clothing/head/helmet/space/hardsuit/security/inteq/boulder
	name = "Boulder hardsuit helmet"
	desc = "A modified EOD helmet, with extra plating and a more durable visor."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "hardsuit0-boulder"
	hardsuit_type = "boulder"
	armor = list("melee" = 60, "bullet" = 70, "laser" = 50, "energy" = 40, "bomb" = 100, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 50)

//Pointman Hardsuit
/obj/item/clothing/suit/space/hardsuit/syndi/inteq
	name = "pointman hardsuit"
	desc = "One of Inteq's sturdiest and finest combat armors. It is in EVA mode. Retrofitted by the IRMG."
	alt_desc = "One of Inteq's sturdiest and finest combat armors. It is in travel mode. Retrofitted by the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	icon_state = "hardsuit1-pointman"
	hardsuit_type = "pointman"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/inteq
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION


/obj/item/clothing/head/helmet/space/hardsuit/syndi/inteq
	name = "pointman hardsuit helmet"
	desc = "One of Inteq's sturdiest and finest combat armors. It is in EVA mode. Retrofitted by the IRMG."
	alt_desc = "One of Inteq's sturdiest and finest combat armors. It is in travel mode. Retrofitted by the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "hardsuit1-pointman"
	hardsuit_type = "pointman"
	full_retraction = TRUE
	supports_variations = VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/inteq
	name = "elite rampart hardsuit helmet"
	desc = "A unique edition of the infamous Gorlex elite hardsuit, customized from seized ICW-era caches. It is in EVA mode. Property of the IRMG."
	alt_desc = "A unique edition of the infamous Gorlex elite hardsuit, customized from seized ICW-era caches. It is in combat mode. Property of the IRMG."
	icon_state = "hardsuit0-rampart"
	hardsuit_type = "rampart"
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'

/obj/item/clothing/suit/space/hardsuit/syndi/elite/inteq
	name = "elite rampart hardsuit"
	desc = "A unique edition of the infamous Gorlex elite hardsuit, customized from seized ICW-era caches. It is in travel mode."
	alt_desc = "A unique edition of the infamous Gorlex elite hardsuit, customized from seized ICW-era caches. It is in combat mode."
	icon_state = "hardsuit0-rampart"
	item_state = "hardsuit0-rampart"
	hardsuit_type = "rampart"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/inteq
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	jetpack = null
	supports_variations = DIGITIGRADE_VARIATION


// pilot softsuit
/obj/item/clothing/suit/space/inteq/pilot
	name = "inteq pilot space suit"
	icon = 'icons/obj/clothing/faction/inteq/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/suits.dmi'
	item_state = "space-inteq-pilot"
	icon_state = "space-inteq-pilot"
	desc = "A rich brown, lightweight spacesuit made of a fire retardant material. While uncumbersome, it has poor protection against extreme temperatures of either end. Utilized by exosuit and shuttle pilots of the IRMG."
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 60, "fire" = 80, "acid" = 75, "wound" = 5)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | FAST_EMBARK
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	slowdown = 0.2

/obj/item/clothing/head/helmet/space/inteq/pilot
	name = "inteq pilot helmet"
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	lefthand_file = 'icons/mob/inhands/faction/inteq/inteq_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/inteq/inteq_righthand.dmi'
	item_state = "space-inteq-pilot"
	icon_state = "space-inteq-pilot0"
	desc = "A specialized space helmet with a large gold visor, designed to provide maximum visibility while protecting from glare. While protective against low pressure environments, it does little against extreme temperatures of either end. Utilized by exosuit and shuttle pilots of the IRMG."
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 60, "fire" = 80, "acid" = 75, "wound" = 5)
	visor_flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR|HIDEMASK
	visor_flags = STOPSPRESSUREDAMAGE | ALLOWINTERNALS | FLASH_PROTECTION_WELDER
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF

	up = FALSE
	actions_types = list(/datum/action/item_action/toggle_helmet)

/obj/item/clothing/head/helmet/space/inteq/pilot/update_icon_state()
	icon_state = "space-inteq-pilot[up]"
	return ..()

/obj/item/clothing/head/helmet/space/inteq/pilot/attack_self(mob/user) //toggle copied from indie pilot helm
	if(!isturf(user.loc))
		to_chat(user, span_warning("You cannot toggle your helmet while in this [user.loc]!") )
		return
	up = !up
	if(!up || force)
		to_chat(user, span_notice("You close your helmet's visor and breathing mask."))
		gas_transfer_coefficient = initial(gas_transfer_coefficient)
		permeability_coefficient = initial(permeability_coefficient)
		clothing_flags |= visor_flags
		flags_cover |= HEADCOVERSEYES | HEADCOVERSMOUTH
		flags_inv |= visor_flags_inv
		cold_protection |= HEAD
	else
		to_chat(user, span_notice("You open your helmet's visor and breathing mask."))
		gas_transfer_coefficient = null
		permeability_coefficient = null
		clothing_flags &= ~visor_flags
		flags_cover &= ~(HEADCOVERSEYES | HEADCOVERSMOUTH)
		flags_inv &= ~visor_flags_inv
		cold_protection &= ~HEAD
	update_appearance()
	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	user.update_inv_head()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.head_update(src, forced = 1)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

// Headgear

/obj/item/clothing/head/warden/inteq
	name = "master at arms' campaign hat"
	desc = "A special brown campaign hat with the IRMG insignia emblazoned on it. For yelling at clueless auxiliaries in style."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "maahat"
	supports_variations = VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

/obj/item/clothing/head/inteq_peaked // i dont like this path
	name = "inteq peaked cap"
	desc = "A peaked cap for Vanguards with a commanding authority, emblazoned with the golden badge of the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteq_peaked"
	item_state = "inteq_peaked"
	flags_inv = 0
	supports_variations = VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

/obj/item/clothing/head/soft/inteq
	name = "inteq utility cover"
	desc = "A rich brown utility cover with the golden shield of the IRMG on it."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteqsoft"
	unique_reskin = null
	dog_fashion = null
	supports_variations = VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

/obj/item/clothing/head/soft/inteq/corpsman
	name = "inteq corpsman utility cover"
	desc = "A sterile white utility cover with a green cross emblazoned on it. Worn by the IRMG's support division Corpsmen."
	icon_state = "inteqmedsoft"
	supports_variations = VOX_VARIATION
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/beret/sec/inteq
	name = "inteq beret"
	desc = "A comfortable looking brown beret with a badge of the golden shield of the IRMG. Denotes the wearer as part of the IRMG."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteq_beret"
	supports_variations = VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

/obj/item/clothing/head/beret/sec/hos/inteq
	name = "inteq vanguard beret"
	desc = "A comfortable looking brown beret with a badge of the golden shield of the IRMG. Denotes the wearer as a vanguard of the IRMG. The padding inside feels thicker."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteq_beret"
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/beret/sec/hos/inteq/honorable
	name = "honorable vanguard beret"
	desc = "A snow white beret with an air of distinction around it, emblazoned with the golden shield of the IRMG as the badge."
	icon_state = "inteq_honorable_beret"
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/bulletproof/x11/inteq
	name = "inteq X-11 helmet"
	desc = "A robust bulletproof helmet utilizing the Bezuts-made X-11 format. There is an insignia on the earpad with the letters 'IRMG' on it."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteq_x11helm"
	item_state = "inteq_swat"
	can_flashlight = TRUE
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	content_overlays = TRUE
	unique_reskin = null

/obj/item/clothing/head/helmet/m10/inteq
	name = "inteq M-10 helmet"
	desc = "A standard issue M-10 helmet in the colors of the IRMG. It doesn't feel special in any way."
	icon = 'icons/obj/clothing/faction/inteq/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/hats.dmi'
	icon_state = "inteq_m10helm"
	can_flashlight = TRUE
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'
	content_overlays = TRUE
	unique_reskin = null

// Gloves

/obj/item/clothing/gloves/color/latex/nitrile/inteq
	name = "green nitrile gloves"
	desc = "Thick sterile gloves that reach up to the wrists, colored in a pine green shade. Transfers combat medic knowledge into the user via nanochips."
	icon = 'icons/obj/clothing/faction/inteq/gloves.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/gloves.dmi'
	icon_state = "nitrile_inteq"

// Eyewear

/obj/item/clothing/glasses/hud/security/sunglasses/inteq
	name = "inteq ballistic HUD"
	desc = "A snazzy looking pair of ballistic goggles with an integrated security hud. The opaque visor provides flash protection."
	icon = 'icons/obj/clothing/faction/inteq/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/eyes.dmi'
	icon_state = "inteq_goggles"
	item_state = "inteq_goggles"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'
	glass_colour_type = /datum/client_colour/glass_colour/orange
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

// Mask

/obj/item/clothing/mask/gas/inteq
	name = "Inteq gas mask"
	desc = "A protective gas mask refit for Inteq's standards. It features a modified scratch resistant visor, ports for connecting an oxygen supply, and secure, comfortable straps."
	icon = 'icons/obj/clothing/faction/inteq/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/mask.dmi'
	icon_state = "inteq_gas_mask"
	item_state = "inteq_gas_mask"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/clothing/mask/balaclava/inteq
	name = "Inteq combat balaclava"
	desc = "A surprisingly advanced balaclava. While it doesn't muffle your voice, it has a mouthpiece for internals. Comfy to boot! This one is a variataion commonly used by the IRMG to protect it's members idenites."
	icon = 'icons/obj/clothing/faction/inteq/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/mask.dmi'
	icon_state = "inteq_balaclava"
	item_state = "inteq_balaclava"
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'


// Back

/obj/item/storage/backpack/messenger/inteq
	name = "inteq messenger bag"
	desc = "A comfortable leather strapped messenger bag worn over one shoulder. This one shows IRMG branding."
	icon = 'icons/obj/clothing/faction/inteq/back.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/back.dmi'
	icon_state = "courierbaginteq"
	item_state = "courierbaginteq"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

// Belt

/obj/item/storage/belt/security/webbing/inteq
	name = "inteq webbing"
	desc = "A set of tactical webbing for operators of the IRMG, can hold security gear."
	icon = 'icons/obj/clothing/faction/inteq/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/inteq/belt.dmi'
	icon_state = "inteq_webbing"
	item_state = "inteq_webbing"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/inteq/kepori.dmi'

/obj/item/storage/belt/security/webbing/inteq/skm/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/skm_762_40(src)

/obj/item/storage/belt/security/webbing/inteq/skm_carabine/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/smgm10mm(src)

/obj/item/storage/belt/security/webbing/inteq/alt
	name = "inteq drop pouch harness"
	desc = "A harness with a bunch of pouches attached to them emblazoned in the colors of the IRMG, can hold security gear."
	icon_state = "inteq_droppouch"
	item_state = "inteq_droppouch"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/inteq/vox.dmi'

/obj/item/storage/belt/security/webbing/inteq/alt/bulldog/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m12g_bulldog(src)
