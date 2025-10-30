GLOBAL_DATUM_INIT(fire_overlay, /mutable_appearance, mutable_appearance('icons/effects/fire.dmi', "fire"))

GLOBAL_DATUM_INIT(welding_sparks, /mutable_appearance, mutable_appearance('icons/effects/welding_effect.dmi', "welding_sparks", GASFIRE_LAYER, ABOVE_LIGHTING_PLANE))

GLOBAL_DATUM_INIT(cutting_effect, /mutable_appearance, mutable_appearance('icons/effects/cutting_effect.dmi', "cutting_effect", GASFIRE_LAYER, ABOVE_LIGHTING_PLANE))

GLOBAL_DATUM_INIT(advanced_cutting_effect, /mutable_appearance, mutable_appearance('icons/effects/cutting_effect.dmi', "advanced_cutting_effect", GASFIRE_LAYER, ABOVE_LIGHTING_PLANE))

GLOBAL_DATUM_INIT(cleaning_bubbles, /mutable_appearance, mutable_appearance('icons/effects/effects.dmi', "bubbles", ABOVE_MOB_LAYER, GAME_PLANE))

GLOBAL_VAR_INIT(rpg_loot_items, FALSE)
// if true, everyone item when created will have its name changed to be
// more... RPG-like.

GLOBAL_VAR_INIT(stickpocalypse, FALSE) // if true, all non-embeddable items will be able to harmlessly stick to people when thrown
GLOBAL_VAR_INIT(embedpocalypse, FALSE) // if true, all items will be able to embed in people, takes precedence over stickpocalypse

/obj/item
	name = "item"
	icon = 'icons/obj/items.dmi'
	blocks_emissive = EMISSIVE_BLOCK_GENERIC
	///percentage of armour effectiveness to remove
	armour_penetration = 0
	///icon state name for inhand overlays
	var/item_state = null
	///Icon file for left hand inhand overlays
	var/lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	///Icon file for right inhand overlays
	var/righthand_file = 'icons/mob/inhands/items_righthand.dmi'

	///If set it will add a world icon using item_state
	var/world_file

	///Handled by world_icon element
	var/world_state
	///Handled by world_icon element
	var/inventory_state

	///This is a bitfield that defines what variations exist for bodyparts like Digi legs.
	var/supports_variations = null

	///If set, kepori wearing this use this instead of their clothing file
	var/kepori_override_icon
	///If set, vox wearing this use this instead of their clothing file
	var/vox_override_icon

	/// Needs to follow this syntax: either a list() with the x and y coordinates of the pixel you want to get the colour from, or a hexcolour. Colour one replaces red, two replaces green, and three replaces blue in the icon state.
	var/list/greyscale_colors[3]
	/// Needs to be a RGB-greyscale format icon state in all species' clothing icon files.
	var/greyscale_icon_state

	///Icon file for mob worn overlays.
	var/icon/mob_overlay_icon
	///icon state for mob worn overlays, if null the normal icon_state will be used.
	var/mob_overlay_state
	///Forced mob worn layer instead of the standard preferred ssize.
	var/alternate_worn_layer

	///Dimensions of the icon file used when this item is worn, eg: hats.dmi (32x32 sprite, 64x64 sprite, etc.). Allows inhands/worn sprites to be of any size, but still centered on a mob properly
	var/worn_x_dimension = 32
	///Dimensions of the icon file used when this item is worn, eg: hats.dmi (32x32 sprite, 64x64 sprite, etc.). Allows inhands/worn sprites to be of any size, but still centered on a mob properly
	var/worn_y_dimension = 32
	///Same as for [worn_x_dimension][/obj/item/var/worn_x_dimension] but for inhands, uses the lefthand_ and righthand_ file vars
	var/inhand_x_dimension = 32
	///Same as for [worn_y_dimension][/obj/item/var/worn_y_dimension] but for inhands, uses the lefthand_ and righthand_ file vars
	var/inhand_y_dimension = 32

	/// Worn overlay will be shifted by this along y axis
	var/worn_y_offset = 0

	max_integrity = 200

	obj_flags = NONE
	///Item flags for the item
	var/item_flags = NONE

	///Sound played when you hit something with the item
	var/hitsound
	///Played when the item is used, for example tools
	var/usesound
	///Used when yate into a mob
	var/mob_throw_hit_sound
	///Sound used when an item has been equipped into a valid slot
	var/equip_sound
	///Sound uses when picking the item up (into your hands)
	var/pickup_sound
	///Sound uses when dropping the item, or when its thrown.
	var/drop_sound
	///Sound used when an item is being equipped with equip_delay
	var/equipping_sound
	///Sound used when an item is being unequipped with equip_delay
	var/unequipping_sound

	///flags used for equip_delay
	var/equip_self_flags = NONE

	///Whether or not we use stealthy audio levels for this item's attack sounds
	var/stealthy_audio = FALSE

	/// Weight class for how much storage capacity it uses and how big it physically is meaning storages can't hold it if their maximum weight class isn't as high as it.
	var/w_class = WEIGHT_CLASS_NORMAL
	/// Volume override for the item, otherwise automatically calculated from w_class.
	var/w_volume

	///This is used to determine on which slots an item can fit.
	var/slot_flags = 0
	pass_flags = PASSTABLE
	pressure_resistance = 4
	var/obj/item/master = null

	///flags which determine which body parts are protected from heat. [See here][HEAD]
	var/heat_protection = 0
	///flags which determine which body parts are protected from cold. [See here][HEAD]
	var/cold_protection = 0
	///Set this variable to determine up to which temperature (IN KELVIN) the item protects against heat damage. Keep at null to disable protection. Only protects areas set by heat_protection flags
	var/max_heat_protection_temperature
	///Set this variable to determine down to which temperature (IN KELVIN) the item protects against cold damage. 0 is NOT an acceptable number due to if(varname) tests!! Keep at null to disable protection. Only protects areas set by cold_protection flags
	var/min_cold_protection_temperature

	///list of /datum/action's that this item has.
	var/list/actions
	///list of paths of action datums to give to the item on New().
	var/list/actions_types

	//Since any item can now be a piece of clothing, this has to be put here so all items share it.
	///This flag is used to determine when items in someone's inventory cover others. IE helmets making it so you can't see glasses, etc.
	var/flags_inv
	///you can see someone's mask through their transparent visor, but you can't reach it
	var/transparent_protection = NONE

	///flags for what should be done when you click on the item, default is picking it up
	var/interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_PICKUP

	/// Used in picking icon_states based on the string color here. Also used for cables or something. This could probably do with being deprecated.
	var/item_color = null

	///What body parts are covered by the clothing when you wear it
	var/body_parts_covered = 0
	///Literally does nothing right now
	var/gas_transfer_coefficient = 1
	/// How likely a disease or chemical is to get through a piece of clothing
	var/permeability_coefficient = 1
	/// for electrical admittance/conductance (electrocution checks and shit)
	var/siemens_coefficient = 1
	/// How much clothing is slowing you down. Negative values speeds you up
	var/slowdown = 0
	///What objects the suit storage can store
	var/list/allowed = null
	///In deciseconds, how long an item takes to equip; counts only for normal clothing slots, not pockets etc.
	var/equip_delay_self = 0
	///In deciseconds, how long an item takes to put on another person
	var/equip_delay_other = 20
	///In deciseconds, how long an item takes to remove from another person
	var/strip_delay = 40
	///How long it takes to resist out of the item (cuffs and such)
	var/breakouttime = 0
	///How much power would this item use?
	var/power_use_amount = POWER_CELL_USE_NORMAL

	/// Used in attackby() to say how something was attacked "[x] has been [z.attack_verb] by [y] with [z]"
	var/list/attack_verb
	/// list() of species types, if a species cannot put items in a certain slot, but species type is in list, it will be able to wear that item
	var/list/species_exception = null
	///A bitfield of bodytypes that the item cannot be worn by.
	var/restricted_bodytypes = null

	///A weakref to the mob who threw the item
	var/datum/weakref/thrownby = null //I cannot verbally describe how much I hate this var

	///the icon to indicate this object is being dragged
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER

	///Does it embed and if yes, what kind of embed
	var/list/embedding

	///for flags such as [GLASSESCOVERSEYES]
	var/flags_cover = 0
	var/heat = 0
	///All items with sharpness of SHARP_EDGED or higher will automatically get the butchering component.
	var/sharpness = SHARP_NONE

	///How a tool acts when you use it on something, such as wirecutters cutting wires while multitools measure power
	var/tool_behaviour = NONE
	///How fast does the tool work
	var/toolspeed = 1
	/// how much damage does this item do when tearing down walls during deconstruction steps?
	var/wall_decon_damage = 0

	var/block_chance = 0
	var/block_cooldown_time = 1 SECONDS
	COOLDOWN_DECLARE(block_cooldown)
	var/hit_reaction_chance = 0 //If you want to have something unrelated to blocking/armour piercing etc. Maybe not needed, but trying to think ahead/allow more freedom
	///In tiles, how far this weapon can reach; 1 for adjacent, which is default
	var/reach = 1

	///The list of slots by priority. equip_to_appropriate_slot() uses this list. Doesn't matter if a mob type doesn't have a slot. For default list, see [/mob/proc/equip_to_appropriate_slot]
	var/list/slot_equipment_priority = null

	///Reference to the datum that determines whether dogs can wear the item: Needs to be in /obj/item because corgis can wear a lot of non-clothing items
	var/datum/dog_fashion/dog_fashion = null

	//Tooltip vars
	///string form of an item's force. Edit this var only to set a custom force string
	var/force_string
	var/last_force_string_check = 0
	var/tip_timer

	///Determines who can shoot this
	var/trigger_guard = TRIGGER_GUARD_NONE

	///Used as the dye color source in the washing machine only (at the moment). Can be a hex color or a key corresponding to a registry entry, see washing_machine.dm
	var/dye_color
	///Whether the item is unaffected by standard dying.
	var/undyeable = FALSE
	///What dye registry should be looked at when dying this item; see washing_machine.dm
	var/dying_key

	///Grinder var:A reagent list containing the reagents this item produces when ground up in a grinder - this can be an empty list to allow for reagent transferring only
	var/list/grind_results
	//Grinder var:A reagent list containing blah blah... but when JUICED in a grinder!
	var/list/juice_results

	//the outline filter on hover
	var/outline_filter

	var/canMouseDown = FALSE

	var/attack_cooldown = CLICK_CD_MELEE

	/// Has the item been reskinned?
	var/current_skin
	/// List of options to reskin.
	var/list/unique_reskin
	/// If reskins change base icon state as well
	var/unique_reskin_changes_base_icon_state = FALSE
	/// If reskins change inhands as well
	var/unique_reskin_changes_inhand = FALSE
	var/unique_reskin_changes_name = FALSE

	bad_type = /obj/item

