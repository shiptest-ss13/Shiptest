#define DEFAULT_TIMED 5 SECONDS
#define MASTER_TIMED 2 SECONDS

#define DEFAULT_HEATED 25 SECONDS
#define MASTER_HEATED 50 SECONDS

#define MAX_FORGE_TEMP 100
#define MIN_FORGE_TEMP 51 //the minimum temp to actually use it

#define FORGE_LEVEL_ZERO 0
#define FORGE_LEVEL_ONE 1
#define FORGE_LEVEL_TWO 2
#define FORGE_LEVEL_THREE 3

#define MAX_UPGRADE_SINEW 10
#define MAX_UPGRADE_GOLIATH 3
#define MAX_UPGRADE_REGEN 6

#define MIN_IMBUE_REQUIRED 90

/obj/structure/forge
	name = "forge"
	desc = "A structure built out of bricks, with the intended purpose of heating up metal."
	icon = 'icons/obj/forge_structures.dmi'
	icon_state = "forge_empty"

	anchored = TRUE
	density = TRUE

	///the temperature of the forge
	//temperature reached by wood is not enough, requires billows. As long as fuel is in, temperature can be raised.
	var/forge_temperature = 0
	//what temperature the forge is trying to reach
	var/target_temperature = 0
	///the chance that the forges temperature will not lower; max of 100 sinew_lower_chance.
	//normal forges are 0; to increase value, use watcher sinew to increase by 10, to a max of 100.
	var/sinew_lower_chance = 0
	///how many sinews have been used
	var/current_sinew = 0
	///the number of extra sheets an ore will produce, up to 3
	var/goliath_ore_improvement = 0
	///the fuel amount (in seconds) that the forge has (wood)
	var/forge_fuel_weak = 0
	///the fuel amount (in seconds) that the forge has (stronger than wood)
	var/forge_fuel_strong = 0
	///whether the forge is capable of allowing reagent forging of the forged item.
	//normal forges are false; to turn into true, use 6 (active) legion cores.
	var/reagent_forging = FALSE
	///counting how many cores used to turn forge into a reagent forging forge.
	var/current_core = 0
	//cooldown between each process for the forge
	COOLDOWN_DECLARE(forging_cooldown)
	///the variable that stops spamming
	var/in_use = FALSE
	///the forge level, which will upgrade the forge (goliath/sinew/core upgrades)
	var/forge_level = FORGE_LEVEL_ZERO
	var/static/list/choice_list = list(
		"Chain" = /obj/item/forging/incomplete/chain,
		"Plate" = /obj/item/forging/incomplete/plate,
		"Sword" = /obj/item/forging/incomplete/sword,
		"Katana" = /obj/item/forging/incomplete/katana,
		"Dagger" = /obj/item/forging/incomplete/dagger,
		"Staff" = /obj/item/forging/incomplete/staff,
		"Spear" = /obj/item/forging/incomplete/spear,
		"Axe" = /obj/item/forging/incomplete/axe,
		"Hammer" = /obj/item/forging/incomplete/hammer,
		"Pickaxe" = /obj/item/forging/incomplete/pickaxe,
		"Shovel" = /obj/item/forging/incomplete/shovel,
	)

/obj/structure/forge/examine(mob/user)
	. = ..()
	. += "<span class='warning'><br>Perhaps using your hand on [src] when skilled will do something...</span>"
	switch(forge_level)
		if(FORGE_LEVEL_ZERO)
			. += "<span class='notice'>[src] has not yet been touched by a smithy.<br></span>"
		if(FORGE_LEVEL_ONE)
			. += "<span class='notice'>[src] has been touched by an apprentice smithy.<br></span>"
		if(FORGE_LEVEL_TWO)
			. += "<span class='notice'>[src] has been touched by an expert smithy.<br></span>"
		if(FORGE_LEVEL_THREE)
			. += "<span class='boldwarning'>[src] has been touched by a master smithy.<br></span>"
	if(forge_level < FORGE_LEVEL_THREE)
		. += "<span class='notice'>[src] has [goliath_ore_improvement]/[MAX_UPGRADE_GOLIATH] goliath hides.</span>"
		. += "<span class='notice'>[src] has [current_sinew]/[MAX_UPGRADE_SINEW] watcher sinews.</span>"
		. += "<span class='notice'>[src] has [current_core]/[MAX_UPGRADE_REGEN] regenerative cores.</span>"
	. += "<span class='notice'><br>[src] is about [forge_temperature] degrees hot and it's going towards [target_temperature] degrees.<br></span>"
	if(reagent_forging)
		. += "<span class='warning'>[src] has a red tinge and it seems weirdly... dry?</span>"

