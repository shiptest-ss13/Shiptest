//Glasses
/obj/item/clothing/glasses
	name = "glasses"
	icon = 'icons/obj/clothing/eyes/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/eyes/eyes.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/glasses_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/glasses_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = GLASSESCOVERSEYES
	slot_flags = ITEM_SLOT_EYES
	resistance_flags = NONE
	custom_materials = list(/datum/material/glass = 250)
	supports_variations = VOX_VARIATION
	greyscale_colors = list(list(14, 26), list(17, 26))
	greyscale_icon_state = "glasses"

	equip_sound = 'sound/items/equip/straps_equip.ogg'
	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_EYEWEAR
	equip_delay_other = EQUIP_DELAY_EYEWEAR * 1.5
	strip_delay = EQUIP_DELAY_EYEWEAR * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT

	// var/vision_flags = 0
	// var/darkness_view = 2//Base human is 2
	// var/invis_view = SEE_INVISIBLE_LIVING	//admin only for now
	// var/invis_override = 0 //Override to allow glasses to set higher than normal see_invis
	// var/lighting_alpha
	// var/list/icon/current = list() //the current hud icons
	var/vision_correction = 0 //does wearing these glasses correct some of our vision defects?
	var/glass_colour_type //colors your vision when worn

/obj/item/clothing/glasses/examine(mob/user)
	. = ..()
	if(glass_colour_type && ishuman(user))
		. += span_notice("Alt-click to toggle [p_their()] colors.")

/obj/item/clothing/glasses/visor_toggling()
	..()
	if(visor_vars_to_toggle & VISOR_VISIONFLAGS)
		vision_flags ^= initial(vision_flags)
	if(visor_vars_to_toggle & VISOR_DARKNESSVIEW)
		darkness_view ^= initial(darkness_view)
	if(visor_vars_to_toggle & VISOR_INVISVIEW)
		invis_view ^= initial(invis_view)

/obj/item/clothing/glasses/weldingvisortoggle(mob/user)
	. = ..()
	if(. && user)
		user.update_sight()
		if(icon_state == "welding-g")
			change_glass_color(user, /datum/client_colour/glass_colour/gray)
		else
			change_glass_color(user, null)

//called when thermal glasses are emped.
/obj/item/clothing/glasses/proc/thermal_overload()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(!H.is_blind())
			if(H.glasses == src)
				to_chat(H, span_danger("[src] overloads and blinds you!"))
				H.flash_act(visual = 1)
				H.blind_eyes(3)
				H.blur_eyes(5)
				eyes.applyOrganDamage(5)

/obj/item/clothing/glasses/meson
	name = "optical meson scanner"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions."
	icon_state = "mesongoggles"
	item_state = "meson"
	darkness_view = 2
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES


/obj/item/clothing/glasses/meson/night
	name = "night vision meson scanner"
	desc = "An optical meson scanner fitted with an amplified visible light spectrum overlay, providing greater visual clarity in darkness."
	icon_state = "nvgmeson"
	item_state = "nvgmeson"
	darkness_view = 8
	flash_protect = FLASH_PROTECTION_SENSITIVE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/science
	name = "science goggles"
	desc = "A pair of snazzy goggles used to protect against chemical spills. Fitted with an analyzer for scanning items and reagents."
	icon_state = "scigoggles"
	item_state = "glasses"
	clothing_flags = SCAN_REAGENTS //You can see reagents while wearing science goggles
	actions_types = list(/datum/action/item_action/toggle_research_scanner)
	glass_colour_type = /datum/client_colour/glass_colour/purple
	resistance_flags = ACID_PROOF
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	custom_price = 250
	supports_variations = VOX_VARIATION
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/science/item_action_slot_check(slot)
	if(slot == ITEM_SLOT_EYES)
		return 1

/obj/item/clothing/glasses/science/prescription
	name = "prescription science goggles"
	desc = "A pair of prescription glasses fitted with an analyzer for scanning items and reagents. "
	icon_state = "prescriptionpurple"
	vision_correction = 1
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/science/prescription/fake
	name = "science glasses"
	desc = "A pair of glasses fitted with an analyzer for scanning items and reagents. Someone seems to have popped out the perscription lenses... "
	vision_correction = 0

