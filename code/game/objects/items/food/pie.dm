/obj/item/food/pie
	icon = 'icons/obj/food/piecake.dmi'
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pie" = 1)
	foodtypes = GRAIN
	/// type is spawned 5 at a time and replaces this pie when processed by cutting tool
	var/obj/item/food/pieslice/slice_type
	/// so that the yield can change if it isnt 5
	var/yield = 5

/obj/item/food/pie/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, table_required = TRUE, /*screentip_verb = "Slice"*/)

/obj/item/food/pieslice
	name = "pie slice"
	icon = 'icons/obj/food/piecake.dmi'
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		)
	tastes = list("pie" = 1, "uncertainty" = 1)
	foodtypes = GRAIN

/obj/item/food/pie/plain
	name = "plain pie"
	desc = "A baked pie crust with no fillings. Edible as is, but..."
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("pie" = 1)
	foodtypes = GRAIN

/obj/item/food/pie/cream
	name = "banana cream pie"
	desc = "A custard and baked banana pie, topped with whipped cream. Ever popular in human cuisine, a brief extranet fad of using it as a throwing projectile made it a favorite of pranksters."
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	var/stunning = TRUE

/obj/item/food/pie/cream/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/food/pie/cream/proc/splat(atom/movable/hit_atom)

	if(isliving(loc)) //someone caught us!
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(hit_turf)

	if(reagents?.total_volume)
		reagents.expose(hit_atom, TOUCH)

	var/is_creamable = TRUE
	if(isliving(hit_atom))
		var/mob/living/living_target_getting_hit = hit_atom

		if(stunning)
			living_target_getting_hit.Paralyze(20) //splat!

		if(iscarbon(living_target_getting_hit))
			is_creamable = !!(living_target_getting_hit.get_bodypart(BODY_ZONE_HEAD))

		if(is_creamable)
			living_target_getting_hit.adjust_blurriness(1)

		living_target_getting_hit.visible_message(
			span_warning("[living_target_getting_hit] is creamed by [src]!"),
			span_userdanger("You've been creamed by [src]!"),
			span_warning("You hear a splat.")
		)
		playsound(living_target_getting_hit, "desceration", 50, TRUE)

	if(is_creamable && is_type_in_typecache(hit_atom, GLOB.creamable))
		hit_atom.AddComponent(/datum/component/creamed, src)

	qdel(src)

/obj/item/food/pie/cream/nostun
	stunning = FALSE

/obj/item/food/pie/cream/body

/obj/item/food/pie/cream/body/Destroy()
	var/turf/T = get_turf(src)
	for(var/atom/movable/A in contents)
		A.forceMove(T)
		A.throw_at(T, 1, 1)
	. = ..()

/*
/obj/item/food/pie/cream/body/proc/on_consume(mob/living/carbon/M)
	if(!reagents.total_volume) //so that it happens on the last bite
		if(iscarbon(M) && contents.len)
			var/turf/T = get_turf(src)
			for(var/atom/movable/A in contents)
				A.forceMove(T)
				A.throw_at(T, 1, 1)
				M.visible_message("[src] bursts out of [M]!</span>")
			M.emote("scream")
			M.Knockdown(40)
			M.adjustBruteLoss(60)
	return ..()
*/

/obj/item/food/pie/berryclafoutis
	name = "berry clafoutis"
	desc = "A tart consisting of berries smothered in a thick batter before being baked and coated with powdered sugar. A pleasant treat from the outer cantons."
	icon_state = "berryclafoutis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/berryjuice = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "blackberries" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/bearypie
	name = "beary pie"
	desc = "A particularly heavy meat pie. The name stems from a rumor of a sort of spaceborne ursine that stalks asteroids and hunts unfortunate asteroid miners, known for their starry pelts."
	icon_state = "bearypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "meat" = 1, "salmon" = 1)
	foodtypes = GRAIN | SUGAR | MEAT | FRUIT

