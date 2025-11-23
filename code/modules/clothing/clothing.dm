/obj/item/clothing
	name = "clothing"
	resistance_flags = FLAMMABLE
	max_integrity = 200
	integrity_failure = 0.4

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC

	var/damaged_clothes = 0 //similar to machine's BROKEN stat and structure's broken var
	///What level of bright light protection item has.
	var/flash_protect = FLASH_PROTECTION_NONE
	var/tint = 0				//Sets the item's level of visual impairment tint, normally set to the same as flash_protect
	var/up = 0					//but separated to allow items to protect but not impair vision, like space helmets
	var/visor_flags = 0			//flags that are added/removed when an item is adjusted up/down
	var/visor_flags_inv = 0		//same as visor_flags, but for flags_inv
	var/visor_flags_cover = 0	//same as above, but for flags_cover

	//what to toggle when toggled with weldingvisortoggle()
	var/visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT | VISOR_VISIONFLAGS | VISOR_DARKNESSVIEW | VISOR_INVISVIEW
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	var/alt_desc = null
	var/toggle_message = null
	var/alt_toggle_message = null
	var/active_sound = null
	var/toggle_cooldown = null
	var/cooldown = 0
	var/clothing_flags = NONE

	var/cuttable = FALSE //If you can cut the clothing with anything sharp
	var/clothamnt = 0 //How much cloth

	var/can_be_bloody = TRUE

	//set during equip_to_slot, removed when taking off.
	//here lies some of the most batshit insane reference code I've ever seen. Look it up in the commit history
	var/datum/weakref/wearer

	var/pocket_storage_component_path

	///These are armor values that protect the wearer, taken from the clothing's armor datum. List updates on examine because it's currently only used to print armor ratings to chat in Topic().
	var/list/armor_list = list()
	///These are armor values that protect the clothing, taken from its armor datum. List updates on examine because it's currently only used to print armor ratings to chat in Topic().
	var/list/durability_list = list()
	/// If this can be eaten by a moth
	var/moth_edible = TRUE

	// Not used yet
	/// Trait modification, lazylist of traits to add/take away, on equipment/drop in the correct slot
	var/list/clothing_traits

	///sets the icon path of the onmob blood overlay created by this object. syntax is "[var]blood"
	var/blood_overlay_type = "uniform"

	var/vision_flags = 0
	var/darkness_view = 2//Base human is 2
	var/invis_view = SEE_INVISIBLE_LIVING	//admin only for now
	var/invis_override = 0 //Override to allow glasses to set higher than normal see_invis
	var/lighting_alpha
	var/list/icon/current = list() //the current hud icons

/obj/item/clothing/Initialize()
	if((clothing_flags & VOICEBOX_TOGGLABLE))
		actions_types += /datum/action/item_action/toggle_voice_box
	. = ..()
	if(ispath(pocket_storage_component_path))
		LoadComponent(pocket_storage_component_path)
	if(can_be_bloody && ((body_parts_covered & FEET) || (flags_inv & HIDESHOES)))
		LoadComponent(/datum/component/bloodysoles)

/obj/item/clothing/MouseDrop(atom/over_object)
	. = ..()
	var/mob/M = usr

	if(ismecha(M.loc)) // stops inventory actions in a mech
		return

	if(!M.incapacitated() && loc == M && istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		if(M.putItemFromInventoryInHandIfPossible(src, H.held_index, FALSE, TRUE))
			add_fingerprint(usr)

/obj/item/food/clothing // fuck you
	name = "temporary moth clothing snack item"
	desc = "If you're reading this it means I messed up. This is related to moths eating clothes and I didn't know a better way to do it than making a new food object."
	food_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("dust" = 1, "lint" = 1)
	foodtypes = CLOTH

/obj/item/clothing/attack(mob/M, mob/user, def_zone)
	if(user.a_intent != INTENT_HARM && moth_edible && ismoth(M))
		var/obj/item/food/clothing/clothing_as_food = new
		clothing_as_food.name = name
		if(clothing_as_food.attack(M, user, def_zone))
			take_damage(15, sound_effect=FALSE)
		qdel(clothing_as_food)
	else
		return ..()

/obj/item/clothing/attackby(obj/item/tool, mob/user, params)
	if(tool.get_sharpness() && cuttable)
		if(tgui_alert(user, "Are you sure you want to cut \the [src] into strips?", "Cut clothing:", list("Yes", "No")) != "Yes")
			return
		if(QDELETED(src))
			return
		playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, TRUE)
		to_chat(user, span_notice("You cut the [src] into strips with [tool]."))
		var/obj/item/stack/sheet/cotton/cloth/cloth = new (get_turf(src), clothamnt)
		user.put_in_hands(cloth)
		qdel(src)

	if(damaged_clothes && istype(tool, /obj/item/stack/sheet/cotton/cloth))
		var/obj/item/stack/sheet/cotton/cloth/cloth = tool
		if(!cloth.use(1))
			to_chat(user, span_notice("You fail to fix the damage on [src]."))
			return TRUE
		update_clothes_damaged_state(FALSE)
		atom_integrity = max_integrity
		to_chat(user, span_notice("You fix the damage on [src] with [cloth]."))
		return TRUE

	return ..()

