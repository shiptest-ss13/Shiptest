//Frame
/obj/item/clothing/suit/space/hardsuit/power_armor
	name = "power armor frame"
	desc = "A power armor frame."
	icon = 'icons/obj/clothing/power_armor/pa_suit.dmi'
	mob_overlay_icon = 'icons/obj/clothing/power_armor/pa_suit.dmi'
	icon_state = "frame"
	mob_overlay_state = "frame"
	//if this isn't set technically "incorrectly" (it should be 32x48, as the icon file is)
	//it will offset the suit overlays with the human sprite and just kinda look weird. This makes it look right.
	//Could maybe alternatively use pixel y offset here, but this may be the best
	worn_x_dimension = 32
	worn_y_dimension = 20

	//Can't move this unless its worn, or shove past it
	density = TRUE
	anchored = TRUE

	integrity_failure = 0.5
	max_integrity = 500
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0,  FIRE = 0, ACID = 0, WOUND = 0)

	actions_types = null //No helmet toggle, sorry dude
	helmettype = null //no helmet; default PA is frame = /obj/item/clothing/head/helmet/space/hardsuit/power_armor
	clothing_traits = list()
	item_flags = NO_PIXEL_RANDOM_DROP
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | BLOCKS_SHOVE_KNOCKDOWN
	// slowdown = 1.35

	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0,  FIRE = 0, ACID = 0, WOUND = 0)

	equipping_sound = null
	unequipping_sound = null
	equip_delay_self = null
	strip_delay = null
	equip_self_flags = null

	var/list/module_armor = list(
		BODY_ZONE_HEAD = null,
		BODY_ZONE_CHEST = null,
		BODY_ZONE_L_ARM = null,
		BODY_ZONE_R_ARM = null,
		BODY_ZONE_L_LEG = null,
		BODY_ZONE_R_LEG = null,
	)
	///The hoist currently linked 
	var/obj/structure/power_armor_hoist/linked_to
	///Actions granted by modules
	var/list/actions_modules = list()
	var/mob/listeningTo

/obj/item/clothing/suit/space/hardsuit/power_armor/Initialize()
	. = ..()
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	ADD_TRAIT(src, TRAIT_NODROP, STICKY_NODROP) //Somehow it's stuck to your body, no questioning.
	// AddElement(/datum/element/radiation_protected_clothing)
	RegisterSignal(src, COMSIG_ATOM_CAN_BE_PULLED, PROC_REF(reject_pulls))

	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		if(i == BODY_ZONE_HEAD)
			var/type = module_armor[i]
			var/obj/item/power_armor/head/pa_head = new type(null)
			module_armor[i] = pa_head
			helmettype = pa_head.type_helmet
			MakeHelmet()
			continue
		var/type = module_armor[i]
		var/obj/item/power_armor/pa_part = new type(null)
		pa_part.frame = src
		module_armor[i] = pa_part
		var/icon/PA = new(icon, icon_state = pa_part.icon_state_pa)
		add_overlay(PA)

		for(var/k in pa_part.modules)
			if(isnull(pa_part.modules[k]))
				continue
			var/obj/item/pa_module/pa_module = pa_part.modules[k]
			pa_module.added_to_pa()

/obj/item/clothing/suit/space/hardsuit/power_armor/Destroy()
	. = ..()
	linked_to = null
	
	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		qdel(module_armor[i])

	actions_modules = list()
	listeningTo = null

/obj/item/clothing/suit/space/hardsuit/power_armor/proc/update_actions()
	actions_modules = null

	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		var/obj/item/power_armor/power_armor = module_armor[i]
		if(power_armor.actions_modules)
			LAZYINITLIST(actions_modules)
			actions_modules |= power_armor.actions_modules

/obj/item/clothing/suit/space/hardsuit/power_armor/proc/update_parts_icons()
	cut_overlays()

	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		if(i == BODY_ZONE_HEAD)
			continue

		var/obj/item/power_armor/pa_part = module_armor[i]
		var/icon/PA = new(icon, icon_state = pa_part.icon_state_pa)
		add_overlay(PA)

