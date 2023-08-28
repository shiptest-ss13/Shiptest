/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	item_state = "helmet"
	var/flashlight_state = "helmet_flight_overlay"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

	dog_fashion = /datum/dog_fashion/head/helmet

	var/can_flashlight = FALSE //if a flashlight can be mounted. if it has a flashlight and this is false, it is permanently attached.
	var/obj/item/flashlight/seclite/attached_light
	var/datum/action/item_action/toggle_helmet_flashlight/action_light

/obj/item/clothing/head/helmet/Initialize()
	. = ..()
	if(attached_light)
		action_light = new(src)


/obj/item/clothing/head/helmet/Destroy()
	var/obj/item/flashlight/seclite/old_light = set_attached_light(null)
	if(old_light)
		qdel(old_light)
	return ..()


/obj/item/clothing/head/helmet/examine(mob/user)
	. = ..()
	if(attached_light)
		. += "It has \a [attached_light] [can_flashlight ? "" : "permanently "]mounted on it."
		if(can_flashlight)
			. += "<span class='info'>[attached_light] looks like it can be <b>unscrewed</b> from [src].</span>"
	else if(can_flashlight)
		. += "It has a mounting point for a <b>seclite</b>."


/obj/item/clothing/head/helmet/handle_atom_del(atom/A)
	if(A == attached_light)
		set_attached_light(null)
		update_helmlight()
		update_appearance()
		QDEL_NULL(action_light)
		qdel(A)
	return ..()


///Called when attached_light value changes.
/obj/item/clothing/head/helmet/proc/set_attached_light(obj/item/flashlight/seclite/new_attached_light)
	if(attached_light == new_attached_light)
		return
	. = attached_light
	attached_light = new_attached_light
	if(attached_light)
		attached_light.set_light_flags(attached_light.light_flags | LIGHT_ATTACHED)
		if(attached_light.loc != src)
			attached_light.forceMove(src)
	else if(.)
		var/obj/item/flashlight/seclite/old_attached_light = .
		old_attached_light.set_light_flags(old_attached_light.light_flags & ~LIGHT_ATTACHED)
		if(old_attached_light.loc == src)
			old_attached_light.forceMove(get_turf(src))

/obj/item/clothing/head/helmet/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "<span class='notice'>[up ? alt_toggle_message : toggle_message] \the [src].</span>")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

//LightToggle

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/ui_action_click(mob/user, action)
	if(istype(action, action_light))
		toggle_helmlight()
	else
		..()

/obj/item/clothing/head/helmet/attackby(obj/item/tool, mob/user, params)
	if(istype(tool, /obj/item/flashlight/seclite))
		var/obj/item/flashlight/seclite/attaching_seclite = tool
		if(can_flashlight && !attached_light)
			if(!user.transferItemToLoc(attaching_seclite, src))
				return
			to_chat(user, "<span class='notice'>You click [attaching_seclite] into place on [src].</span>")
			set_attached_light(attaching_seclite)
			update_appearance()
			update_helmlight()
			action_light = new(src)
			if(loc == user)
				action_light.Grant(user)
		return
	return ..()

/obj/item/clothing/head/helmet/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(can_flashlight && attached_light) //if it has a light but can_flashlight is false, the light is permanently attached.
		tool.play_tool_sound(src)
		to_chat(user, "<span class='notice'>You unscrew [attached_light] from [src].</span>")
		attached_light.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(attached_light)

		var/obj/item/flashlight/removed_light = set_attached_light(null)
		update_helmlight()
		removed_light.update_brightness(user)
		update_appearance()
		user.update_inv_head()
		QDEL_NULL(action_light)
		return TRUE

/obj/item/clothing/head/helmet/proc/toggle_helmlight()
	set name = "Toggle Helmet light"
	set category = "Object"
	set desc = "Click to toggle your helmet's attached flashlight."

	if(!attached_light)
		return

	var/mob/user = usr
	if(user.incapacitated())
		return
	attached_light.on = !attached_light.on
	attached_light.update_brightness()
	to_chat(user, "<span class='notice'>You toggle the helmet light [attached_light.on ? "on":"off"].</span>")

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_helmlight()

/obj/item/clothing/head/helmet/proc/update_helmlight()
	if(attached_light)
		update_appearance()

	for(var/datum/action/action as anything in actions)
		action.UpdateButtonIcon()