/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = "You can totally see in the dark now!"
	icon_state = "night"
	item_state = "glasses"
	darkness_view = 8
	flash_protect = FLASH_PROTECTION_SENSITIVE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/green
	supports_variations = VOX_VARIATION
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = "Yarr."
	icon_state = "eyepatch-0"
	item_state = "eyepatch-0"
	var/flipped = FALSE

/obj/item/clothing/glasses/eyepatch/AltClick(mob/user)
	. = ..()
	flipped = !flipped
	to_chat(user, span_notice("You shift the eyepatch to cover the [flipped == 0 ? "right" : "left"] eye."))
	icon_state = "eyepatch-[flipped]"
	item_state = "eyepatch-[flipped]"
	update_appearance()

/obj/item/clothing/glasses/eyepatch/examine(mob/user)
	. = ..()
	. += "It is currently aligned to the [flipped == 0 ? "right" : "left"] side."

/obj/item/clothing/glasses/eyepatch/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/clothing/glasses/eyepatch))
		var/obj/item/clothing/glasses/eyepatch/old_patch = I
		var/obj/item/clothing/glasses/blindfold/eyepatch/double_patch = new()
		to_chat(user, span_notice("You combine the eyepatches with a knot."))
		qdel(old_patch)
		qdel(src)
		user.put_in_hands(double_patch)

/obj/item/clothing/glasses/material
	name = "optical material scanner"
	desc = "Very confusing glasses."
	icon_state = "materialgoggles"
	item_state = "glasses"
	vision_flags = SEE_OBJS
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/material/mining
	name = "optical material scanner"
	desc = "Used by miners to detect ores deep within the rock."
	darkness_view = 0

/obj/item/clothing/glasses/regular
	name = "prescription glasses"
	desc = "Made by Nerd. Co."
	icon_state = "glasses"
	item_state = "glasses"
	vision_correction = 1 //corrects nearsightedness
	supports_variations = VOX_VARIATION

/obj/item/clothing/glasses/regular/jamjar
	name = "jamjar glasses"
	desc = "Also known as Virginity Protectors."
	icon_state = "jamjar_glasses"
	item_state = "jamjar_glasses"

/obj/item/clothing/glasses/regular/hipster
	name = "prescription glasses"
	desc = "Made by Uncool. Co."
	icon_state = "hipster_glasses"
	item_state = "hipster_glasses"

/obj/item/clothing/glasses/regular/circle
	name = "circle glasses"
	desc = "Why would you wear something so controversial yet so brave?"
	icon_state = "circle_glasses"
	item_state = "circle_glasses"

/obj/item/clothing/glasses/regular/thin
	name = "thin glasses"
	desc = "More expensive, more fragile and much less practical, but oh so fashionable."
	icon_state = "thin_glasses"

//Here lies green glasses, so ugly they died. RIP

/obj/item/clothing/glasses/sunglasses
	name = "sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks flashes."
	icon_state = "sun"
	item_state = "sunglasses"
	darkness_view = 1
	flash_protect = FLASH_PROTECTION_FLASH
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray
	dog_fashion = /datum/dog_fashion/head
	supports_variations = VOX_VARIATION

/obj/item/clothing/glasses/sunglasses/reagent
	name = "beer goggles"
	icon_state = "sunhudbeer"
	desc = "A pair of sunglasses outfitted with apparatus to scan reagents, as well as providing an innate understanding of liquid viscosity while in motion."
	clothing_flags = SCAN_REAGENTS
	glass_colour_type = /datum/client_colour/glass_colour/orange

/obj/item/clothing/glasses/sunglasses/reagent/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && slot == ITEM_SLOT_EYES)
		ADD_TRAIT(user, TRAIT_BOOZE_SLIDER, CLOTHING_TRAIT)

/obj/item/clothing/glasses/sunglasses/reagent/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_BOOZE_SLIDER, CLOTHING_TRAIT)

/obj/item/clothing/glasses/sunglasses/chemical
	name = "science glasses"
	icon_state = "sunhudsci"
	desc = "A pair of tacky purple sunglasses that allow the wearer to recognize various chemical compounds with only a glance."
	clothing_flags = SCAN_REAGENTS
	glass_colour_type = /datum/client_colour/glass_colour/darkpurple