/obj/item/clothing/suit/space/hardsuit/power_armor/build_worn_icon(default_layer, default_icon_file, isinhands, override_state, override_file, datum/species/mob_species, direction)
	var/mutable_appearance/standing = ..()
	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		if(i == BODY_ZONE_HEAD)
			continue
		var/obj/item/power_armor/PA_part = module_armor[i]
		var/icon/PA = new(icon, icon_state = PA_part.icon_state_pa)
		standing.overlays.Add(PA)
	return standing

/obj/item/clothing/suit/space/hardsuit/power_armor/get_examine_string(mob/user, thats, damage = TRUE)
	var/damage_txt = ""
	if(damage)
		if(atom_integrity <= 0)
			damage_txt = "It's completely broken"
		if(atom_integrity > 0 && (atom_integrity < (max_integrity / 3)))
			damage_txt = "It's in bad condition"
		if((atom_integrity > (max_integrity / 3)) && (atom_integrity < (max_integrity * (2/3))))
			damage_txt = "It's seen some wear and tear"
		if((atom_integrity > (max_integrity * (2/3))) && (atom_integrity < max_integrity))
			damage_txt = "It's a little banged up"
		if(atom_integrity == max_integrity)
			damage_txt = "It's in good condition"
	return "[icon2html(src, user)] [get_examine_name(user)]. [damage_txt]"

/obj/item/clothing/suit/space/hardsuit/power_armor/examine(mob/user)
	. = ..()

	for(var/i in module_armor)
		if(isnull(module_armor[i]))
			continue
		var/obj/item/power_armor/PA = module_armor[i]
		if(PA.zone == BODY_ZONE_HEAD)
			. +=  "[helmet.get_examine_string(user, TRUE)]"
			continue
		. += "[PA.get_examine_string(user, TRUE)]"

	. += "Alt+left click this power armor to get into and out of it."

//We want to be able to strip the PA as usual but also have the benefits of NO_DROP to disallow stuff like drag clicking PA into hand slot
/obj/item/clothing/suit/space/hardsuit/power_armor/canStrip(mob/stripper, mob/owner)
	return !(item_flags & ABSTRACT)

/obj/item/clothing/suit/space/hardsuit/power_armor/doStrip(mob/stripper, mob/owner)
	GetOutside(owner)
	return TRUE

