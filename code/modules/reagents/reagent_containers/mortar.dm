/*\ ### Mortars (& pestle) ###
Originally in glass.dm, moved here
to accommodate additional materials.
\*/

#define MORTAR_STAMINA_MINIMUM 50 //What is the amount of stam damage that we prevent mortar use at
#define MORTAR_STAMINA_USE 40 //How much stam damage is given to people when the mortar is used

/obj/item/pestle
	name = "pestle"
	desc = "An ancient, simple tool used in conjunction with a mortar to grind or juice items."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/chemical/mortar.dmi'
	icon_state = "pestle"
	force = 7

/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A specially formed bowl of ancient design. It is possible to crush or juice items placed in it using a pestle; however the process, unlike modern methods, is slow and physically exhausting. Alt click to eject the item."
	icon = 'icons/obj/chemical/mortar.dmi'
	icon_state = "mortar_wood"
	fill_icon_state = "mortar"
	fill_icon_thresholds = list(1, 20, 40, 80, 100)
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	volume = 100
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT)
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	var/grind_speed = 30 //How long does it take to grind
	var/obj/item/grinded

/obj/item/reagent_containers/glass/mortar/AltClick(mob/user)
	if(grinded)
		grinded.forceMove(drop_location())
		grinded = null
		to_chat(user, "<span class='notice'>You eject the item inside.</span>")

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/attacking_item, mob/living/carbon/human/user)
	..()
	if(istype(attacking_item, /obj/item/pestle))
		if(!grinded)
			balloon_alert(user, "nothing to grind")
			return

		if(user.getStaminaLoss() > MORTAR_STAMINA_MINIMUM)
			balloon_alert(user, "too tired")
			return

		var/list/choose_options = list(
			"Grind" = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_grind"),
			"Juice" = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_juice")
		)
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)

		if(!grinded || !in_range(src, user) || !user.is_holding(attacking_item) || !picked_option)
			return

		balloon_alert(user, "grinding...")
		if(!do_after(user, grind_speed, target = src))
			balloon_alert(user, "stopped grinding")
			return

		user.adjustStaminaLoss(MORTAR_STAMINA_USE)
		switch(picked_option)
			if("Juice")
				if(grinded.juice_results)
					juice_target_item(grinded, user)
				else
					grind_target_item(grinded, user)
				grinded = null

			if("Grind")
				if(grinded.grind_results)
					grind_target_item(grinded, user)
				else
					juice_target_item(grinded, user)
				grinded = null
		return

	if(!attacking_item.juice_results && !attacking_item.grind_results)
		balloon_alert(user, "can't grind this")
		return ..()

	if(grinded)
		balloon_alert(user, "already full")
		return

	attacking_item.forceMove(src)
	grinded = attacking_item

///Juices the passed target item, and transfers any contained chems to the mortar as well
/obj/item/reagent_containers/glass/mortar/proc/juice_target_item(obj/item/to_be_juiced, mob/living/carbon/human/user)
	to_be_juiced.on_juice()
	reagents.add_reagent_list(to_be_juiced.juice_results)

	if(to_be_juiced.reagents) //If juiced item has reagents within, transfer them to the mortar
		to_be_juiced.reagents.trans_to(src, to_be_juiced.reagents.total_volume, transfered_by = user)

	to_chat(user, span_notice("You juice [to_be_juiced] into a fine liquid."))
	QDEL_NULL(to_be_juiced)

///Grinds the passed target item, and transfers any contained chems to the mortar as well
/obj/item/reagent_containers/glass/mortar/proc/grind_target_item(obj/item/to_be_ground, mob/living/carbon/human/user)
	to_be_ground.on_grind()
	reagents.add_reagent_list(to_be_ground.grind_results)

	if(to_be_ground.reagents) //If grinded item has reagents within, transfer them to the mortar
		to_be_ground.reagents.trans_to(src, to_be_ground.reagents.total_volume, transfered_by = user)

	to_chat(user, span_notice("You break [to_be_ground] into powder."))
	QDEL_NULL(to_be_ground)

#undef MORTAR_STAMINA_MINIMUM
#undef MORTAR_STAMINA_USE

/obj/item/reagent_containers/glass/mortar/glass //mmm yes... this glass is made of glass
	icon_state = "mortar_glass"
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT)
	grind_speed = 25

/obj/item/reagent_containers/glass/mortar/metal
	icon_state = "mortar_metal"
	custom_materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT)
	grind_speed = 25

/obj/item/reagent_containers/glass/mortar/gold
	icon_state = "mortar_gold"
	custom_materials = list(/datum/material/gold = MINERAL_MATERIAL_AMOUNT)
	grind_speed = 20

/obj/item/reagent_containers/glass/mortar/bone
	icon_state = "mortar_bone"
	custom_materials = list(/datum/material/bone = MINERAL_MATERIAL_AMOUNT)

/obj/item/reagent_containers/glass/mortar/mushroom
	icon_state = "mortar_shroom"
	custom_materials = list(/datum/material/biomass = MINERAL_MATERIAL_AMOUNT)