/obj/structure/forge/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/forge/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/**
 * Here we check both strong (coal) and weak (wood) fuel
 */
/obj/structure/forge/proc/check_fuel()
	if(forge_fuel_strong) //use strong fuel first
		forge_fuel_strong -= 5 SECONDS
		target_temperature = 100
		return
	if(forge_fuel_weak) //then weak fuel second
		forge_fuel_weak -= 5 SECONDS
		target_temperature = 50
		return
	target_temperature = 0 //if no fuel, slowly go back down to zero

/**
 * Here we make the reagent forge reagent imbuing
 */
/obj/structure/forge/proc/create_reagent_forge()
	reagent_forging = TRUE
	say("gurgle!") //ReplaceWithBalloonAlertLater
	color = "#ff5151"
	name = "master forge"

/**
 * Here we give a fail message as well as set the in_use to false
 */
/obj/structure/forge/proc/fail_message(mob/living/fail_user, message)
	to_chat(fail_user, "<span class='warning'>[message]</span>")
	in_use = FALSE

/**
 * Here we adjust our temp to the target temperature
 */
/obj/structure/forge/proc/check_temp()
	if(forge_temperature > target_temperature) //above temp needs to lower slowly
		if(sinew_lower_chance && prob(sinew_lower_chance))//chance to not lower the temp, up to 100 from 10 sinew
			return
		forge_temperature -= 5
		return
	else if(forge_temperature < target_temperature && (forge_fuel_weak || forge_fuel_strong)) //below temp with fuel needs to rise
		forge_temperature += 5

	if(forge_temperature > 0)
		icon_state = "forge_full"
		light_range = 3
	else if(forge_temperature <= 0)
		icon_state = "forge_empty"
		light_range = 0

/**
 * Here we fix any weird in_use bugs
 */
/obj/structure/forge/proc/check_in_use()
	if(!in_use)
		return
	for(var/mob/living/living_mob in range(1,src))
		if(!living_mob)
			in_use = FALSE

/**
 * Here we spawn coal depending on a chance of using wood
 */
/obj/structure/forge/proc/spawn_coal()
	var/obj/item/stack/sheet/mineral/coal/spawn_coal = new(get_turf(src))
	spawn_coal.name = "charcoal"

/obj/structure/forge/process()
	if(!COOLDOWN_FINISHED(src, forging_cooldown)) //every 5 seconds to not be too intensive, also balanced around 5 seconds
		return
	COOLDOWN_START(src, forging_cooldown, 5 SECONDS)
	check_fuel()
	check_temp()
	check_in_use() //plenty of weird bugs, this should hopefully fix the in_use bugs

/obj/structure/forge/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/user_smithing_skill = user.mind.get_skill_level(/datum/skill/smithing)
	var/previous_level = forge_level
	if(user_smithing_skill <= SKILL_LEVEL_NOVICE)
		to_chat(user, "<span class='notice'>[src] requires you to be more experienced!</span>")
		return
	if(user_smithing_skill >= SKILL_LEVEL_APPRENTICE)
		goliath_ore_improvement = MAX_UPGRADE_GOLIATH
		forge_level = FORGE_LEVEL_ONE
	if(user_smithing_skill >= SKILL_LEVEL_EXPERT)
		sinew_lower_chance = MAX_UPGRADE_SINEW * 10 //100, just written funny!
		current_sinew = MAX_UPGRADE_SINEW
		forge_level = FORGE_LEVEL_TWO
	if(user_smithing_skill >= SKILL_LEVEL_MASTER)
		forge_level = FORGE_LEVEL_THREE
	if(forge_level == previous_level)
		to_chat(user, "<span class='notice'>[src] was already upgraded by your level of expertise!</span>")
		return
	to_chat(user, "<span class='notice'>As you work with [src], you note the purity caused by heating metal with nothing but exposed flame. Examine to view what has improved!</span>")
	playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)