/obj/item/clothing/glasses/sunglasses/ballistic
	name = "ballistic goggles"
	desc = "A pair of flash-proof ballistic goggles."
	icon_state = "ballistic_goggles"
	item_state = "ballistic_goggles"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/welding
	name = "welding goggles"
	desc = "Protects the eyes from bright flashes; approved by the mad scientist association."
	icon_state = "welding-g"
	item_state = "welding-g"
	actions_types = list(/datum/action/item_action/toggle)
	flash_protect = FLASH_PROTECTION_WELDER
	custom_materials = list(/datum/material/iron = 250)
	tint = 2
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT | SEALS_EYES
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/gray
	supports_variations = VOX_VARIATION

/obj/item/clothing/glasses/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/glasses/blindfold
	name = "blindfold"
	desc = "Covers the eyes, preventing sight."
	icon_state = "blindfold"
	item_state = "blindfold"
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 3
	darkness_view = 1
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/glasses/blindfold/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_EYES)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/blindfold/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/trickblindfold
	name = "blindfold"
	desc = "A see-through blindfold perfect for cheating at games."
	icon_state = "trickblindfold"
	item_state = "blindfold"

/obj/item/clothing/glasses/blindfold/white
	name = "blind personnel blindfold"
	desc = "Indicates that the wearer suffers from blindness."
	icon_state = "blindfoldwhite"
	item_state = "blindfoldwhite"
	var/colored_before = FALSE

/obj/item/clothing/glasses/blindfold/white/visual_equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && slot == ITEM_SLOT_EYES)
		update_icon(ALL, user)
		user.update_inv_glasses() //Color might have been changed by update_icon.
	..()

/obj/item/clothing/glasses/blindfold/white/update_icon(updates = ALL, mob/living/carbon/human/user)
	. = ..()
	if(ishuman(user) && !colored_before)
		add_atom_colour("#[user.eye_color]", FIXED_COLOUR_PRIORITY)
		colored_before = TRUE

/obj/item/clothing/glasses/blindfold/white/worn_overlays(isinhands = FALSE, file2use)
	. = ..()
	if(!isinhands && ishuman(loc) && !colored_before)
		var/mob/living/carbon/human/H = loc
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/eyes/eyes.dmi', "blindfoldwhite")
		M.appearance_flags |= RESET_COLOR
		M.color = "#[H.eye_color]"
		. += M

/obj/item/clothing/glasses/blindfold/eyepatch
	name = "double eyepatch"
	desc = "For those pirates who've been at it a while. May interfere with navigating ability."
	icon_state = "eyepatchd"
	item_state = "eyepatchd"

/obj/item/clothing/glasses/blindfold/eyepatch/attack_self(mob/user)
	. = ..()
	var/obj/item/clothing/glasses/eyepatch/patch_one = new/obj/item/clothing/glasses/eyepatch
	var/obj/item/clothing/glasses/eyepatch/patch_two = new/obj/item/clothing/glasses/eyepatch
	patch_one.forceMove(user.drop_location())
	patch_two.forceMove(user.drop_location())
	to_chat(user, span_notice("You undo the knot on the eyepatches."))
	qdel(src)

/obj/item/clothing/glasses/sunglasses/big
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Larger than average enhanced shielding blocks flashes."
	icon_state = "bigsunglasses"
	item_state = "bigsunglasses"

/obj/item/clothing/glasses/thermal
	name = "optical thermal scanner"
	desc = "Thermals in the shape of glasses."
	icon_state = "thermalgoggles"
	item_state = "glasses"
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	flash_protect = FLASH_PROTECTION_SENSITIVE
	glass_colour_type = /datum/client_colour/glass_colour/red
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/thermal/xray
	name = "syndicate xray goggles"
	desc = "A pair of xray goggles manufactured by the Syndicate."
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS

/obj/item/clothing/glasses/thermal/syndi	//These are now a traitor item, concealed as mesons.	-Pete
	name = "chameleon thermals"
	desc = "A pair of thermal optic goggles with an onboard chameleon generator."

	var/datum/action/item_action/chameleon/change/chameleon_action

/obj/item/clothing/glasses/thermal/syndi/Initialize()
	. = ..()
	chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/clothing/glasses
	chameleon_action.chameleon_name = "Glasses"
	chameleon_action.chameleon_blacklist = typecacheof(/obj/item/clothing/glasses/changeling, only_root_path = TRUE)
	chameleon_action.initialize_disguises()

/obj/item/clothing/glasses/thermal/syndi/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chameleon_action.emp_randomise()