/obj/item/clothing/head/helmet/update_overlays()
	. = ..()
	var/mutable_appearance/flashlightlight_overlay
	if(!attached_light)
		return
	if(attached_light.on)
		flashlightlight_overlay = mutable_appearance(icon, "[flashlight_state]_on")
	else
		flashlightlight_overlay = mutable_appearance(icon, flashlight_state)
	. += flashlightlight_overlay

/obj/item/clothing/head/helmet/worn_overlays(isinhands)
	. = ..()
	var/mutable_appearance/flashlightlight_overlay
	if(isinhands)
		return
	if(!attached_light)
		return
	if(attached_light.on)
		flashlightlight_overlay = mutable_appearance('icons/mob/clothing/head.dmi', "[flashlight_state]_on")
	else
		flashlightlight_overlay = mutable_appearance('icons/mob/clothing/head.dmi', flashlight_state)
	. += flashlightlight_overlay

/obj/item/clothing/head/helmet/sec
	can_flashlight = TRUE

/obj/item/clothing/head/helmet/sec/attackby(obj/item/I, mob/user, params)
	if(issignaler(I))
		var/obj/item/assembly/signaler/S = I
		if(attached_light) //Has a flashlight. Player must remove it, else it will be lost forever.
			to_chat(user, "<span class='warning'>The mounted flashlight is in the way, remove it first!</span>")
			return

		if(S.secured)
			qdel(S)
			var/obj/item/bot_assembly/secbot/A = new
			user.put_in_hands(A)
			to_chat(user, "<span class='notice'>You add the signaler to the helmet.</span>")
			qdel(src)
			return
	return ..()

/obj/item/clothing/head/helmet/bulletproof
	name = "bulletproof helmet"
	desc = "A bulletproof combat helmet that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "helmetalt"
	item_state = "helmetalt"
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	can_flashlight = TRUE
	dog_fashion = null
	allow_post_reskins = TRUE
	unique_reskin = list("Urban" = "helmetalt",
		"Desert" = "helmetalt_desert",
		"Woodland" = "helmetalt_woodland",
		"Snow" = "helmetalt_snow",
		)


/obj/item/clothing/head/helmet/marine
	name = "tactical combat helmet"
	desc = "A tactical black helmet, sealed from outside hazards with a plate of reinforced glass."
	icon_state = "marine_command"
	item_state = "helmetalt"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 25, "bomb" = 50, "bio" = 100, "fire" = 40, "acid" = 50)
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	can_flashlight = TRUE
	dog_fashion = null

/obj/item/clothing/head/helmet/marine/Initialize(mapload)
	set_attached_light(new /obj/item/flashlight/seclite)
	update_helmlight()
	update_appearance()
	. = ..()

/obj/item/clothing/head/helmet/marine/security
	name = "marine heavy helmet"
	icon_state = "marine_security"

/obj/item/clothing/head/helmet/marine/engineer
	name = "marine utility helmet"
	icon_state = "marine_engineer"

/obj/item/clothing/head/helmet/marine/medic
	name = "marine medic helmet"
	icon_state = "marine_medic"

/obj/item/clothing/head/helmet/old
	name = "degrading helmet"
	desc = "Standard issue security helmet. Due to degradation the helmet's visor obstructs the users ability to see long distances."
	tint = 2

/obj/item/clothing/head/helmet/blueshirt
	name = "blue helmet"
	desc = "A reliable, blue tinted helmet reminding you that you <i>still</i> owe that engineer a beer."
	icon_state = "blueshift"
	item_state = "blueshift"
	custom_premium_price = 750

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	toggle_message = "You pull the visor down on"
	alt_toggle_message = "You push the visor up on"
	can_toggle = 1
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	flags_inv = HIDEEARS|HIDEFACE
	strip_delay = 80
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEFACE
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	dog_fashion = null

/obj/item/clothing/head/helmet/riot/minutemen
	name = "\improper Minutemen riot helmet"
	desc = "Designed to protect against close range attacks. Mainly used by the CM-BARD against hostile xenofauna, it also sees prolific use on some Minutemen member worlds."
	icon_state = "riot_minutemen"


/obj/item/clothing/head/helmet/justice
	name = "helmet of justice"
	desc = "WEEEEOOO. WEEEEEOOO. WEEEEOOOO."
	icon_state = "justice"
	toggle_message = "You turn off the lights on"
	alt_toggle_message = "You turn on the lights on"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = 1
	toggle_cooldown = 20
	var/datum/looping_sound/siren/weewooloop
	dog_fashion = null

/obj/item/clothing/head/helmet/justice/Initialize()
	. = ..()
	weewooloop = new(list(src), FALSE)

