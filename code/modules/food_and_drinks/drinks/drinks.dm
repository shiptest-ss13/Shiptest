////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/food/drinks
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = null
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	pickup_sound =  'sound/items/handling/bottle_pickup.ogg'
	drop_sound = 'sound/items/handling/bottle_drop.ogg'
	reagent_flags = OPENCONTAINER | DUNKABLE
	var/gulp_size = 5 //This is now officially broken ... need to think of a nice way to fix it.
	possible_transfer_amounts = list(5,10,15,20,25,30,50)
	volume = 50
	resistance_flags = NONE
	var/isGlass = TRUE //Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it

/obj/item/reagent_containers/food/drinks/attack(mob/living/M, mob/user, def_zone)

	if(!reagents || !reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return FALSE

	if(!canconsume(M, user))
		return FALSE

	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s lid hasn't been opened!</span>")
		return FALSE

	if(M == user)
		user.visible_message("<span class='notice'>[user] swallows a gulp of [src].</span>", \
			"<span class='notice'>You swallow a gulp of [src].</span>")
		if(HAS_TRAIT(M, TRAIT_VORACIOUS))
			M.changeNext_move(CLICK_CD_MELEE * 0.5) //chug! chug! chug!

	else
		M.visible_message("<span class='danger'>[user] attempts to feed [M] the contents of [src].</span>", \
			"<span class='userdanger'>[user] attempts to feed you the contents of [src].</span>")
		if(!do_after(user, target = M))
			return
		if(!reagents || !reagents.total_volume)
			return // The drink might be empty after the delay, such as by spam-feeding
		M.visible_message("<span class='danger'>[user] fed [M] the contents of [src].</span>", \
			"<span class='userdanger'>[user] fed you the contents of [src].</span>")
		log_combat(user, M, "fed", reagents.log_list())

	var/fraction = min(gulp_size/reagents.total_volume, 1)
	checkLiked(fraction, M)
	reagents.trans_to(M, gulp_size, transfered_by = user, method = INGEST)
	playsound(M.loc,'sound/items/drink.ogg', rand(10,50), TRUE)
	return TRUE

/obj/item/reagent_containers/food/drinks/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity || !check_allowed_items(target,target_self=1))
		return

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!is_drainable())
			to_chat(user, "<span class='warning'>[src] isn't open!</span>")
			return

		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src] is empty.</span>")
			return

		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return

		var/refill = reagents.get_master_reagent_id()
		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, "<span class='notice'>You transfer [trans] units of the solution to [target].</span>")
		playsound(src, 'sound/items/glass_transfer.ogg', 50, 1)

		if(iscyborg(user)) //Cyborg modules that include drinks automatically refill themselves, but drain the borg's cell
			var/mob/living/silicon/robot/bro = user
			bro.cell.use(30)
			addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, add_reagent), refill, trans), 600)

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if (!is_refillable())
			to_chat(user, "<span class='warning'>[src] isn't open!</span>")
			return

		if(!target.reagents.total_volume)
			to_chat(user, "<span class='warning'>[target] is empty.</span>")
			return

		if(reagents.holder_full())
			to_chat(user, "<span class='warning'>[src] is full.</span>")
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, "<span class='notice'>You fill [src] with [trans] units of the contents of [target].</span>")

	else if(reagents.total_volume && is_drainable())
		switch(user.a_intent)
			if(INTENT_HELP)
				attempt_pour(target, user)
			if(INTENT_HARM)
				user.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [target]!</span>", \
									"<span class='notice'>You splash the contents of [src] onto [target].</span>")
				reagents.expose(target, TOUCH)
				reagents.clear_reagents()
				playsound(src, 'sound/items/glass_splash.ogg', 50, 1)

/obj/item/reagent_containers/food/drinks/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		reagents.expose_temperature(hotness)
		to_chat(user, "<span class='notice'>You heat [name] with [I]!</span>")
	..()

/obj/item/reagent_containers/food/drinks/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if the bottle wasn't caught
		smash(hit_atom, throwingdatum?.thrower, TRUE)

/obj/item/reagent_containers/food/drinks/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	smash()
	..()