/obj/item/clothing/glasses/thermal/eyepatch
	name = "optical thermal eyepatch"
	desc = "An eyepatch with built-in thermal optics."
	icon_state = "eyepatch-0"
	item_state = "eyepatch-0"
	var/flipped = FALSE
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/thermal/eyepatch/AltClick(mob/user)
	. = ..()
	flipped = !flipped
	to_chat(user, span_notice("You shift the eyepatch to cover the [flipped == 0 ? "right" : "left"] eye."))
	icon_state = "eyepatch-[flipped]"
	item_state = "eyepatch-[flipped]"
	update_appearance()

/obj/item/clothing/glasses/thermal/eyepatch/examine(mob/user)
	. = ..()
	. += "It is currently aligned to the [flipped == 0 ? "right" : "left"] side."

/obj/item/clothing/glasses/cold
	name = "cold goggles"
	desc = "A pair of goggles meant for low temperatures."
	icon_state = "cold"
	item_state = "cold"
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/heat
	name = "heat goggles"
	desc = "A pair of goggles meant for high temperatures."
	icon_state = "heat"
	item_state = "heat"
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

/obj/item/clothing/glasses/orange
	name = "orange glasses"
	desc = "A sweet pair of orange shades."
	icon_state = "orangeglasses"
	item_state = "orangeglasses"
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/red
	name = "red glasses"
	desc = "Hey, you're looking good, senpai!"
	icon_state = "redglasses"
	item_state = "redglasses"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/AltClick(mob/user)
	if(glass_colour_type && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.client)
			if(H.client.prefs)
				if(src == H.glasses)
					H.client.prefs.uses_glasses_colour = !H.client.prefs.uses_glasses_colour
					if(H.client.prefs.uses_glasses_colour)
						to_chat(H, span_notice("You will now see glasses colors."))
					else
						to_chat(H, span_notice("You will no longer see glasses colors."))
					H.update_glasses_color(src, 1)
	else
		return ..()

/obj/item/clothing/glasses/proc/change_glass_color(mob/living/carbon/human/H, datum/client_colour/glass_colour/new_color_type)
	var/old_colour_type = glass_colour_type
	if(!new_color_type || ispath(new_color_type)) //the new glass colour type must be null or a path.
		glass_colour_type = new_color_type
		if(H && H.glasses == src)
			if(old_colour_type)
				H.remove_client_colour(old_colour_type)
			if(glass_colour_type)
				H.update_glasses_color(src, 1)


/mob/living/carbon/human/proc/update_glasses_color(obj/item/clothing/glasses/G, glasses_equipped)
	if(client && client.prefs.uses_glasses_colour && glasses_equipped)
		add_client_colour(G.glass_colour_type)
	else
		remove_client_colour(G.glass_colour_type)

/obj/item/clothing/glasses/debug
	name = "debug glasses"
	desc = "Medical, security and diagnostic hud. Alt click to toggle xray."
	icon_state = "nvgmeson"
	item_state = "nvgmeson"
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES
	darkness_view = 8
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = FALSE
	clothing_flags = SCAN_REAGENTS
	vision_flags = SEE_TURFS
	var/list/hudlist = list(DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED, DATA_HUD_SECURITY_ADVANCED)
	var/xray = FALSE

/obj/item/clothing/glasses/debug/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_EYES)
		return
	if(ishuman(user))
		for(var/hud in hudlist)
			var/datum/atom_hud/H = GLOB.huds[hud]
			H.add_hud_to(user)
		ADD_TRAIT(user, TRAIT_MEDICAL_HUD, GLASSES_TRAIT)
		ADD_TRAIT(user, TRAIT_SECURITY_HUD, GLASSES_TRAIT)

/obj/item/clothing/glasses/debug/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_MEDICAL_HUD, GLASSES_TRAIT)
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, GLASSES_TRAIT)
	if(ishuman(user))
		for(var/hud in hudlist)
			var/datum/atom_hud/H = GLOB.huds[hud]
			H.remove_hud_from(user)

/obj/item/clothing/glasses/debug/AltClick(mob/user)
	. = ..()
	if(ishuman(user))
		if(xray)
			vision_flags -= SEE_MOBS|SEE_OBJS
		else
			vision_flags += SEE_MOBS|SEE_OBJS
		xray = !xray
		var/mob/living/carbon/human/H = user
		H.update_sight()

/obj/item/clothing/glasses/cheapsuns
	name = "cheap sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover."
	icon_state = "sun"
	item_state = "sunglasses"
	darkness_view = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray
	dog_fashion = /datum/dog_fashion/head
