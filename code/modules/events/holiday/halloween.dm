//Lore Document for Mexapix: https://hackmd.io/D-9st3kxThm93WlUY7gKig

/*
/datum/round_event_control/spooky
	name = "Mexapix"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/spooky
	weight = -1							//forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event/spooky/start()
	..()
	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/human = i
		var/obj/item/storage/backpack/backpack = locate() in human.contents
		if(backpack)
			new /obj/item/storage/box/papersack/mexapix_candy(backpack)

/datum/round_event/spooky/announce(fake)
	priority_announce("Happy Mexapix. Read up about it <a href=\"https://hackmd.io/D-9st3kxThm93WlUY7gKig\">Here!</a>")
*/

/obj/item/food/cookie/sugar/spookyskull
	name = "skull cookie"
	desc = "Spooky! It's got delicious calcium flavouring!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "skeletoncookie"

/obj/item/storage/box/papersack/mexapix_candy
	name = "folded arxa"
	desc = "A bag with a random assorment of treats to celebrate Mexapix!"
	icon_state = "paperbag_None_closed"

/obj/item/storage/box/papersack/mexapix_candy/PopulateContents()
	new /obj/effect/spawner/random/food_or_drink/mexapix(src)

/obj/effect/spawner/random/food_or_drink/mexapix
	spawn_loot_count = 5
	loot = list(
			/obj/item/food/sucrika = 10,
			/obj/effect/spawner/random/entertainment/mexapix_trinkets = 2,
			/obj/item/food/cookie/sugar/spookyskull = 1,
			/obj/item/food/candy_corn = 1,
			/obj/item/food/candy = 1,
			/obj/item/food/candiedapple = 1,
			/obj/item/food/chocolatebar = 1,
		)

/obj/effect/spawner/random/entertainment/mexapix_trinkets
	loot = list(
		/obj/effect/spawner/random/entertainment/coin,
		/obj/effect/spawner/random/entertainment/dice,
		/obj/effect/spawner/random/entertainment/toy
	)

/obj/item/clothing/accessory/tooth_armlet
	name = "tooth armlet"
	desc = "One of the customary worn items of Mexapix are strings of teeth, made from the wearer's shedded teeth (if they are a Sarathi) or, more recently, plastic (if they are an Elzuosa) and worn on the neck or wrist."
	icon_state = "tooth_armlet"
	icon = 'icons/obj/halloween_items.dmi'
	attachment_slot = ARMS
	above_suit = TRUE
	var/painted_color

/obj/item/clothing/accessory/tooth_armlet/Initialize()
	. = ..()
	painted_color = pick(list("warm colors", "blue and gold"))
	desc += "<br>They are painted in "
	switch(painted_color)
		if("warm colors")
			name = "warm painted [name]"
			desc += "warm colors, indicating a desire for safety from the cold"
			icon_state += "_warm"
		if("blue and gold")
			name = "gold and blue painted [name]"
			desc += "blue and gold, signifying a desire for good financial fortune"
			icon_state += "_gold"

/obj/item/clothing/accessory/tooth_armlet/plastic
	name = "plastic tooth armlet"
	icon_state = "plastic_armlet"

/datum/supply_pack/civilian/mexapix
	name = "Mexapix supplies"
	desc = "Everything needed for a mexapix celerbration"
	cost = 300
	contains = list(
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/storage/box/papersack/mexapix_candy,
		/obj/item/storage/box/papersack/mexapix_candy,
		/obj/item/storage/box/papersack/mexapix_candy,
		/obj/item/reagent_containers/food/drinks/bottle/koerbalk,
		/obj/item/reagent_containers/food/drinks/bottle/koerbalk,
	)

/obj/item/leaves
	name = "a pile of loose leaves"
	icon_state = "tobacco_leaves"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	custom_materials = list(/datum/material/wood = 50, /datum/material/biomass = 50)

/datum/reagent/consumable/ethanol/koerbalk
	name = "koerbalk"
	taste_description = "fermented indigenous nuts and herbs"
	boozepwr = 5

/obj/item/reagent_containers/food/drinks/bottle/koerbalk
	name = "bottle of koerbalk"
	desc = "A bottle of koerbalk produced by a CLIP firm."
	icon_state = "mintbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/koerbalk = 50)
	var/mixing_sticks_left = 5

/obj/item/reagent_containers/food/drinks/bottle/koerbalk/examine(mob/user)
	. = ..()
	. += "It has [mixing_sticks_left] mixing sticks attached to the side of the container"
	. += "You can <b>Ctrl-Click</b> [src] to remove one."

