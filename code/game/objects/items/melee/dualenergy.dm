/obj/item/melee/duelenergy
	icon = 'icons/obj/weapon/energy.dmi'
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	hitsound = "swing_hit"
	armour_penetration = 35
	light_system = MOVABLE_LIGHT
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	light_on = FALSE
	attack_cooldown = HEAVY_WEAPON_CD
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "tore", "lacerated", "ripped", "diced", "cut")
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 70)
	resistance_flags = FIRE_PROOF
	var/active_w_class = WEIGHT_CLASS_BULKY
	var/two_hand_force = 34
	var/sword_color = "green"
	var/hacked = FALSE
	var/list/possible_colors = list("red", "blue", "green", "purple", "yellow")
	var/impale_flavor_text = "twirl"
	var/hack_flavor_text = ""

/obj/item/melee/duelenergy/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	if(LAZYLEN(possible_colors))
		sword_color = pick(possible_colors)
		switch(sword_color)
			if("red")
				set_light_color(COLOR_SOFT_RED)
			if("green")
				set_light_color(LIGHT_COLOR_GREEN)
			if("blue")
				set_light_color(LIGHT_COLOR_LIGHT_CYAN)
			if("purple")
				set_light_color(LIGHT_COLOR_LAVENDER)
			if("yellow")
				set_light_color(COLOR_YELLOW)

/obj/item/melee/duelenergy/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = two_hand_force, wieldsound = 'sound/weapons/saberon.ogg', unwieldsound = 'sound/weapons/saberoff.ogg')

/obj/item/melee/duelenergy/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/// Triggered on wield of two handed item
/// Specific hulk checks due to reflection chance for balance issues and switches hitsounds.
/obj/item/melee/duelenergy/proc/on_wield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	sharpness = IS_SHARP
	w_class = active_w_class
	hitsound = 'sound/weapons/blade1.ogg'
	START_PROCESSING(SSobj, src)
	set_light_on(TRUE)


/// Triggered on unwield of two handed item
/// switch hitsounds
/obj/item/melee/duelenergy/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	sharpness = initial(sharpness)
	w_class = initial(w_class)
	hitsound = "swing_hit"
	STOP_PROCESSING(SSobj, src)
	set_light_on(FALSE)

/obj/item/melee/duelenergy/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		if(!hacked)
			hacked = TRUE
			to_chat(user, "<span class='warning'>[hack_flavor_text]</span>")
			sword_color = "rainbow"
			update_appearance()
		else
			to_chat(user, "<span class='warning'>It's starting to look like a triple rainbow - no, nevermind.</span>")
	else
		return ..()

/obj/item/melee/duelenergy/attack(mob/target, mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT(src, TRAIT_WIELDED) && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
		impale(user)
		return

/obj/item/melee/duelenergy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		return ..()
	return FALSE

/obj/item/melee/duelenergy/IsReflect()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		return TRUE

/obj/item/melee/duelenergy/process()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		if(hacked)
			set_light_color(pick(COLOR_SOFT_RED, LIGHT_COLOR_GREEN, LIGHT_COLOR_LIGHT_CYAN, LIGHT_COLOR_LAVENDER))
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/melee/duelenergy/update_icon_state()
	icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "[base_icon_state][sword_color]" : base_icon_state
	return ..()

/obj/item/melee/duelenergy/ignition_effect(atom/A, mob/user)
	// same as /obj/item/melee/transforming/energy, mostly
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return ""
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [user.p_their()] nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), TRUE, -1)
	add_fingerprint(user)

/obj/item/melee/duelenergy/proc/impale(mob/living/user)
	to_chat(user, "<span class='warning'>You [impale_flavor_text] around a bit before losing your balance and impaling yourself on [src].</span>")
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		user.take_bodypart_damage(20,25,check_armor = TRUE)
	else
		user.adjustStaminaLoss(25)
/*
 * Double-Bladed Energy Swords - Cheridan
 */
/obj/item/melee/duelenergy/saber
	name = "double-bladed energy sword"
	desc = "For when simply killing someone isn't enough."
	icon_state = "dualsaber"
	base_icon_state = "dualsaber"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	light_range = 6 //TWICE AS BRIGHT AS A REGULAR ESWORD

/obj/item/melee/duelenergy/saber/green
	possible_colors = list("green")

/obj/item/melee/duelenergy/saber/red
	possible_colors = list("red")

/obj/item/melee/duelenergy/saber/blue
	possible_colors = list("blue")

/obj/item/melee/duelenergy/saber/purple
	possible_colors = list("purple")

/obj/item/melee/duelenergy/saber/yellow
	possible_colors = list("yellow")

/*
 * Energy Halberds - TetraZeta, Imaginos and Zevo.
 */
/obj/item/melee/duelenergy/halberd
	name = "energy halberd"
	desc = "For when a normal halberd just isnt enough."
	icon_state = "halberd"
	base_icon_state = "halberd"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	light_range = 4
	impale_flavor_text = "swing"
	hack_flavor_text = "HLBRDRNBW_ENGAGE"

/obj/item/melee/duelenergy/halberd/green
	possible_colors = list("green")

/obj/item/melee/duelenergy/halberd/red
	possible_colors = list("red")

/obj/item/melee/duelenergy/halberd/blue
	possible_colors = list("blue")

/obj/item/melee/duelenergy/halberd/purple
	possible_colors = list("purple")

/obj/item/melee/duelenergy/halberd/yellow
	possible_colors = list("yellow")