/obj/item/clothing/suit/space/hardsuit/power_armor/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		// toggle_spacesuit_cell(user)
		return

	// else if(cell_cover_open && istype(I, /obj/item/stock_parts/cell))
	// 	if(cell)
	// 		to_chat(user, span_warning("[src] already has a cell installed."))
	// 		return
	// 	if(user.transferItemToLoc(I, src))
	// 		cell = I
	// 		to_chat(user, span_notice("You successfully install \the [cell] into [src]."))
	// 		return

	else if(istype(I, /obj/item/light) && helmettype)
		if(src == user.get_item_by_slot(ITEM_SLOT_OCLOTHING))
			to_chat(user, span_warning("You cannot replace the bulb in the helmet of [src] while wearing it."))
			return
		if(helmet)
			to_chat(user, span_warning("The helmet of [src] does not require a new bulb."))
			return
		var/obj/item/light/L = I
		if(L.status)
			to_chat(user, span_warning("This bulb is too damaged to use as a replacement!"))
			return
		if(do_after(user, 5 SECONDS, src))
			qdel(I)
			helmet = new helmettype(src)
			to_chat(user, span_notice("You have successfully repaired [src]'s helmet."))
			new /obj/item/light/bulb/broken(drop_location())
			return

	else if(istype(I, /obj/item/power_armor))
		if(!linked_to)
			to_chat(user, span_warning("You need connect the power armor to a hoist to modify it!"))
			return
		var/obj/item/power_armor/PA = I
		if(module_armor[PA.zone])
			to_chat(user, span_warning("This module power armor already in power armor!"))
			return
		if(do_after(user, 3 SECONDS, target = user) && user.transferItemToLoc(I, src))
			module_armor[PA.zone] = PA
			if(PA.zone == BODY_ZONE_HEAD)
				helmettype = PA:type_helmet
				MakeHelmet()
			update_actions()
			update_parts_icons()
			PA.frame = src
			for(var/k in PA.modules)
				if(isnull(PA.modules[k]))
					continue
				var/obj/item/pa_module/PA_m = PA.modules[k]
				PA_m.added_to_pa()
			to_chat(user, span_notice("You successfully install \the [PA] into [src]."))
		return

	else if(I.tool_behaviour == TOOL_WRENCH)
		if(!linked_to)
			to_chat(user, span_warning("You need connect power armor to workbench for modify!"))
			return

		var/list/radial_options = list()
		var/list/part_to_zone = list()
		for(var/i in module_armor)
			if(isnull(module_armor[i]))
				continue
			var/obj/item/power_armor/PA = module_armor[i]
			radial_options[PA.name] = image(PA.icon, PA.icon_state)
			part_to_zone[PA.name] = PA.zone

		if(!radial_options.len)
			to_chat(user, span_warning("Power armor don't have modules!"))
			return

		var/radial_result = part_to_zone[show_radial_menu(user, src, radial_options, require_near = TRUE, tooltips = TRUE)]
		var/hand = user.get_empty_held_index_for_side(LEFT_HANDS) || user.get_empty_held_index_for_side(RIGHT_HANDS)
		if(radial_result && do_after(user, 5 SECONDS, user))
			var/obj/item/power_armor/PA = module_armor[radial_result]
			if(!user.put_in_hand(PA, hand))
				PA.forceMove(user.loc)
			module_armor[radial_result] = null
			if(radial_result == BODY_ZONE_HEAD)
				helmettype = null
				qdel(helmet)

			update_parts_icons()
			PA.frame = null

			for(var/k in PA.modules)
				if(isnull(PA.modules[k]))
					continue
				var/obj/item/pa_module/PA_m = PA.modules[k]
				PA_m.removed_from_pa()

			to_chat(user, span_notice("You successfully uninstall \the [PA] into [src]."))

	else if(I.tool_behaviour == TOOL_WELDER)
		for(var/i in module_armor)
			if(!isnull(module_armor[i]))
				to_chat(user, span_notice("You need to remove all armour from the [src]."))
				return
		if(!(atom_integrity <= max_integrity - 10))
			to_chat(user, span_warning("The [src] doesn't need repairs."))
			return
		if(!I.tool_start_check(user, amount=1))
			return
		user.visible_message(
			span_notice("[user] begins patching up the [src] with [I]."),
			span_notice("You begin restoring the [src]..."))
		playsound(src, 'sound/items/welder2.ogg', 45, TRUE)
		if(!I.use_tool(src, user, 1.5 SECONDS, volume=0, amount=1))
			return
		user.visible_message(
			span_notice("[user] fixes up the [src]!"),
			span_notice("You mend the damage of the [src]."))
		atom_integrity += 25
		playsound(src, 'sound/items/welder2.ogg', 45, TRUE)
		update_appearance()
		update_overlays()
		return ..()

/obj/item/clothing/suit/space/hardsuit/power_armor/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration, def_zone = BODY_ZONE_CHEST)
	if(!uses_integrity)
		CRASH("[src] had /atom/proc/take_damage() called on it without it being a type that has uses_integrity = TRUE!")
	if(QDELETED(src))
		CRASH("[src] taking damage after deletion")
	if(sound_effect)
		play_attack_sound(damage_amount, damage_type, damage_flag)
	if(resistance_flags & INDESTRUCTIBLE)
		return

	if(def_zone == BODY_ZONE_PRECISE_GROIN)
		def_zone = BODY_ZONE_CHEST
	if(def_zone == BODY_ZONE_PRECISE_EYES || def_zone == BODY_ZONE_PRECISE_MOUTH)
		def_zone = BODY_ZONE_HEAD

	if(def_zone == BODY_ZONE_HEAD)
		if(helmet && helmet.get_integrity() > 0)
			var/damage_to_human = - (helmet.get_integrity() - helmet.take_damage(damage_amount, damage_type, damage_flag, null, attack_dir, armour_penetration, def_zone))
			return max(0, damage_to_human)
		else
			return damage_amount

	var/obj/item/power_armor/PA_item = module_armor[def_zone]
	if(istype(PA_item) && PA_item.get_integrity() > 0)
		var/damage_to_frame = - (PA_item.get_integrity() - PA_item.take_damage(damage_amount, damage_type, damage_flag, null, attack_dir, armour_penetration, def_zone))
		if(damage_to_frame <= 0)
			return 0
		damage_amount = damage_to_frame

	if(atom_integrity <= 0)
		return damage_amount

	damage_amount = run_atom_armor(damage_amount, damage_type, damage_flag, attack_dir, armour_penetration)
	if(damage_amount < DAMAGE_PRECISION)
		return
	if(SEND_SIGNAL(src, COMSIG_ATOM_TAKE_DAMAGE, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration) & COMPONENT_NO_TAKE_DAMAGE)
		return

	. = max(damage_amount - atom_integrity, 0)

	update_integrity(atom_integrity - damage_amount)

	//BREAKING
	if(integrity_failure && atom_integrity <= integrity_failure * max_integrity)
		atom_break(damage_flag)

	if(atom_integrity <= 0)
		atom_destruction(damage_flag)