/obj/item/Initialize()

	if(attack_verb)
		attack_verb = typelist("attack_verb", attack_verb)

	. = ..()
	for(var/path in actions_types)
		new path(src)
	actions_types = null

	if(force_string)
		item_flags |= FORCE_STRING_OVERRIDE

	if(istype(loc, /obj/item/storage))
		item_flags |= IN_STORAGE

	if(istype(loc, /obj/item/robot_module))
		item_flags |= IN_INVENTORY

	if(!hitsound)
		if(damtype == "fire")
			hitsound = 'sound/items/welder.ogg'
		if(damtype == "brute")
			hitsound = "swing_hit"

	setup_reskinning()

/obj/item/Destroy()
	item_flags &= ~DROPDEL	//prevent reqdels
	if(ismob(loc))
		var/mob/m = loc
		m.temporarilyRemoveItemFromInventory(src, TRUE)
	for(var/X in actions)
		qdel(X)
	return ..()

/// Called when an action associated with our item is deleted
/obj/item/proc/on_action_deleted(datum/source)
	SIGNAL_HANDLER

	if(!(source in actions))
		CRASH("An action ([source.type]) was deleted that was associated with an item ([src]), but was not found in the item's actions list.")

	LAZYREMOVE(actions, source)


/// Adds an item action to our list of item actions.
/// Item actions are actions linked to our item, that are granted to mobs who equip us.
/// This also ensures that the actions are properly tracked in the actions list and removed if they're deleted.
/// Can be be passed a typepath of an action or an instance of an action.
/obj/item/proc/add_item_action(action_or_action_type)

	var/datum/action/action
	if(ispath(action_or_action_type, /datum/action))
		action = new action_or_action_type(src)
	else if(istype(action_or_action_type, /datum/action))
		action = action_or_action_type
	else
		CRASH("item add_item_action got a type or instance of something that wasn't an action.")

	LAZYADD(actions, action)
	RegisterSignal(action, COMSIG_PARENT_QDELETING, PROC_REF(on_action_deleted))
	grant_action_to_bearer(action)
	return action

/// Grant the action to anyone who has this item equipped to an appropriate slot
/obj/item/proc/grant_action_to_bearer(datum/action/action)
	if(!ismob(loc))
		return
	var/mob/holder = loc
	give_item_action(action, holder, holder.get_slot_by_item(src))

/// Removes an instance of an action from our list of item actions.
/obj/item/proc/remove_item_action(datum/action/action)
	if(!action)
		return

	UnregisterSignal(action, COMSIG_PARENT_QDELETING)
	LAZYREMOVE(actions, action)
	qdel(action)

/obj/item/proc/check_allowed_items(atom/target, not_inside, target_self)
	if(((src in target) && !target_self) || (!isturf(target.loc) && !isturf(target) && not_inside))
		return 0
	else
		return 1

/obj/item/ComponentInitialize()
	. = ..()
	// this proc says it's for initializing components, but we're initializing elements too because it's you and me against the world >:)
	if(!LAZYLEN(embedding))
		if(GLOB.embedpocalypse)
			embedding = EMBED_POINTY
			name = "pointy [name]"
		else if(GLOB.stickpocalypse)
			embedding = EMBED_HARMLESS
			name = "sticky [name]"

	updateEmbedding()

	if(world_file)
		AddElement(/datum/element/world_icon, null, world_file, icon)

	if(GLOB.rpg_loot_items)
		AddComponent(/datum/component/fantasy)

	if(sharpness) //give sharp objects butchering functionality, for consistency
		AddComponent(/datum/component/butchering, 80 * toolspeed)