/obj/item/reagent_containers/food/drinks/proc/smash(atom/target = FALSE, mob/thrower = FALSE, ranged = FALSE)
	if(!isGlass)
		return
	if(QDELING(src) || !(flags_1 & INITIALIZED_1))	//Invalid loc
		return
	if(target)
		if(bartender_check(target) && ranged)
			return
	var/obj/item/broken_bottle/smashed_bottle = new (loc)
	if(!ranged && thrower)
		thrower.put_in_hands(smashed_bottle)
	smashed_bottle.icon_state = icon_state
	var/icon/new_icon = new(icon, icon_state)
	new_icon.Blend(smashed_bottle.broken_outline, ICON_OVERLAY, rand(5), 1)
	new_icon.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	smashed_bottle.icon = new_icon
	smashed_bottle.name = "broken [name]"
	if(prob(33))
		var/obj/item/shard/new_shard = new(drop_location())
		if(target)
			target.Bumped(new_shard)
	playsound(src, "shatter", 70, TRUE)
	transfer_fingerprints_to(smashed_bottle)
	qdel(src)
	if(target)
		target.Bumped(smashed_bottle)

/obj/item/reagent_containers/food/drinks/bullet_act(obj/projectile/P)
	. = ..()
	if(!(P.nodamage) && P.damage_type == BRUTE && !QDELETED(src))
		var/atom/T = get_turf(src)
		smash(T)
		return



////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////


/obj/item/reagent_containers/food/drinks/trophy
	name = "pewter cup"
	desc = "Everyone gets a trophy."
	icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/iron=100)
	possible_transfer_amounts = list()
	volume = 5
	flags_1 = CONDUCT_1
	spillable = TRUE
	resistance_flags = FIRE_PROOF
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/trophy/gold_cup
	name = "gold cup"
	desc = "You're winner!"
	icon_state = "golden_cup"
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	custom_materials = list(/datum/material/gold=1000)
	volume = 150

/obj/item/reagent_containers/food/drinks/trophy/silver_cup
	name = "silver cup"
	desc = "Best loser!"
	icon_state = "silver_cup"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 8
	amount_per_transfer_from_this = 15
	custom_materials = list(/datum/material/silver=800)
	volume = 100


/obj/item/reagent_containers/food/drinks/trophy/bronze_cup
	name = "bronze cup"
	desc = "At least you ranked!"
	icon_state = "bronze_cup"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 4
	amount_per_transfer_from_this = 10
	custom_materials = list(/datum/material/iron=400)
	volume = 25

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
//	rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
//	Formatting is the same as food.

/obj/item/reagent_containers/food/drinks/coffee
	name = "Solar's Best black coffee"
	desc = "A cup of piping hot black coffee. Made from beans grown across the solar cantons for the caffeine that every spacer needs."
	icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/ice
	name = "ice cup"
	desc = "Careful, cold ice, do not chew."
	custom_price = 15
	icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/ice = 30)
	spillable = TRUE
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/ice/prison
	name = "dirty ice cup"
	desc = "Either Nanotrasen's water supply is contaminated, or this machine actually vends lemon, chocolate, and cherry snow cones."
	list_reagents  = list(/datum/reagent/consumable/ice = 25, /datum/reagent/liquidgibs = 5)

/obj/item/reagent_containers/food/drinks/mug/ // parent type is literally just so empty mug sprites are a thing
	name = "mug"
	desc = "A drink served in a classy mug."
	icon_state = "tea"
	item_state = "coffee"
	spillable = TRUE

/obj/item/reagent_containers/food/drinks/mug/on_reagent_change(changetype)
	if(reagents.total_volume)
		icon_state = "tea"
	else
		icon_state = "tea_empty"

/obj/item/reagent_containers/food/drinks/mug/tea
	name = "Guildmaiden's tea"
	desc = "Dark tea, made from pressed, fermented tea leaves. Originally from Sol, it became wildly popular among the Rachnid Guilds, and has become a staple."
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/food/drinks/mug/coco
	name = "Solar's Best Hot Cocoa"
	desc = "A cup of hot water mixed with chocolate and malted milk powder. A classic hot drink from the Solarian Confederation."
	list_reagents = list(/datum/reagent/consumable/hot_coco = 15, /datum/reagent/consumable/sugar = 5)
	foodtype = SUGAR
	resistance_flags = FREEZE_PROOF
	custom_price = 120

