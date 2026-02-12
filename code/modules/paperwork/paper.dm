/**
 * Paper
 * also scraps of paper
 *
 * lipstick wiping is in code/game/objects/items/weapons/cosmetics.dm!
 */

/**
 * Paper is now using markdown (like in github pull notes) for ALL rendering
 * so we do loose a bit of functionality but we gain in easy of use of
 * paper and getting rid of that crashing bug
 */
/obj/item/paper
	name = "paper"
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper"
	custom_fire_overlay = "paper_onfire_overlay"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	pressure_resistance = 0
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = HEAD
	resistance_flags = FLAMMABLE
	max_integrity = 50
	dog_fashion = /datum/dog_fashion/head
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	grind_results = list(/datum/reagent/cellulose = 3)
	color = COLOR_WHITE

	/// Whether the icon should show little scribbly written words when the paper has some text on it.
	var/show_written_words = TRUE

	/// Reagent to transfer to the user when they pick the paper up without proper protection.
	var/contact_poison
	/// Volume of contact_poison to transfer to the user when they pick the paper up without proper protection.
	var/contact_poison_volume = 0

	/// Default raw text to fill this paper with on init.
	var/default_raw_text

	/// Paper can be shown via cameras. When that is done, a deep copy of the paper is made and stored as a var on the camera.
	/// The paper is located in nullspace, and holds a weak ref to the camera that once contained it so the paper can do some
	/// state checking on if it should be shown to a viewer.
	var/datum/weakref/camera_holder

	///If TRUE, staff can read paper everywhere, but usually from requests panel.
	var/request_state = FALSE

/obj/item/paper/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-9, 9)
	pixel_y = base_pixel_y + rand(-8, 8)

	AddComponent(/datum/component/writing, default_raw_text)
	update_appearance()

/obj/item/paper/Destroy()
	. = ..()
	camera_holder = null
	clear_paper()

/**
 * This proc copies this sheet of paper to a new
 * sheet. Used by carbon papers and the photocopier machine.
 *
 * Arguments
 * * paper_type - Type path of the new paper to create. Can copy anything to anything.
 * * location - Where to spawn in the new copied paper.
 * * colored - If true, the copied paper will be coloured and will inherit all colours.
 * * greyscale_override - If set to a colour string and coloured is false, it will override the default of COLOR_WEBSAFE_DARK_GRAY when copying.
 */

/obj/item/paper/proc/copy(paper_type = /obj/item/paper, atom/location = loc, colored = TRUE, greyscale_override = null)
	var/obj/item/paper/new_paper = new paper_type(location)
	var/datum/component/writing/our_text = GetComponent(/datum/component/writing)
	var/datum/component/writing/new_text = new_paper.GetComponent(/datum/component/writing)

	if(colored)
		new_paper.color = color
	our_text.copy_to(new_text, colored, greyscale_override)

	new_paper.update_icon_state()
	copy_overlays(new_paper, TRUE)
	return new_paper

/// Removes all input and all stamps from the paper, clearing it completely.
/obj/item/paper/proc/clear_paper()
	if(!QDELETED(src))
		AddComponent(/datum/component/writing) // deletes old component
	cut_overlays()
	update_appearance()

