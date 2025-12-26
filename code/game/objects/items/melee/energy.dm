/obj/item/melee/energy
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	icon = 'icons/obj/weapon/energy.dmi'
	heat = 0
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	var/sword_color
	/// The heat given off when active.
	var/active_heat = 3500
	/// Damage type used while active.
	var/active_damtype = BURN

	/// Force while active.
	var/active_force = 30
	/// Throwforce while active.
	var/active_throwforce = 20
	/// Sharpness while active.
	var/active_sharpness = SHARP_EDGED
	/// Hitsound played attacking while active.
	var/active_hitsound = 'sound/weapons/blade1.ogg'
	/// Weight class while active.
	var/active_w_class = WEIGHT_CLASS_BULKY

	var/list/attack_verb_on = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/melee/energy/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
		throwforce_on = active_throwforce, \
		throw_speed_on = 4, \
		sharpness_on = active_sharpness, \
		hitsound_on = active_hitsound, \
		w_class_on = active_w_class, \
		attack_verb_on = attack_verb_on, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	AddElement(/datum/element/update_icon_updates_onmob)
	if(sharpness)
		AddComponent(/datum/component/butchering, 50, 100, 0, hitsound)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		START_PROCESSING(SSobj, src)

/obj/item/melee/energy/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/energy/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		heat = active_heat
		damtype = active_damtype
		START_PROCESSING(SSobj, src)
		if(sword_color)
			icon_state = "[base_icon_state][sword_color]"
	else
		heat = initial(heat)
		damtype = initial(damtype)
		STOP_PROCESSING(SSobj, src)

	tool_behaviour = (active ? TOOL_SAW : NONE) //Lets energy weapons cut trees. Also lets them do bonecutting surgery, which is kinda metal!
	if(user)
		balloon_alert(user, "[name] [active ? "enabled":"disabled"]")
	playsound(src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	set_light_on(active)
	update_appearance(UPDATE_ICON_STATE)

	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/energy/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/energy/get_sharpness()
	return sharpness

/obj/item/melee/energy/process(seconds_per_tick)
	if(heat)
		open_flame()

/obj/item/melee/energy/get_temperature()
	return heat

/obj/item/melee/energy/ignition_effect(atom/A, mob/user)
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return ""

	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [C.p_their()] nose"
	. = span_warning("[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.")
	playsound(loc, hitsound, get_clamped_volume(), TRUE, -1)
	add_fingerprint(user)

/obj/item/melee/energy/axe
	name = "energy axe"
	desc = "An energized battle axe."
	icon_state = "axe"
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	force = 40
	active_force = 150
	throwforce = 25
	active_throwforce = 30
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	active_w_class = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 100
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = LIGHT_COLOR_LIGHT_CYAN

/obj/item/melee/energy/sword
	name = "energy sword"
	desc = "For when a katana isn't enough. While Nanotrasen and the Syndicate both produce the so-called e-swords, they are visually and functionaly identical."
	icon_state = "sword"
	base_icon_state = "sword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	embedding = list("embed_chance" = 75, "impact_pain_mult" = 10)
	armour_penetration = 35
	block_chance = 50

/obj/item/melee/energy/sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return ..()
	return 0

/obj/item/melee/energy/sword/cyborg
	sword_color = "red"
	var/hitcost = 50

/obj/item/melee/energy/sword/cyborg/attack(mob/M, mob/living/silicon/robot/R)
	if(R.cell)
		var/obj/item/stock_parts/cell/C = R.cell
		if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) && !(C.use(hitcost)))
			attack_self(R)
			to_chat(R, span_notice("It's out of charge!"))
			return
		return ..()