/obj/item/clothing/suit/space/hardsuit/power_armor/atom_break(damage_flag)
	. = ..()
	if(prob(35))
		do_sparks(2, FALSE, src)

/obj/item/clothing/suit/space/hardsuit/power_armor/atom_destruction(damage_flag)
	armor = armor.setRating(NONE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if(listeningTo)
		ADD_TRAIT(listeningTo, TRAIT_IMMOBILIZED, "power_armor")
		ADD_TRAIT(listeningTo, TRAIT_INCAPACITATED, "power_armor")
	. = ..()

/obj/item/clothing/suit/space/hardsuit/power_armor/equipped(mob/living/carbon/human/user, slot)
	if(actions_modules)
		actions = actions_modules
	. = ..()

	if(slot != ITEM_SLOT_OCLOTHING)
		return

	// user.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	// user.AddElement(/datum/element/footstep, FOOTSTEP_PA, 1, -6, sound_vary = TRUE)
	listeningTo = user

	// user.can_buckle_to = FALSE
	#warn check here for why this is offsetting the suit overlays
	user.base_pixel_y = user.base_pixel_y + 6
	user.pixel_y = user.base_pixel_y

	ADD_TRAIT(user, TRAIT_FORCED_STANDING, "power_armor")
	ADD_TRAIT(user, TRAIT_NOSLIPALL, "power_armor")
	ADD_TRAIT(user, TRAIT_STUNIMMUNE, "power_armor")
	ADD_TRAIT(user, TRAIT_NOMOBSWAP, "power_armor")
	ADD_TRAIT(user, TRAIT_QUICKER_CARRY, "power_armor")
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, "power_armor")
	
	if(atom_integrity == 0)
		ADD_TRAIT(user, TRAIT_IMMOBILIZED, "power_armor")
		ADD_TRAIT(user, TRAIT_INCAPACITATED, "power_armor")

	RegisterSignal(user, COMSIG_ATOM_CAN_BE_PULLED, PROC_REF(reject_pulls))

/obj/item/clothing/suit/space/hardsuit/power_armor/dropped(mob/living/carbon/human/user)
	. = ..()

	user.base_pixel_y = user.base_pixel_y - 6
	user.pixel_y = user.base_pixel_y
	// user.RemoveElement(/datum/element/footstep, FOOTSTEP_PA, 1, -6, sound_vary = TRUE)
	// user.AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	listeningTo = null

	REMOVE_TRAIT(user, TRAIT_FORCED_STANDING, "power_armor")
	REMOVE_TRAIT(user, TRAIT_NOSLIPALL, "power_armor")
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, "power_armor")
	REMOVE_TRAIT(user, TRAIT_NOMOBSWAP, "power_armor")
	REMOVE_TRAIT(user, TRAIT_QUICKER_CARRY, "power_armor")
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, "power_armor")

	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, "power_armor")
	REMOVE_TRAIT(user, TRAIT_INCAPACITATED, "power_armor")

	UnregisterSignal(user, COMSIG_ATOM_CAN_BE_PULLED)

/obj/item/clothing/suit/space/hardsuit/power_armor/proc/reject_pulls(datum/source, mob/living/puller)
	SIGNAL_HANDLER

	if(puller != loc) // != the wearer
		to_chat(puller, span_warning("The [src] won't budge!"))
		return COMSIG_ATOM_CANT_PULL

//No helmet toggles for now when helmet is up
/obj/item/clothing/suit/space/hardsuit/power_armor/ToggleHelmet()
	// if(helmet_on || (helmettype == null))
	if(helmettype == null)
		return
	return ..()