/obj/item/verb/move_to_top()
	set name = "Move To Top"
	set category = "Object"
	set src in oview(1)

	if(!isturf(loc) || usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))
		return

	if(isliving(usr))
		var/mob/living/L = usr
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return

	var/turf/T = loc
	abstract_move(null)
	forceMove(T)

/obj/item/examine(mob/user)
	. = ..()

	if(unique_reskin && !current_skin)
		. += span_notice("<b>Alt-click</b> it to reskin it.")

	. += span_notice("[gender == PLURAL ? "They are" : "It is"] a <b>[weightclass2text(w_class)]</b> item.")

	if(resistance_flags & INDESTRUCTIBLE)
		. += span_notice("[src] looks incredibly tough. No way to get through this.")
	else
		if(resistance_flags & LAVA_PROOF)
			. += span_notice("[src] is made of <b>lava-resistant</b> materials.")
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += span_notice("[src] is made of <b>acid-resistant</b> materials.")
		if(resistance_flags & FREEZE_PROOF)
			. += span_notice("[src] is made of <b>cold-resistant</b> materials.")
		if(resistance_flags & FIRE_PROOF)
			. += span_notice("[src] is made of <b>fire-resistant</b> materials.")

	if(!user.research_scanner)
		return

	//what even is all this garbage
	/// Research prospects, including boostable nodes and point values. Deliver to a console to know whether the boosts have already been used.
	var/list/research_msg = list("<font color='purple'>Research prospects:</font> ")
	///Separator between the items on the list
	var/sep = ""
	///Nodes that can be boosted
	var/list/boostable_nodes = techweb_item_boost_check(src)

	if(boostable_nodes)
		for(var/id in boostable_nodes)
			var/datum/techweb_node/node = SSresearch.techweb_node_by_id(id)
			if(!node)
				continue
			research_msg += sep
			research_msg += node.display_name
			sep = ", "
	var/list/points = techweb_item_point_check(src)
	if(length(points))
		sep = ", "
		research_msg += techweb_point_display_generic(points)

	if(!sep) // nothing was shown
		research_msg += "None"

	//Extractable materials. Only shows the names, not the amounts.
	research_msg += ".<br><font color='purple'>Extractable materials:</font> "
	if(length(custom_materials))
		sep = ""
		for(var/mat in custom_materials)
			research_msg += sep
			research_msg += CallMaterialName(mat)
			sep = ", "
	else
		research_msg += "None"
	research_msg += "."
	. += research_msg.Join()

/obj/item/interact(mob/user)
	add_fingerprint(user)
	ui_interact(user)

/obj/item/ui_act(action, list/params)
	add_fingerprint(usr)
	return ..()

/obj/item/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!user)
		return
	if(anchored)
		return

	//check if the item is inside another item's storage
	if(istype(loc, /obj/item/storage))
		//if so, can we actually access it?
		var/datum/component/storage/ourstorage = loc.GetComponent(/datum/component/storage)
		if(!ourstorage.access_check())
			SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_HIDE_FROM, user)//you're not supposed to be in here right now, punk!
			return

	if(resistance_flags & ON_FIRE)
		var/mob/living/carbon/C = user
		var/can_handle_hot = FALSE
		if(!istype(C))
			can_handle_hot = TRUE
		else if(C.gloves && (C.gloves.max_heat_protection_temperature > 360))
			can_handle_hot = TRUE
		else if(HAS_TRAIT(C, TRAIT_RESISTHEAT) || HAS_TRAIT(C, TRAIT_RESISTHEATHANDS))
			can_handle_hot = TRUE

		if(can_handle_hot)
			extinguish()
			to_chat(user, span_notice("You put out the fire on [src]."))
		else
			to_chat(user, span_warning("You burn your hand on [src]!"))
			var/obj/item/bodypart/affecting = C.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
			if(affecting && affecting.receive_damage(0, 5))		// 5 burn damage
				C.update_damage_overlays()
			return

	if(acid_level > 20 && !ismob(loc))// so we can still remove the clothes on us that have acid.
		var/mob/living/carbon/C = user
		if(istype(C))
			if(!C.gloves || (!(C.gloves.resistance_flags & (UNACIDABLE|ACID_PROOF))))
				to_chat(user, span_warning("The acid on [src] burns your hand!"))
				var/obj/item/bodypart/affecting = C.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				if(affecting && affecting.receive_damage(0, 5))		// 5 burn damage
					C.update_damage_overlays()

	if(!(interaction_flags_item & INTERACT_ITEM_ATTACK_HAND_PICKUP))		//See if we're supposed to auto pickup.
		return

	//Heavy gravity makes picking up things very slow.
	var/grav = user.has_gravity()
	if(grav > STANDARD_GRAVITY)
		var/grav_power = min(3,grav - STANDARD_GRAVITY)
		to_chat(user,span_notice("You start picking up [src]..."))
		if(!do_after(user, 30*grav_power, src))
			return


	//If the item is in a storage item, take it out
	SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_TAKE, src, user.loc, TRUE)
	if(QDELETED(src)) //moving it out of the storage to the floor destroyed it.
		return

	if(throwing)
		throwing.finalize(FALSE)
	if(loc == user)
		if(!allow_attack_hand_drop(user) || !user.temporarilyRemoveItemFromInventory(src, use_unequip_delay = TRUE))
			return

	remove_outline()
	pickup(user)
	add_fingerprint(user)
	if(!user.put_in_active_hand(src, FALSE, FALSE))
		user.dropItemToGround(src)

/obj/item/proc/allow_attack_hand_drop(mob/user)
	return TRUE

/obj/item/attack_paw(mob/user)
	if(!user)
		return
	if(anchored)
		return

	SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_TAKE, src, user.loc, TRUE)

	if(throwing)
		throwing.finalize(FALSE)
	if(loc == user)
		if(!user.temporarilyRemoveItemFromInventory(src))
			return

	pickup(user)
	add_fingerprint(user)
	if(!user.put_in_active_hand(src, FALSE, FALSE))
		user.dropItemToGround(src)

/obj/item/attack_alien(mob/user)
	var/mob/living/carbon/alien/A = user

	if(!A.has_fine_manipulation)
		if(src in A.contents) // To stop Aliens having items stuck in their pockets
			A.dropItemToGround(src)
		to_chat(user, span_warning("Your claws aren't capable of such fine manipulation!"))
		return
	attack_paw(A)

/obj/item/attack_ai(mob/user)
	if(istype(src.loc, /obj/item/robot_module))
		//If the item is part of a cyborg module, equip it
		if(!iscyborg(user))
			return
		var/mob/living/silicon/robot/R = user
		if(!R.low_power_mode) //can't equip modules with an empty cell.
			R.activate_module(src)
			R.hud_used.update_robot_modules_display()

/obj/item/proc/GetDeconstructableContents()
	return GetAllContents() - src

// afterattack() and attack() prototypes moved to _onclick/item_attack.dm for consistency