/obj/item/food/pie/meatpie
	name = "meat-pie"
	icon_state = "meatpie"
	desc = "A pie crust, filled with meat and other savory ingredients. A source of culinary debate between which culture on Terra and Kalixcis invented it first still goes on today, with both early species having used ancient recipes to use pie dough to allow cooked meat to be held and eaten thousands of years ago."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("pie" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/pie/tofupie
	name = "tofu-pie"
	icon_state = "meatpie"
	desc = "A vegetarian variant of the meat pie, usually of firm tofu that's been seasoned thoroughly beforehand and paired with a sauce."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("pie" = 1, "tofu" = 1)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/pie/amanita_pie
	name = "amanita pie"
	desc = "A culinary experiment, the amanita pie, or fly agaric pie, is still notoriously poisonous and hallucinogenic in spite of the culinary preparation."
	icon_state = "amanita_pie"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/amatoxin = 3,
		/datum/reagent/drug/mushroomhallucinogen = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | TOXIC | GROSS

/obj/item/food/pie/plump_pie
	name = "plump pie"
	desc = "A common method of preparing the savory mushroom from Syeben'Altch, the plump pie is full of baked, softened mushrooms."
	icon_state = "plump_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/pie/plump_pie/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "exceptional plump pie"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump pie!"
		food_reagents = list(
			/datum/reagent/consumable/nutriment = 11,
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment/vitamin = 4,
		)
	. = ..()

/obj/item/food/pie/xemeatpie
	name = "xeno-pie"
	icon_state = "xenomeatpie"
	desc = "A meat pie prepared from the dangerous xenomorph's prepared flesh. The crust is actively melting and smoking from the acid."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("pie" = 1, "meat" = 1, "acid" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/pie/applepie
	name = "apple pie"
	desc = "A pie consisting of sweetened, baked apples and cinnamon. A hallmark of Solar dessert cuisine."
	icon_state = "applepie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "apple" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/cherrypie
	name = "cherry pie"
	desc = "A pie filled with sour cherries mixed with sugar and baked. Considered a sibling to the other fruit-filled pies of Solar make."
	icon_state = "cherrypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 7, "Nicole Paige Brooks" = 2)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/pumpkinpie
	name = "pumpkin pie"
	desc = "A pie filled with a pumpkin-based custard, spiced heavily. Despite catching on as a flavoring, the actual pumpkin gourd is relatively plain."
	icon_state = "pumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "pumpkin" = 1)
	foodtypes = GRAIN | VEGETABLES | SUGAR
	slice_type = /obj/item/food/pieslice/pumpkin

/obj/item/food/pieslice/pumpkin
	name = "pumpkin pie slice"
	desc = "A slice of pumpkin pie."
	icon_state = "pumpkinpieslice"
	tastes = list("pie" = 1, "pumpkin" = 1)
	foodtypes = GRAIN | VEGETABLES | SUGAR

/obj/item/food/pie/appletart
	name = "golden apple streusel tart"
	desc = "Baked, cinnamon-coated apples mixed with streusel. Particularly crumbly."
	icon_state = "gappletart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/gold = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "apple" = 1, "expensive metal" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/grapetart
	name = "grape tart"
	desc = "A thin tart, filled with sweetened grapes."
	icon_state = "grapetart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "grape" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/berrytart
	name = "berry tart"
	desc = "A thin tart, filled with various berries."
	icon_state = "berrytart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "berries" = 2)
	foodtypes = GRAIN | FRUIT

/obj/item/food/pie/cocoalavatart
	name = "chocolate lava tart"
	desc = "A smaller version of the lava cake, this is essentially a miniature cake filled with molten chocolate."
	icon_state = "cocoalavatart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pie" = 1, "dark chocolate" = 3)
	foodtypes = GRAIN | SUGAR

/obj/item/food/pie/blumpkinpie
	name = "blumpkin pie"
	desc = "A pie filled with a botanical experiment-based custard, which stings the eyes and nose heavily. The smell of chlorine is almost unbearable."
	icon_state = "blumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 13,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("pie" = 1, "a mouthful of pool water" = 1)
	foodtypes = GRAIN | VEGETABLES
	slice_type = /obj/item/food/pieslice/blumpkin

/obj/item/food/pieslice/blumpkin
	name = "blumpkin pie slice"
	desc = "A slice of blumpkin pie."
	icon_state = "blumpkinpieslice"
	tastes = list("pie" = 1, "a mouthful of pool water" = 1)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/pie/dulcedebatata
	name = "dulce de batata"
	desc = "A jelly derived from sweet potatoes, often found canned or mixed with chocolate."
	icon_state = "dulcedebatata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("jelly" = 1, "sweet potato" = 1)
	foodtypes = VEGETABLES | SUGAR
	slice_type = /obj/item/food/pieslice/dulcedebatata

/obj/item/food/pieslice/dulcedebatata
	name = "dulce de batata slice"
	desc = "A slice of dulce de batata."
	icon_state = "dulcedebatataslice"
	tastes = list("jelly" = 1, "sweet potato" = 1)
	foodtypes = VEGETABLES | SUGAR

/obj/item/food/pie/frostypie
	name = "frosty pie"
	desc = "An extremely minty pie, served cold. It's difficult to eat from the sheer strength of its contents..."
	icon_state = "frostypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("mint" = 1, "pie" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/pie/baklava
	name = "baklava"
	desc = "A pastry made up of layers of filo, chopped nuts, and brushed with honey."
	icon_state = "baklava"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("nuts" = 1, "pie" = 1)
	foodtypes = /*NUTS | */SUGAR
	slice_type = /obj/item/food/pieslice/baklava
	yield = 6

/obj/item/food/pieslice/baklava
	name = "baklava dish"
	desc = "A portion of a many-layered baklava."
	icon_state = "baklavaslice"
	tastes = list("nuts" = 1, "pie" = 1)
	foodtypes = /*NUTS | */SUGAR
