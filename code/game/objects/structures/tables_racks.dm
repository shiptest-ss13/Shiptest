/* Tables and Racks
 * Contains:
 *		Tables
 *		Glass Tables
 *		Wooden Tables
 *		Reinforced Tables
 *		Racks
 *		Rack Parts
 */

/*
 * Tables
 */

/obj/structure/table
	name = "table"
	desc = "A square piece of metal standing on four metal legs. It can not move."
	icon = 'icons/obj/smooth_structures/table.dmi'
	icon_state = "table-0"
	base_icon_state = "table"
	density = TRUE
	anchored = TRUE
	obj_flags = parent_type::obj_flags | ELEVATED_SURFACE
	pass_flags_self = PASSTABLE | LETPASSTHROW
	layer = TABLE_LAYER
	climbable = TRUE
	var/frame = /obj/structure/table_frame
	var/framestack = /obj/item/stack/rods
	var/buildstack = /obj/item/stack/sheet/metal
	var/busy = FALSE
	var/buildstackamount = 1
	var/framestackamount = 2
	var/deconstruction_ready = 1
	custom_materials = list(/datum/material/iron = 2000)
	max_integrity = 100
	integrity_failure = 0.33
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TABLES)
	canSmoothWith = list(SMOOTH_GROUP_TABLES)
	/// The type created when this table is flipped
	var/flipped_table_type = /obj/structure/flippedtable
	/// Whether or not this table can actually be flipped. TODO: Make setting flipped_table_type to null do this instead and remove this var
	var/can_flip = TRUE

/obj/structure/table/examine(mob/user)
	. = ..()
	. += deconstruction_hints(user)
	if(can_flip)
		. += span_notice("You can flip it by control shift-clicking the table.")

/obj/structure/table/proc/deconstruction_hints(mob/user)
	return span_notice("The top is <b>screwed</b> on, but the main <b>bolts</b> are also visible.")

/obj/structure/table/update_icon()
	. = ..()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/structure/table/narsie_act()
	var/atom/A = loc
	qdel(src)
	new /obj/structure/table/wood(A)

/obj/structure/table/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/table/attack_hand(mob/living/user)
	if(Adjacent(user) && user.pulling)
		if(isliving(user.pulling))
			var/mob/living/pushed_mob = user.pulling
			if(pushed_mob.buckled)
				to_chat(user, span_warning("[pushed_mob] is buckled to [pushed_mob.buckled]!"))
				return
			if(user.a_intent == INTENT_GRAB)
				if(user.grab_state < GRAB_AGGRESSIVE)
					to_chat(user, span_warning("You need a better grip to do that!"))
					return
				if(user.grab_state >= GRAB_NECK)
					tablelimbsmash(user, pushed_mob)
				else
					tablepush(user, pushed_mob)
			if(user.a_intent == INTENT_HELP)
				pushed_mob.visible_message(span_notice("[user] begins to place [pushed_mob] onto [src]..."), \
									span_userdanger("[user] begins to place [pushed_mob] onto [src]..."))
				if(do_after(user, 35, target = pushed_mob))
					tableplace(user, pushed_mob)
				else
					return
			user.stop_pulling()
		else if(user.pulling.pass_flags & PASSTABLE)
			user.Move_Pulled(src)
			if (user.pulling.loc == loc)
				user.visible_message(span_notice("[user] places [user.pulling] onto [src]."),
					span_notice("You place [user.pulling] onto [src]."))
				user.stop_pulling()
	return ..()

/obj/structure/table/attack_tk()
	return FALSE

/obj/structure/table/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(mover.throwing)
		return TRUE
	if(locate(/obj/structure/table) in get_turf(mover))
		return TRUE
	if(mover.movement_type & FLOATING)
		return TRUE

/obj/structure/table/CanAStarPass(ID, dir, requester)
	. = !density
	if(ismovable(requester))
		var/atom/movable/mover = requester
		. = . || (mover.pass_flags & PASSTABLE)

/obj/structure/table/proc/tableplace(mob/living/user, mob/living/pushed_mob)
	pushed_mob.forceMove(loc)
	pushed_mob.set_resting(TRUE, TRUE)
	pushed_mob.visible_message(span_notice("[user] places [pushed_mob] onto [src]."), \
								span_notice("[user] places [pushed_mob] onto [src]."))
	log_combat(user, pushed_mob, "places", null, "onto [src]")