/obj/item/reagent_containers/food/drinks/cafelatte
	name = "cafe latte"
	desc = "A nice, strong and refreshing beverage while you're reading."
	icon_state = "cafe_latte"
	list_reagents = list(/datum/reagent/consumable/cafe_latte = 30)
	custom_price = 200

/obj/item/reagent_containers/food/drinks/soylatte
	name = "soy latte"
	desc = "A nice and refreshing beverage while you're reading."
	icon_state = "soy_latte"
	list_reagents = list(/datum/reagent/consumable/soy_latte = 30)
	custom_price = 200

/obj/item/reagent_containers/food/drinks/dry_ramen
	name = "cup ramen"
	desc = "A cup full of dried noodles, premixed with a flavor powder. Adding 5 units of water will cause the cup to self-heat, cooking it rapidly. Commonly eaten under dozens of brands, from students to eating on a budget. Always umami!"
	icon_state = "ramen"
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 15, /datum/reagent/consumable/sodiumchloride = 3)
	foodtype = GRAIN
	isGlass = FALSE
	custom_price = 95

/obj/item/reagent_containers/food/drinks/waterbottle
	name = "Ryuunosuke Reserve" //we still have to find a way to make multiple variants as per the plan
	desc = "Water bottled from a plant somewhere on Ryuunosuke. It has a mild, mineral-y flavor."
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "smallbottle"
	item_state = "bottle"
	list_reagents = list(/datum/reagent/water = 50)
	custom_materials = list(/datum/material/plastic=1000)
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	isGlass = FALSE
	custom_price = 30
	can_have_cap = TRUE
	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	cap_icon_state = "bottle_cap_small"
	cap_on = TRUE
	var/flip_chance = 10

/obj/item/reagent_containers/food/drinks/waterbottle/attack(mob/target, mob/user, def_zone)
	if(target && user.a_intent == INTENT_HARM)
		if(!spillable)
			to_chat(user, "<span class='warning'>[src] is closed!</span>")
		else
			SplashReagents(target)
		return

	return ..()

// heehoo bottle flipping
/obj/item/reagent_containers/food/drinks/waterbottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!QDELETED(src) && !spillable && reagents.total_volume)
		if(prob(flip_chance)) // landed upright
			src.visible_message("<span class='notice'>[src] lands upright!</span>")
			if(throwingdatum.thrower)
				SEND_SIGNAL(throwingdatum.thrower, COMSIG_ADD_MOOD_EVENT, "bottle_flip", /datum/mood_event/bottle_flip)
		else // landed on it's side
			animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/food/drinks/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/food/drinks/waterbottle/empty
	list_reagents = list()
	cap_on = FALSE

/obj/item/reagent_containers/food/drinks/waterbottle/large
	desc = "A fresh commercial-sized bottle of water."
	icon_state = "largebottle"
	custom_materials = list(/datum/material/plastic=3000)
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 20
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/food/drinks/waterbottle/large/empty
	list_reagents = list()
	cap_on = FALSE

// Admin spawn
/obj/item/reagent_containers/food/drinks/waterbottle/relic
	name = "mysterious bottle"
	desc = "A bottle quite similar to a water bottle, but with some words scribbled on with a marker. It seems to be radiating some kind of energy."
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/food/drinks/waterbottle/relic/Initialize()
	var/reagent_id = get_random_reagent_id()
	var/datum/reagent/random_reagent = new reagent_id
	list_reagents = list(random_reagent.type = 50)
	. = ..()
	desc +=  "<span class='notice'>The writing reads '[random_reagent.name]'.</span>"
	update_appearance()

/obj/item/reagent_containers/food/drinks/beer
	name = "Bizircan Brewery GDM" //ditto the plan for bottled water, need to find a way to make multiple variants
	desc = "A popular Gezenan drink made of fermented honey and spices, known as Gezenan Dark Mead, or GDM for short."
	icon_state = "beer"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)
	foodtype = SUGAR | ALCOHOL
	custom_price = 60

/obj/item/reagent_containers/food/drinks/beer/light
	name = "Carp Lite"
	desc = "Brewed with \"Pure Ice Asteroid Spring Water\"."
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 30)

