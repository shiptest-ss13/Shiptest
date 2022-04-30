/obj/structure/forging_workbench
	name = "forging workbench"
	desc = "A crafting bench fitted with tools, securing mechanisms, and a steady surface for blacksmithing."
	icon = 'icons/obj/forge_structures.dmi'
	icon_state = "crafting_bench_empty"

	anchored = TRUE
	density = TRUE

	///the current goal item that is obtainable
	var/goal_item_path
	///the name of the goal item
	var/goal_name
	///the amount of chains within the bench
	var/current_chain = 0
	///the amount of chains required
	var/required_chain = 0
	///the amount of plates within the bench
	var/current_plate = 0
	///the amount of plates required
	var/required_plate = 0
	///the amount of coils within the bench
	var/current_coil = 0
	///the amount of coils required
	var/required_coil = 0
	///the amount of hits required to complete the item
	var/required_hits = 0
	///the current amount of hits
	var/current_hits = 0
	///the amount of wood currently stored
	var/current_wood = 0
	//so we can't just keep being hit without cooldown
	COOLDOWN_DECLARE(hit_cooldown)
	///the choices allowed in crafting
	var/static/list/allowed_choices = list(
		"Chain Helmet" = /obj/item/clothing/head/helmet/reagent_clothing,
		"Chain Armor" = /obj/item/clothing/suit/armor/reagent_clothing,
		"Chain Gloves" = /obj/item/clothing/gloves/reagent_clothing,
		"Chain Boots" = /obj/item/clothing/shoes/chain_boots,
		"Plated Boots" = /obj/item/clothing/shoes/plated_boots,
		"Horseshoes" = /obj/item/clothing/shoes/horseshoe,
		"Ring" = /obj/item/clothing/gloves/ring/reagent_clothing,
		"Collar" = /obj/item/clothing/neck/kink_collar/reagent_clothing,
		"Handcuffs" = /obj/item/restraints/handcuffs/reagent_clothing,
		"Pavise Shield" = /obj/item/shield/riot/buckler/forged_weapon/pavise,
		"Buckler Shield" = /obj/item/shield/riot/buckler/forged_weapon,
		"Coil" = /obj/item/forging/coil,
	)

/obj/structure/forging_workbench/examine(mob/user)
	. = ..()
	if(goal_name)
		. += "<span class='notice'>Goal Item: [goal_name]</span>"
		. += "<span class='notice'>When you have the necessary materials, begin hammering!<br></span>"
		if(required_chain)
			. += "<span class='warning'>[current_chain]/[required_chain] chains stored.</span>"
		if(required_plate)
			. += "<span class='warning'>[current_plate]/[required_plate] plates stored.</span>"
		if(required_coil)
			. += "<span class='warning'>[current_coil]/[required_coil] coils stored.</span>"
	if(length(contents))
		. += "<span class='notice'>Held Item: [contents[1]]</span>"

/obj/structure/forging_workbench/proc/update_appearance(updates)
	icon_state = "crafting_bench_[length(contents) ? "full" : "empty"]"

//when picking a design or clearing a design
/obj/structure/forging_workbench/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(length(contents))
		var/obj/item/moving_item = contents[1]
		user.put_in_hands(moving_item)
		to_chat(user, "<span class='notice'>item retrieved!</span>") //ReplaceWithBalloonAlertLater
		update_appearance()
		return
	if(goal_item_path)
		clear_required()
		to_chat(user, "<span class='notice'>table cleared!</span>")
		update_appearance()
		return
	var/target_choice = tgui_input_list(user, "Which item would you like to craft?", "Crafting Choice", allowed_choices)
	if(!target_choice)
		to_chat(user, "<span class='notice'>no choice made!</span>") //ReplaceWithBalloonAlertLater
		return
	goal_name = target_choice
	goal_item_path = allowed_choices[target_choice]
	switch(target_choice)
		if("Chain Helmet")
			required_chain = 5
		if("Chain Armor")
			required_chain = 6
		if("Chain Gloves")
			required_chain = 4
		if("Chain Boots")
			required_chain = 4
		if("Plated Boots")
			required_plate = 4
		if("Horseshoes")
			required_chain = 4
		if("Ring")
			required_chain = 2
		if("Collar")
			required_chain = 3
		if("Handcuffs")
			required_chain = 10
		if("Pavise Shield")
			required_plate = 8
		if("Buckler Shield")
			required_plate = 5
		if("Coil")
			required_chain = 2
	if(!required_hits)
		required_hits = (required_chain * 2) + (required_plate * 2) + (required_coil * 2)
	to_chat(user, "<span class='notice'>choice made!</span>") //ReplaceWithBalloonAlertLater
	update_appearance()

/obj/structure/forging_workbench/proc/clear_required()
	required_hits = 0
	current_hits = 0
	goal_item_path = null
	goal_name = null
	required_chain = 0
	required_plate = 0
	required_coil = 0

