// *************************************
// Hydroponics Tools
// *************************************

/obj/item/reagent_containers/spray/weedspray // -- Skie
	desc = "It's a toxic mixture, in spray form, to kill small weeds."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	name = "weed spray"
	icon_state = "weedspray"
	item_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 100)

/obj/item/reagent_containers/spray/pestspray // -- Skie
	desc = "It's some pest eliminator spray! <I>Do not inhale!</I>"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	name = "pest spray"
	icon_state = "pestspray"
	item_state = "plantbgone"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/pestkiller = 100)

/obj/item/cultivator
	name = "cultivator"
	desc = "It's used for removing weeds or scratching your back."
	icon = 'icons/obj/items.dmi'
	icon_state = "cultivator"
	item_state = "cultivator"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("slashed", "sliced", "cut", "clawed")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/cultivator/rake
	name = "rake"
	icon_state = "rake"
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "bashed", "clawed")
	hitsound = null
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.5)
	flags_1 = NONE
	resistance_flags = FLAMMABLE

/obj/item/cultivator/rake/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/cultivator/rake/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	if(has_gravity(loc) && HAS_TRAIT(H, TRAIT_CLUMSY) && !H.resting)
		H.confused = max(H.confused, 10)
		H.Stun(20)
		playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
		H.visible_message(
			span_warning("[H] steps on [src] causing the handle to hit [H.p_them()] right in the face!"), \
			span_userdanger("You step on [src] causing the handle to hit you right in the face!"))

/obj/item/hatchet
	name = "hatchet"
	desc = "A very sharp axe blade upon a short fibremetal handle. It has a long history of chopping things, but now it is used for chopping wood."
	icon = 'icons/obj/weapon/axes/axe.dmi'
	icon_state = "hatchet"
	item_state = "hatchet"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 12
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 3
	throw_range = 4
	custom_materials = list(/datum/material/iron = 15000)
	attack_verb = list("chopped", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/hatchet/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)

/obj/item/hatchet/wooden
	desc = "A crude axe blade upon a short wooden handle."
	icon_state = "woodhatchet"
	custom_materials = null
	flags_1 = NONE

/obj/item/scythe
	icon_state = "scythe0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "scythe"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	force = 13
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	armour_penetration = 20
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("chopped", "sliced", "cut", "reaped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/swiping = FALSE

/obj/item/scythe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 90, 105)

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params)
	if(swiping || !istype(A, /obj/structure/spacevine) || get_turf(A) == get_turf(user))
		return ..()
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(A))
	swiping = TRUE
	var/static/list/scythe_slash_angles = list(0, 45, 90, -45, -90)
	for(var/i in scythe_slash_angles)
		var/turf/T = get_step(user_turf, turn(dir_to_target, i))
		for(var/obj/structure/spacevine/V in T)
			if(user.Adjacent(V))
				melee_attack_chain(user, V)
	swiping = FALSE
	return TRUE

// *************************************
// Nutrient defines for hydroponics
// *************************************


/obj/item/reagent_containers/glass/bottle/nutrient
	name = "bottle of nutrient"
	volume = 50
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)
	var/auto_scatter = TRUE

/obj/item/reagent_containers/glass/bottle/nutrient/Initialize()
	. = ..()
	if(auto_scatter)
		pixel_x = base_pixel_x + rand(-5, 5)
		pixel_y = base_pixel_y + rand(-5, 5)


/obj/item/reagent_containers/glass/bottle/nutrient/ez
	name = "bottle of E-Z-Nutrient"
	desc = "Contains a fertilizer that causes mild mutations with each harvest."
	list_reagents = list(/datum/reagent/plantnutriment/eznutriment = 50)

/obj/item/reagent_containers/glass/bottle/nutrient/l4z
	name = "bottle of Left 4 Zed"
	desc = "Contains a fertilizer that limits plant yields to no more than one and causes significant mutations in plants."
	list_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 50)

/obj/item/reagent_containers/glass/bottle/nutrient/rh
	name = "bottle of Robust Harvest"
	desc = "Contains a fertilizer that increases the yield of a plant by 30% while causing no mutations."
	list_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 50)

/obj/item/reagent_containers/glass/bottle/killer
	volume = 50
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/glass/bottle/killer/weedkiller
	name = "bottle of weed killer"
	desc = "Contains a herbicide."
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 50)

/obj/item/reagent_containers/glass/bottle/killer/pestkiller
	name = "bottle of pest spray"
	desc = "Contains a pesticide."
	list_reagents = list(/datum/reagent/toxin/pestkiller = 50)