/obj/item/reagent_containers/food/drinks/ale
	name = "RHIMBASA TAP"
	desc = "An ale that is brewed on Reh'himl, named after the planet that shields it from their sun. Telh'aim Pale Ales are shortened to TAP, with most breweries reducing their names to acronyms alongside it."
	icon_state = "alebottle"
	item_state = "beer"
	list_reagents = list(/datum/reagent/consumable/ethanol/ale = 30)
	foodtype = GRAIN | ALCOHOL
	custom_price = 60

/obj/item/reagent_containers/food/drinks/sillycup
	name = "paper cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = list()
	volume = 10
	spillable = TRUE
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/sillycup/on_reagent_change(changetype)
	if(reagents.total_volume)
		icon_state = "water_cup"
	else
		icon_state = "water_cup_e"

/obj/item/reagent_containers/food/drinks/sillycup/smallcarton
	name = "small carton"
	desc = "A small carton, intended for holding drinks."
	icon_state = "juicebox"
	volume = 15 //I figure if you have to craft these it should at least be slightly better than something you can get for free from a watercooler

/obj/item/reagent_containers/food/drinks/sillycup/smallcarton/smash(atom/target, mob/thrower, ranged = FALSE)
	if(bartender_check(target) && ranged)
		return
	var/obj/item/broken_bottle/B = new (loc)
	B.icon_state = icon_state
	var/icon/I = new('icons/obj/drinks/drinks.dmi', src.icon_state)
	I.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
	I.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	B.icon = I
	B.name = "broken [name]"
	B.force = 0
	B.throwforce = 0
	B.desc = "A carton with the bottom half burst open. Might give you a papercut."
	transfer_fingerprints_to(B)
	qdel(src)
	target.Bumped(B)

/obj/item/reagent_containers/food/drinks/sillycup/smallcarton/on_reagent_change(changetype)
	if (reagents.reagent_list.len)
		switch(reagents.get_master_reagent_id())
			if(/datum/reagent/consumable/orangejuice)
				icon_state = "orangebox"
				name = "orange juice box"
				desc = "A great source of vitamins. Stay healthy!"
				foodtype = FRUIT | BREAKFAST
			if(/datum/reagent/consumable/milk)
				icon_state = "milkbox"
				name = "carton of milk"
				desc = "An excellent source of calcium for growing space explorers."
				foodtype = DAIRY | BREAKFAST
			if(/datum/reagent/consumable/applejuice)
				icon_state = "juicebox"
				name = "apple juice box"
				desc = "Sweet apple juice. Don't be late for school!"
				foodtype = FRUIT
			if(/datum/reagent/consumable/grapejuice)
				icon_state = "grapebox"
				name = "grape juice box"
				desc = "Tasty grape juice in a fun little container. Non-alcoholic!"
				foodtype = FRUIT
			if(/datum/reagent/consumable/pineapplejuice)
				icon_state = "pineapplebox"
				name = "pineapple juice box"
				desc = "Sweet, tart pineapple juice."
				foodtype = FRUIT | PINEAPPLE
			if(/datum/reagent/consumable/milk/chocolate_milk)
				icon_state = "chocolatebox"
				name = "carton of chocolate milk"
				desc = "Milk mixed with chocolate, a common childhood favorite!"
				foodtype = SUGAR
			if(/datum/reagent/consumable/ethanol/eggnog)
				icon_state = "nog2"
				name = "carton of eggnog"
				desc = "A carton of eggnog, a drink of choice for celebrating Winter Solstice."
				foodtype = MEAT
	else
		icon_state = "juicebox"
		name = "small carton"
		desc = "A small carton, intended for holding drinks."


/obj/item/reagent_containers/food/drinks/colocup
	name = "colo cup"
	desc = "A cheap, mass produced style of cup, typically used at parties. They never seem to come out red, for some reason..."
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "colocup"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	item_state = "colocup"
	custom_materials = list(/datum/material/plastic = 1000)
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5
	isGlass = FALSE
	/// Allows the lean sprite to display upon crafting
	var/random_sprite = TRUE

/obj/item/reagent_containers/food/drinks/colocup/Initialize()
	.=..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
	if (random_sprite)
		icon_state = "colocup[rand(0, 6)]"

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
//	itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
//	icon states.