/obj/item/clothing/dropped(mob/user)
	..()
	if(!istype(user))
		return

	for(var/trait in clothing_traits)
		REMOVE_CLOTHING_TRAIT(user, trait)

	if(wearer?.resolve())
		wearer = null

/obj/item/clothing/equipped(mob/user, slot)
	..()
	if(!istype(user))
		return
	if(slot_flags & slot) //Was equipped to a valid slot for this item?
		for(var/trait in clothing_traits)
			ADD_CLOTHING_TRAIT(user, trait)
		if(!wearer?.resolve())
			wearer = WEAKREF(user)

/**
 * Inserts a trait (or multiple traits) into the clothing traits list
 *
 * If worn, then we will also give the wearer the trait as if equipped
 *
 * This is so you can add clothing traits without worrying about needing to equip or unequip them to gain effects
 */
/obj/item/clothing/proc/attach_clothing_traits(trait_or_traits)
	if(!islist(trait_or_traits))
		trait_or_traits = list(trait_or_traits)

	LAZYOR(clothing_traits, trait_or_traits)
	var/mob/wearer = loc
	if(istype(wearer) && (wearer.get_slot_by_item(src) & slot_flags))
		for(var/new_trait in trait_or_traits)
			ADD_CLOTHING_TRAIT(wearer, new_trait)

/**
 * Removes a trait (or multiple traits) from the clothing traits list
 *
 * If worn, then we will also remove the trait from the wearer as if unequipped
 *
 * This is so you can add clothing traits without worrying about needing to equip or unequip them to gain effects
 */
/obj/item/clothing/proc/detach_clothing_traits(trait_or_traits)
	if(!islist(trait_or_traits))
		trait_or_traits = list(trait_or_traits)

	LAZYREMOVE(clothing_traits, trait_or_traits)
	var/mob/wearer = loc
	if(istype(wearer))
		for(var/new_trait in trait_or_traits)
			REMOVE_CLOTHING_TRAIT(wearer, new_trait)

/obj/item/clothing/examine(mob/user)
	. = ..()

	switch(max_heat_protection_temperature)
		if (400 to 1000)
			. += "[src] offers the wearer limited protection from fire."
		if (1001 to 1600)
			. += "[src] offers the wearer some protection from fire."
		if (1601 to 35000)
			. += "[src] offers the wearer robust protection from fire."

	if(damaged_clothes)
		. += span_warning("It looks damaged!")

	var/datum/component/storage/pockets = GetComponent(/datum/component/storage)
	if(pockets)
		var/list/how_cool_are_your_threads = list("<span class='notice'>")
		if(pockets.attack_hand_interact)
			how_cool_are_your_threads += "[src]'s storage opens when clicked.\n"
		else
			how_cool_are_your_threads += "[src]'s storage opens when dragged to yourself.\n"
		if (pockets.can_hold?.len) // If pocket type can hold anything, vs only specific items
			how_cool_are_your_threads += "[src] can store [pockets.max_items] <a href='byond://?src=[REF(src)];show_valid_pocket_items=1'>item\s</a>.\n"
		else
			how_cool_are_your_threads += "[src] can store [pockets.max_items] item\s that are [weightclass2text(pockets.max_w_class)] or smaller.\n"
		if(pockets.quickdraw)
			how_cool_are_your_threads += "You can quickly remove an item from [src] using Right-Click.\n"
		if(pockets.silent)
			how_cool_are_your_threads += "Adding or removing items from [src] makes no noise.\n"
		how_cool_are_your_threads += "</span>"
		. += how_cool_are_your_threads.Join()

	if(LAZYLEN(armor_list))
		armor_list.Cut()
	if(armor.bio)
		armor_list += list("TOXIN" = armor.bio)
	if(armor.bomb)
		armor_list += list("EXPLOSIVE" = armor.bomb)
	if(armor.bullet)
		armor_list += list("BULLET" = armor.bullet)
	if(armor.energy)
		armor_list += list("ENERGY" = armor.energy)
	if(armor.laser)
		armor_list += list("LASER" = armor.laser)
	if(armor.magic)
		armor_list += list("MAGIC" = armor.magic)
	if(armor.melee)
		armor_list += list("MELEE" = armor.melee)
	if(armor.rad)
		armor_list += list("RADIATION" = armor.rad)

	if(LAZYLEN(durability_list))
		durability_list.Cut()
	if(armor.fire)
		durability_list += list("FIRE" = armor.fire)
	if(armor.acid)
		durability_list += list("ACID" = armor.acid)

	if(LAZYLEN(armor_list) || LAZYLEN(durability_list))
		. += span_notice("It has a <a href='byond://?src=[REF(src)];list_armor=1'>tag</a> listing its protection classes.")

