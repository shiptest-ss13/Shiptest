/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		trapper
 *		Pumpkin head
 *		Kitty ears
 *		Cardborg disguise
 *		Wig
 *		Bronze hat
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	item_state = "welding"
	custom_materials = list(/datum/material/iron=1750, /datum/material/glass=400)
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 60)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	resistance_flags = FIRE_PROOF
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/*
 * Trapper Hat
 */
/obj/item/clothing/head/trapper
	name = "trapper hat"
	desc = "Perfect for the cold weather."
	icon_state = "ushankadown"
	item_state = "ushankadown"
	flags_inv = HIDEEARS|HIDEHAIR
	var/earflaps = 1
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

	dog_fashion = /datum/dog_fashion/head/trapper

/obj/item/clothing/head/trapper/attack_self(mob/user)
	if(earflaps)
		src.icon_state = "ushankaup"
		src.item_state = "ushankaup"
		earflaps = 0
		to_chat(user, "<span class='notice'>You raise the ear flaps on the trapper.</span>")
	else
		src.icon_state = "ushankadown"
		src.item_state = "ushankadown"
		earflaps = 1
		to_chat(user, "<span class='notice'>You lower the ear flaps on the trapper.</span>")

/*
 * Pumpkin head
 */
/obj/item/clothing/head/hardhat/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat_pumpkin"
	item_state = "hardhat_pumpkin"

	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	light_range = 2 //luminosity when on
	flags_cover = HEADCOVERSEYES
	light_color = "#fff2bf"

/obj/item/clothing/head/hardhat/pumpkinhead/blumpkin
	name = "carved blumpkin"
	desc = "A very blue jack o' lantern! Believed to ward off vengeful chemists."
	icon_state = "hardhat_blumpkin"
	item_state = "hardhat_blumpkin"
	light_color = "#76ff8e"

/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	color = "#999999"

	dog_fashion = /datum/dog_fashion/head/kitty

/obj/item/clothing/head/kitty/visual_equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && slot == ITEM_SLOT_HEAD)
		update_icon(ALL, user)
		user.update_inv_head() //Color might have been changed by update_icon.
	..()

/obj/item/clothing/head/kitty/update_icon(updates=ALL, mob/living/carbon/human/user)
	. = ..()
	if(ishuman(user))
		add_atom_colour("#[user.hair_color]", FIXED_COLOUR_PRIORITY)

/obj/item/clothing/head/cardborg
	name = "cardborg helmet"
	desc = "A helmet made out of a box."
	icon_state = "cardborg_h"
	item_state = "cardborg_h"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

	dog_fashion = /datum/dog_fashion/head/cardborg

/obj/item/clothing/head/cardborg/equipped(mob/living/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_HEAD)
		var/mob/living/carbon/human/H = user
		if(istype(H.wear_suit, /obj/item/clothing/suit/cardborg))
			var/obj/item/clothing/suit/cardborg/CB = H.wear_suit
			CB.disguise(user, src)

/obj/item/clothing/head/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")

/obj/item/clothing/head/wig
	name = "wig"
	desc = "A bunch of hair without a head attached."
	icon = 'icons/mob/human_face.dmi'	  // default icon for all hairs
	icon_state = "hair_vlong"
	item_state = "pwig"
	flags_inv = HIDEHAIR
	color = "#000000"
	var/hairstyle = "Very Long Hair"
	var/adjustablecolor = TRUE //can color be changed manually?

/obj/item/clothing/head/wig/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/head/wig/update_icon_state()
	var/datum/sprite_accessory/S = GLOB.hairstyles_list[hairstyle]
	if(!S)
		icon = 'icons/obj/clothing/hats.dmi'
		icon_state = "pwig"
	else
		icon = S.icon
		icon_state = S.icon_state
	return ..()

/obj/item/clothing/head/wig/worn_overlays(isinhands = FALSE, file2use)
	. = ..()
	if(!isinhands)
		var/datum/sprite_accessory/S = GLOB.hairstyles_list[hairstyle]
		if(!S)
			return
		var/mutable_appearance/M = mutable_appearance(S.icon, S.icon_state,layer = -HAIR_LAYER)
		M.appearance_flags |= RESET_COLOR
		M.color = color
		. += M

/obj/item/clothing/head/wig/attack_self(mob/user)
	var/new_style = input(user, "Select a hairstyle", "Wig Styling")  as null|anything in (GLOB.hairstyles_list - "Bald")
	var/newcolor = adjustablecolor ? input(usr,"","Choose Color",color) as color|null : null
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(new_style && new_style != hairstyle)
		hairstyle = new_style
		user.visible_message("<span class='notice'>[user] changes \the [src]'s hairstyle to [new_style].</span>", "<span class='notice'>You change \the [src]'s hairstyle to [new_style].</span>")
	if(newcolor && newcolor != color) // only update if necessary
		add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	update_appearance()

/obj/item/clothing/head/wig/afterattack(mob/living/carbon/human/target, mob/user)
	. = ..()
	if (istype(target) && (HAIR in target.dna.species.species_traits) && target.hairstyle != "Bald")
		to_chat(user, "<span class='notice'>You adjust the [src] to look just like [target.name]'s [target.hairstyle].</span>")
		add_atom_colour("#[target.hair_color]", FIXED_COLOUR_PRIORITY)
		hairstyle = target.hairstyle
		update_appearance()

/obj/item/clothing/head/wig/random/Initialize(mapload)
	hairstyle = pick(GLOB.hairstyles_list - "Bald") //Don't want invisible wig
	add_atom_colour("#[random_color_natural()]", FIXED_COLOUR_PRIORITY)
	. = ..()

/obj/item/clothing/head/wig/natural
	name = "natural wig"
	desc = "A bunch of hair without a head attached. This one changes color to match the hair of the wearer. Nothing natural about that."
	color = "#FFFFFF"
	adjustablecolor = FALSE
	custom_price = 100

/obj/item/clothing/head/wig/natural/Initialize(mapload)
	hairstyle = pick(GLOB.hairstyles_list - "Bald")
	. = ..()

/obj/item/clothing/head/wig/natural/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(ishuman(user) && slot == ITEM_SLOT_HEAD)
		if (color != "#[user.hair_color]") // only update if necessary
			add_atom_colour("#[user.hair_color]", FIXED_COLOUR_PRIORITY)
			update_appearance()
		user.update_inv_head()

/obj/item/clothing/head/bronze
	name = "bronze hat"
	desc = "A crude helmet made out of bronze plates. It offers very little in the way of protection."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_helmet_old"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list("melee" = 5, "bullet" = 0, "laser" = -5, "energy" = -15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 20)

/obj/item/clothing/head/plastic_flower
	name = "plastic flower"
	desc = "A realistic imitation of a flower. Not edible though."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "poppy"
	body_parts_covered = null
	unique_reskin = list(
		"Poppy" = "poppy",
		"Sunflower" = "sunflower",
		"Moonflower" = "moonflower",
		"Novaflower" = "novaflower",
		"Harebell" = "harebell",
		"Geranium" = "geranium",
		"Lily" = "lily"
		)
	custom_materials = (list(/datum/material/plastic = 1000))