/obj/item/paper/pickup(user)
	if(contact_poison && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/clothing/gloves/G = H.gloves
		if(!istype(G) || G.transfer_prints)
			H.reagents.add_reagent(contact_poison,contact_poison_volume)
			contact_poison = null
	. = ..()

/obj/item/paper/update_icon_state()
	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	if(words && show_written_words && LAZYLEN(words.raw_text_inputs))
		icon_state = "[initial(icon_state)]_words"
	return ..()

/obj/item/paper/verb/rename()
	set name = "Rename paper"
	set category = "Object"
	set src in usr

	if(!usr.can_read(src) || usr.incapacitated(TRUE, TRUE) || isAdminObserver(usr))
		return
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(HAS_TRAIT(H, TRAIT_CLUMSY) && prob(25))
			to_chat(H, span_warning("You cut yourself on the paper! Ahhhh! Ahhhhh!"))
			H.damageoverlaytemp = 9001
			H.update_damage_hud()
			return
	var/n_name = stripped_input(usr, "What would you like to label the paper?", "Paper Labelling", null, MAX_NAME_LEN)
	if((loc == usr && usr.stat == CONSCIOUS))
		name = "paper[(n_name ? text("- '[n_name]'") : null)]"
	add_fingerprint(usr)

/obj/item/paper/ui_status(mob/user,/datum/ui_state/state)
	// Are we on fire?  Hard to read if so
	if(resistance_flags & ON_FIRE)
		return UI_CLOSE
	if(camera_holder && can_show_to_mob_through_camera(user) || request_state)
		return UI_UPDATE
	if(in_contents_of(/obj/machinery/door/airlock) || in_contents_of(/obj/item/clipboard))
		return UI_INTERACTIVE
	return ..()

/obj/item/paper/can_interact(mob/user)
	if(in_contents_of(/obj/machinery/door/airlock))
		return TRUE
	return ..()

/obj/item/proc/burn_paper_product_attackby_check(obj/item/I, mob/living/user, bypass_clumsy)
	var/ignition_message = I.ignition_effect(src, user)
	if(!ignition_message)
		return
	. = TRUE
	if(!bypass_clumsy && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(10) && Adjacent(user))
		user.visible_message(span_warning("[user] accidentally ignites [user.p_them()]self!"), \
							span_userdanger("You miss [src] and accidentally light yourself on fire!"))
		if(user.is_holding(I)) //checking if they're holding it in case TK is involved
			user.dropItemToGround(I)
		user.adjust_fire_stacks(1)
		user.ignite_mob()
		return

	if(user.is_holding(src)) //no TK shit here.
		user.dropItemToGround(src)
	user.visible_message(ignition_message)
	add_fingerprint(user)
	fire_act(I.get_temperature())

/obj/item/paper/attackby(obj/item/attacking_item, mob/living/user, params)
	if(burn_paper_product_attackby_check(attacking_item, user))
		SStgui.close_uis(src)
		return TRUE

	// Enable picking paper up by clicking on it with the clipboard or folder
	if(istype(attacking_item, /obj/item/clipboard) || istype(attacking_item, /obj/item/folder) || istype(attacking_item, /obj/item/paper_bin))
		attacking_item.attackby(src, user)
		return TRUE

	// Handle cutting paper apart
	if(!attacking_item.get_writing_implement_details() && attacking_item.sharpness > SHARP_NONE && !istype(src, /obj/item/paper/paperslip))
		if(do_after(user, 5, src))
			playsound(src.loc, 'sound/weapons/slash.ogg', 50, TRUE)
			to_chat(user, span_notice("You neatly cut [src]."))
			new /obj/item/paper/paperslip(get_turf(src))
			new /obj/item/paper/paperslip(get_turf(src))
			qdel(src)
		return TRUE

	return ..()

/**
 * Attempts to ui_interact the paper to the given user, with some sanity checking
 * to make sure the camera still exists via the weakref and that this paper is still
 * attached to it.
 */
/obj/item/paper/proc/show_through_camera(mob/living/user)
	if(!can_show_to_mob_through_camera(user))
		return

	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	return words?.ui_interact(user)

/obj/item/paper/proc/can_show_to_mob_through_camera(mob/living/user)
	var/obj/machinery/camera/held_to_camera = camera_holder.resolve()

	if(!held_to_camera)
		return FALSE

	if(isAI(user))
		var/mob/living/silicon/ai/ai_user = user
		if(ai_user.control_disabled || (ai_user.stat == DEAD))
			return FALSE

		return TRUE

	if(user.client?.eye != held_to_camera)
		return FALSE

	return TRUE

/obj/item/paper/ui_host(mob/user)
	if(istype(loc, /obj/structure/noticeboard))
		return loc
	return ..()

/// Adds raw text to the writing component
/obj/item/paper/proc/add_raw_text(text, font, color, bold, advanced_html)
	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	return words?.add_raw_text(text, font, color, bold, advanced_html)

/// Adds raw text to the writing component
/obj/item/paper/proc/add_stamp(stamp_class, stamp_x, stamp_y, rotation, stamp_icon_state)
	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	return words?.add_raw_text(stamp_class, stamp_x, stamp_y, rotation, stamp_icon_state)

/obj/item/paper/proc/get_total_length()
	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	return words?.get_total_length()

/// Get a single string representing the text on a page
/obj/item/paper/proc/get_raw_text()
	var/datum/component/writing/words = GetComponent(/datum/component/writing)
	return words?.get_raw_text()

/obj/item/paper/construction

/obj/item/paper/construction/Initialize(mapload)
	. = ..()
	color = pick(COLOR_RED, COLOR_LIME, COLOR_LIGHT_ORANGE, COLOR_DARK_PURPLE, COLOR_FADED_PINK, COLOR_BLUE_LIGHT)

/obj/item/paper/natural
	color = COLOR_OFF_WHITE

/obj/item/paper/crumpled
	name = "paper scrap"
	icon_state = "scrap"
	slot_flags = null
	show_written_words = FALSE

/obj/item/paper/crumpled/bloody
	icon_state = "scrap_bloodied"

/obj/item/paper/crumpled/muddy
	icon_state = "scrap_mud"
