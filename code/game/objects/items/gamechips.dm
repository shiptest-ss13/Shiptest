/// gaming/gambling chips, for if one doesn't want to use literal cash/holochips, or if collateral in a buy-in needs its own value blah blah blah.
/// lovingly copied from hydrogen merit code which itself was copied from cash code which was copied from cev eris.

/obj/item/gamechip
	name = "game chip"
	desc = "If you can see this, please make a bug report. If you're a mapper, use the bundle subtype!"
	icon = 'icons/obj/economy.dmi'
	icon_state = "gamechip0"
	w_class = WEIGHT_CLASS_TINY
	var/value = 0
	grind_results = list(/datum/reagent/silicon = 5)

/obj/item/gamechip/Initialize(mapload, amount)
	. = ..()
	if(amount)
		value = amount
	update_appearance()

/obj/item/gamechip/attackby(obj/item/I, mob/user)
	if(!istype(I, /obj/item/gamechip))
		return
	var/obj/item/gamechip/bundle/bundle
	if(istype(I, /obj/item/gamechip/bundle))
		bundle = I
	else
		var/obj/item/gamechip/cash = I
		bundle = new (loc)
		bundle.value = cash.value
		user.dropItemToGround(cash)
		qdel(cash)

	bundle.value += value
	bundle.update_appearance()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.dropItemToGround(src)
		H.dropItemToGround(bundle)
		H.put_in_hands(bundle)
	to_chat(user, span_notice("You add [value] chips worth of value to the stack.<br>It now holds [bundle.value] worth of chips."))
	qdel(src)

/obj/item/gamechip/Destroy()
	. = ..()
	value = 0 // Prevents money from be duplicated anytime.//I'll trust eris on this one//i'll trust helmcrab trusting eris on this one

/obj/item/gamechip/bundle
	icon_state = "chip15"

/obj/item/gamechip/bundle/Initialize()
	. = ..()
	update_appearance()

/obj/item/gamechip/bundle/update_appearance()
	icon_state = "nothing"
	cut_overlays()
	var/remaining_value = value
	var/iteration = 0
	var/singles_only = TRUE /// only using this for sound/description
	var/list/single_denominations = list(10000, 2500, 500, 100, 25, 5, 1)
	var/list/stack_denominations = list(50000, 40000, 30000, 20000, 7500, 5000, 2000, 1500, 1000, 400, 300, 200, 75, 50, 20, 15, 10, 4, 3, 2)
	for(var/i in stack_denominations)
		while(remaining_value >= i && iteration < 50)
			remaining_value -= i
			iteration++
			var/image/stack = image('icons/obj/economy.dmi', "chip[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			stack.transform = M
			overlays += stack
			singles_only = FALSE

	if(remaining_value)
		for(var/i in single_denominations)
			while(remaining_value >= i && iteration < 50)
				remaining_value -= i
				iteration++
				var/image/single = image('icons/obj/economy.dmi', "chip[i]")
				var/matrix/M = matrix()
				M.Translate(rand(-6, 6), rand(-4, 8))
				single.transform = M
				overlays += single

	if(singles_only)
		if(value == 1)
			name = "one game chip"
			desc = "A single gaming chip. Down on your luck, time for a comeback."
			drop_sound = 'sound/items/handling/gamechips_few_drop.ogg'
			pickup_sound =  'sound/items/handling/gamechips_few_pickup.ogg'
		else
			name = "[value] game chips"
			desc = "A handful of game chips. Feeling lucky, punk?"
			gender = PLURAL
			drop_sound = 'sound/items/handling/gamechips_few_drop.ogg'
			pickup_sound =  'sound/items/handling/gamechips_few_pickup.ogg'
	else
		if(value <= 3000)
			name = "[value] game chips"
			gender = NEUTER
			desc = "A pile of game chips. Play your cards right, and it'll grow."
			drop_sound = 'sound/items/handling/gamechips_lots_drop.ogg'
			pickup_sound =  'sound/items/handling/gamechips_lots_pickup.ogg'
		else
			name = "[value] game chips"
			gender = NEUTER
			desc = "A heaping pile of game chips. Aren't you a high roller?"
			drop_sound = 'sound/items/handling/gamechips_lots_drop.ogg'
			pickup_sound =  'sound/items/handling/gamechips_lots_pickup.ogg'
	return ..()

/obj/item/gamechip/bundle/attack_self(mob/user)
	if(!Adjacent(user))
		to_chat(user, span_warning("You need to be in arm's reach for that!"))
		return

	var/cashamount = input(user, "How many game chips do you want to take? (0 to [value])", "Take Game Chips", 20) as num
	cashamount = round(clamp(cashamount, 0, value))
	if(!cashamount)
		return

	value -= cashamount
	if(!value)
		user.dropItemToGround(src)
		qdel(src)

	var/obj/item/gamechip/bundle/bundle = new (user.loc)
	bundle.value = cashamount
	bundle.update_appearance()
	user.put_in_hands(bundle)
	update_appearance()

/obj/item/gamechip/bundle/AltClick(mob/living/user)
	if(!Adjacent(user))
		to_chat(user, span_warning("You need to be in arm's reach for that!"))
		return

	var/cashamount = input(user, "How many game chips do you want to take? (0 to [value])", "Take Game Chips", 20) as num
	cashamount = round(clamp(cashamount, 0, value))
	if(!cashamount)
		return

	value -= cashamount
	if(!value)
		user.dropItemToGround(src)
		qdel(src)

	var/obj/item/gamechip/bundle/bundle = new (user.loc)
	bundle.value = cashamount
	bundle.update_appearance()
	user.put_in_hands(bundle)
	update_appearance()

/obj/item/gamechip/bundle/attack_hand(mob/user)
	if(user.get_inactive_held_item() != src)
		return ..()
	if(value == 0)//may prevent any edge case duping
		qdel(src)
		return
	value--
	user.put_in_hands(new /obj/item/gamechip/bundle(loc, 1))
	update_appearance()

//bundles for mapping + testing

/obj/item/gamechip/bundle/g1
	value = 1
	icon_state = "chip1"

/obj/item/gamechip/bundle/g5
	value = 5
	icon_state = "chip5"

/obj/item/gamechip/bundle/g25
	value = 25
	icon_state = "chip25"

/obj/item/gamechip/bundle/g100
	value = 100
	icon_state = "chip100"

/obj/item/gamechip/bundle/g500
	value = 500
	icon_state = "chip500"

/obj/item/gamechip/bundle/g2500
	value = 2500
	icon_state = "chip2500"

/obj/item/gamechip/bundle/g10000
	value = 10000
	icon_state = "chip10000"

/obj/item/gamechip/bundle/g50000
	value = 50000
	icon_state = "chip50000"