/obj/item/melee/energy/sword/cyborg/saw //Used by medical Syndicate cyborgs
	name = "energy saw"
	desc = "For heavy duty cutting. It has a carbon-fiber blade in addition to a toggleable hard-light edge to dramatically increase sharpness."
	active_force = 30
	force = 18 //About as much as a spear
	hitsound = 'sound/weapons/circsawhit.ogg'
	icon = 'icons/obj/surgery.dmi'
	icon_state = "esaw"
	sword_color = null //stops icon from breaking when turned on.
	hitcost = 75 //Costs more than a standard cyborg esword
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	light_color = LIGHT_COLOR_LIGHT_CYAN
	tool_behaviour = TOOL_SAW
	toolspeed = 0.7 //faster as a saw

/obj/item/melee/energy/sword/cyborg/saw/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return FALSE

/obj/item/melee/energy/sword/saber
	var/list/possible_colors = list("red" = COLOR_SOFT_RED, "blue" = LIGHT_COLOR_LIGHT_CYAN, "green" = LIGHT_COLOR_GREEN, "purple" = LIGHT_COLOR_LAVENDER, "yellow" = COLOR_YELLOW)
	var/hacked = FALSE

/obj/item/melee/energy/sword/saber/Initialize(mapload)
	. = ..()
	if(LAZYLEN(possible_colors))
		var/set_color = pick(possible_colors)
		sword_color = set_color
		set_light_color(possible_colors[set_color])

/obj/item/melee/energy/sword/saber/process(seconds_per_tick)
	. = ..()
	if(hacked)
		var/set_color = pick(possible_colors)
		set_light_color(possible_colors[set_color])

/obj/item/melee/energy/sword/saber/red
	possible_colors = list("red" = COLOR_SOFT_RED)

/obj/item/melee/energy/sword/saber/blue
	possible_colors = list("blue" = LIGHT_COLOR_LIGHT_CYAN)

/obj/item/melee/energy/sword/saber/green
	possible_colors = list("green" = LIGHT_COLOR_GREEN)

/obj/item/melee/energy/sword/saber/purple
	possible_colors = list("purple" = LIGHT_COLOR_LAVENDER)

/obj/item/melee/energy/sword/saber/yellow
	possible_colors = list("yellow" = COLOR_YELLOW)

/obj/item/melee/energy/sword/saber/attackby(obj/item/W, mob/living/user, params)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		if(!hacked)
			hacked = TRUE
			sword_color = "rainbow"
			to_chat(user, span_warning("RNBW_ENGAGE"))

			if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
				icon_state = "[base_icon_state]rainbow"
				user.update_inv_hands()
		else
			to_chat(user, span_warning("It's already fabulous!"))
	else
		return ..()


/obj/item/melee/energy/sword/saber/pirate
	name = "energy cutlass"
	desc = "Arrrr matey."
	icon_state = "cutlass"
	base_icon_state = "cutlass"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/melee/energy/sword/saber/pirate/red
	possible_colors = list("red" = COLOR_SOFT_RED)

/obj/item/melee/energy/sword/saber/pirate/blue
	possible_colors = list("blue" = LIGHT_COLOR_LIGHT_CYAN)

/obj/item/melee/energy/sword/saber/pirate/green
	possible_colors = list("green" = LIGHT_COLOR_GREEN)

/obj/item/melee/energy/sword/saber/pirate/purple
	possible_colors = list("purple" = LIGHT_COLOR_LAVENDER)

/obj/item/melee/energy/sword/saber/pirate/yellow
	possible_colors = list("yellow" = COLOR_YELLOW)

/obj/item/melee/energy/blade
	name = "energy blade"
	desc = "A concentrated beam of energy in the shape of a blade. Very stylish... and lethal."
	icon_state = "lightblade"
	item_state = "lightblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 30 //Normal attacks deal esword damage
	hitsound = 'sound/weapons/blade1.ogg'
	throwforce = 1 //Throwing or dropping the item deletes it.
	throw_speed = 3
	throw_range = 1
	w_class = WEIGHT_CLASS_BULKY//So you can't hide it in your pocket or some such.
	var/datum/effect_system/spark_spread/spark_system
	sharpness = SHARP_EDGED