/obj/item/reagent_containers/food/drinks/bottle/koerbalk/CtrlClick(mob/user)
	. = ..()
	if(isliving(user) && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		if(mixing_sticks_left > 0)
			mixing_sticks_left--
			to_chat(user, "You pull off a sugar encrusted stick from the side of [src].")
			var/turf/local_turf = get_turf(src)
			var/obj/item/food/chewable/mixing_stick/pulled_stick = new(local_turf)
			if(!user.put_in_hands(pulled_stick))
				to_chat(user, "You fumble as [pulled_stick] falls to the ground.")

/obj/item/food/chewable/mixing_stick
	name = "koerbalk mixing stick"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "mixstick_sugar_white"
	item_state = "lollipop_stick"
	desc = "Encrusted in sugar."
	food_reagents = list(/datum/reagent/consumable/sugar = 10)
	custom_materials = list(/datum/material/wood = 20)
	foodtypes = SUGAR
	w_class = WEIGHT_CLASS_TINY
	force = 0

/datum/crafting_recipe/food/brextak
	name = "Brextak"
	reqs = list(
		/obj/item/food/meat = 5,
		/obj/item/food/grown = 5,
		/datum/reagent/consumable/ethanol/wine = 10
	)
	result = /obj/item/food/brextak_uncooked
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/brextak_big
	name = "Communal Brextak"
	reqs = list(
		/obj/item/food/meat = 20,
		/obj/item/food/grown = 20,
		/datum/reagent/consumable/ethanol/wine = 40
	)
	result = /obj/item/food/brextak_uncooked/big
	subcategory = CAT_MEAT

/obj/item/food/brextak
	name = "brextak"
	desc = "A slow-roasted dish prepared with red meat, wine and various root vegetables in a ceramic dish over low heat for several hours."
	icon_state = "shepherds_pie"
	icon = 'icons/obj/halloween_items.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 50)
	//filling_color = "#FA8072"
	tastes = list("mexapix" = 1)
	foodtypes = MEAT | VEGETABLES | ALCOHOL
	resistance_flags = FIRE_PROOF
	var/slice_num = 5

/obj/item/food/brextak/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/brextak/slice, slice_num, 5 SECONDS, table_required = TRUE, /*screentip_verb = "Slice"*/)

/obj/item/food/brextak_uncooked
	name = "uncooked brextak"
	icon_state = "shepherds_pie"
	icon = 'icons/obj/halloween_items.dmi'
	food_reagents = list()
	foodtypes = RAW
	var/obj/item/cooked_type = /obj/item/food/brextak

/obj/item/food/brextak_uncooked/make_bakeable()
	AddComponent(/datum/component/bakeable, cooked_type, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/* Is this required anymore?
/obj/item/food/brextak_uncooked/burn()
	visible_message(span_notice("[src] finishes cooking!"))
	new cooked_type(loc)
	qdel(src)
*/

/obj/item/food/brextak/big
	name = "communal brextak"
	food_reagents = list(/datum/reagent/consumable/nutriment = 150)
	w_class = WEIGHT_CLASS_BULKY
	max_volume = 200
	slice_num = 20

/obj/item/food/brextak_uncooked/big
	name = "uncooked communal brextak"
	cooked_type = /obj/item/food/brextak/big

/obj/item/food/brextak/slice
	name = "slice of brextak"
	icon_state = "shepherds_pie_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10)
	//slice_path = null
	resistance_flags = NONE

/obj/item/food/brextak/slice/make_processable()
	return

/obj/item/food/sucrika
	name = "sucrika"
	desc = "Boiled, dryed, and candied. A mix of various fruits and nuts, which are wrapped in wax paper and eaten as snacks throughout the day as part of Mexapix"
	icon_state = "sucrika"
	icon = 'icons/obj/halloween_items.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 2)
	//filling_color = "#FF8C00"
	tastes = list("nuts" = 1, "dried fruits" = 1)
	foodtypes = FRUIT | SUGAR
	w_class = WEIGHT_CLASS_TINY

//A debug item
/obj/item/storage/box/ingredients/one_large_brextak
	theme_name = "wildcard"

/obj/item/storage/box/ingredients/one_large_brextak/PopulateContents()
	for(var/i in 1 to 20)
		var/randomFood = pick(
			/obj/item/food/grown/chili,
			/obj/item/food/grown/tomato,
			/obj/item/food/grown/carrot)
		new randomFood(src)
	for(var/i in 1 to 20)
		var/randomFood = pick(
			/obj/item/food/meat/slab/goliath,
			/obj/item/food/meat/slab/bear)
		new randomFood(src)
	new /obj/item/reagent_containers/food/drinks/bottle/wine(src)
