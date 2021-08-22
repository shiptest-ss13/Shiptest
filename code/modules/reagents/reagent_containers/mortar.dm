/*\ ### Mortars (& pestle) ###
Originally in glass.dm, moved here
to accommodate additional materials.
\*/

/obj/item/pestle
	name = "pestle"
	desc = "An ancient, simple tool used in conjunction with a mortar to grind or juice items."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pestle"
	force = 7

/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A specially formed bowl of ancient design. It is possible to crush or juice items placed in it using a pestle; however the process, unlike modern methods, is slow and physically exhausting. Alt click to eject the item."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "mortar-wood"
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

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	..()
	if(istype(I,/obj/item/pestle))
		if(grinded)
			if(user.getStaminaLoss() > 50)
				to_chat(user, "<span class='warning'>You are too tired to work!</span>")
				return
			to_chat(user, "<span class='notice'>You start grinding...</span>")
			if((do_after(user, 25, target = src)) && grinded)
				user.adjustStaminaLoss(40)
				if(grinded.juice_results) //prioritize juicing
					grinded.on_juice()
					reagents.add_reagent_list(grinded.juice_results)
					to_chat(user, "<span class='notice'>You juice [grinded] into a fine liquid.</span>")
					QDEL_NULL(grinded)
					return
				grinded.on_grind()
				reagents.add_reagent_list(grinded.grind_results)
				if(grinded.reagents) //food and pills
					grinded.reagents.trans_to(src, grinded.reagents.total_volume, transfered_by = user)
				to_chat(user, "<span class='notice'>You break [grinded] into powder.</span>")
				QDEL_NULL(grinded)
				return
			return
		else
			to_chat(user, "<span class='warning'>There is nothing to grind!</span>")
			return
	if(grinded)
		to_chat(user, "<span class='warning'>There is something inside already!</span>")
		return
	if(I.juice_results || I.grind_results)
		I.forceMove(src)
		grinded = I
		return
	to_chat(user, "<span class='warning'>You can't grind this!</span>")

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

// Mushroom recipes are all over the place so I'm just putting it here
/datum/crafting_recipe/mushroom_mortar
	name = "Mushroom Mortar"
	result = /obj/item/reagent_containers/glass/mortar/mushroom
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_PRIMAL