/obj/item/proc/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	//Mostly shields
	if((prob(final_block_chance) && COOLDOWN_FINISHED(src, block_cooldown)) || (prob(final_block_chance) && istype(src, /obj/item/shield)))
		owner.visible_message(span_danger("[owner] blocks [attack_text] with [src]!"))
		playsound(src, 'sound/weapons/effects/deflect.ogg', 100)
		if(!istype(src, /obj/item/shield))
			COOLDOWN_START(src, block_cooldown, block_cooldown_time)
		return TRUE

	var/signal_result = (SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, owner, hitby, damage, attack_type)) + prob(final_block_chance)
	if(!signal_result)
		return FALSE
	if(hit_reaction_chance >= 0)
		owner.visible_message(span_danger("[owner] blocks [attack_text] with [src]!"))
	return signal_result

/obj/item/proc/talk_into(mob/M, input, channel, spans, datum/language/language, list/message_mods)
	return ITALICS | REDUCE_RANGE

/obj/item/proc/dropped(mob/user, silent = FALSE)
	SHOULD_CALL_PARENT(1)
	for(var/X in actions)
		var/datum/action/A = X
		A.Remove(user)
	if(item_flags & DROPDEL)
		qdel(src)
	item_flags &= ~IN_INVENTORY
	SEND_SIGNAL(src, COMSIG_ITEM_DROPPED,user)
	remove_outline()
	if(!silent)
		playsound(src, drop_sound, DROP_SOUND_VOLUME, ignore_walls = FALSE)
	user?.update_equipment_speed_mods()

/// called just as an item is picked up (loc is not yet changed)
/obj/item/proc/pickup(mob/user)
	SHOULD_CALL_PARENT(1)
	SEND_SIGNAL(src, COMSIG_ITEM_PICKUP, user)
	SEND_SIGNAL(user, COMSIG_MOB_PICKUP_ITEM, src)
	item_flags |= IN_INVENTORY

/// called when "found" in pockets and storage items. Returns 1 if the search should end.
/obj/item/proc/on_found(mob/finder)
	return


/**
 * To be overwritten to only perform visual tasks;
 * this is directly called instead of `equipped` on visual-only features like human dummies equipping outfits.
 *
 * This separation exists to prevent things like the monkey sentience helmet from
 * polling ghosts while it's just being equipped as a visual preview for a dummy.
 */
/obj/item/proc/visual_equipped(mob/user, slot, initial = FALSE)
	return

/**
 *called after an item is placed in an equipment slot

 * Arguments:
 * * user is mob that equipped it
 * * slot uses the slot_X defines found in setup.dm for items that can be placed in multiple slots
 * * Initial is used to indicate whether or not this is the initial equipment (job datums etc) or just a player doing it
 */
/obj/item/proc/equipped(mob/user, slot, initial = FALSE)
	SHOULD_CALL_PARENT(1)
	visual_equipped(user, slot, initial)
	for(var/X in actions)
		var/datum/action/A = X
		if(item_action_slot_check(slot, user)) //some items only give their actions buttons when in a specific slot.
			A.Grant(user)
	item_flags |= IN_INVENTORY
	SEND_SIGNAL(src, COMSIG_ITEM_EQUIPPED, user, slot)
	if(!initial)
		if(equip_sound && (slot_flags & slot))
			playsound(src, equip_sound, EQUIP_SOUND_VOLUME, TRUE, ignore_walls = FALSE)
		else if(slot == ITEM_SLOT_HANDS)
			playsound(src, pickup_sound, PICKUP_SOUND_VOLUME, ignore_walls = FALSE)
	user.update_equipment_speed_mods()

/// Gives one of our item actions to a mob, when equipped to a certain slot
/obj/item/proc/give_item_action(datum/action/action, mob/to_who, slot)
	// Some items only give their actions buttons when in a specific slot.
	if(!item_action_slot_check(slot, to_who))
		// There is a chance we still have our item action currently,
		// and are moving it from a "valid slot" to an "invalid slot".
		// So call Remove() here regardless, even if excessive.
		action.Remove(to_who)
		return

	action.Grant(to_who)

/// Sometimes we only want to grant the item's action if it's equipped in a specific slot.
/obj/item/proc/item_action_slot_check(slot, mob/user, datum/action/action)
	if(slot & (ITEM_SLOT_BACKPACK|ITEM_SLOT_LEGCUFFED)) //these aren't true slots, so avoid granting actions there
		return FALSE
	return TRUE

/**
 *the mob M is attempting to equip this item into the slot passed through as 'slot'. Return 1 if it can do this and 0 if it can't.
 *if this is being done by a mob other than M, it will include the mob equipper, who is trying to equip the item to mob M. equipper will be null otherwise.
 *If you are making custom procs but would like to retain partial or complete functionality of this one, include a 'return ..()' to where you want this to happen.
 * Arguments:
 * * disable_warning to TRUE if you wish it to not give you text outputs.
 * * slot is the slot we are trying to equip to
 * * equipper is the mob trying to equip the item
 * * bypass_equip_delay_self for whether we want to bypass the equip delay
 */
/obj/item/proc/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, swap = FALSE)
	if(!M)
		return FALSE

	return M.can_equip(src, slot, disable_warning, bypass_equip_delay_self, swap)

/obj/item/verb/verb_pickup()
	set src in oview(1)
	set category = "Object"
	set name = "Pick up"

	if(usr.incapacitated() || !Adjacent(usr))
		return

	if(isliving(usr))
		var/mob/living/L = usr
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return

	if(usr.get_active_held_item() == null) // Let me know if this has any problems -Yota
		usr.UnarmedAttack(src)

/**
 *This proc is executed when someone clicks the on-screen UI button.
 *The default action is attack_self().
 *Checks before we get to here are: mob is alive, mob is not restrained, stunned, asleep, resting, laying, item is on the mob.
 */
/obj/item/proc/ui_action_click(mob/user, actiontype)
	attack_self(user)

///This proc determines if and at what an object will reflect energy projectiles if it's in l_hand,r_hand or wear_suit
/obj/item/proc/IsReflect(def_zone)
	return FALSE

/obj/item/proc/eyestab(mob/living/carbon/M, mob/living/carbon/user)

	var/is_human_victim
	var/obj/item/bodypart/affecting = M.get_bodypart(BODY_ZONE_HEAD)
	if(ishuman(M))
		if(!affecting) //no head!
			return
		is_human_victim = TRUE

	if(M.is_eyes_covered())
		// you can't stab someone in the eyes wearing a mask!
		to_chat(user, span_warning("You're going to need to remove [M.p_their()] eye protection first!"))
		return

	if(isalien(M))//Aliens don't have eyes./N     slimes also don't have eyes!
		to_chat(user, span_warning("You cannot locate any eyes on this creature!"))
		return

	if(isbrain(M))
		to_chat(user, span_warning("You cannot locate any organic eyes on this brain!"))
		return

	src.add_fingerprint(user)

	playsound(loc, src.hitsound, 30, TRUE, -1)

	user.do_attack_animation(M)

	if(M != user)
		M.visible_message(span_danger("[user] stabs [M] in the eye with [src]!"), \
							span_userdanger("[user] stabs you in the eye with [src]!"))
	else
		user.visible_message( \
			span_danger("[user] stabs [user.p_them()]self in the eyes with [src]!"), \
			span_userdanger("You stab yourself in the eyes with [src]!") \
		)
	if(is_human_victim)
		var/mob/living/carbon/human/U = M
		U.apply_damage(7, BRUTE, affecting)

	else
		M.take_bodypart_damage(7)

	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "eye_stab", /datum/mood_event/eye_stab)

	log_combat(user, M, "attacked", "[src.name]", "(INTENT: [uppertext(user.a_intent)])")

	var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	M.adjust_blurriness(3)
	eyes.applyOrganDamage(rand(2,4))
	if(eyes.damage >= 10)
		M.adjust_blurriness(15)
		if(M.stat != DEAD)
			to_chat(M, span_danger("Your eyes start to bleed profusely!"))
		if(!(M.is_blind() || HAS_TRAIT(M, TRAIT_NEARSIGHT)))
			to_chat(M, span_danger("You become nearsighted!"))
		M.become_nearsighted(EYE_DAMAGE)
		if(prob(50))
			if(M.stat != DEAD)
				if(M.drop_all_held_items())
					to_chat(M, span_danger("You drop what you're holding and clutch at your eyes!"))
			M.adjust_blurriness(10)
			M.Unconscious(20)
			M.Paralyze(40)
		if (prob(eyes.damage - 10 + 1))
			M.become_blind(EYE_DAMAGE)
			to_chat(M, span_danger("You go blind!"))