/obj/item/clothing/head/helmet/justice/Destroy()
	QDEL_NULL(weewooloop)
	return ..()

/obj/item/clothing/head/helmet/justice/attack_self(mob/user)
	. = ..()
	if(up)
		weewooloop.start()
	else
		weewooloop.stop()


/obj/item/clothing/head/helmet/justice/escape
	name = "alarm helmet"
	desc = "WEEEEOOO. WEEEEEOOO. STOP THAT MONKEY. WEEEOOOO."
	icon_state = "justice2"

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "An extremely robust, space-worthy helmet in a nefarious red and black stripe pattern."
	icon_state = "swatsyndie"
	item_state = "swatsyndie"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 50, "bio" = 90, "rad" = 20, "fire" = 100, "acid" = 100)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE
	strip_delay = 80
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = null

/obj/item/clothing/head/helmet/police
	name = "police officer's hat"
	desc = "A police officer's Hat. This hat emphasizes that you are THE LAW."
	icon_state = "policehelm"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/helmet/constable
	name = "constable helmet"
	desc = "A british looking helmet."
	mob_overlay_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	icon_state = "constable"
	item_state = "constable"
	worn_x_dimension = 64
	worn_y_dimension = 64
	custom_price = 350

/obj/item/clothing/head/helmet/swat/nanotrasen
	name = "\improper SWAT helmet"
	desc = "An extremely robust, space-worthy helmet with the Nanotrasen logo emblazoned on the top."
	icon_state = "swat"
	item_state = "swat"

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "thunderdome"
	item_state = "thunderdome"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/roman
	name = "\improper Roman helmet"
	desc = "An ancient helmet made of bronze and leather."
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 25, "bullet" = 0, "laser" = 25, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	icon_state = "roman"
	item_state = "roman"
	strip_delay = 100
	dog_fashion = null

/obj/item/clothing/head/helmet/roman/fake
	desc = "An ancient helmet made of plastic and leather."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/helmet/roman/legionnaire
	name = "\improper Roman legionnaire helmet"
	desc = "An ancient helmet made of bronze and leather. Has a red crest on top of it."
	icon_state = "roman_c"
	item_state = "roman_c"

/obj/item/clothing/head/helmet/roman/legionnaire/fake
	desc = "An ancient helmet made of plastic and leather. Has a red crest on top of it."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/redtaghelm
	name = "red laser tag helmet"
	desc = "They have chosen their own end."
	icon_state = "redtaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "redtaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/bluetaghelm
	name = "blue laser tag helmet"
	desc = "They'll need more men."
	icon_state = "bluetaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "bluetaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/knight
	name = "medieval helmet"
	desc = "A classic metal helmet."
	icon_state = "knight_green"
	item_state = "knight_green"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null


/obj/item/clothing/head/helmet/knight/Initialize(mapload)
	. = ..()
	var/datum/component = GetComponent(/datum/component/wearertargeting/earprotection)
	qdel(component)

/obj/item/clothing/head/helmet/knight/blue
	icon_state = "knight_blue"
	item_state = "knight_blue"

/obj/item/clothing/head/helmet/knight/yellow
	icon_state = "knight_yellow"
	item_state = "knight_yellow"

/obj/item/clothing/head/helmet/knight/red
	icon_state = "knight_red"
	item_state = "knight_red"

/obj/item/clothing/head/helmet/knight/greyscale
	name = "heavy plate helmet"
	desc = "A classic medieval helmet, if you hold it upside down you could see that it's actually a bucket."
	icon_state = "knight_greyscale"
	item_state = "knight_greyscale"
	armor = list("melee" = 50, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 40, "acid" = 40)
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

/obj/item/clothing/head/helmet/skull
	name = "skull helmet"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	icon_state = "skull"
	item_state = "skull"
	strip_delay = 100

/obj/item/clothing/head/helmet/durathread
	name = "durathread helmet"
	desc = "A helmet made from durathread and leather."
	icon_state = "durathread"
	item_state = "durathread"
	resistance_flags = FLAMMABLE
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 40, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/helmet/rus_helmet
	name = "russian helmet"
	desc = "It can hold a bottle of vodka."
	icon_state = "rus_helmet"
	item_state = "rus_helmet"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 0, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/helmet

/obj/item/clothing/head/helmet/r_trapper
	name = "reinforced trapper hat"
	desc = "An occasional sight on the heads of soldiers stationed on cold worlds. 200% bear."
	icon_state = "rus_ushanka"
	item_state = "rus_ushanka"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 50, "rad" = 20, "fire" = -10, "acid" = 50)

