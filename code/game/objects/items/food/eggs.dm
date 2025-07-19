//Eggs
/obj/item/food/chocolateegg
	name = "chocolate egg"
	desc = "Chocolate tempered and shaped into an egg. Doesn't acually contain any eggs, unless you put one in there yourself."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "chocolateegg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("chocolate" = 4, "sweetness" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/egg
	name = "egg"
	desc = "An egg from a terran chicken, the most successful of egg-laying domesticated animals."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "egg"
	item_state = "egg"
	food_reagents = list(
		/datum/reagent/consumable/eggyolk = 5,
		/datum/reagent/consumable/eggwhite = 4,
	)
	microwaved_type = /obj/item/food/boiledegg
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/egg/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!istype(target, /obj/machinery/griddle))
		return

	var/atom/broken_egg = new /obj/item/food/rawegg(target.loc)
	broken_egg.pixel_x = pixel_x
	broken_egg.pixel_y = pixel_y
	playsound(get_turf(user), 'sound/items/sheath.ogg', 40, TRUE)
	reagents.copy_to(broken_egg,reagents.total_volume)

	var/obj/machinery/griddle/hit_griddle = target
	hit_griddle.AddToGrill(broken_egg, user)
	target.visible_message(
		span_notice("[user] cracks [src] open."),
		span_notice("You crack [src] open."),
		span_notice("You hear a crack."),
	)
	qdel(src)

/obj/item/food/egg/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/boiledegg, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/egg/gland
	desc = "An egg from... something other than a chicken. It doesn't look right."

/obj/item/food/egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob?
		return

	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/egg_smudge(T)
	reagents.expose(hit_atom, TOUCH)
	qdel(src)

/obj/item/food/egg/blue
	icon_state = "egg-blue"

/obj/item/food/egg/green
	icon_state = "egg-green"

/obj/item/food/egg/mime
	icon_state = "egg-mime"

/obj/item/food/egg/orange
	icon_state = "egg-orange"

/obj/item/food/egg/purple
	icon_state = "egg-purple"

/obj/item/food/egg/rainbow
	icon_state = "egg-rainbow"

/obj/item/food/egg/red
	icon_state = "egg-red"

/obj/item/food/egg/yellow
	icon_state = "egg-yellow"

/obj/item/food/friedegg
	name = "fried egg"
	desc = "An egg that's been cooked on a flat surface, then seasoned with salt and pepper."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "friedegg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 1
	tastes = list("egg" = 4, "salt" = 1, "pepper" = 1)
	foodtypes = MEAT | FRIED | BREAKFAST

/obj/item/food/rawegg
	name = "raw egg"
	desc = "Supposedly good for you, if you can stomach it. Better fried."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "rawegg"
	food_reagents = list() //Receives all reagents from its whole egg counterpart
	bite_consumption = 1
	tastes = list("raw egg" = 6, "sliminess" = 1)
	eatverbs = list("gulp down")
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rawegg/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/friedegg, rand(20 SECONDS, 35 SECONDS), TRUE, FALSE)

/obj/item/food/boiledegg
	name = "boiled egg"
	desc = "A hard boiled egg."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "egg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("egg" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD // pretty sure I've seen people pop these in their mouths... right?
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/omelette //FUCK THIS
	name = "omelette du fromage"
	desc = "An ancient term that roughly translates into \"beaten eggs with cheese\", originating from Terra. Essentially a well-beaten egg mixed with cheese before frying in a pan."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "omelette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	bite_consumption = 1
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("egg" = 1, "cheese" = 1)
	foodtypes = MEAT | BREAKFAST | DAIRY //yeah, I say this just about reaches the threshold of dairy foodgroup

/obj/item/food/omelette/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/kitchen/fork))
		var/obj/item/kitchen/fork/F = W
		if(F.forkload)
			to_chat(user, span_warning("You already have omelette on your fork!"))
		else
			F.icon_state = "forkloaded"
			user.visible_message(span_notice("[user] takes a piece of omelette with [user.p_their()] fork!"), \
				span_notice("You take a piece of omelette with your fork."))

			var/datum/reagent/R = pick(reagents.reagent_list)
			reagents.remove_reagent(R.type, 1)
			F.forkload = R
			if(reagents.total_volume <= 0)
				qdel(src)
		return
	..()

/obj/item/food/benedict
	name = "eggs benedict"
	desc = "A popular breakfast meal consisting of a solarian muffin with ham, a poached egg, and hollaindaise. Technically, this is a meal with two eggs involved."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "benedict"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("egg" = 1, "bacon" = 1, "bun" = 1)
	foodtypes = MEAT | BREAKFAST | GRAIN

/obj/item/food/eggrolls
	name = "tamagoyaki nigiri"
	desc = "A grilled egg, wrapped with sticky white rice and held with specially prepared and dried seaweed."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "eggroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 2
	)
	tastes = list("rice" = 1, "dried seaweed" = 1, "eggs" = 1)
	foodtypes = BREAKFAST | FRIED

/obj/item/food/eggwrap
	name = "egg wrap"
	desc = "Thinly cooked egg, intended as a wrapper for a filling."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "eggwrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("egg" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/chawanmushi
	name = "chawanmushi"
	desc = "A savory egg custard originating from Earth, named after being prepared by being steamed in a tea bowl or teacup."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "chawanmushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("custard" = 1)
	foodtypes = MEAT | VEGETABLES