/obj/structure/forging_workbench/proc/check_required_materials(mob/living/user)
	if(current_chain < required_chain)
		to_chat(user, "<span class='notice'>not enough materials!</span>") //ReplaceWithBalloonAlertLater
		return FALSE
	if(current_plate < required_plate)
		to_chat(user, "<span class='notice'>not enough materials!</span>") //ReplaceWithBalloonAlertLater
		return FALSE
	if(current_coil < required_coil)
		to_chat(user, "<span class='notice'>not enough materials!</span>") //ReplaceWithBalloonAlertLater
		return FALSE
	return TRUE

//when inserting the materials
/obj/structure/forging_workbench/attackby(obj/item/attacking_item, mob/user, params)
	update_appearance()
	//if we are attacking with a hammer and we have a goal in mind!
	if(istype(attacking_item, /obj/item/forging/hammer))
		playsound(src, 'sound/misc/forge.ogg', 50, TRUE)
		if(length(contents))
			if(istype(contents[1], /obj/item/forging/complete))
				var/obj/item/forging/complete/complete_content = contents[1]
				if(!complete_content?.spawning_item)
					to_chat(user, "<span class='notice'>no craftable!</span>") //ReplaceWithBalloonAlertLater
					return
				if(current_wood < 2)
					to_chat(user, "<span class='notice'>not enough wood!</span>") //ReplaceWithBalloonAlertLater
					return
				current_wood -= 2
				var/spawning_item = complete_content.spawning_item
				qdel(complete_content)
				new spawning_item(src)
				user.mind.adjust_experience(/datum/skill/smithing, 15) //creating grants you something
				to_chat(user, "<span class='notice'>item crafted!</span>") //ReplaceWithBalloonAlertLater
				update_appearance()
				return
		if(!goal_item_path)
			to_chat(user, "<span class='notice'>no choice made!</span>") //ReplaceWithBalloonAlertLater
			return
		if(!check_required_materials(user))
			return
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * 1 SECONDS
		if(!COOLDOWN_FINISHED(src, hit_cooldown))
			current_hits -= 3
			to_chat(user, "<span class='notice'>bad hit!</span>") //ReplaceWithBalloonAlertLater
			if(current_hits <= -required_hits)
				clear_required()
			return
		COOLDOWN_START(src, hit_cooldown, skill_modifier)
		if(current_hits >= required_hits && !length(contents))
			new goal_item_path(src)
			to_chat(user, "<span class='notice'>item crafted!</span>") //ReplaceWithBalloonAlertLater
			update_appearance()
			user.mind.adjust_experience(/datum/skill/smithing, 15) //creating grants you something
			current_chain -= required_chain
			current_plate -= required_plate
			current_coil -= required_coil
			clear_required()
			return
		current_hits++
		to_chat(user, "<span class='notice'>good hit!</span>") //ReplaceWithBalloonAlertLater
		user.mind.adjust_experience(/datum/skill/smithing, 2) //useful hammering means you get some experience
		return

	//the block of code where we add the amounts for each type
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/attacking_wood = attacking_item
		if(!attacking_wood.use(1))
			return
		current_wood++
		to_chat(user, "<span class='notice'>wood added!</span>") //ReplaceWithBalloonAlertLater
		return
	if(istype(attacking_item, /obj/item/forging/complete/plate))
		qdel(attacking_item)
		current_plate++
		to_chat(user, "<span class='notice'>plate added!</span>") //ReplaceWithBalloonAlertLater
		return
	if(istype(attacking_item, /obj/item/forging/complete/chain))
		qdel(attacking_item)
		current_chain++
		to_chat(user, "<span class='notice'>chain added!</span>") //ReplaceWithBalloonAlertLater
		return
	if(istype(attacking_item, /obj/item/forging/coil))
		qdel(attacking_item)
		current_coil++
		to_chat(user, "<span class='notice'>coil added!</span>") //ReplaceWithBalloonAlertLater
		return

	//inserting a thing
	if(istype(attacking_item, /obj/item/forging/complete))
		var/obj/item/forging/complete/attacking_complete = attacking_item
		if(length(contents))
			to_chat(user, "<span class='notice'>already full!</span>") //ReplaceWithBalloonAlertLater
			return
		attacking_complete.forceMove(src)
		to_chat(user, "<span class='notice'>item inserted!</span>") //ReplaceWithBalloonAlertLater
		update_appearance()
		return

	//destroying the thing
	if(attacking_item.tool_behaviour == TOOL_WRENCH)
		var/turf/src_turf = get_turf(src)
		for(var/i in 1 to current_chain)
			new /obj/item/forging/complete/chain(src_turf)
		for(var/i in 1 to current_plate)
			new /obj/item/forging/complete/plate(src_turf)
		for(var/i in 1 to current_coil)
			new /obj/item/forging/coil(src_turf)
		var/spawning_wood = current_wood + 5
		for(var/i in 1 to spawning_wood)
			new /obj/item/stack/sheet/mineral/wood(src_turf)
		attacking_item.play_tool_sound(src, 50)
		qdel(src)
		return

	return ..()