/obj/item/reagent_containers/food/drinks/shaker
	name = "shaker"
	desc = "A metal shaker to mix drinks in."
	icon_state = "shaker"
	custom_materials = list(/datum/material/iron=1500)
	amount_per_transfer_from_this = 10
	volume = 100
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/flask
	name = "flask"
	desc = "Every good spacer knows it's a good idea to bring along a couple of pints of whiskey wherever they go."
	custom_price = 200
	icon_state = "flask"
	custom_materials = list(/datum/material/iron=250)
	volume = 60
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/flask/gold
	name = "captain's flask"
	desc = "A gold flask belonging to the captain."
	icon_state = "flask_gold"
	custom_materials = list(/datum/material/gold=500)

/obj/item/reagent_containers/food/drinks/flask/det
	name = "detective's flask"
	desc = "The detective's only true friend."
	icon_state = "detflask"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)

/obj/item/reagent_containers/food/drinks/mug
	name = "cup"
	desc = "A mug. Stylishly plain."
	icon_state = "tea_empty"
	volume = 30
	spillable = TRUE

/obj/item/reagent_containers/food/drinks/rilenacup
	name = "RILENA mug"
	desc = "A mug with RILENA: LMR protagonist Ri's face on it."
	icon_state = "rilenacup"
	volume = 30
	spillable = TRUE

//////////////////////////soda_cans//
//These are in their own group to be used as IED's in /obj/item/grenade/ghettobomb.dm

/obj/item/reagent_containers/food/drinks/soda_cans
	name = "soda can"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	reagent_flags = NONE
	spillable = FALSE
	isGlass = FALSE
	custom_price = 45
	var/pierced = FALSE
	obj_flags = CAN_BE_HIT