/obj/structure/table/proc/tablepush(mob/living/user, mob/living/pushed_mob)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_danger("Throwing [pushed_mob] onto the table might hurt them!"))
		return
	var/added_passtable = FALSE
	if(!(pushed_mob.pass_flags & PASSTABLE))
		added_passtable = TRUE
		pushed_mob.pass_flags |= PASSTABLE
	pushed_mob.Move(src.loc)
	if(added_passtable)
		pushed_mob.pass_flags &= ~PASSTABLE
	if(pushed_mob.loc != loc) //Something prevented the tabling
		return
	pushed_mob.Knockdown(30)
	pushed_mob.apply_damage(10, BRUTE)
	pushed_mob.apply_damage(40, STAMINA)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)
	playsound(pushed_mob, 'sound/effects/tableslam.ogg', 90, TRUE)
	pushed_mob.visible_message(span_danger("[user] slams [pushed_mob] onto \the [src]!"), \
								span_userdanger("[user] slams you onto \the [src]!"))
	log_combat(user, pushed_mob, "tabled", null, "onto [src]")
	SEND_SIGNAL(pushed_mob, COMSIG_ADD_MOOD_EVENT, "table", /datum/mood_event/table)

/obj/structure/table/proc/tablelimbsmash(mob/living/user, mob/living/pushed_mob)
	pushed_mob.Knockdown(30)

	var/obj/item/bodypart/banged_limb = pushed_mob.get_bodypart(user.zone_selected) || pushed_mob.get_bodypart(BODY_ZONE_HEAD)
	var/extra_wound = 0
	if(HAS_TRAIT(user, TRAIT_HULK))
		extra_wound = 20
	banged_limb.receive_damage(30, wound_bonus = extra_wound)
	pushed_mob.apply_damage(60, STAMINA)

	take_damage(50)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)

	// playsound(pushed_mob, 'sound/effects/tablelimbsmash.ogg', 90, TRUE)
	pushed_mob.visible_message(
		span_danger("[user] smashes [pushed_mob]'s [banged_limb.name] against \the [src]!"),
		span_userdanger("[user] smashes your [banged_limb.name] against \the [src]"),
		span_userdanger("You hear a loud bang!"),
	)
	log_combat(user, pushed_mob, "head slammed", null, "against [src]")