/obj/item/singularity_pull(S, current_size)
	..()
	if(current_size >= STAGE_FOUR)
		throw_at(S,14,3, spin=0)
	else
		return

/obj/item/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(hit_atom && !QDELETED(hit_atom))
		SEND_SIGNAL(src, COMSIG_MOVABLE_IMPACT, hit_atom, throwingdatum)
		if(get_temperature() && isliving(hit_atom))
			var/mob/living/L = hit_atom
			L.IgniteMob()
		var/itempush = 1
		if(w_class < 4)
			itempush = 0 //too light to push anything
		if(istype(hit_atom, /mob/living)) //Living mobs handle hit sounds differently.
			var/volume = get_volume_by_throwforce_and_or_w_class()
			if (throwforce > 0)
				if (mob_throw_hit_sound)
					playsound(hit_atom, mob_throw_hit_sound, volume, TRUE, -1)
				else if(hitsound)
					playsound(hit_atom, hitsound, volume, TRUE, -1)
				else
					playsound(hit_atom, 'sound/weapons/genhit.ogg',volume, TRUE, -1)
			else
				playsound(hit_atom, 'sound/weapons/throwtap.ogg', 1, volume, -1)

		else
			playsound(src, drop_sound, YEET_SOUND_VOLUME, ignore_walls = FALSE)
		return hit_atom.hitby(src, 0, itempush, throwingdatum=throwingdatum)

/obj/item/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	if(HAS_TRAIT(src, TRAIT_NODROP))
		return
	thrownby = WEAKREF(thrower)
	callback = CALLBACK(src, PROC_REF(after_throw), callback) //replace their callback with our own
	. = ..(target, range, speed, thrower, spin, diagonals_first, callback, force, gentle, quickstart = quickstart)

/obj/item/proc/after_throw(datum/callback/callback)
	if (callback) //call the original callback
		. = callback.Invoke()
	item_flags &= ~IN_INVENTORY
	if(!pixel_y && !pixel_x && !(item_flags & NO_PIXEL_RANDOM_DROP))
		pixel_x = rand(-8,8)
		pixel_y = rand(-8,8)


/obj/item/proc/remove_item_from_storage(atom/newLoc) //please use this if you're going to snowflake an item out of a obj/item/storage
	if(!newLoc)
		return FALSE
	if(SEND_SIGNAL(loc, COMSIG_CONTAINS_STORAGE))
		return SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_TAKE, src, newLoc, TRUE)
	return FALSE

/obj/item/proc/get_belt_overlay() //Returns the icon used for overlaying the object on a belt
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', icon_state)

/obj/item/proc/get_helmet_overlay() // returns the icon for overlaying on a helmet
	return mutable_appearance('icons/mob/clothing/helmet_overlays.dmi', icon_state)

/obj/item/proc/update_slot_icon()
	if(!ismob(loc))
		return
	var/mob/owner = loc
	var/flags = slot_flags
	if(flags & ITEM_SLOT_OCLOTHING)
		owner.update_inv_wear_suit()
	if(flags & ITEM_SLOT_ICLOTHING)
		owner.update_inv_w_uniform()
	if(flags & ITEM_SLOT_GLOVES)
		owner.update_inv_gloves()
	if(flags & ITEM_SLOT_EYES)
		owner.update_inv_glasses()
	if(flags & ITEM_SLOT_EARS)
		owner.update_inv_ears()
	if(flags & ITEM_SLOT_MASK)
		owner.update_inv_wear_mask()
	if(flags & ITEM_SLOT_HEAD)
		owner.update_inv_head()
	if(flags & ITEM_SLOT_FEET)
		owner.update_inv_shoes()
	if(flags & ITEM_SLOT_ID)
		owner.update_inv_wear_id()
	if(flags & ITEM_SLOT_BELT)
		owner.update_inv_belt()
	if(flags & ITEM_SLOT_BACK)
		owner.update_inv_back()
	if(flags & ITEM_SLOT_NECK)
		owner.update_inv_neck()

///Returns the temperature of src. If you want to know if an item is hot use this proc.
/obj/item/proc/get_temperature()
	return heat

///Returns the sharpness of src. If you want to get the sharpness of an item use this.
/obj/item/proc/get_sharpness()
	return sharpness

/obj/item/proc/get_dismember_sound()
	if(damtype == BURN)
		. = 'sound/weapons/sear.ogg'
	else
		. = "desceration"

/obj/item/proc/open_flame(flame_heat=700)
	var/turf/location = loc
	if(ismob(location))
		var/mob/M = location
		var/success = FALSE
		if(src == M.get_item_by_slot(ITEM_SLOT_MASK))
			success = TRUE
		if(success)
			location = get_turf(M)
	if(isturf(location))
		location.hotspot_expose(flame_heat, 5)
		if(SEND_SIGNAL(location, COMSIG_TURF_OPEN_FLAME, flame_heat) & BLOCK_TURF_IGNITION)
			return
		var/turf/open/open_location = loc // NOT the location variable used earlier else cigarettes in mouths start fires
		if(isopenturf(open_location) && open_location.flammability >= 1 && prob(open_location.flammability))
			open_location.ignite_turf(2) // if there's enough flammability for a fire to sustain itself..

/obj/item/proc/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_notice("[user] lights [A] with [src].")
	else
		. = ""

/obj/item/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	return SEND_SIGNAL(src, COMSIG_ATOM_HITBY, AM, skipcatch, hitpush, blocked, throwingdatum)

/obj/item/attack_hulk(mob/living/carbon/human/user)
	return FALSE

/obj/item/attack_animal(mob/living/simple_animal/M)
	if (obj_flags & CAN_BE_HIT)
		return ..()
	return 0

/obj/item/mech_melee_attack(obj/mecha/M)
	return 0

/obj/item/attack_basic_mob(mob/living/basic/user, list/modifiers)
	if (obj_flags & CAN_BE_HIT)
		return ..()
	return 0

