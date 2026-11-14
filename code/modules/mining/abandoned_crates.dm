//Originally coded by ISaidNo, later modified by Kelenius. Ported from Baystation12.

/obj/structure/closet/crate/secure/loot
	name = "tamper-proof crate"
	desc = "An abandoned crate locked with a Deca-code lock. Next to the lock is a warning: Too many failed attempts will cause the anti-tamper explosive to detonate."
	icon_state = "securecrate"
	integrity_failure = 0 //no breaking open the crate
	var/code = null
	var/lastattempt = null
	var/attempts = 10
	var/codelen = 4
	var/qdel_on_open = FALSE
	var/spawned_loot = FALSE
	tamperproof = 90

/obj/structure/closet/crate/secure/loot/Initialize()
	. = ..()
	var/list/digits = list("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	code = ""
	for(var/i = 0, i < codelen, i++)
		var/dig = pick(digits)
		code += dig
		digits -= dig  //there are never matching digits in the answer

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/closet/crate/secure/loot/attack_hand(mob/user)
	if(locked)
		to_chat(user, span_notice("The crate is locked with a Deca-code lock."))
		var/input = input(usr, "Enter [codelen] digits. All digits must be unique.", "Deca-Code Lock", "") as text|null
		if(user.canUseTopic(src, BE_CLOSE))
			var/list/sanitised = list()
			var/sanitycheck = TRUE
			var/char = ""
			var/length_input = length(input)
			for(var/i = 1, i <= length_input, i += length(char)) //put the guess into a list
				char = input[i]
				sanitised += text2num(char)
			for(var/i = 1, i <= length(sanitised) - 1, i++) //compare each digit in the guess to all those following it
				for(var/j = i + 1, j <= length(sanitised), j++)
					if(sanitised[i] == sanitised[j])
						sanitycheck = FALSE //if a digit is repeated, reject the input
			if(input == code)
				to_chat(user, span_notice("The crate unlocks!"))
				locked = FALSE
				cut_overlays()
				add_overlay("securecrateg")
				tamperproof = 0 // set explosion chance to zero, so we dont accidently hit it with a multitool and instantly die
				if(!spawned_loot)
					spawn_loot()
			else if(!input || !sanitycheck || length(sanitised) != codelen)
				to_chat(user, span_notice("You leave the crate alone."))
			else
				to_chat(user, span_warning("A red light flashes."))
				lastattempt = input
				attempts--
				if(attempts == 0)
					boom(user)
	else
		return ..()

/obj/structure/closet/crate/secure/loot/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	return attack_hand(user) //this helps you not blow up so easily by overriding unlocking which results in an immediate boom.

/obj/structure/closet/crate/secure/loot/attackby(obj/item/W, mob/user)
	if(locked)
		if(W.tool_behaviour == TOOL_MULTITOOL)
			to_chat(user, span_notice("DECA-CODE LOCK REPORT:"))
			if(attempts == 1)
				to_chat(user, span_warning("* Anti-Tamper Bomb will activate on next failed access attempt."))
			else
				to_chat(user, span_notice("* Anti-Tamper Bomb will activate after [attempts] failed access attempts."))
			if(lastattempt != null)
				var/bulls = 0 //right position, right number
				var/cows = 0 //wrong position but in the puzzle

				var/lastattempt_char = ""
				var/length_lastattempt = length(lastattempt)
				var/lastattempt_it = 1

				var/code_char = ""
				var/length_code = length(code)
				var/code_it = 1

				while(lastattempt_it <= length_lastattempt && code_it <= length_code) // Go through list and count matches
					lastattempt_char = lastattempt[lastattempt_it]
					code_char = code[code_it]
					if(lastattempt_char == code_char)
						++bulls
					else if(findtext(code, lastattempt_char))
						++cows

					lastattempt_it += length(lastattempt_char)
					code_it += length(code_char)

				to_chat(user, span_notice("Last code attempt, [lastattempt], had [bulls] correct digits at correct positions and [cows] correct digits at incorrect positions."))
			return
	return ..()

/obj/structure/closet/secure/loot/dive_into(mob/living/user)
	if(!locked)
		return ..()
	to_chat(user, span_notice("That seems like a stupid idea."))
	return FALSE

/obj/structure/closet/crate/secure/loot/emag_act(mob/user)
	if(locked)
		boom(user)

/obj/structure/closet/crate/secure/loot/togglelock(mob/user)
	if(locked)
		boom(user)
	else
		if (qdel_on_open)
			qdel(src)
		..()

/obj/structure/closet/crate/secure/loot/deconstruct(disassembled = TRUE)
	if(locked)
		boom()
	else
		if (qdel_on_open)
			qdel(src)
		..()

// No busting open (used to disallow angle grinder cheesing
/obj/structure/closet/crate/secure/loot/bust_open()
	boom()

/obj/structure/closet/crate/secure/loot/proc/spawn_loot()
	var/rarity = rand(1,100)
	switch(rarity)
		if(1 to 80)
			spawn_common()
		if(81 to 95)
			spawn_uncommon()
		if(96 to 100)
			spawn_rare()
	spawned_loot = TRUE

// abandoned crate common pool
// junk, misc low-grade contraband
/obj/structure/closet/crate/secure/loot/proc/spawn_common()
	var/roll = rand(1, 150)
	switch(roll)
		if(1 to 10)
			// plushies
			var/count = rand(5, 10)
			for(var/i in 1 to count)
				var/newitem = pick(subtypesof(/obj/item/toy/plush))
				new newitem(src)
		if(11 to 20)
			// e11s
			var/count = rand(4, 8)
			for(var/i in 1 to count)
				new /obj/item/gun/energy/e_gun/e11(src)
		if(21 to 30)
			// arcade prizes
			var/count = rand(10, 20)
			for(var/i in 1 to count)
				var/newitem = pick(subtypesof(/obj/item/toy/prize))
				new newitem(src)
		if(31 to 40)
			// broken chameleon kit
			new /obj/item/storage/box/syndie_kit/chameleon/broken
		if(41 to 50)
			// beagle mugs
			for(var/i in 1 to 12)
				new /obj/item/reagent_containers/food/drinks/beaglemug(src)
		if(51 to 60)
			// zippies
			for(var/i in 1 to 4)
				new /obj/item/storage/box/disposable_gun_gacha(src)
		if(61 to 70)
			// hermit stimpacks
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/survival(src)
		if(71 to 80)
			// lottery tickets
			var/count = rand(4, 8)
			for(var/i in 1 to count)
				var/ticket = /obj/item/scratch_ticket/small
				if(prob(50))
					ticket = /obj/item/scratch_ticket/large
				var/obj/item/scratch_ticket/real_ticket = new ticket(src)
				if(prob(1))
					real_ticket.fake = TRUE // xd
		if(81 to 90)
			// shoalwiches
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				var/newitem = pick(subtypesof(/obj/item/storage/box/shoalpockets))
				new newitem(src)
		if(91 to 100)
			// frontiersman uniform and armor
			new /obj/item/clothing/under/frontiersmen(src)
			new /obj/item/clothing/head/beret/sec/frontier(src)
			new /obj/item/clothing/suit/armor/vest/marine/frontier(src)
			new /obj/item/clothing/head/helmet/frontier(src)
			new /obj/item/clothing/shoes/jackboots(src)
		if(101 to 110)
			// medical junk
			new /obj/item/defibrillator/loaded(src)
			new /obj/item/roller(src)
			new /obj/item/storage/firstaid(src)
		if(111 to 120)
			// meat and cleaver
			var/count = rand(5, 10)
			for(var/i in 1 to count)
				new /obj/item/food/meat/slab/meatproduct(src)
			new /obj/item/melee/knife/butcher(src)
		if(121 to 130)
			// sports game
			new /obj/item/toy/beach_ball/holoball(src)
			for(var/i in 1 to 2)
				new /obj/item/melee/baseball_bat(src)
		if(131 to 140)
			// practice laser guns
			for(var/i in 1 to 4)
				new /obj/item/gun/energy/laser/practice(src)
		if(141 to 150)
			// starlight patch bottle
			var/count = rand(1, 3)
			for(var/i in 1 to count)
				new /obj/item/storage/pill_bottle/starlight(src)

// abandoned crate uncommon pool
// mostly drugs but has some other stuff too
/obj/structure/closet/crate/secure/loot/proc/spawn_uncommon()
	var/roll = rand(1, 100)
	switch(roll)
		if(1 to 10)
			// clip energy bars. yum yum
			for(var/i in 1 to 15)
				new /obj/item/food/energybar(src)
		if(11 to 20)
			// fake facehugger
			new /mob/living/simple_animal/hostile/facehugger/toy(src)
		if(21 to 30)
			// hellstone
			new /obj/item/stack/sheet/mineral/hidden/hellstone(src, 10)
		if(31 to 40)
			// shoalmix pens
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/combat_drug(src)
		if(41 to 50)
			// rabbit pens
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/rabbit(src)
		if(51 to 60)
			// mammoth pens
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/mammoth(src)
		if(61 to 70)
			// fino pills
			var/count = rand(1, 3)
			for(var/i in 1 to count)
				new /obj/item/storage/pill_bottle/finobranc(src)
		if(71 to 80)
			// trickwine assortment
			var/count = rand(3, 5)
			for(var/i in 1 to count)
				var/newitem = pick(subtypesof(/obj/item/reagent_containers/food/drinks/breakawayflask/vintage))
				new newitem(src)
		if(81 to 90)
			// bullshark hardsuit
			new /obj/item/clothing/suit/space/hardsuit/security/independent/heavy
		if(91 to 100)
			// floorpill injectors
			var/count = rand(5, 10)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/gambling(src)

// abandoned crate rare pool
// either awesome or evil
/obj/structure/closet/crate/secure/loot/proc/spawn_rare()
	var/roll = rand(1, 110)
	switch(roll)
		if(1 to 10)
			// hoverboard
			new /obj/item/skateboard/hoverboard(src)
		if(11 to 20)
			// twenty pounds of ice for your deep fryer
			new /obj/item/twenty_pounds_of_ice(src)
		if(21 to 30)
			// secret of the mimic
			new /mob/living/simple_animal/hostile/mimic/crate(src)
			qdel_on_open = TRUE
		if(31 to 40)
			// cockroach swarm
			for(var/i in 1 to 30)
				new /mob/living/basic/cockroach(src)
		if(41 to 50)
			// IOU paper
			new /obj/item/paper/crumpled/fluff/abandoned_crate(src)
		if(51 to 60)
			// drop and run pellet
			new /obj/item/nuke_core/waste(src)
		if(61 to 70)
			// e40
			new /obj/item/gun/ballistic/automatic/assault/e40(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/e40(loc)
		if(71 to 80)
			// swiss cheese
			new /obj/item/gun/ballistic/automatic/assault/swiss_cheese(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/swiss(loc)
		if(81 to 90)
			// live grenade
			var/obj/item/grenade/frag/trap = new /obj/item/grenade/frag(src)
			trap.name = "GOTCHA!"
			trap.preprime()
		if(91 to 100)
			// corpse stuffed in box
			new /obj/effect/mob_spawn/human/corpse/damaged/legioninfested(src)
		if(101 to 110)
			// chrono pens
			var/count = rand(2, 4)
			for(var/i in 1 to count)
				new /obj/item/reagent_containers/hypospray/medipen/chrono(src)