//Most of the other special functions are handled in their own files. aka special snowflake code so kewl
/obj/item/melee/energy/blade/Initialize()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/melee/energy/blade/Destroy()
	QDEL_NULL(spark_system)
	return ..()

/obj/item/melee/energy/blade/on_transform(obj/item/source, mob/user, active)
	return

/obj/item/melee/energy/blade/hardlight
	name = "hardlight blade"
	desc = "An extremely sharp blade made out of hard light. Packs quite a punch."
	icon_state = "lightblade"
	item_state = "lightblade"

/obj/item/melee/energy/ctf
	name = "energy sword"
	desc = "That cable over there, I'm going to cut it."
	icon_state = "plasmasword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = SHARP_EDGED
	armour_penetration = 200
	block_chance = 0
	force = 0
	throwforce = 0
	hitsound = "swing_hit" //it starts deactivated
	attack_verb = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	active_force = 200 //instakill if shields are down

/obj/item/melee/energy/ctf/on_transform(obj/item/source, mob/user, active)
	. = ..()
	if(active)
		icon_state = "plasmasword_on"
	playsound(user, active ? 'sound/weapons/SolGov_sword_arm.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	to_chat(user, span_notice("[src] [active ? "is now active":"can now be concealed"]."))
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/energy/ctf/solgov
	armour_penetration = 40
	active_force = 34 //desword grade, but 0 blocking

/obj/item/melee/energy/flyssa
	name = "energy flyssa"
	desc = "Also known as a static-field flyssa, a powerful energy field is generated at the edge of a microforged filament, creating unheard of cutting power."
	icon_state = "flyssa"
	base_icon_state = "flyssa"
	item_state = "flyssa"

	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

	throwforce = 5
	active_throwforce = 20
	force = 10
	active_force = 35
	wound_bonus = -35
	bare_wound_bonus = -10
	armour_penetration = -20

	w_class = WEIGHT_CLASS_NORMAL

	active_hitsound = 'sound/weapons/blade1.ogg'

	var/cell_override = /obj/item/stock_parts/cell/high
	power_use_amount = 200

/obj/item/melee/energy/flyssa/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell, cell_override, _cell_can_be_removed=FALSE, _has_cell_overlays=FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_PRE_TRANSFORM, PROC_REF(check_power))
	update_appearance()

/obj/item/melee/energy/flyssa/AltClick(mob/user)
	. = ..()
	update_appearance()

/obj/item/melee/energy/flyssa/get_cell()
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	return our_cell.inserted_cell

/obj/item/melee/energy/flyssa/update_overlays()
	. = ..()
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	if(!our_cell.inserted_cell)
		return cut_overlays()
	var/charge = our_cell.inserted_cell.percent()
	switch(charge)
		if(86 to 100)
			. += "flyssa-1"
		if(70 to 85)
			. += "flyssa-2"
		if(55 to 69)
			. += "flyssa-3"
		if(40 to 54)
			. += "flyssa-4"
		if(25 to 39)
			. += "flyssa-5"
		if(0 to 25)
			. += "flyssa-6"

/obj/item/melee/energy/flyssa/proc/check_power()
	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		playsound(src, 'sound/machines/button1.ogg', 10)
		return COMPONENT_BLOCK_TRANSFORM

/obj/item/melee/energy/flyssa/process(seconds_per_tick)
	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		SEND_SIGNAL(src, COMSIG_ITEM_FORCE_TRANSFORM, "no_power")
		on_transform()
		playsound(src, 'sound/weapons/saberoff.ogg', 35)
		STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/melee/energy/flyssa/on_transform(obj/item/source, mob/user, active)
	if(active)
		icon_state = "[base_icon_state]-on"
		item_state = "[base_icon_state]-on"
		armour_penetration = 60
	else
		icon_state = base_icon_state
		item_state = base_icon_state
		armour_penetration = -20
	. = ..()
