/obj/item/reagent_containers/pill/patch
	name = "chemical patch"
	desc = "A chemical patch for touch based applications."
	icon = 'icons/obj/chemical/medicine.dmi'
	icon_state = "bandaid"
	item_state = "bandaid"
	possible_transfer_amounts = list()
	volume = 40
	apply_type = PATCH
	apply_method = "apply"
	self_delay = 30		// three seconds
	dissolvable = FALSE

/obj/item/reagent_containers/pill/patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(!IS_ORGANIC_LIMB(affecting))
			to_chat(user, span_notice("Medicine won't work on a robotic limb!"))
			return
	..()

/obj/item/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return 0
	return 1 // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/reagent_containers/pill/patch/indomide
	name = "indomide patch"
	desc = "Helps with brute injuries."
	list_reagents = list(/datum/reagent/medicine/indomide = 20)
	icon_state = "bandaid_brute"

/obj/item/reagent_containers/pill/patch/alvitane
	name = "alvitane patch"
	desc = "Helps with burn injuries."
	list_reagents = list(/datum/reagent/medicine/alvitane = 20)
	icon_state = "bandaid_burn"

/obj/item/reagent_containers/pill/patch/synthflesh
	name = "synthflesh patch"
	desc = "Helps with brute and burn injuries."
	list_reagents = list(/datum/reagent/medicine/synthflesh = 20)
	icon_state = "bandaid_both"

/obj/item/reagent_containers/pill/patch/stardrop
	name = "stardrop patch"
	desc = "A patch of a vision enhancing compound known as Stardrop."
	list_reagents = list(/datum/reagent/drug/stardrop = 20)

/obj/item/reagent_containers/pill/patch/starlight
	name = "starlight patch"
	desc = "A patch of a vision enhancing compound known as Starlight."
	list_reagents = list(/datum/reagent/drug/stardrop/starlight = 10)

/obj/item/reagent_containers/pill/patch/strider
	name = "strider patch"
	desc = "A patch made to give the user a burst of physical endurance."
	list_reagents = list(/datum/reagent/drug/cinesia = 10, /datum/reagent/medicine/hadrakine = 5)
