/obj/item/clothing/head/safety_helmet
	name = "safety helmet"
	desc = "A yellow hard hat used in dangerous work settings to protect the head from falling items and errant swinging toolboxes."
	icon_state = "hardhat_standard"
	item_state = "hardhat_standard"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = 0
	clothing_flags = SNUG_FIT
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat_yellow"
	item_state = "hardhat_yellow"
	light_color = "#FFCC66"
	var/power_on = 0.8
	var/brightness_on = 4 //luminosity when on
	var/on = FALSE
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 10, "rad" = 20, "fire" = 100, "acid" = 50)
	flags_inv = 0
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	clothing_flags = SNUG_FIT
	resistance_flags = FIRE_PROOF
	dynamic_hair_suffix = "+generic"

	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/head/hardhat/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/hardhat/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/hardhat/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/head/hardhat/update_icon_state()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		item_state = "[initial(icon_state)]-on"
	else
		icon_state = "[initial(icon_state)]"
		item_state = "[initial(icon_state)]"

/obj/item/clothing/head/hardhat/proc/turn_on(mob/user)
	set_light(brightness_on, power_on)

/obj/item/clothing/head/hardhat/proc/turn_off(mob/user)
	set_light(0)

/obj/item/clothing/head/hardhat/orange
	icon_state = "hardhat_orange"
	item_state = "hardhat_orange"
	dog_fashion = null

/obj/item/clothing/head/hardhat/red
	name = "firefighter helmet"
	icon_state = "hardhat_red"
	item_state = "hardhat_red"
	dog_fashion = null
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/hardhat/red/upgraded
	name = "workplace-ready firefighter helmet"
	desc = "By applying state of the art lighting technology to a fire helmet, and using photo-chemical hardening methods, this hardhat will protect you from robust workplace hazards."
	icon_state = "hardhat_purple"
	item_state = "hardhat_purple"
	brightness_on = 5
	resistance_flags = FIRE_PROOF | ACID_PROOF
	custom_materials = list(/datum/material/iron = 4000, /datum/material/glass = 1000, /datum/material/plastic = 3000, /datum/material/silver = 500)

/obj/item/clothing/head/hardhat/white
	icon_state = "hardhat_white"
	item_state = "hardhat_white"
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/head/hardhat/green
	icon_state = "hardhat_green"
	item_state = "hardhat_green"
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/head/hardhat/dblue
	icon_state = "hardhat_dblue"
	item_state = "hardhat_dblue"
	dog_fashion = null

/obj/item/clothing/head/hardhat/atmos
	icon_state = "hardhat_atmos"
	item_state = "hardhat_atmos"
	dog_fashion = null
	name = "atmospheric technician's firefighting helmet"
	desc = "A firefighter's helmet, able to keep the user cool in any situation."
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/hardhat/mining
	name = "mining helmet"
	desc = "A yellow hard hat used in dangerous mining settings to protect the head from falling rocks and from natives who had advanced in the areas of toolbox swinging technology."
	icon_state = "hardhat_mining"
	item_state = "hardhat_mining"
	dog_fashion = null

	armor = list("melee" = 15, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/head/hardhat/weldhat
	name = "welding hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight AND welding shield! The bulb seems a little smaller though."
	brightness_on = 3 //Needs a little bit of tradeoff
	dog_fashion = null
	actions_types = list(/datum/action/item_action/toggle_helmet_light, /datum/action/item_action/toggle_welding_screen)
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	flags_inv = HIDEEYES | HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	visor_flags_inv = HIDEEYES | HIDEFACE
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/hardhat/weldhat/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/head/hardhat/weldhat/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/hardhat/weldhat/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		toggle_welding_screen(user)

/obj/item/clothing/head/hardhat/weldhat/proc/toggle_welding_screen(mob/living/user)
	if(weldingvisortoggle(user))
		playsound(src, 'sound/mecha/mechmove03.ogg', 50, TRUE) //Visors don't just come from nothing
	update_icon()

/obj/item/clothing/head/hardhat/weldhat/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		. += mutable_appearance('icons/mob/clothing/head.dmi', "hardhat-weldhelmet")
		if(!up)
			. += mutable_appearance('icons/mob/clothing/head.dmi', "hardhat-weldvisor")

/obj/item/clothing/head/hardhat/weldhat/update_overlays()
	. = ..()
	if(!up)
		. += "hardhat-weldvisor"

/obj/item/clothing/head/hardhat/weldhat/orange
	icon_state = "hardhat_orange"
	item_state = "hardhat_orange"

/obj/item/clothing/head/hardhat/weldhat/white
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight AND welding shield!" //This bulb is not smaller
	icon_state = "hardhat_white"
	item_state = "hardhat_white"
	brightness_on = 4 //Boss always takes the best stuff
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/hardhat/weldhat/dblue
	icon_state = "hardhat_dblue"
	item_state = "hardhat_dblue"