/obj/item/burn()
	if(!QDELETED(src))
		var/turf/T = get_turf(src)
		var/ash_type = /obj/effect/decal/cleanable/ash
		if(w_class == WEIGHT_CLASS_HUGE || w_class == WEIGHT_CLASS_GIGANTIC)
			ash_type = /obj/effect/decal/cleanable/ash/large
		var/obj/effect/decal/cleanable/ash/A = new ash_type(T)
		A.desc += "\nLooks like this used to be \an [name] some time ago."
		..()

/obj/item/acid_melt()
	if(!QDELETED(src))
		var/turf/T = get_turf(src)
		var/obj/effect/decal/cleanable/molten_object/MO = new(T)
		MO.pixel_x = rand(-16,16)
		MO.pixel_y = rand(-16,16)
		MO.desc = "Looks like this was \an [src] some time ago."
		..()

/obj/item/proc/microwave_act(obj/machinery/microwave/M)
	if(SEND_SIGNAL(src, COMSIG_ITEM_MICROWAVE_ACT, M) & COMPONENT_SUCCESFUL_MICROWAVE)
		return
	if(istype(M) && M.dirty < 100)
		M.dirty++

/obj/item/proc/on_mob_death(mob/living/L, gibbed)

/obj/item/proc/grind_requirements(obj/machinery/reagentgrinder/R) //Used to check for extra requirements for grinding an object
	return TRUE

///Called BEFORE the object is ground up - use this to change grind results based on conditions. Use "return -1" to prevent the grinding from occurring
/obj/item/proc/on_grind()

/obj/item/proc/on_juice()

/obj/item/proc/set_force_string()
	switch(force)
		if(0 to 3)
			force_string = "pitiful"
		if(3 to 6)
			force_string = "very low"
		if(6 to 9)
			force_string = "low"
		if(10 to 13) //12 is the force of a toolbox
			force_string = "medium"
		if(13 to 16)
			force_string = "high"
		if(16 to 20)
			force_string = "robust"
		if(20 to 25)
			force_string = "very robust"
		if(25 to 30)
			force_string = "exceptionally robust"
		else
			force_string = "unfair"

	last_force_string_check = force

/obj/item/proc/openTip(location, control, params, user)
	if(last_force_string_check != force && !(item_flags & FORCE_STRING_OVERRIDE))
		set_force_string()
	if(!(item_flags & FORCE_STRING_OVERRIDE))
		openToolTip(user,src,params,title = name,content = "[desc]<br>[force ? "<b>Force:</b> [force_string]" : ""]",theme = "")
	else
		openToolTip(user,src,params,title = name,content = "[desc]<br><b>Force:</b> [force_string]",theme = "")

/obj/item/MouseEntered(location, control, params)
	. = ..()
	SEND_SIGNAL(src, COMSIG_ITEM_MOUSE_ENTER, location, control, params)
	if((item_flags & IN_INVENTORY || item_flags & IN_STORAGE) && usr.client.prefs.enable_tips && !QDELETED(src))
		var/timedelay = usr.client.prefs.tip_delay/100
		var/user = usr
		tip_timer = addtimer(CALLBACK(src, PROC_REF(openTip), location, control, params, user), timedelay, TIMER_STOPPABLE)//timer takes delay in deciseconds, but the pref is in milliseconds. dividing by 100 converts it.
	var/mob/living/L = usr
	if(istype(L) && L.incapacitated())
		apply_outline(COLOR_RED_GRAY)
	else
		apply_outline()

/obj/item/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	remove_outline()

/obj/item/MouseExited(location,control,params)
	SEND_SIGNAL(src, COMSIG_ITEM_MOUSE_EXIT, location, control, params)
	deltimer(tip_timer)//delete any in-progress timer if the mouse is moved off the item before it finishes
	closeToolTip(usr)
	remove_outline()

/obj/item/proc/apply_outline(colour = null)
	if(!(item_flags & IN_INVENTORY || item_flags & IN_STORAGE) || QDELETED(src) || isobserver(usr))
		return
	if(usr.client)
		if(!usr.client.prefs.outline_enabled)
			return
	if(!colour)
		if(usr.client)
			colour = usr.client.prefs.outline_color
			if(!colour)
				colour = COLOR_BLUE_GRAY
		else
			colour = COLOR_BLUE_GRAY
	add_filter(HOVER_OUTLINE_FILTER, 1, list(type="outline", size=1, color=colour))


/obj/item/proc/remove_outline()
	remove_filter(HOVER_OUTLINE_FILTER)

/// Use the power of an attached component that posesses power handling, will return the signal bitflag.
/obj/item/proc/item_use_power(use_amount, mob/user, check_only)
	SHOULD_CALL_PARENT(TRUE)
	return SEND_SIGNAL(src, COMSIG_ITEM_POWER_USE, use_amount, user, check_only)

/// Called when a mob tries to use the item as a tool.Handles most checks.
/obj/item/proc/use_tool(atom/target, mob/living/user, delay, amount=0, volume=0, datum/callback/extra_checks)
	// we have no target, why are we even doing this?
	if(isnull(target))
		return
	// No delay means there is no start message, and no reason to call tool_start_check before use_tool.
	// Run the start check here so we wouldn't have to call it manually.
	if(!delay && !tool_start_check(user, amount))
		return

	delay *= toolspeed

	// Play tool sound at the beginning of tool usage.
	play_tool_sound(target, volume)

	if(delay)
		// Create a callback with checks that would be called every tick by do_after.
		var/datum/callback/tool_check = CALLBACK(src, PROC_REF(tool_check_callback), user, target, amount, extra_checks)

		if(ismob(target))
			if(!do_after(user, delay, target, extra_checks=tool_check))
				return
		else
			if(!do_after(user, delay, target=target, extra_checks=tool_check))
				return
	else
		// Invoke the extra checks once, just in case.
		if(extra_checks && !extra_checks.Invoke())
			return

	// Use tool's fuel, stack sheets or charges if amount is set.
	if(amount && !use(amount))
		return

	// Play tool sound at the end of tool usage,
	// but only if the delay between the beginning and the end is not too small
	if(delay >= MIN_TOOL_SOUND_DELAY)
		play_tool_sound(target, volume)

	return TRUE

/// Called before [obj/item/proc/use_tool] if there is a delay, or by [obj/item/proc/use_tool] if there isn't. Only ever used by welding tools and stacks, so it's not added on any other [obj/item/proc/use_tool] checks.
/obj/item/proc/tool_start_check(mob/living/user, atom/target, amount=0)
	. = tool_use_check(user, target, amount)
	if(.)
		SEND_SIGNAL(src, COMSIG_TOOL_START_USE, user)

/// A check called by [/obj/item/proc/tool_start_check] once, and by use_tool on every tick of delay.
/obj/item/proc/tool_use_check(mob/living/user, atom/target, amount)
	return !amount

/// Generic use proc. Depending on the item, it uses up fuel, charges, sheets, etc. Returns TRUE on success, FALSE on failure.
/obj/item/proc/use(used)
	return !used

/// Plays item's usesound, if any.
/obj/item/proc/play_tool_sound(atom/target, volume=50)
	if(target && usesound && volume)
		var/played_sound = usesound

		if(islist(usesound))
			played_sound = pick(usesound)

		playsound(target, played_sound, volume, TRUE, mono_adj = TRUE)

