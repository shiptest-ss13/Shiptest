#define LARGE_MORTAR_STAMINA_MINIMUM 50 //What is the amount of stam damage that we prevent mortar use at
#define LARGE_MORTAR_STAMINA_USE 70 //How much stam damage is given to people when the mortar is used
#define MORTAR_CONTAINER (DRAINABLE | TRANSPARENT)

/obj/structure/large_mortar
	name = "large mortar"
	desc = "A large bowl perfect for grinding or juicing a large number of things at once."
	icon = 'icons/obj/cooking_structures.dmi'
	icon_state = "big_mortar"
	density = TRUE
	anchored = TRUE
	max_integrity = 100
	pass_flags = PASSTABLE
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 10)
	/// The maximum number of items this structure can store
	var/maximum_contained_items = 10
	obj_flags = NONE

/obj/structure/large_mortar/Initialize(mapload)
	. = ..()
	create_reagents(200, DRAWABLE | DRAINABLE | TRANSPARENT)

	//AddElement(/datum/element/falling_hazard, damage = 20, wound_bonus = 5, hardhat_safety = TRUE, crushes = FALSE)

/obj/structure/large_mortar/examine(mob/user)
	. = ..()
	. += span_notice("It currently contains <b>[length(contents)]/[maximum_contained_items]</b> items.")
	. += span_notice("It can be (un)secured with <b>wrench</b>")
	. += span_notice("You can empty all of the items out of it with <b>Alt Click</b>")

/obj/structure/large_mortar/Destroy()
	drop_everything_contained()
	return ..()

/obj/structure/large_mortar/AltClick(mob/user)
	if(!length(contents))
		balloon_alert(user, "nothing inside")
		return

	drop_everything_contained()
	balloon_alert(user, "removed all items")

/// Drops all contents at the mortar
/obj/structure/large_mortar/proc/drop_everything_contained()
	if(!length(contents))
		return

	for(var/obj/target_item as anything in contents)
		target_item.forceMove(get_turf(src))

/obj/structure/large_mortar/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	//if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
	//	return

	if(!can_interact(user) || !user.canUseTopic(src, be_close = TRUE))
		return

	set_anchored(!anchored)
	balloon_alert(user, anchored ? "secured" : "unsecured")
	return //SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/large_mortar/attackby(obj/item/attacking_item, mob/living/carbon/human/user)
	if(istype(attacking_item, /obj/item/wrench))
		return
	if(istype(attacking_item, /obj/item/reagent_containers))
		if(attacking_item.is_refillable())
			var/obj/structure/target = src // Taken from reagent_containters/glass afterattack proc
			if(!target.reagents.total_volume)
				to_chat(user, "<span class='warning'>[target] is empty.</span>")
				return COMPONENT_NO_AFTERATTACK

			if(attacking_item.reagents.holder_full())
				to_chat(user, "<span class='warning'>[attacking_item] is full.</span>")
				return COMPONENT_NO_AFTERATTACK

			var/trans = target.reagents.trans_to(attacking_item, target.reagents.total_volume, transfered_by = user)
			to_chat(user, "<span class='notice'>You fill [attacking_item] with [trans] unit\s of the contents of [target].</span>")
			return COMPONENT_NO_AFTERATTACK

	if(istype(attacking_item, /obj/item/pestle))
		if(!anchored)
			balloon_alert(user, "secure to ground first")
			return

		if(!length(contents))
			balloon_alert(user, "nothing to grind")
			return

		if(user.getStaminaLoss() > LARGE_MORTAR_STAMINA_MINIMUM)
			balloon_alert(user, "too tired")
			return

		var/list/choose_options = list(
			"Grind" = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_grind"),
			"Juice" = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_juice")
		)
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)

		if(!length(contents) || !in_range(src, user) || !user.is_holding(attacking_item) && !picked_option)
			return

		balloon_alert(user, "grinding...")
		if(!do_after(user, 5 SECONDS, target = src))
			balloon_alert(user, "stopped grinding")
			return

		user.adjustStaminaLoss(LARGE_MORTAR_STAMINA_USE) //This is a bit more tiring than a normal sized mortar and pestle
		switch(picked_option)
			if("Juice")
				for(var/obj/item/target_item as anything in contents)
					if(target_item.juice_results)
						juice_target_item(target_item, user)
					else
						grind_target_item(target_item, user)

			if("Grind")
				for(var/obj/item/target_item as anything in contents)
					if(target_item.grind_results)
						grind_target_item(target_item, user)
					else
						juice_target_item(target_item, user)
		return

	if(!attacking_item.juice_results && !attacking_item.grind_results)
		balloon_alert(user, "can't grind this")
		return ..()

	if(length(contents) >= maximum_contained_items)
		balloon_alert(user, "already full")
		return

	attacking_item.forceMove(src)

///Juices the passed target item, and transfers any contained chems to the mortar as well
/obj/structure/large_mortar/proc/juice_target_item(obj/item/to_be_juiced, mob/living/carbon/human/user)
	to_be_juiced.on_juice()
	reagents.add_reagent_list(to_be_juiced.juice_results)

	if(to_be_juiced.reagents) //If juiced item has reagents within, transfer them to the mortar
		to_be_juiced.reagents.trans_to(src, to_be_juiced.reagents.total_volume, transfered_by = user)

	to_chat(user, span_notice("You juice [to_be_juiced] into a fine liquid."))
	QDEL_NULL(to_be_juiced)

///Grinds the passed target item, and transfers any contained chems to the mortar as well
/obj/structure/large_mortar/proc/grind_target_item(obj/item/to_be_ground, mob/living/carbon/human/user)
	to_be_ground.on_grind()
	reagents.add_reagent_list(to_be_ground.grind_results)

	if(to_be_ground.reagents) //If grinded item has reagents within, transfer them to the mortar
		to_be_ground.reagents.trans_to(src, to_be_ground.reagents.total_volume, transfered_by = user)

	to_chat(user, span_notice("You break [to_be_ground] into powder."))
	QDEL_NULL(to_be_ground)

#undef LARGE_MORTAR_STAMINA_MINIMUM
#undef LARGE_MORTAR_STAMINA_USE
#undef MORTAR_CONTAINER

GLOBAL_LIST_INIT(big_mortar_recipe, list(
	new/datum/stack_recipe("large wooden mortar", /obj/structure/large_mortar, 10, time = 3 SECONDS, one_per_turf = TRUE, on_floor = TRUE),
))

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.big_mortar_recipe