//Let's get into the power armor (or not)
/obj/item/clothing/suit/space/hardsuit/power_armor/AltClick(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	else
		if(user.wear_suit == src)
			to_chat(user, "You begin exiting the [src].")
			if(do_after(user, 1 SECONDS, user, IGNORE_INCAPACITATED) && !density && (get_dist(user, src) <= 1))
				GetOutside(user)
				return TRUE
			return FALSE

	if(!CheckEquippedClothing(user) || get_dist(user, src) > 1 || linked_to)
		return FALSE

	to_chat(user, "You begin entering the [src].")
	if(do_after(user, 1 SECONDS, user) && CheckEquippedClothing(user) && density)
		GetInside(user)
		return TRUE
	return FALSE

//A proc that checks if the user is already wearing clothing that obstructs the equipping of the power armor
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/CheckEquippedClothing(mob/living/carbon/human/user)
	// No helmets, suit slot, backpacks, belts, or ear slot.
	if(helmet && user.head && (user.head != helmet) || user.wear_suit && (user.wear_suit != src) || user.back || user.belt || user.ears)
		to_chat(user, span_warning("You're unable to climb into the [src] due to already having a helmet, backpack, belt, ear accessories or outer suit equipped!"))
		return FALSE
	return TRUE

//Let's actually get into the power armor
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/GetInside(mob/living/carbon/human/user)
	if(!istype(user))
		return

	//Nothing can possibly go wrong
	user.dna.species.no_equip += ITEM_SLOT_BACK
	user.dna.species.no_equip += ITEM_SLOT_BELT

	density = FALSE
	anchored = FALSE
	user.visible_message(
		span_warning("[user] enters the [src]!"),
	)
	user.forceMove(get_turf(src))
	user.equip_to_slot_if_possible(src, ITEM_SLOT_OCLOTHING)

	if(helmettype)
		ToggleHelmet()
		var/obj/item/clothing/head/helmet/space/hardsuit/power_armor/helmet2 = helmet
		if(helmet2?.radio)
			user.equip_to_slot(helmet2.radio, ITEM_SLOT_EARS)
			for(var/X in helmet2.radio.actions)
				var/datum/action/A = X
				A.Grant(user)

//Nevermind let's get out
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/GetOutside(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] exits the [src]."))
	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	user.dropItemToGround(src, force = TRUE)
	density = TRUE
	anchored = TRUE
	//Nothing can possibly go wrong
	user.dna.species.no_equip -= ITEM_SLOT_BACK
	user.dna.species.no_equip -= ITEM_SLOT_BELT

	var/obj/item/clothing/head/helmet/space/hardsuit/power_armor/helmet2 = helmet
	if(helmet2?.radio)
		user.transferItemToLoc(helmet2.radio, helmet)
		for(var/X in helmet2.radio.actions)
			var/datum/action/A = X
			A.Remove(user)

//TODO for later involving integrity and ricochets
/obj/item/clothing/suit/space/hardsuit/power_armor/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(prob(50))
		var/datum/effect_system/spark_spread/spark_system = new /datum/effect_system/spark_spread
		spark_system.start()
	return ..()

//t51 - placeholder test!!!!!!!!
/obj/item/clothing/head/helmet/space/hardsuit/power_armor/t51
	name = "T-51B Power Armor Helmet"
	desc = "A more advanced helmet for a more advanced piece of power armor. Comes with a high quality headlamp and integrated radio."
	icon_state = "helmet0-t51"
	hardsuit_type = "t51" //Determines used sprites: hardsuit[on]-[type]
	light_range = 4.20
	light_power = 0.9
	light_color = "#d1c58d"
	radiotype = /obj/item/radio/headset/power_armor/t51

/obj/item/clothing/suit/space/hardsuit/power_armor/t51
	module_armor = list(
		BODY_ZONE_HEAD = /obj/item/power_armor/head/t51,
		BODY_ZONE_CHEST = /obj/item/power_armor/chest/t51,
		BODY_ZONE_L_ARM = /obj/item/power_armor/arm/left/t51,
		BODY_ZONE_R_ARM = /obj/item/power_armor/arm/right/t51,
		BODY_ZONE_L_LEG = /obj/item/power_armor/leg/left/t51,
		BODY_ZONE_R_LEG = /obj/item/power_armor/leg/right/t51
	)