/obj/item/clothing/Topic(href, href_list)
	. = ..()

	if(href_list["list_armor"])
		var/list/readout = list("<span class='notice'><u><b>PROTECTION CLASSES (I-X)</u></b>")
		if(LAZYLEN(armor_list))
			readout += "\n<b>ARMOR</b>"
			for(var/dam_type in armor_list)
				var/armor_amount = armor_list[dam_type]
				readout += "\n[dam_type] [armor_to_protection_class(armor_amount)]" //e.g. BOMB IV
		if(LAZYLEN(durability_list))
			readout += "\n<b>DURABILITY</b>"
			for(var/dam_type in durability_list)
				var/durability_amount = durability_list[dam_type]
				readout += "\n[dam_type] [armor_to_protection_class(durability_amount)]" //e.g. FIRE II
		readout += "</span>"

		to_chat(usr, "[readout.Join()]")

/**
 * Rounds armor_value to nearest 10, divides it by 10 and then expresses it in roman numerals up to 10
 *
 * Rounds armor_value to nearest 10, divides it by 10
 * and then expresses it in roman numerals up to 10
 * Arguments:
 * * armor_value - Number we're converting
 */
/obj/item/clothing/proc/armor_to_protection_class(armor_value)
	armor_value = round(armor_value,10) / 10
	switch (armor_value)
		if (1)
			. = "I"
		if (2)
			. = "II"
		if (3)
			. = "III"
		if (4)
			. = "IV"
		if (5)
			. = "V"
		if (6)
			. = "VI"
		if (7)
			. = "VII"
		if (8)
			. = "VIII"
		if (9)
			. = "IX"
		if (10 to INFINITY)
			. = "X"
	return .

/obj/item/clothing/atom_break(damage_flag)
	if(!damaged_clothes)
		update_clothes_damaged_state(TRUE)

	if(ismob(loc)) //It's not important enough to warrant a message if nobody's wearing it
		var/mob/M = loc
		to_chat(M, span_warning("Your [name] starts to fall apart!"))

	. = ..()

//This mostly exists so subtypes can call appriopriate update icon calls on the wearer.
/obj/item/clothing/proc/update_clothes_damaged_state(damaging = TRUE)
	if(damaging)
		damaged_clothes = 1
	else
		damaged_clothes = 0

/obj/item/clothing/update_overlays()
	. = ..()
	var/index = "[REF(initial(icon))]-[initial(icon_state)]"
	var/static/list/damaged_clothes_icons = list()

	if(!damaged_clothes)
		return

	var/icon/damaged_clothes_icon = damaged_clothes_icons[index]
	if(!damaged_clothes_icon)
		damaged_clothes_icon = icon(initial(icon), initial(icon_state), , 1) //we only want to apply damaged effect to the initial icon_state for each object
		damaged_clothes_icon.Blend("#fff", ICON_ADD) //fills the icon_state with white (except where it's transparent)
		damaged_clothes_icon.Blend(icon('icons/effects/item_damage.dmi', "itemdamaged"), ICON_MULTIPLY) //adds damage effect and the remaining white areas become transparant
		damaged_clothes_icon = fcopy_rsc(damaged_clothes_icon)
		damaged_clothes_icons[index] = damaged_clothes_icon
	. += damaged_clothes_icon