/obj/structure/table/attackby(obj/item/I, mob/user, params)
	var/list/modifiers = params2list(params)
	if(!(flags_1 & NODECONSTRUCT_1) && user.a_intent != INTENT_HELP)
		if((I.tool_behaviour == TOOL_SCREWDRIVER) && deconstruction_ready)
			to_chat(user, span_notice("You start disassembling [src]..."))
			if(I.use_tool(src, user, 20, volume=50))
				deconstruct(TRUE)
			return

		if(I.tool_behaviour == TOOL_WRENCH && deconstruction_ready)
			to_chat(user, span_notice("You start deconstructing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
				deconstruct(TRUE, 1)
			return

	if(istype(I, /obj/item/storage/bag/tray))
		var/obj/item/storage/bag/tray/T = I
		if(T.contents.len > 0) // If the tray isn't empty
			for(var/x in T.contents)
				var/obj/item/item = x
				AfterPutItemOnTable(item, user)
			SEND_SIGNAL(I, COMSIG_TRY_STORAGE_QUICK_EMPTY, drop_location())
			user.visible_message(span_notice("[user] empties [I] on [src]."))
			return
		// If the tray IS empty, continue on (tray will be placed on the table like other items)

	if(istype(I, /obj/item/riding_offhand))
		var/obj/item/riding_offhand/riding_item = I
		var/mob/living/carried_mob = riding_item.rider
		if(carried_mob == user) //Piggyback user.
			return
		switch(user.a_intent)
			if(INTENT_HARM)
				user.unbuckle_mob(carried_mob)
				tablelimbsmash(user, carried_mob)
			if(INTENT_HELP)
				var/tableplace_delay = 3.5 SECONDS
				var/skills_space = ""
				if(HAS_TRAIT(user, TRAIT_QUICKER_CARRY))
					tableplace_delay = 2 SECONDS
					skills_space = " expertly"
				else if(HAS_TRAIT(user, TRAIT_QUICK_CARRY))
					tableplace_delay = 2.75 SECONDS
					skills_space = " quickly"
				carried_mob.visible_message(span_notice("[user] begins to[skills_space] place [carried_mob] onto [src]..."),
					span_userdanger("[user] begins to[skills_space] place [carried_mob] onto [src]..."))
				if(do_after(user, tableplace_delay, target = carried_mob))
					user.unbuckle_mob(carried_mob)
					tableplace(user, carried_mob)
			else
				user.unbuckle_mob(carried_mob)
				tablepush(user, carried_mob)
		return TRUE

	if(user.a_intent != INTENT_HARM && !(I.item_flags & ABSTRACT))
		if(user.transferItemToLoc(I, drop_location(), silent = FALSE))
			//Center the icon where the user clicked.
			if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
				return
			//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
			I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
			I.pixel_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
			AfterPutItemOnTable(I, user)
			return TRUE
	else
		return ..()

/obj/structure/table/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE
	if(!I.tool_start_check(user, src, amount=0))
		return FALSE
	if (I.use_tool(src, user, 1 SECONDS, volume=0))
		to_chat(user, span_warning("You cut [src] into sheets."))
		deconstruct(wrench_disassembly = TRUE)
		return TRUE

/obj/structure/table/proc/AfterPutItemOnTable(obj/item/I, mob/living/user)
	return

/obj/structure/table/CtrlShiftClick(mob/living/user) // table flipping
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return
	if(can_flip)
		user.visible_message(span_danger("[user] starts flipping [src]!"), span_notice("You start flipping over the [src]!"))
		if(do_after(user, max_integrity/4))
			var/obj/structure/flippedtable/flipped = new flipped_table_type(src.loc)
			flipped.name = "flipped [src.name]"
			flipped.desc = "[src.desc] It is flipped!"
			flipped.icon_state = src.base_icon_state
			var/new_dir = get_dir(user, flipped)
			flipped.dir = new_dir
			if(new_dir == NORTH)
				flipped.layer = BELOW_MOB_LAYER
			flipped.max_integrity = src.max_integrity
			flipped.atom_integrity = src.atom_integrity
			flipped.table_type = src.type
			user.visible_message(span_danger("[user] flips over the [src]!"), span_notice("You flip over the [src]!"))
			playsound(src, 'sound/items/trayhit2.ogg', 100)
			qdel(src)

/obj/structure/table/deconstruct(disassembled = TRUE, wrench_disassembly = 0)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/turf/T = get_turf(src)
		if(buildstack)
			new buildstack(T, buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(T, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
		if(!wrench_disassembly)
			new frame(T)
		else
			new framestack(T, framestackamount)
	qdel(src)


/obj/structure/table/greyscale
	icon = 'icons/obj/smooth_structures/table_greyscale.dmi'
	icon_state = "table-0"       // WS Edit - Custom Table Fix
	base_icon_state = "table"    // WS Edit - Custom Table Fix
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	buildstack = null //No buildstack, so generate from mat datums

/obj/structure/table/chem
	name = "chemistry counter"
	desc = "A square piece of metal designed to be resistant to any chemical spill."
	icon = 'icons/obj/smooth_structures/table_chem.dmi'
	icon_state = "table_chem-0"
	base_icon_state = "table_chem"
	smoothing_groups = list(SMOOTH_GROUP_CHEM_TABLES)
	canSmoothWith = list(SMOOTH_GROUP_CHEM_TABLES)
	buildstack = /obj/item/stack/sheet/mineral/plastitanium
	can_flip = FALSE

///Table on wheels
/obj/structure/table/rolling
	name = "Rolling table"
	desc = "A NT brand \"Rolly poly\" rolling table. It can and will move."
	anchored = FALSE
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	icon = 'icons/obj/smooth_structures/rollingtable.dmi'
	icon_state = "rollingtable"
	can_flip = FALSE
	var/list/attached_items = list()

/obj/structure/table/rolling/AfterPutItemOnTable(obj/item/I, mob/living/user)
	. = ..()
	attached_items += I
	RegisterSignal(I, COMSIG_MOVABLE_MOVED, PROC_REF(RemoveItemFromTable)) //Listen for the pickup event, unregister on pick-up so we aren't moved

/obj/structure/table/rolling/proc/RemoveItemFromTable(datum/source, newloc, dir)
	SIGNAL_HANDLER

	if(newloc != loc) //Did we not move with the table? because that shit's ok
		return FALSE
	attached_items -= source
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/obj/structure/table/rolling/Moved(atom/OldLoc, Dir)
	. = ..()
	//Nullspaced
	if(!loc)
		return
	for(var/mob/M in OldLoc.contents)//Kidnap everyone on top
		M.forceMove(loc)
	for(var/x in attached_items)
		var/atom/movable/AM = x
		if(!AM.Move(loc))
			RemoveItemFromTable(AM, AM.loc)

/*
 * Glass tables
 */
/obj/structure/table/glass
	name = "glass table"
	desc = "What did I say about leaning on the glass tables? Now you need surgery."
	icon = 'icons/obj/smooth_structures/glass_table.dmi'
	icon_state = "glass_table-0"
	base_icon_state = "glass_table"
	buildstack = /obj/item/stack/sheet/glass
	smoothing_groups = list(SMOOTH_GROUP_GLASS_TABLES)
	canSmoothWith = list(SMOOTH_GROUP_GLASS_TABLES)
	max_integrity = 70
	resistance_flags = ACID_PROOF
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	var/list/debris = list()

	hitsound_type = PROJECTILE_HITSOUND_GLASS

/obj/structure/table/glass/Initialize()
	. = ..()
	debris += new frame
	debris += new /obj/item/shard

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/table/glass/Destroy()
	QDEL_LIST(debris)
	. = ..()

/obj/structure/table/glass/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(flags_1 & NODECONSTRUCT_1)
		return
	if(!isliving(AM))
		return
	// Don't break if they're just flying past
	if(AM.throwing)
		addtimer(CALLBACK(src, PROC_REF(throw_check), AM), 5)
	else
		check_break(AM)

/obj/structure/table/glass/proc/throw_check(mob/living/M)
	if(M.loc == get_turf(src))
		check_break(M)

/obj/structure/table/glass/proc/check_break(mob/living/M)
	if(M.has_gravity() && M.mob_size > MOB_SIZE_SMALL && !(M.movement_type & (FLYING || FLOATING)))
		table_shatter(M)

/obj/structure/table/glass/proc/table_shatter(mob/living/L)
	visible_message(span_warning("[src] breaks!"),
		span_danger("You hear breaking glass."))
	var/turf/T = get_turf(src)
	playsound(T, "shatter", 50, TRUE)
	for(var/I in debris)
		var/atom/movable/AM = I
		AM.forceMove(T)
		debris -= AM
		if(istype(AM, /obj/item/shard))
			AM.throw_impact(L)
	L.Paralyze(100)
	qdel(src)

/obj/structure/table/glass/deconstruct(disassembled = TRUE, wrench_disassembly = 0)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			..()
			return
		else
			var/turf/T = get_turf(src)
			playsound(T, "shatter", 50, TRUE)
			for(var/X in debris)
				var/atom/movable/AM = X
				AM.forceMove(T)
				debris -= AM
	qdel(src)

/obj/structure/table/glass/narsie_act()
	color = NARSIE_WINDOW_COLOUR
	for(var/obj/item/shard/S in debris)
		S.color = NARSIE_WINDOW_COLOUR

/*
 * Wooden tables
 */

/obj/structure/table/wood
	name = "wooden table"
	desc = "Do not apply fire to this. Rumour says it burns easily."
	icon = 'icons/obj/smooth_structures/wood_table.dmi'
	icon_state = "wood_table-0"
	base_icon_state = "wood_table"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood
	resistance_flags = FLAMMABLE
	max_integrity = 70
	smoothing_groups = list(SMOOTH_GROUP_WOOD_TABLES) //Don't smooth with SMOOTH_GROUP_TABLES
	canSmoothWith = list(SMOOTH_GROUP_WOOD_TABLES)

	hitsound_type = PROJECTILE_HITSOUND_WOOD

/obj/structure/table/wood/narsie_act(total_override = TRUE)
	if(!total_override)
		..()

/obj/structure/table/wood/poker //No specialties, Just a mapping object.
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'icons/obj/smooth_structures/poker_table.dmi'
	icon_state = "poker_table-0"
	base_icon_state = "poker_table"
	buildstack = /obj/item/stack/tile/carpet

/obj/structure/table/wood/poker/narsie_act()
	..(FALSE)

/obj/structure/table/wood/fancy
	name = "fancy table"
	desc = "A standard metal table frame covered with an amazingly fancy, patterned cloth."
	icon = 'icons/obj/structures.dmi'
	icon_state = "fancy_table"
	base_icon_state = "fancy_table"
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/tile/carpet
	smoothing_groups = list(SMOOTH_GROUP_FANCY_WOOD_TABLES) //Don't smooth with SMOOTH_GROUP_TABLES or SMOOTH_GROUP_WOOD_TABLES
	canSmoothWith = list(SMOOTH_GROUP_FANCY_WOOD_TABLES)
	var/smooth_icon = 'icons/obj/smooth_structures/fancy_table.dmi' // see Initialize()

/obj/structure/table/wood/fancy/Initialize()
	. = ..()
	// Needs to be set dynamically because table smooth sprites are 32x34,
	// which the editor treats as a two-tile-tall object. The sprites are that
	// size so that the north/south corners look nice - examine the detail on
	// the sprites in the editor to see why.
	icon = smooth_icon

/obj/structure/table/wood/fancy/black
	base_icon_state = "fancy_table_black"
	buildstack = /obj/item/stack/tile/carpet/black
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_black.dmi'

/obj/structure/table/wood/fancy/blue
	base_icon_state = "fancy_table_blue"
	buildstack = /obj/item/stack/tile/carpet/blue
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_blue.dmi'

/obj/structure/table/wood/fancy/cyan
	base_icon_state = "fancy_table_cyan"
	buildstack = /obj/item/stack/tile/carpet/cyan
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_cyan.dmi'

/obj/structure/table/wood/fancy/green
	base_icon_state = "fancy_table_green"
	buildstack = /obj/item/stack/tile/carpet/green
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_green.dmi'

/obj/structure/table/wood/fancy/orange
	base_icon_state = "fancy_table_orange"
	buildstack = /obj/item/stack/tile/carpet/orange
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_orange.dmi'

/obj/structure/table/wood/fancy/purple
	base_icon_state = "fancy_table_purple"
	buildstack = /obj/item/stack/tile/carpet/purple
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_purple.dmi'

/obj/structure/table/wood/fancy/red
	base_icon_state = "fancy_table_red"
	buildstack = /obj/item/stack/tile/carpet/red
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_red.dmi'

/obj/structure/table/wood/fancy/royalblack
	base_icon_state = "fancy_table_royalblack"
	buildstack = /obj/item/stack/tile/carpet/royalblack
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_royalblack.dmi'

/obj/structure/table/wood/fancy/royalblue
	base_icon_state = "fancy_table_royalblue"
	buildstack = /obj/item/stack/tile/carpet/royalblue
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_royalblue.dmi'

/obj/structure/table/wood/fancy/red_gold
	base_icon_state = "fancy_table_red"
	buildstack = /obj/item/stack/tile/carpet/red_gold
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_red.dmi'

/*
 * Reinforced tables
 */
/obj/structure/table/reinforced
	name = "reinforced table"
	desc = "A reinforced version of the four legged table."
	icon = 'icons/obj/smooth_structures/reinforced_table.dmi'
	icon_state = "reinforced_table-0"
	base_icon_state = "reinforced_table"
	deconstruction_ready = 0
	buildstack = /obj/item/stack/sheet/plasteel
	max_integrity = 200
	integrity_failure = 0.25
	armor = list("melee" = 10, "bullet" = 30, "laser" = 30, "energy" = 100, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	can_flip = FALSE //It's bolted to the ground mate

/obj/structure/table/reinforced/deconstruction_hints(mob/user)
	if(deconstruction_ready)
		return span_notice("The top cover has been <i>welded</i> loose and the main frame's <b>bolts</b> are exposed.")
	else
		return span_notice("The top cover is firmly <b>welded</b> on.")

/obj/structure/table/reinforced/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WELDER && user.a_intent != INTENT_HELP)
		if(!W.tool_start_check(user, src, amount=0))
			return

		if(deconstruction_ready)
			to_chat(user, span_notice("You start strengthening the reinforced table..."))
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, span_notice("You strengthen the table."))
				deconstruction_ready = 0
		else
			to_chat(user, span_notice("You start weakening the reinforced table..."))
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, span_notice("You weaken the table."))
				deconstruction_ready = 1
	else
		. = ..()

/obj/structure/table/bronze
	name = "bronze table"
	desc = "A solid table made out of bronze."
	icon = 'icons/obj/smooth_structures/brass_table.dmi'
	icon_state = "brass_table-0"
	base_icon_state = "brass_table"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	buildstack = /obj/item/stack/tile/bronze
	smoothing_groups = list(SMOOTH_GROUP_BRONZE_TABLES) //Don't smooth with SMOOTH_GROUP_TABLES
	canSmoothWith = list(SMOOTH_GROUP_BRONZE_TABLES)

/obj/structure/table/bronze/tablepush(mob/living/user, mob/living/pushed_mob)
	..()
	playsound(src, 'sound/magic/clockwork/fellowship_armory.ogg', 50, TRUE)

/*
 * Surgery Tables
 */

/obj/structure/table/optable
	name = "operating table"
	desc = "Used for advanced medical procedures."
	icon = 'icons/obj/surgery_table.dmi'
	icon_state = "surgery_table"
	buildstack = /obj/item/stack/sheet/mineral/silver
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	can_buckle = TRUE
	buckle_lying = 90 //I don't see why you wouldn't be lying down while buckled to it
	buckle_requires_restraints = FALSE
	can_flip = FALSE
	var/mob/living/carbon/human/patient = null
	var/obj/machinery/computer/operating/computer = null

/obj/structure/table/optable/Initialize()
	. = ..()
	for(var/direction in GLOB.alldirs)
		computer = locate(/obj/machinery/computer/operating) in get_step(src, direction)
		if(computer)
			computer.table = src
			break

/obj/structure/table/optable/Destroy()
	. = ..()
	if(computer && computer.table == src)
		computer.table = null

/obj/structure/table/optable/tablepush(mob/living/user, mob/living/pushed_mob)
	pushed_mob.forceMove(loc)
	pushed_mob.set_resting(TRUE, TRUE)
	visible_message(span_notice("[user] lays [pushed_mob] on [src]."))
	get_patient()

/obj/structure/table/optable/proc/get_patient()
	var/mob/living/carbon/M = locate(/mob/living/carbon) in loc
	if(M)
		if(M.resting || M.buckled == src)
			set_patient(M)
	else
		set_patient(null)

/obj/structure/table/optable/proc/set_patient(new_patient)
	if(patient)
		UnregisterSignal(patient, COMSIG_PARENT_QDELETING)
	patient = new_patient
	if(patient)
		RegisterSignal(patient, COMSIG_PARENT_QDELETING, PROC_REF(patient_deleted))

/obj/structure/table/optable/proc/patient_deleted(datum/source)
	SIGNAL_HANDLER
	set_patient(null)

/obj/structure/table/optable/proc/check_eligible_patient()
	get_patient()
	if(!patient)
		return FALSE
	if(ishuman(patient) ||  ismonkey(patient))
		return TRUE
	return FALSE

/*
 * Racks
 */
/obj/structure/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	obj_flags = parent_type::obj_flags | ELEVATED_SURFACE
	pass_flags_self = LETPASSTHROW //You can throw objects over this, despite it's density.
	max_integrity = 20

/obj/structure/rack/examine(mob/user)
	. = ..()
	. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/rack/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return TRUE

/obj/structure/rack/MouseDrop_T(obj/O, mob/user)
	. = ..()
	if ((!(istype(O, /obj/item)) || user.get_active_held_item() != O))
		return
	if(!user.dropItemToGround(O))
		return
	if(O.loc != src.loc)
		step(O, get_dir(O, src))

/obj/structure/rack/attackby(obj/item/W, mob/user, params)
	var/list/modifiers = params2list(params)
	if (W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1) && user.a_intent != INTENT_HELP)
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(user.transferItemToLoc(W, drop_location(), silent = FALSE))
		//Center the icon where the user clicked.
		if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
			return
		//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
		W.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
		W.pixel_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
		return TRUE

/obj/structure/rack/attack_paw(mob/living/user)
	attack_hand(user)

/obj/structure/rack/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.body_position == LYING_DOWN || user.usable_legs < 2)
		return

	if(user.a_intent != INTENT_HARM)
		to_chat(user, span_danger("You aren't HARMFUL enough to beat the rack."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_KICK)
	user.visible_message(span_danger("[user] kicks [src]."), null, null, COMBAT_MESSAGE_RANGE)
	take_damage(rand(4,8), BRUTE, "melee", 1)

/obj/structure/rack/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/items/dodgeball.ogg', 80, TRUE)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 40, TRUE)

/*
 * Rack destruction
 */

/obj/structure/rack/deconstruct(disassembled = TRUE)
	if(!(flags_1&NODECONSTRUCT_1))
		density = FALSE
		var/obj/item/rack_parts/newparts = new(loc)
		transfer_fingerprints_to(newparts)
	qdel(src)


/*
 * Rack Parts
 */

/obj/item/rack_parts
	name = "rack parts"
	desc = "Parts of a rack."
	icon_state = "rack_parts"
	flags_1 = CONDUCT_1
	custom_materials = list(/datum/material/iron=2000)
	var/building = FALSE
	var/obj/construction_type = /obj/structure/rack

/obj/item/rack_parts/attackby(obj/item/W, mob/user, params)
	if (W.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/metal(user.loc)
		qdel(src)
	else
		. = ..()

/obj/item/rack_parts/attack_self(mob/user)
	if(locate(construction_type) in get_turf(user))
		balloon_alert(user, "no room!")
		return
	if(building)
		return
	building = TRUE
	to_chat(user, span_notice("You start assembling [src]..."))
	if(do_after(user, 50, target = user))
		if(!user.temporarilyRemoveItemFromInventory(src))
			return
		var/obj/structure/R = new construction_type(user.loc)
		user.visible_message("<span class='notice'>[user] assembles \a [R].\
			</span>", span_notice("You assemble \a [R]."))
		R.add_fingerprint(user)
		qdel(src)
	building = FALSE

/obj/structure/table/wood/reinforced //a reinforced version of the regular wooden table, primarily for use in solgov outposts or ships
	name = "reinforced wooden table"
	desc = "A reinforced version of the four-legged wooden table. Likely as easy to burn as a normal one."
	icon = 'icons/obj/smooth_structures/reinforced_wood_table.dmi'
	icon_state = "reinforced_wood_table-0"
	base_icon_state = "reinforced_wood_table"
	deconstruction_ready = 0
	buildstack = /obj/item/stack/sheet/plasteel
	resistance_flags = FLAMMABLE
	max_integrity = 200
	integrity_failure = 0.25
	armor = list("melee" = 10, "bullet" = 30, "laser" = 30, "energy" = 100, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70) //trolld
	can_flip = FALSE //same as reinforced and theres no sprites for it

	hitsound_type = PROJECTILE_HITSOUND_WOOD

/obj/structure/table/wood/reinforced/deconstruction_hints(mob/user)
	if(deconstruction_ready)
		return span_notice("The top cover has been <i>pried</i> loose and the main frame's <b>bolts</b> are exposed.")
	else
		return span_notice("The top cover is firmly stuck on, but could be <i>pried</i> off with considerable effort.")

/obj/structure/table/wood/reinforced/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_CROWBAR && user.a_intent != INTENT_HELP)
		if(!W.tool_start_check(user, src, amount=0))
			return

		if(deconstruction_ready)
			to_chat(user, span_notice("You begin levering the top cover back in place..."))
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, span_notice("You pry the top cover back into place."))
				deconstruction_ready = 0
		else
			to_chat(user, span_notice("You start prying off the top cover..."))
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, span_notice("You pry off the top cover."))
				deconstruction_ready = 1
	else
		. = ..()

/obj/structure/table/emptycomputer
	name = "computer table"
	desc = "An empty section of a control panel, perfect for putting items on."
	icon = 'icons/obj/structures/emptycomputer.dmi'
	icon_state = "emptycomputer"
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null
	can_flip = FALSE