/// Used in a callback that is passed by use_tool into do_after call. Do not override, do not call manually.
/obj/item/proc/tool_check_callback(mob/living/user, atom/target, amount, datum/callback/extra_checks)
	SHOULD_NOT_OVERRIDE(TRUE)
	. = tool_use_check(user, target, amount) && (!extra_checks || extra_checks.Invoke())
	if(.)
		SEND_SIGNAL(src, COMSIG_TOOL_IN_USE, user)

/// Returns a numeric value for sorting items used as parts in machines, so they can be replaced by the rped
/obj/item/proc/get_part_rating()
	return 0

/obj/item/doMove(atom/destination)
	if (ismob(loc))
		var/mob/M = loc
		var/hand_index = M.get_held_index_of_item(src)
		if(hand_index)
			M.held_items[hand_index] = null
			M.update_inv_hands()
			if(M.client)
				M.client.screen -= src
			layer = initial(layer)
			plane = initial(plane)
			appearance_flags &= ~NO_CLIENT_COLOR
			dropped(M, FALSE)
	return ..()

/// Get an item's volume that it uses when being stored.
/obj/item/proc/get_w_volume()
	// if w_volume is 0 you fucked up.
	return w_volume || AUTO_SCALE_VOLUME(w_class)

/obj/item/proc/embedded(atom/embedded_target)
	return

/obj/item/proc/unembedded()
	if(item_flags & DROPDEL)
		QDEL_NULL(src)
		return TRUE

/obj/item/proc/canStrip(mob/stripper, mob/owner)
	SHOULD_BE_PURE(TRUE)
	return !HAS_TRAIT(src, TRAIT_NODROP)

/obj/item/proc/doStrip(mob/stripper, mob/owner)
	return owner.dropItemToGround(src)

///Does the current embedding var meet the criteria for being harmless? Namely, does it have a pain multiplier and jostle pain mult of 0? If so, return true.
/obj/item/proc/isEmbedHarmless()
	if(embedding)
		return !isnull(embedding["pain_mult"]) && !isnull(embedding["jostle_pain_mult"]) && embedding["pain_mult"] == 0 && embedding["jostle_pain_mult"] == 0

///In case we want to do something special (like self delete) upon failing to embed in something
/obj/item/proc/failedEmbed()
	if(item_flags & DROPDEL)
		qdel(src)

///Called by the carbon throw_item() proc. Returns null if the item negates the throw, or a reference to the thing to suffer the throw else.
/obj/item/proc/on_thrown(mob/living/carbon/user, atom/target)
	if((item_flags & ABSTRACT) || HAS_TRAIT(src, TRAIT_NODROP))
		return
	user.dropItemToGround(src, silent = TRUE)
	if(throwforce && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_notice("You set [src] down gently on the ground."))
		return
	return src

/**
 * tryEmbed() is for when you want to try embedding something without dealing with the damage + hit messages of calling hitby() on the item while targetting the target.
 *
 * Really, this is used mostly with projectiles with shrapnel payloads, from [/datum/element/embed/proc/checkEmbedProjectile], and called on said shrapnel. Mostly acts as an intermediate between different embed elements.
 *
 * Returns TRUE if it embedded successfully, nothing otherwise
 *
 * Arguments:
 * * target - Either a body part or a carbon. What are we hitting?
 * * forced - Do we want this to go through 100%?
 */
/obj/item/proc/tryEmbed(atom/target, forced = FALSE)
	if(!isbodypart(target) && !iscarbon(target))
		return

	if(!forced && !LAZYLEN(embedding))
		return NONE

	if(SEND_SIGNAL(src, COMSIG_EMBED_TRY_FORCE, target = target, forced = forced))
		return COMPONENT_EMBED_SUCCESS
	failedEmbed()

///For when you want to disable an item's embedding capabilities (like transforming weapons and such), this proc will detach any active embed elements from it.
/obj/item/proc/disableEmbedding()
	SEND_SIGNAL(src, COMSIG_ITEM_DISABLE_EMBED)
	return

///For when you want to add/update the embedding on an item. Uses the vars in [/obj/item/embedding], and defaults to config values for values that aren't set. Will automatically detach previous embed elements on this item.
/obj/item/proc/updateEmbedding()
	if(!islist(embedding) || !LAZYLEN(embedding))
		return

	AddElement(/datum/element/embed,\
		embed_chance = (!isnull(embedding["embed_chance"]) ? embedding["embed_chance"] : EMBED_CHANCE),\
		fall_chance = (!isnull(embedding["fall_chance"]) ? embedding["fall_chance"] : EMBEDDED_ITEM_FALLOUT),\
		pain_chance = (!isnull(embedding["pain_chance"]) ? embedding["pain_chance"] : EMBEDDED_PAIN_CHANCE),\
		pain_mult = (!isnull(embedding["pain_mult"]) ? embedding["pain_mult"] : EMBEDDED_PAIN_MULTIPLIER),\
		remove_pain_mult = (!isnull(embedding["remove_pain_mult"]) ? embedding["remove_pain_mult"] : EMBEDDED_UNSAFE_REMOVAL_PAIN_MULTIPLIER),\
		rip_time = (!isnull(embedding["rip_time"]) ? embedding["rip_time"] : EMBEDDED_UNSAFE_REMOVAL_TIME),\
		ignore_throwspeed_threshold = (!isnull(embedding["ignore_throwspeed_threshold"]) ? embedding["ignore_throwspeed_threshold"] : FALSE),\
		impact_pain_mult = (!isnull(embedding["impact_pain_mult"]) ? embedding["impact_pain_mult"] : EMBEDDED_IMPACT_PAIN_MULTIPLIER),\
		jostle_chance = (!isnull(embedding["jostle_chance"]) ? embedding["jostle_chance"] : EMBEDDED_JOSTLE_CHANCE),\
		jostle_pain_mult = (!isnull(embedding["jostle_pain_mult"]) ? embedding["jostle_pain_mult"] : EMBEDDED_JOSTLE_PAIN_MULTIPLIER),\
		pain_stam_pct = (!isnull(embedding["pain_stam_pct"]) ? embedding["pain_stam_pct"] : EMBEDDED_PAIN_STAM_PCT))
	return TRUE

// Update icons if this is being carried by a mob
/obj/item/wash(clean_types)
	. = ..()

	if(ismob(loc))
		var/mob/mob_loc = loc
		mob_loc.regenerate_icons()

/**
 * * An interrupt for offering an item to other people, called mainly from [/mob/living/carbon/proc/give], in case you want to run your own offer behavior instead.
 *
 * * Return TRUE if you want to interrupt the offer.
 *
 * * Arguments:
 * * offerer - the person offering the item
 */
/obj/item/proc/on_offered(mob/living/carbon/offerer)
	if(SEND_SIGNAL(src, COMSIG_ITEM_OFFERING, offerer) & COMPONENT_OFFER_INTERRUPT)
		return TRUE

/**
 * * An interrupt for someone trying to accept an offered item, called mainly from [/mob/living/carbon/proc/take], in case you want to run your own take behavior instead.
 *
 * * Return TRUE if you want to interrupt the taking.
 *
 * * Arguments:
 * * offerer - the person offering the item
 * * taker - the person trying to accept the offer
 */