/obj/item/proc/generate_species_clothing(file2use, state2use, layer, datum/species/mob_species)
	if(!icon_exists(file2use, state2use))
		return

	var/icon/human_clothing_icon = icon(file2use, state2use)

	if("[layer]" in mob_species.offset_clothing)
		// This code taken from Baystation 12
		var/icon/final_I = icon('icons/blanks/64x64.dmi', "nothing")
		var/list/shifts = mob_species.offset_clothing["[layer]"]

		// Apply all pixel shifts for each direction.
		for(var/shift_facing in shifts)
			var/list/facing_list = shifts[shift_facing]
			var/use_dir = text2num(shift_facing)
			var/icon/equip = icon(file2use, icon_state = state2use, dir = use_dir)
			var/icon/canvas = icon('icons/blanks/64x64.dmi', "nothing")
			canvas.Blend(equip, ICON_OVERLAY, facing_list["x"]+1, facing_list["y"]+1)
			final_I.Insert(canvas, dir = use_dir)

		final_I = fcopy_rsc(final_I)
		GLOB.species_clothing_icons[mob_species.id]["[file2use]-[state2use]"] = final_I
		return TRUE

	if(!greyscale_colors || !greyscale_icon_state)
		GLOB.species_clothing_icons[mob_species.id]["[file2use]-[state2use]"] = human_clothing_icon
		return

	if(!icon_exists(mob_species.species_clothing_path, greyscale_icon_state))
		return

	var/icon/species_icon = icon(mob_species.species_clothing_path, greyscale_icon_state)
	var/list/final_list = list()
	for(var/i in 1 to 3)
		if(length(greyscale_colors) < i)
			final_list += "#00000000"
			continue
		var/color = greyscale_colors[i]
		if(islist(color))
			final_list += human_clothing_icon.GetPixel(color[1], color[2]) || "#00000000"
		else if(istext(color))
			final_list += color

	species_icon.MapColors(final_list[1], final_list[2], final_list[3])
	species_icon = fcopy_rsc(species_icon)
	GLOB.species_clothing_icons[mob_species.id]["[file2use]-[state2use]"] = species_icon

	return TRUE

/obj/item/clothing/under/verb/toggle()
	set name = "Adjust Suit Sensors"
	set category = "Object"
	set src in usr
	var/mob/M = usr
	if (istype(M, /mob/dead/))
		return
	if (!can_use(M))
		return
	if(src.has_sensor == LOCKED_SENSORS)
		to_chat(usr, "The controls are locked.")
		return 0
	if(src.has_sensor == BROKEN_SENSORS)
		to_chat(usr, "The sensors have shorted out!")
		return 0
	if(src.has_sensor <= NO_SENSORS)
		to_chat(usr, "This suit does not have any sensors.")
		return 0

	var/list/modes = list("Off", "Binary vitals", "Exact vitals", "Tracking beacon")
	var/switchMode = input("Select a sensor mode:", "Suit Sensor Mode", modes[sensor_mode + 1]) in modes
	if(get_dist(usr, src) > 1)
		to_chat(usr, span_warning("You have moved too far away!"))
		return
	sensor_mode = modes.Find(switchMode) - 1

	if (src.loc == usr)
		switch(sensor_mode)
			if(0)
				to_chat(usr, span_notice("You disable your suit's remote sensing equipment."))
			if(1)
				to_chat(usr, span_notice("Your suit will now only report whether you are alive or dead."))
			if(2)
				to_chat(usr, span_notice("Your suit will now only report your exact vital lifesigns."))
			if(3)
				to_chat(usr, span_notice("Your suit will now report your exact vital lifesigns as well as your coordinate position."))

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.w_uniform == src)
			H.update_suit_sensors()

/obj/item/clothing/under/attack_hand(mob/user)
	if(attached_accessory && ispath(attached_accessory.pocket_storage_component_path) && loc == user)
		attached_accessory.attack_hand(user)
		return
	..()

/obj/item/clothing/under/attack_hand_secondary(mob/user, list/modifiers)
	toggle()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/attackby_secondary(obj/item/weapon, mob/user, params)
	toggle()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/AltClick(mob/user)
	if(..())
		return TRUE

	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		if(attached_accessory && ispath(attached_accessory.pocket_storage_component_path) && loc == user)
			attached_accessory.attack_hand(user)
			return
		if(toggle_sleeves())
			return TRUE
		if(toggle_rolldown())
			return TRUE

/obj/item/clothing/under/CtrlClick(mob/user)
	if(..())
		return 1
	if(attached_accessory)
		remove_accessory(user)

/obj/item/clothing/under/verb/jumpsuit_rollsleeves()
	set name = "Roll Up/Down Sleeves"
	set category = null
	set src in usr
	toggle_sleeves()

/obj/item/clothing/under/verb/jumpsuit_rolldown()
	set name = "Roll Down/Up Jumpsuit"
	set category = null
	set src in usr
	toggle_rolldown()

/obj/item/clothing/under/proc/toggle_sleeves()
	if(!can_use(usr))
		return FALSE
	if(!roll_sleeves)
		return FALSE
	if(adjusted == ALT_STYLE)
		to_chat(usr, span_warning("You cannot adjust your uniform's sleeves while your top is rolled down!"))
		return FALSE
	else if(toggle_jumpsuit_adjust(ROLLED_STYLE))
		to_chat(usr, span_notice("You roll up your uniform's sleeves."))
	else
		to_chat(usr, span_notice("You roll down your uniform's sleeves."))
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.update_inv_w_uniform()
		H.update_body()
		return TRUE
	return FALSE

