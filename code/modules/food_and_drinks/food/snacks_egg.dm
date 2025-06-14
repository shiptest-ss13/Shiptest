
////////////////////////////////////////////EGGS////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/chocolateegg
	name = "chocolate egg"
	desc = "Chocolate tempered and shaped into an egg. Doesn't acually contain any eggs, unless you put one in there yourself."
	icon_state = "chocolateegg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 4, "sweetness" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/egg
	name = "egg"
	desc = "An egg from a terran chicken, the most successful of egg-laying domesticated animals."
	icon_state = "egg"
	list_reagents = list(/datum/reagent/consumable/eggyolk = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/boiledegg
	filling_color = "#F0E68C"
	foodtype = MEAT | RAW
	w_class = WEIGHT_CLASS_TINY
	grind_results = list()
	var/static/chick_count = 0 //I copied this from the chicken_count (note the "en" in there) variable from chicken code.

/obj/item/reagent_containers/food/snacks/egg/gland
	desc = "An egg from... something other than a chicken. It doesn't look right."

/obj/item/reagent_containers/food/snacks/egg/gland/Initialize()
	. = ..()
	reagents.add_reagent(get_random_reagent_id(), 15)

	var/color = mix_color_from_reagents(reagents.reagent_list)
	add_atom_colour(color, FIXED_COLOUR_PRIORITY)

/obj/item/reagent_containers/food/snacks/egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		var/turf/T = get_turf(hit_atom)
		new /obj/effect/decal/cleanable/food/egg_smudge(T)
		if(prob(13)) //Roughly a 1/8 (12.5%) chance to make a chick, as in Minecraft. I decided not to include the chances for the creation of multiple chicks from the impact of one egg, since that'd probably require nested prob()s or something (and people might think that it was a bug, anyway).
			if(chick_count < MAX_CHICKENS) //Chicken code uses this MAX_CHICKENS variable, so I figured that I'd use it again here. Even this check and the check in chicken code both use the MAX_CHICKENS variable, they use independent counter variables and thus are independent of each other.
				new /mob/living/simple_animal/chick(T)
				chick_count++
		reagents.expose(hit_atom, TOUCH)
		qdel(src)

/obj/item/reagent_containers/food/snacks/egg/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/toy/crayon))
		var/obj/item/toy/crayon/C = W
		var/clr = C.crayon_color

		if(!(clr in list("blue", "green", "orange", "purple", "rainbow", "red", "yellow")))
			to_chat(usr, span_notice("[src] refuses to take on this colour!"))
			return

		to_chat(usr, span_notice("You colour [src] with [W]."))
		icon_state = "egg-[clr]"
	else
		..()

/obj/item/reagent_containers/food/snacks/egg/blue
	icon_state = "egg-blue"

/obj/item/reagent_containers/food/snacks/egg/green
	icon_state = "egg-green"

/obj/item/reagent_containers/food/snacks/egg/orange
	icon_state = "egg-orange"

/obj/item/reagent_containers/food/snacks/egg/purple
	icon_state = "egg-purple"

/obj/item/reagent_containers/food/snacks/egg/rainbow
	icon_state = "egg-rainbow"

/obj/item/reagent_containers/food/snacks/egg/red
	icon_state = "egg-red"

/obj/item/reagent_containers/food/snacks/egg/yellow
	icon_state = "egg-yellow"

/obj/item/reagent_containers/food/snacks/friedegg
	name = "fried egg"
	desc = "An egg that's been cooked on a flat surface, then seasoned with salt and pepper."
	icon_state = "friedegg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	bitesize = 1
	filling_color = "#FFFFF0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("egg" = 4, "salt" = 1, "pepper" = 1)
	foodtype = MEAT | BREAKFAST

/obj/item/reagent_containers/food/snacks/boiledegg
	name = "boiled egg"
	desc = "A hard boiled egg."
	icon_state = "egg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#FFFFF0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("egg" = 1)
	foodtype = MEAT | BREAKFAST
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/omelette	//FUCK THIS
	name = "omelette du fromage"
	desc = "An ancient term that roughly translates into \"beaten eggs with cheese\", originating from Terra. Essentially a well-beaten egg mixed with cheese before frying in a pan."
	icon_state = "omelette"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	bitesize = 1
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("egg" = 1, "cheese" = 1)
	foodtype = MEAT | BREAKFAST | DAIRY

/obj/item/reagent_containers/food/snacks/omelette/attackby(obj/item/W, mob/user, params)
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

/obj/item/reagent_containers/food/snacks/benedict
	name = "eggs benedict"
	desc = "A popular breakfast meal consisting of a solarian muffin with ham, a poached egg, and hollaindaise. Technically, this is a meal with two eggs involved."
	icon_state = "benedict"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 4)
	trash = /obj/item/trash/plate
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("egg" = 1, "bacon" = 1, "bun" = 1)

	foodtype = MEAT | BREAKFAST | GRAIN

/obj/item/reagent_containers/food/snacks/eggrolls
	name = "tamagoyaki nigiri"
	desc = "A grilled egg, wrapped with sticky white rice and held with specially prepared and dried seaweed."
	icon_state = "eggroll"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	filling_color = "#d3ceba"
	tastes = list("rice" = 1, "dried seaweed" = 1, "eggs" = 1)
	foodtype = BREAKFAST | FRIED