/obj/item/proc/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	if(SEND_SIGNAL(src, COMSIG_ITEM_OFFER_TAKEN, offerer, taker) & COMPONENT_OFFER_INTERRUPT)
		return TRUE

///Intended for interactions with guns, like racking
/obj/item/proc/unique_action(mob/living/user)
	if(SEND_SIGNAL(src, COMSIG_ITEM_UNIQUE_ACTION, user))
		return TRUE

///Called before unique action, if any other associated items should do a unique action or override it.
/obj/item/proc/pre_unique_action(mob/living/user)
	if(SEND_SIGNAL(src,COMSIG_CLICK_UNIQUE_ACTION,user) & OVERRIDE_UNIQUE_ACTION)
		return TRUE
	return FALSE //return true if the proc should end here

///Intended for interactions with guns, like swapping firemodes
/obj/item/proc/secondary_action(mob/living/user)

///Called before unique action, if any other associated items should do a secondary action or override it.
/obj/item/proc/pre_secondary_action(mob/living/user)
	if(SEND_SIGNAL(src,COMSIG_CLICK_SECONDARY_ACTION,user) & OVERRIDE_SECONDARY_ACTION)
		return TRUE
	return FALSE //return true if the proc should end here
/**
 * Returns null if this object cannot be used to interact with physical writing mediums such as paper.
 * Returns a list of key attributes for this object interacting with paper otherwise.
 */
/obj/item/proc/get_writing_implement_details()
	return null

/obj/item/proc/can_trigger_gun(mob/living/user)
	if(!user.can_use_guns(src))
		return FALSE
	return TRUE

/// Whether or not this item can be put into a storage item through attackby
/obj/item/proc/attackby_storage_insert(datum/storage, atom/storage_holder, mob/user)
	return TRUE

/obj/item/proc/update_weight_class(new_w_class)
	if(w_class == new_w_class)
		return FALSE

	var/old_w_class = w_class
	w_class = new_w_class
	SEND_SIGNAL(src, COMSIG_ITEM_WEIGHT_CLASS_CHANGED, old_w_class, new_w_class)
	if(!isnull(loc))
		SEND_SIGNAL(loc, COMSIG_ATOM_CONTENTS_WEIGHT_CLASS_CHANGED, src, old_w_class, new_w_class)
	return TRUE

/// How many different types of mats will be counted in a bite?
#define MAX_MATS_PER_BITE 2

/*
 * On accidental consumption: when you somehow end up eating an item accidentally (currently, this is used for when items are hidden in food like bread or cake)
 *
 * The base proc will check if the item is sharp and has a decent force.
 * Then, it checks the item's mat datums for the effects it applies afterwards.
 * Then, it checks tiny items.
 * After all that, it returns TRUE if the item is set to be discovered. Otherwise, it returns FALSE.
 *
 * This works similarily to /suicide_act: if you want an item to have a unique interaction, go to that item
 * and give it an /on_accidental_consumption proc override. For a simple example of this, check out the nuke disk.
 *
 * Arguments
 * * M - the mob accidentally consuming the item
 * * user - the mob feeding M the item - usually, it's the same as M
 * * source_item - the item that held the item being consumed - bread, cake, etc
 * * discover_after - if the item will be discovered after being chomped (FALSE will usually mean it was swallowed, TRUE will usually mean it was bitten into and discovered)
 */
/obj/item/proc/on_accidental_consumption(mob/living/carbon/victim, mob/living/carbon/user, obj/item/source_item, discover_after = TRUE)
	if(get_sharpness() && force >= 5) //if we've got something sharp with a decent force (ie, not plastic)
		INVOKE_ASYNC(victim, TYPE_PROC_REF(/mob, force_scream))
		victim.visible_message(
			span_warning("[victim] looks like [victim.p_theyve()] just bit something they shouldn't have!"),
			span_boldwarning("OH GOD! Was that a crunch? That didn't feel good at all!!"),
		)

		victim.apply_damage(max(15, force), BRUTE, BODY_ZONE_HEAD)
		victim.losebreath += 2

		if(tryEmbed(victim.get_bodypart(BODY_ZONE_CHEST), forced = TRUE)) //and if it embeds successfully in their chest, cause a lot of pain
			victim.apply_damage(max(25, force * 1.5), BRUTE, BODY_ZONE_CHEST)
			victim.losebreath += 6
			discover_after = FALSE

		if(QDELETED(src)) // in case trying to embed it caused its deletion (say, if it's DROPDEL)
			return
		source_item?.reagents?.add_reagent(/datum/reagent/blood, 2)

	else if(custom_materials?.len) //if we've got materials, lets see whats in it
		/// How many mats have we found? You can only be affected by two material datums by default
		var/found_mats = 0
		/// How much of each material is in it? Used to determine if the glass should break
		var/total_material_amount = 0

		for(var/mats in custom_materials)
			total_material_amount += custom_materials[mats]
			if(found_mats >= MAX_MATS_PER_BITE)
				continue //continue instead of break so we can finish adding up all the mats to the total

			var/datum/material/discovered_mat = mats
			if(discovered_mat.on_accidental_mat_consumption(victim, source_item))
				found_mats++

		//if there's glass in it and the glass is more than 60% of the item, then we can shatter it
		if(custom_materials[SSmaterials.GetMaterialRef(/datum/material/glass)] >= total_material_amount * 0.60)
			if(prob(66)) //66% chance to break it
				/// The glass shard that is spawned into the source item
				var/obj/item/shard/broken_glass = new /obj/item/shard(loc)
				broken_glass.name = "broken [name]"
				broken_glass.desc = "This used to be \a [name], but it sure isn't anymore."
				playsound(victim, "shatter", 25, TRUE)
				qdel(src)
				if(QDELETED(source_item))
					broken_glass.on_accidental_consumption(victim, user)
			else //33% chance to just "crack" it (play a sound) and leave it in the bread
				playsound(victim, "shatter", 15, TRUE)
			discover_after = FALSE

		victim.adjust_disgust(33)
		victim.visible_message(
			span_warning("[victim] looks like [victim.p_theyve()] just bitten into something hard."), \
			span_warning("Eugh! Did I just bite into something?"))

	else if(w_class == WEIGHT_CLASS_TINY) //small items like soap or toys that don't have mat datums
		/// victim's chest (for cavity implanting the item)
		var/obj/item/bodypart/chest/victim_cavity = victim.get_bodypart(BODY_ZONE_CHEST)
		if(victim_cavity.cavity_item)
			victim.vomit(5, FALSE, FALSE, distance = 0)
			forceMove(drop_location())
			to_chat(victim, span_warning("You vomit up a [name]! [source_item? "Was that in \the [source_item]?" : ""]"))
		else
			victim.transferItemToLoc(src, victim, TRUE)
			victim.losebreath += 2
			victim_cavity.cavity_item = src
			to_chat(victim, span_warning("You swallow hard. [source_item? "Something small was in \the [source_item]..." : ""]"))
		discover_after = FALSE

	else
		to_chat(victim, span_warning("[source_item? "Something strange was in the \the [source_item]..." : "I just bit something strange..."] "))

	return discover_after

#undef MAX_MATS_PER_BITE