/obj/structure/forge/attackby(obj/item/I, mob/living/user, params)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)

	if(istype(I, /obj/item/stack/sheet/mineral/wood)) //used for weak fuel
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(forge_fuel_weak >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one to two pieces of wood at a time! You have [forge_fuel_weak/10] seconds remaining!")
			return
		to_chat(user, "<span class='warning'>You start to throw [I] into [src]...</span>")
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //you need to be able to use the item, so no glue.
			fail_message(user, "You fail fueling [src].")
			return
		forge_fuel_weak += 5 MINUTES
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully fuel [src].</span>")
		user.mind.adjust_experience(/datum/skill/smithing, 3) //useful fueling means you get some experience
		if(prob(45))
			to_chat(user, "<span class='notice'>[src]'s fuel is packed densely enough to have made some charcoal!</span>")
			addtimer(CALLBACK(src, .proc/spawn_coal), 1 MINUTES)
		return

	//why use coal over wood? the target temp is set to 100 under coal, while only 50 with wood
	//which means you have to use the billows with wood, but not with coal
	if(istype(I, /obj/item/stack/sheet/mineral/coal)) //used for strong fuel
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(forge_fuel_strong >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one piece of coal at a time! You have [forge_fuel_strong/10] seconds remaining!")
			return
		to_chat(user, "<span class='warning'>You start to throw [I] into [src]...</span>")
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You fail fueling [src].")
			return
		forge_fuel_strong += 5 MINUTES
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully fuel [src].</span>")
		user.mind.adjust_experience(/datum/skill/smithing, 6) //useful fueling means you get some experience
		return

	if(istype(I, /obj/item/forging/billow))
		var/obj/item/forging/forge_item = I
		if(in_use) //no spamming the billows
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(!forge_fuel_strong && !forge_fuel_weak) //if there isnt any fuel, no billow use
			fail_message(user, "You cannot use [forge_item] without some sort of fuel in [src]!")
			return
		if(forge_temperature >= MAX_FORGE_TEMP) //we don't want the "temp" to overflow or something somehow
			fail_message(user, "You can't heat [src] to be any hotter!")
			return
		to_chat(user, "<span class='warning'>You start to pump [forge_item] into [src]...</span>")
		while(forge_temperature < (MAX_FORGE_TEMP-9))
			if(!do_after(user, skill_modifier * forge_item.work_time, target = src))
				fail_message(user, "You fail billowing [src].")
				return
			forge_temperature += 10
			user.mind.adjust_experience(/datum/skill/smithing, 3) //useful heating means you get some experience
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully increase the temperature inside [src].</span>")
		return TRUE

	if(istype(I, /obj/item/stack/sheet/sinew))
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(sinew_lower_chance >= (MAX_UPGRADE_SINEW * 10)) //max is 100
			fail_message(user, "You cannot insert any more of [I]!")
			return
		to_chat(user, "<span class='warning'>You start lining [src] with [I]...</span>")
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail lining [src] with [I].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You fail lining [src] with [I].")
			return
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		sinew_lower_chance += 10
		current_sinew++
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully line [src] with [I].</span>")
		return

	if(istype(I, /obj/item/organ/regenerative_core))
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(reagent_forging) //if its already able to reagent forge, why continue wasting?
			fail_message(user, "[src] is already upgraded.")
			return
		var/obj/item/organ/regenerative_core/used_core = I
		if(used_core.inert) //no inert cores allowed
			fail_message(user, "You cannot use an inert [used_core].")
			return
		to_chat(user, "<span class='warning'>You begin to sacrifice [used_core] to [src]...</span>")
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail sacrificing [used_core] to [src].")
			return
		to_chat(user, "<span class='notice'>You successfully sacrifice [used_core] to [src].</span>")
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		qdel(I)
		current_core++
		in_use = FALSE
		if(current_core >= MAX_UPGRADE_REGEN) //use six regenerative cores to get reagent forging capabilities on the forge
			create_reagent_forge()
		return

	if(istype(I, /obj/item/stack/sheet/animalhide/goliath_hide))
		var/obj/item/stack/sheet/animalhide/goliath_hide/goliath_hide = I
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(goliath_ore_improvement >= MAX_UPGRADE_GOLIATH)
			fail_message(user, "You have applied the max amount of [goliath_hide]!")
			return
		to_chat(user, "<span class='warning'>You start to improve [src] with [goliath_hide]...</span>")
		if(!do_after(user, skill_modifier * 6 SECONDS, target = src))
			fail_message(user, "You fail improving [src].")
			return
		if(!goliath_hide.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You cannot use [goliath_hide]!")
			return
		goliath_ore_improvement++
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully upgrade [src] with [goliath_hide].</span>")
		return

	if(istype(I, /obj/item/stack/ore))
		var/obj/item/stack/ore/ore_stack = I
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating [ore_stack].")
			return
		if(!ore_stack.refined_type)
			fail_message(user, "It is impossible to smelt [ore_stack].")
			return
		to_chat(user, "<span class='warning'>You start to smelt [ore_stack]...</span>")
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail smelting [ore_stack].")
			return
		var/src_turf = get_turf(src)
		var/spawning_item = ore_stack.refined_type
		var/spawning_amount = max(1, (1 + goliath_ore_improvement) * ore_stack.amount)
		for(var/spawn_ore in 1 to spawning_amount)
			new spawning_item(src_turf)
		in_use = FALSE
		to_chat(user, "<span class='notice'>You successfully smelt [ore_stack].</span>")
		user.mind.adjust_experience(/datum/skill/smithing, ore_stack.mine_experience) //useful smelting means you get some experience
		user.mind.adjust_experience(/datum/skill/mining, ore_stack.mine_experience) //useful smelting means you get some experience
		qdel(I)
		return

	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/forge_item = I
		if(in_use || forge_item.in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		forge_item.in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating the metal.")
			forge_item.in_use = FALSE
			return
		var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete)
			if(!COOLDOWN_FINISHED(search_incomplete, heating_remainder))
				fail_message(user, "[search_incomplete] is still hot, try to keep hammering!")
				forge_item.in_use = FALSE
				return
			to_chat(user, "<span class='warning'>You start to heat up [search_incomplete]...</span>")
			if(!do_after(user, skill_modifier * forge_item.work_time, target = src))
				fail_message(user, "You fail heating up [search_incomplete].")
				forge_item.in_use = FALSE
				return
			COOLDOWN_START(search_incomplete, heating_remainder, 1 MINUTES)
			in_use = FALSE
			forge_item.in_use = FALSE
			user.mind.adjust_experience(/datum/skill/smithing, 2) //heating up stuff gives just a little experience
			to_chat(user, "<span class='notice'>You successfully heat up [search_incomplete].</span>")
			return TRUE
		var/obj/item/stack/rods/search_rods = locate(/obj/item/stack/rods) in I.contents
		if(search_rods)
			var/user_choice = tgui_input_list(user, "What would you like to work on?", "Forge Selection", choice_list)
			if(!user_choice)
				fail_message(user, "You decide against continuing to forge.")
				forge_item.in_use = FALSE
				return
			if(!search_rods.use(1))
				fail_message(user, "You cannot use [search_rods]!")
				forge_item.in_use = FALSE
				return
			to_chat(user, "<span class='warning'>You start to heat up [search_rods]...</span>")
			if(!do_after(user, skill_modifier * forge_item.work_time, target = src))
				fail_message(user, "You fail heating up [search_rods].")
				forge_item.in_use = FALSE
				return
			var/spawn_item = choice_list[user_choice]
			var/obj/item/forging/incomplete/incomplete_item = new spawn_item(get_turf(src))
			COOLDOWN_START(incomplete_item, heating_remainder, 1 MINUTES)
			in_use = FALSE
			forge_item.in_use = FALSE
			user.mind.adjust_experience(/datum/skill/smithing, 2) //creating an item gives you some experience, not a lot
			to_chat(user, "<span class='notice'>You successfully heat up [search_rods], ready to forge a [user_choice].</span>")
			return TRUE
		in_use = FALSE
		forge_item.in_use = FALSE
		return

	if(I.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/metal/ten(get_turf(src))
		qdel(src)

	if(I.GetComponent(/datum/component/reagent_weapon))
		var/obj/item/attacking_item = I
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You can't really do much with [src] at the forge right now...")
			return
		var/datum/component/reagent_weapon/weapon_component = attacking_item.GetComponent(/datum/component/reagent_weapon)
		if(!weapon_component)
			fail_message(user, "[attacking_item] is unable to be imbued!")
			return
		if(length(weapon_component.imbued_reagent))
			fail_message(user, "[attacking_item] has already been imbued!")
			return
		if(!do_after(user, skill_modifier * 10 SECONDS, target = src))
			fail_message(user, "You fail imbueing [attacking_item]!")
			return
		for(var/datum/reagent/weapon_reagent in attacking_item.reagents.reagent_list)
			if(weapon_reagent.volume < MIN_IMBUE_REQUIRED)
				attacking_item.reagents.remove_all_type(weapon_reagent.type)
				continue
			weapon_component.imbued_reagent += weapon_reagent.type
			attacking_item.name = "[weapon_reagent.name] [attacking_item.name]"
		if(attacking_item.name == initial(attacking_item.name))
			fail_message(user, "You failed imbueing [attacking_item]...")
			return
		attacking_item.color = mix_color_from_reagents(attacking_item.reagents.reagent_list)
		to_chat(user, "<span class='notice'>You finish imbuing [attacking_item]...</span>")
		user.mind.adjust_experience(/datum/skill/smithing, 30) //successfully imbuing will grant great experience!
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return TRUE

	if(I.GetComponent(/datum/component/reagent_clothing))
		var/obj/item/attacking_item = I
		if(in_use) //only insert one at a time
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You can't really do much with [src] at the forge right now...")
			return
		var/datum/component/reagent_clothing/clothing_component = attacking_item.GetComponent(/datum/component/reagent_clothing)
		if(!clothing_component)
			fail_message(user, "[attacking_item] is unable to be imbued!")
			return
		if(length(clothing_component.imbued_reagent))
			fail_message(user, "[attacking_item] has already been imbued!")
			return
		if(!do_after(user, skill_modifier * 10 SECONDS, target = src))
			fail_message(user, "You fail imbueing [attacking_item]!")
			return
		for(var/datum/reagent/clothing_reagent in attacking_item.reagents.reagent_list)
			if(clothing_reagent.volume < MIN_IMBUE_REQUIRED)
				attacking_item.reagents.remove_all_type(clothing_reagent.type)
				continue
			clothing_component.imbued_reagent += clothing_reagent.type
			attacking_item.name = "[clothing_reagent.name] [attacking_item.name]"
		if(attacking_item.name == initial(attacking_item.name))
			fail_message(user, "You failed imbueing [attacking_item]...")
			return
		attacking_item.color = mix_color_from_reagents(attacking_item.reagents.reagent_list)
		to_chat(user, "<span class='notice'>You finish imbueing [attacking_item]...</span>")
		user.mind.adjust_experience(/datum/skill/smithing, 30) //successfully imbueing will grant great experience!
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return TRUE

	return ..()

/obj/structure/forge/ready
	current_core = MAX_UPGRADE_REGEN
	reagent_forging = TRUE
	sinew_lower_chance = 100
	forge_temperature = 1000

#undef DEFAULT_TIMED
#undef MASTER_TIMED

#undef DEFAULT_HEATED
#undef MASTER_HEATED

#undef MAX_FORGE_TEMP
#undef MIN_FORGE_TEMP

#undef FORGE_LEVEL_ZERO
#undef FORGE_LEVEL_ONE
#undef FORGE_LEVEL_TWO
#undef FORGE_LEVEL_THREE

#undef MAX_UPGRADE_SINEW
#undef MAX_UPGRADE_GOLIATH
#undef MAX_UPGRADE_REGEN

#undef MIN_IMBUE_REQUIRED