/obj/item/reagent_containers/food/drinks/soda_cans/random/Initialize()
	..()
	var/T = pick(subtypesof(/obj/item/reagent_containers/food/drinks/soda_cans) - /obj/item/reagent_containers/food/drinks/soda_cans/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/reagent_containers/food/drinks/soda_cans/random/Initialize()
	..()
	var/T = pick(subtypesof(/obj/item/reagent_containers/food/drinks/soda_cans) - /obj/item/reagent_containers/food/drinks/soda_cans/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL


/obj/item/reagent_containers/food/drinks/soda_cans/attack(mob/M, mob/user)
	if(istype(M, /mob/living/carbon) && !reagents.total_volume && user.a_intent == INTENT_HARM && user.zone_selected == BODY_ZONE_HEAD)
		if(M == user)
			user.visible_message("<span class='warning'>[user] crushes the can of [src] on [user.p_their()] forehead!</span>", "<span class='notice'>You crush the can of [src] on your forehead.</span>")
		else
			user.visible_message("<span class='warning'>[user] crushes the can of [src] on [M]'s forehead!</span>", "<span class='notice'>You crush the can of [src] on [M]'s forehead.</span>")
		playsound(M,'sound/weapons/pierce.ogg', rand(10,50), TRUE)
		var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(M.loc)
		crushed_can.icon_state = icon_state
		qdel(src)
		return TRUE
	var/chugged = reagents.total_volume
	. = ..()
	if(is_drainable() && pierced && chugged)
		M.changeNext_move(CLICK_CD_RAPID)
		if(iscarbon(M))
			var/mob/living/carbon/broh = M
			broh.adjustOxyLoss(2)
			broh.losebreath++
			switch(broh.losebreath)
				if(-INFINITY to 0)
					EMPTY_BLOCK_GUARD
				if(1 to 2)
					if(prob(30))
						user.visible_message("<b>[broh]</b>'s eyes water as [broh.p_they()] chug the can of [src]!")
				if(3 to 6)
					if(prob(20))
						user.visible_message("<b>[broh]</b> makes \an [pick(list("uncomfortable", "gross", "troubling"))] gurgling noise as [broh.p_they()] chug the can of [src]!")
				if(9 to INFINITY)
					broh.vomit(2, stun=FALSE)


/obj/item/reagent_containers/food/drinks/soda_cans/bullet_act(obj/projectile/P)
	. = ..()
	if(!(P.nodamage) && P.damage_type == BRUTE && !QDELETED(src))
		var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(src.loc)
		crushed_can.icon_state = icon_state
		var/atom/throw_target = get_edge_target_turf(crushed_can, pick(GLOB.alldirs))
		crushed_can.throw_at(throw_target, rand(1,2), 7)
		qdel(src)
		return

/obj/item/reagent_containers/food/drinks/soda_cans/proc/open_soda(mob/user)
	to_chat(user, "You pull back the tab of \the [src] with a satisfying pop.") //Ahhhhhhhh
	reagents.flags |= OPENCONTAINER
	playsound(src, "can_open", 50, TRUE)
	spillable = TRUE

/obj/item/reagent_containers/food/drinks/soda_cans/attack_self(mob/user)
	if(!is_drainable())
		open_soda(user)
	return ..()

/obj/item/reagent_containers/food/drinks/soda_cans/attacked_by(obj/item/I, mob/living/user)
	if(I.sharpness && !pierced && user && user.a_intent != INTENT_HARM)
		user.visible_message("<b>[user]</b> pierces [src] with [I].", "<span class='notice'>You pierce \the [src] with [I].</span>")
		playsound(src, "can_open", 50, TRUE)
		pierced = TRUE
		return
	else if(I.force)
		user.visible_message("<b>[user]</b> crushes [src] with [I]! Party foul!", "<span class='warning'>You crush \the [src] with [I]! Party foul!</span>")
		playsound(src, "can_open", 50, TRUE)
		var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(src.loc)
		crushed_can.icon_state = icon_state
		var/atom/throw_target = get_edge_target_turf(crushed_can, pick(GLOB.alldirs))
		crushed_can.throw_at(throw_target, rand(1,3), 7)
		qdel(src)
		return

	. = ..()

/obj/item/reagent_containers/food/drinks/soda_cans/cola
	name = "Master Cola"
	desc = "Originally a commission to the Rachnid culinary guilds from Solarian historical reenactors on creating an authentic cola that, at some point, dominated the globe in popularity, this soft drink comes as close to anyone might be able to taste the sodas of yore... But it's still a pretty alright drink."
	icon_state = "cola"
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/tonic
	name = "Sixikirtchia's Tonic"
	desc = "A can of water mixed with quinine, which the label purportedly states that it has more health benefits for the Vox than fending off malaria. Most people use it for mixing drinks, Vox or otherwise."
	icon_state = "tonic"
	list_reagents = list(/datum/reagent/consumable/tonic = 50)
	foodtype = ALCOHOL

/obj/item/reagent_containers/food/drinks/soda_cans/sodawater
	name = "Stitiamix Club"
	desc = "Mineral-flavored carbonated water, infused on some part of The Shoal. Touts being made out of minerals from embedded asteroids, apparently!"
	icon_state = "sodawater"
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)

/obj/item/reagent_containers/food/drinks/soda_cans/orange_soda
	name = "Sol Sparkler: Orange Remembrance"
	desc = "A line of flavored seltzer water from the Solarian Confederation. Its infamy stems from being flavored sparingly enough to warrant it being referred to as being vague memories of the fruit in question."
	icon_state = "orange_soda"
	list_reagents = list(/datum/reagent/consumable/orangejuice = 5, /datum/reagent/consumable/sodawater = 25)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry
	name = "Sol Dry"
	desc = "A can of ginger ale, known for helping those with upset stomachs. Popularized due to a widespread belief from Solarians that drinking it will alleviate the nausea from bluespace travel."
	icon_state = "sol_dry"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/space_up
	name = "Space-Up!"
	desc = "Tastes like a hull breach in your mouth."
	icon_state = "space-up"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/lunapunch
	name = "Lunapunch"
	desc = "A soda with a distinctly herbal sweetness and a bitter aftertaste, popular across the C.L.I.P. colonies. Originally marketed as a health soft-drink for members of the CMM, the herbs used in its recipe claim to have health benefits... to dubious results."
	icon_state = "lunapunch"
	list_reagents = list(/datum/reagent/consumable/lunapunch = 30)
	foodtype = SUGAR | FRUIT | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/comet_trail
	name = "Comet Trail"
	desc = "A citrusy drink from the Kepori space installation known as The Ring. Known for its sharp flavor and refreshing carbonation -- best served cold."
	icon_state = "comet_trail"
	list_reagents = list(/datum/reagent/consumable/comet_trail = 30)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/vimukti
	name = "Vimukti"
	desc = "A liquor brewed from sweet lichen scraped off the walls of Shoal water condensers. Stamped with the thirteen-spoked wheel of enlightenment. Spiritual Vox consider it to open the mind's boundaries."
	icon_state = "thirteen_loko"
	list_reagents = list(/datum/reagent/consumable/ethanol/vimukti = 30)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/tadrixx
	name = "Tadrixx"
	desc = "A Kalixcian drink made from a plant that tastes similar to sassafrass, which is used in root beer. A stumpy drake holding a mug of it is on the front."
	icon_state = "tadrixx"
	list_reagents = list(/datum/reagent/consumable/tadrixx = 30)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/pacfuel
	name = "PAC-Fuel"
	desc = "A carbonated energy drink themed after the purple coloration, similar to plasma. It seems to have gotten a sponsorship with the the G.E.C., with a special offer for some sort of deal on... gaming gear and industrial equipment?"
	icon_state = "purple_can"
	list_reagents = list(/datum/reagent/consumable/pacfuel = 30)

/obj/item/reagent_containers/food/drinks/soda_cans/shoal_punch
	name = "Shoal Punch"
	desc = "Carbonated fruit soda, made from a mix of dozens of fruits collected and grown on The Shoal. There's an extensive list of potential allergens on the back."
	icon_state = "shoal_punch"
	list_reagents = list(/datum/reagent/consumable/shoal_punch = 30)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/crosstalk
	name = "Crosstalk"
	desc = "Crosstalk! Share the energy with everyone! The can is a little thin to be passing it around to actually share the energy drink around, though."
	icon_state = "energy_drink"
	list_reagents = list(/datum/reagent/consumable/crosstalk = 20)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/xeno_energy
	name = "Xeno-Energy"
	desc = "A sickly green energy drink that poses itself as made from the real blood of xenomorphs. Deeply controversial among the BARD ranks."
	icon_state = "xeno_energy"
	item_state = "xeno_energy"
	list_reagents = list(/datum/reagent/consumable/xeno_energy = 40, /datum/reagent/consumable/electrolytes = 10)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/soda_cans/air
	name = "Tradewind Canned"
	desc = "Intended to be filled with air from home planets for the sake of nostalgia after it's initial failure as an emergency method of 'canning air'. Tradewind Canned - a breath from home."
	icon_state = "air"
	list_reagents = list(/datum/reagent/nitrogen = 24, /datum/reagent/oxygen = 6)

/obj/item/reagent_containers/food/drinks/soda_cans/molten
	name = "Molten Bubbles"
	desc = "A spicy soft drink made from a coca-like plant from Kalixcis. Popularly served both cold -and- hot, depending on the weather."
	icon_state = "molten"
	list_reagents = list(/datum/reagent/consumable/molten = 50)

/obj/item/reagent_containers/food/drinks/soda_cans/plasma
	name = "Plasma Fizz"
	desc = "A spinoff of the popular Molten Bubbles drink from Kalixcis, made to emulate the flavor of spiced grape instead. It's... not exactly convincing or a very good mix."
	icon_state = "plasma"
	list_reagents = list(/datum/reagent/consumable/molten/plasma_fizz = 50)

/obj/item/reagent_containers/food/drinks/ration
	name = "empty ration pouch"
	desc = "If you ever wondered where air came from..."
	list_reagents = list(/datum/reagent/oxygen = 6, /datum/reagent/nitrogen = 24)
	icon = 'icons/obj/food/ration.dmi'
	icon_state = "ration_drink"
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboardbox_pickup.ogg'
	in_container = TRUE
	reagent_flags = NONE
	spillable = FALSE
	w_class = WEIGHT_CLASS_SMALL
	volume = 50

/obj/item/reagent_containers/food/drinks/ration/proc/open_ration(mob/user)
	to_chat(user, "<span class='notice'>You tear open \the [src].</span>")
	playsound(user.loc, 'sound/items/glass_cap.ogg', 50)
	reagents.flags |= OPENCONTAINER
	spillable = TRUE

/obj/item/reagent_containers/food/drinks/ration/attack_self(mob/user)
	if(!is_drainable())
		open_ration(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/reagent_containers/food/drinks/ration/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>The [src] is sealed shut!</span>")
		return 0
	return ..()

/obj/item/reagent_containers/food/drinks/ration/pan_genezan_vodka
	name = "Pan-Genezan vodka"
	desc = "Vodka made from the finest potatoes."
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 15)