/obj/item/clothing/under/proc/toggle_rolldown()
	if(!can_use(usr))
		return FALSE
	if(!roll_down)
		return FALSE
	if(toggle_jumpsuit_adjust(ALT_STYLE))
		to_chat(usr, span_notice("You roll down your uniform's top."))
	else
		to_chat(usr, span_notice("You roll up your uniform's top."))
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.update_inv_w_uniform()
		H.update_body()
		return TRUE
	return FALSE

// handles logic of toggling uniform rolling and sleeve rolling
// if i had more time i would've written a shorter letter
/obj/item/clothing/under/proc/toggle_jumpsuit_adjust(style) //please rework this if you see this
	adjusted = !adjusted
	// are we already using an alternative uniform style?
	if(adjusted) // we aren't
		switch(style)
			if(ALT_STYLE) // we want to roll down our uniform
				if(!alt_covers_chest) // for outfits that expose the chest when rolled down
					body_parts_covered &= ~CHEST | ARMS
					adjusted = ALT_STYLE
					return adjusted
				else
					adjusted = ALT_STYLE
					return adjusted
			if(ROLLED_STYLE) // we want to roll up our sleeves
				body_parts_covered &= ~ARMS
				adjusted = ROLLED_STYLE
				return adjusted
	else // we are, toggle stuff back to normal
		switch(style)
			if(ALT_STYLE)
				if(!alt_covers_chest)
					body_parts_covered |= CHEST | ARMS
					adjusted = NORMAL_STYLE
					return adjusted
				else
					adjusted = NORMAL_STYLE
					return adjusted
			if(ROLLED_STYLE)
				body_parts_covered |= ARMS
				adjusted = NORMAL_STYLE
				return adjusted

/obj/item/clothing/proc/weldingvisortoggle(mob/user) //proc to toggle welding visors on helmets, masks, goggles, etc.
	if(!can_use(user))
		return FALSE

	visor_toggling()

	to_chat(user, span_notice("You adjust \the [src] [up ? "up" : "down"]."))

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.head_update(src, forced = 1)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
	return TRUE

/obj/item/clothing/proc/visor_toggling() //handles all the actual toggling of flags
	up = !up
	SEND_SIGNAL(src, COMSIG_CLOTHING_VISOR_TOGGLE, up)
	clothing_flags ^= visor_flags
	flags_inv ^= visor_flags_inv
	flags_cover ^= initial(flags_cover)
	icon_state = "[initial(icon_state)][up ? "up" : ""]"
	if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
		flash_protect ^= initial(flash_protect)
	if(visor_vars_to_toggle & VISOR_TINT)
		tint ^= initial(tint)

/obj/item/clothing/head/helmet/space/plasmaman/visor_toggling() //handles all the actual toggling of flags
	up = !up
	SEND_SIGNAL(src, COMSIG_CLOTHING_VISOR_TOGGLE, up)
	clothing_flags ^= visor_flags
	flags_inv ^= visor_flags_inv
	icon_state = "[initial(icon_state)]"
	if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
		flash_protect ^= initial(flash_protect)
	if(visor_vars_to_toggle & VISOR_TINT)
		tint ^= initial(tint)

/obj/item/clothing/proc/can_use(mob/user)
	if(user && ismob(user))
		if(!user.incapacitated())
			return 1
	return 0

/obj/item/clothing/atom_destruction(damage_flag)
	if(damage_flag == "bomb" || damage_flag == "melee")
		var/turf/T = get_turf(src)
		//so the shred survives potential turf change from the explosion.
		addtimer(CALLBACK_NEW(/obj/effect/decal/cleanable/shreds, list(T, name)), 1)
		deconstruct(FALSE)
	else
		..()

///sets up the proper bloody overlay for a clothing object, using species data
/obj/item/clothing/proc/setup_blood_overlay()
	var/overlay_file = 'icons/effects/blood.dmi'

	var/mob/living/carbon/human/wearing = wearer?.resolve()
	var/custom_overlay_icon = wearing?.dna.species.custom_overlay_icon
	if(custom_overlay_icon)
		overlay_file = custom_overlay_icon

	var/mutable_appearance/bloody_clothing = mutable_appearance(overlay_file, "[blood_overlay_type]blood")
	bloody_clothing.color = get_blood_dna_color(return_blood_DNA())

	return bloody_clothing