/obj/item/clothing/head/helmet/infiltrator
	name = "infiltrator helmet"
	desc = "The galaxy isn't big enough for the two of us."
	icon_state = "infiltrator"
	item_state = "infiltrator"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 40, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flash_protect = FLASH_PROTECTION_WELDER
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	strip_delay = 80

/obj/item/clothing/head/helmet/swat/inteq
	name = "inteq SWAT helmet"
	desc = "A robust and spaceworthy helmet with an opaque gold visor. There is an insignia on the earpad with the letters 'IRMG' on it."
	icon_state = "inteq_swat"
	item_state = "inteq_swat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/helmet/inteq
	name = "inteq helmet"
	desc = "A standard issue helmet in the colors of the IRMG. It doesn't feel special in any way."
	icon_state = "inteq_helmet"
	icon_state = "inteq_helmet"
	can_flashlight = TRUE

/obj/item/clothing/head/helmet/bulletproof/minutemen
	name = "\improper Minutemen ballistic helmet"
	desc = "A bulletproof helmet that is worn by members of the Colonial Minutemen."
	icon_state = "antichristhelm"
	allow_post_reskins = TRUE
	unique_reskin = null
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/solgov
	name = "\improper SolGov officer's cap"
	desc = "A blue cap worn by high-ranking officers of SolGov."
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)
	icon_state = "cap_solgov"
	item_state = "cap_solgov"
	strip_delay = 80

/obj/item/clothing/head/solgov/terragov
	name = "\improper TerraGov officer's cap"
	desc = "A cap worn by high-ranking officers of SolGov. This one is still in original TerraGov green."
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)
	icon_state = "cap_terragov"
	item_state = "cap_terragov"

/obj/item/clothing/head/solgov/sonnensoldner
	name = "\improper Sonnensoldner Hat"
	desc = "A standard-issue SolGov hat adorned with a feather, commonly used by Sonnensoldners."
	icon_state = "sonnensoldner_hat"
	item_state = "sonnensoldner_hat"
	worn_y_offset = 4
	dog_fashion = null
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)

/obj/item/clothing/head/solgov/captain
	name = "\improper SolGov bicorne hat"
	desc = "A unique bicorne hat given to Solarian Captains on expeditionary missions."
	icon_state = "solgov_bicorne"
	item_state = "solgov_bicorne"
	worn_y_offset = 2
	dog_fashion = null
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)

/obj/item/clothing/head/helmet/space/plasmaman/solgov
	name = "\improper SolGov envirosuit helmet"
	desc = "A generic white envirohelmet with a secondary blue."
	icon_state = "solgov_envirohelm"
	item_state = "solgov_envirohelm"

/obj/item/clothing/head/helmet/operator
	name = "\improper Operator helmet"
	desc = "A robust combat helmet commonly employed by Syndicate forces, regardless of alignment."
	icon_state = "operator"
	item_state = "operator"

/obj/item/clothing/head/helmet/bulletproof/m10
	name = "\improper M10 pattern Helmet"
	desc = "A classic looking helmet, derived from numerous convergently-similar designs from all across inhabited space. A faded tag reads: 'The difference between an open-casket and closed-casket funeral. Wear on head for best results.'"
	icon_state = "m10helm"
	can_flashlight = TRUE
	dog_fashion = null
	unique_reskin = list("Urban" = "m10helm",
		"Desert" = "m10helm_desert",
		"Woodland" = "m10helm_woodland",
		"Snow" = "m10helm_snow",
		)

/obj/item/clothing/head/helmet/bulletproof/x11
	name = "\improper Type X11 Helmet"
	desc = "This bulky helmet is a mainstay product of any Bezuts-based armor manufacturer worth their spice. It's a (relatively) comfortable fit for individuals with frills, horns, antlers, thorns, branches, spikes, webbing..."
	icon_state = "x11helm"
	can_flashlight = TRUE
	dog_fashion = null
	allow_post_reskins = TRUE
	unique_reskin = list("Urban" = "x11helm",
		"Desert" = "x11helm_desert",
		"Woodland" = "x11helm_woodland",
		"Snow" = "x11helm_snow",
		)

/obj/item/clothing/head/helmet/bulletproof/x11/frontier
	name = "\improper Frontiersmen X11 Helmet"
	desc = "A heavily modified X11 used by the Frontiersmen pirate fleet."
	icon_state = "x11helm_frontier"
	unique_reskin = null
