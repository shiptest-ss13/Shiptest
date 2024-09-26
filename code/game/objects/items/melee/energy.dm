/obj/item/melee/transforming/energy
	icon = 'icons/obj/weapon/energy.dmi'
	hitsound_on = 'sound/weapons/blade1.ogg'
	heat = 3500
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	var/sword_color

/obj/item/melee/transforming/energy/Initialize()
	. = ..()
	if(active)
		START_PROCESSING(SSobj, src)

/obj/item/melee/transforming/energy/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/transforming/energy/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/transforming/energy/get_sharpness()
	return active * sharpness

/obj/item/melee/transforming/energy/process()
	open_flame()

/obj/item/melee/transforming/energy/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(.)
		if(active)
			if(sword_color)
				icon_state = "[base_icon_state][sword_color]"
			START_PROCESSING(SSobj, src)
		else
			STOP_PROCESSING(SSobj, src)
		set_light_on(active)


/obj/item/melee/transforming/energy/get_temperature()
	return active * heat

/obj/item/melee/transforming/energy/ignition_effect(atom/A, mob/user)
	if(!active)
		return ""

	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [C.p_their()] nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), TRUE, -1)
	add_fingerprint(user)

/obj/item/melee/transforming/energy/axe
	name = "energy axe"
	desc = "An energized battle axe."
	icon_state = "axe0"
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	force = 40
	force_on = 150
	throwforce = 25
	throwforce_on = 30
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	w_class_on = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 100
	attack_verb_off = list("attacked", "chopped", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = LIGHT_COLOR_LIGHT_CYAN

/obj/item/melee/transforming/energy/sword
	name = "energy sword"
	desc = "For when a katana isn't enough. While Nanotrasen and the Syndicate both produce the so-called e-swords, they are visually and functionaly identical."
	icon_state = "sword"
	base_icon_state = "sword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = IS_SHARP
	embedding = list("embed_chance" = 75, "impact_pain_mult" = 10)
	armour_penetration = 35
	block_chance = 50

/obj/item/melee/transforming/energy/sword/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(. && active && sword_color)
		icon_state = "[base_icon_state][sword_color]"

/obj/item/melee/transforming/energy/sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(active)
		return ..()
	return 0

/obj/item/melee/transforming/energy/sword/cyborg
	sword_color = "red"
	var/hitcost = 50

/obj/item/melee/transforming/energy/sword/cyborg/attack(mob/M, mob/living/silicon/robot/R)
	if(R.cell)
		var/obj/item/stock_parts/cell/C = R.cell
		if(active && !(C.use(hitcost)))
			attack_self(R)
			to_chat(R, "<span class='notice'>It's out of charge!</span>")
			return
		return ..()

/obj/item/melee/transforming/energy/sword/cyborg/saw //Used by medical Syndicate cyborgs
	name = "energy saw"
	desc = "For heavy duty cutting. It has a carbon-fiber blade in addition to a toggleable hard-light edge to dramatically increase sharpness."
	force_on = 30
	force = 18 //About as much as a spear
	hitsound = 'sound/weapons/circsawhit.ogg'
	icon = 'icons/obj/surgery.dmi'
	icon_state = "esaw_0"
	icon_state_on = "esaw_1"
	sword_color = null //stops icon from breaking when turned on.
	hitcost = 75 //Costs more than a standard cyborg esword
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = IS_SHARP
	light_color = LIGHT_COLOR_LIGHT_CYAN
	tool_behaviour = TOOL_SAW
	toolspeed = 0.7 //faster as a saw

/obj/item/melee/transforming/energy/sword/cyborg/saw/cyborg_unequip(mob/user)
	if(!active)
		return
	transform_weapon(user, TRUE)

/obj/item/melee/transforming/energy/sword/cyborg/saw/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return 0

/obj/item/melee/transforming/energy/sword/saber
	var/list/possible_colors = list("red" = COLOR_SOFT_RED, "blue" = LIGHT_COLOR_LIGHT_CYAN, "green" = LIGHT_COLOR_GREEN, "purple" = LIGHT_COLOR_LAVENDER, "yellow" = COLOR_YELLOW)
	var/hacked = FALSE

/obj/item/melee/transforming/energy/sword/saber/Initialize(mapload)
	. = ..()
	if(LAZYLEN(possible_colors))
		var/set_color = pick(possible_colors)
		sword_color = set_color
		set_light_color(possible_colors[set_color])

/obj/item/melee/transforming/energy/sword/saber/process()
	. = ..()
	if(hacked)
		var/set_color = pick(possible_colors)
		set_light_color(possible_colors[set_color])

/obj/item/melee/transforming/energy/sword/saber/red
	possible_colors = list("red" = COLOR_SOFT_RED)

/obj/item/melee/transforming/energy/sword/saber/blue
	possible_colors = list("blue" = LIGHT_COLOR_LIGHT_CYAN)

/obj/item/melee/transforming/energy/sword/saber/green
	possible_colors = list("green" = LIGHT_COLOR_GREEN)

/obj/item/melee/transforming/energy/sword/saber/purple
	possible_colors = list("purple" = LIGHT_COLOR_LAVENDER)

/obj/item/melee/transforming/energy/sword/saber/yellow
	possible_colors = list("yellow" = COLOR_YELLOW)

/obj/item/melee/transforming/energy/sword/saber/attackby(obj/item/W, mob/living/user, params)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		if(!hacked)
			hacked = TRUE
			sword_color = "rainbow"
			to_chat(user, "<span class='warning'>RNBW_ENGAGE</span>")

			if(active)
				icon_state = "[base_icon_state]rainbow"
				user.update_inv_hands()
		else
			to_chat(user, "<span class='warning'>It's already fabulous!</span>")
	else
		return ..()


/obj/item/melee/transforming/energy/sword/saber/pirate
	name = "energy cutlass"
	desc = "Arrrr matey."
	icon_state = "cutlass"
	base_icon_state = "cutlass"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state_on = "cutlass"

/obj/item/melee/transforming/energy/sword/saber/pirate/red
	possible_colors = list("red" = COLOR_SOFT_RED)

/obj/item/melee/transforming/energy/sword/saber/pirate/blue
	possible_colors = list("blue" = LIGHT_COLOR_LIGHT_CYAN)

/obj/item/melee/transforming/energy/sword/saber/pirate/green
	possible_colors = list("green" = LIGHT_COLOR_GREEN)

/obj/item/melee/transforming/energy/sword/saber/pirate/purple
	possible_colors = list("purple" = LIGHT_COLOR_LAVENDER)

/obj/item/melee/transforming/energy/sword/saber/pirate/yellow
	possible_colors = list("yellow" = COLOR_YELLOW)

/obj/item/melee/transforming/energy/blade
	name = "energy blade"
	desc = "A concentrated beam of energy in the shape of a blade. Very stylish... and lethal."
	icon_state = "blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 30 //Normal attacks deal esword damage
	hitsound = 'sound/weapons/blade1.ogg'
	active = 1
	throwforce = 1 //Throwing or dropping the item deletes it.
	throw_speed = 3
	throw_range = 1
	w_class = WEIGHT_CLASS_BULKY//So you can't hide it in your pocket or some such.
	var/datum/effect_system/spark_spread/spark_system
	sharpness = IS_SHARP

//Most of the other special functions are handled in their own files. aka special snowflake code so kewl
/obj/item/melee/transforming/energy/blade/Initialize()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/melee/transforming/energy/blade/Destroy()
	QDEL_NULL(spark_system)
	return ..()

/obj/item/melee/transforming/energy/blade/transform_weapon(mob/living/user, supress_message_text)
	return

/obj/item/melee/transforming/energy/blade/hardlight
	name = "hardlight blade"
	desc = "An extremely sharp blade made out of hard light. Packs quite a punch."
	icon_state = "lightblade"
	item_state = "lightblade"

/obj/item/melee/transforming/energy/ctf
	name = "energy sword"
	desc = "That cable over there, I'm going to cut it."
	icon_state = "plasmasword0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = IS_SHARP
	armour_penetration = 200
	block_chance = 0
	force = 0
	throwforce = 0
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	force_on = 200 //instakill if shields are down

/obj/item/melee/transforming/energy/ctf/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(. && active)
		icon_state = "plasmasword1"

/obj/item/melee/transforming/energy/ctf/solgov
	armour_penetration = 40
	force_on = 34 //desword grade, but 0 blocking

/obj/item/melee/transforming/energy/ctf/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/SolGov_sword_arm.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")
