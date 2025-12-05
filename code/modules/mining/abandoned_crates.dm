//Originally coded by ISaidNo, later modified by Kelenius. Ported from Baystation12.

/obj/structure/closet/crate/secure/loot
	name = "abandoned crate"
	desc = "What could be inside?"
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
	var/loot = rand(1,100) //100 different crates with varying chances of spawning
	switch(loot)
		if(1 to 5) //5% chance
			new /obj/item/reagent_containers/food/drinks/bottle/rum(src)
			new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
			new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
			new /obj/item/lighter(src)
			new /obj/item/reagent_containers/food/drinks/bottle/absinthe/premium(src)
			new /obj/item/storage/fancy/cigarettes/cigpack_cannabis(src)
		if(6 to 10)
			new /obj/item/gun/ballistic/automatic/pistol/himehabu(src)
			new /obj/item/ammo_box/magazine/m22lr_himehabu(src)
			new /obj/item/ammo_box/magazine/m22lr_himehabu(src)
		if(11 to 15)
			for(var/i in 1 to 5)
				var/newitem = pick(subtypesof(/obj/item/toy/plush))
				new newitem(src)
		if(16 to 20)
			new /obj/item/stack/ore/diamond(src, 10)
		if(21 to 25)
			for(var/i in 1 to 5)
				new /obj/item/poster/random_contraband(src)
		if(26 to 30)
			new /obj/item/reagent_containers/chem_pack/dimorlin(src)
		if(31 to 35)
			for(var/i in 1 to 5)
				new /obj/item/gun/energy/e_gun/e11(src)
		if(36 to 40)
			for(var/i in 1 to 5)
				var/newitem = pick(subtypesof(/obj/item/pen))
				new newitem(src)
		if(41 to 45)
			var/newitem = pick(subtypesof(/obj/item/storage/firstaid))
			new newitem(src)
		if(46 to 50)
			new /obj/item/storage/box/syndie_kit/chameleon/broken
		if(51 to 52) // 2% chance
			new /obj/item/melee/classic_baton(src)
		if(53 to 54)
			new /obj/item/storage/box/maid(src)
		if(55 to 56)
			var/newitem = pick(subtypesof(/obj/item/toy/prize))
			new newitem(src)
		if(57 to 58)
			new /obj/item/storage/pill_bottle/stardrop(src)
		if(59 to 60)
			new /obj/item/borg/upgrade/modkit/aoe/mobs(src)
			new /obj/item/clothing/suit/space(src)
			new /obj/item/clothing/head/helmet/space(src)
		if(61 to 62)
			for(var/i in 1 to 3)
				var/newitem = pick(subtypesof(/obj/item/reagent_containers/food/drinks/breakawayflask/vintage))
				new newitem(src)
		if(63 to 64)
			new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/combat_drug(src)
			new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/stasis(src)
		if(65 to 66)
			new /obj/item/tank/jetpack/oxygen/harness(src)
		if(67 to 68)
			for(var/i in 1 to 3)
				new /obj/item/reagent_containers/hypospray/medipen/rabbit(src)
		if(69 to 70)
			new /obj/item/stack/ore/bluespace_crystal(src, 5)
		if(71 to 72)
			new /mob/living/simple_animal/hostile/asteroid/gutlunch(src)
		if(73 to 74)
			new /mob/living/simple_animal/bot/medbot/rockplanet(src)
		if(75 to 76)
			for(var/i in 1 to 3)
				new /obj/item/reagent_containers/hypospray/medipen/mammoth(src)
		if(77 to 78)
			new /obj/item/storage/pill_bottle/finobranc(src)
		if(79 to 80)
			new /obj/item/stack/sheet/mineral/hidden/hellstone(src, 10)
		if(81 to 82)
			for(var/i in 1 to 3)
				new /obj/item/reagent_containers/hypospray/medipen/combat_drug(src)
		if(83 to 84)
			new /mob/living/simple_animal/hostile/facehugger/toy(src)
		if(85 to 86)
			new /obj/item/defibrillator/compact(src)
		if(87) //1% chance
			new /obj/item/reagent_containers/food/drinks/beaglemug(src)
		if(88)
			new /mob/living/simple_animal/hostile/asteroid/goliath/beast(src)
		if(89)
			new /obj/item/paper/crumpled/fluff/abandoned_crate(src)
		if(90)
			new /obj/item/storage/pill_bottle/starlight(src)
		if(91)
			for(var/i in 1 to 30)
				new /mob/living/basic/cockroach(src)
		if(92)
			new /obj/item/storage/firstaid/advanced(src)
		if(93)
			//new /obj/item/attachment/gun/energy/e50(src)
		if(94)
			new /mob/living/simple_animal/hostile/mimic/crate(src)
			qdel_on_open = TRUE
		if(95)
			for(var/i in 1 to 15)
				new /obj/item/food/energybar(src)
		if(96)
			for(var/i in 1 to 3)
				new /obj/item/mine/pressure/sound(src)
		if(97)
			for(var/i in 1 to 4)
				new /obj/item/clothing/mask/balaclava(src)
			new /obj/item/gun/ballistic/shotgun/toy(src)
			new /obj/item/gun/ballistic/automatic/toy/pistol(src)
			new /obj/item/gun/ballistic/automatic/toy(src)
			new /obj/item/gun/ballistic/automatic/toy(src)
			new /obj/item/storage/box/ammo/foam_darts(src)
		if(98)
			for(var/i in 1 to 3)
				new /mob/living/simple_animal/hostile/poison/bees/toxin(src)
		if(99)
			new /obj/item/twenty_pounds_of_ice(src)
		if(100)
			new /obj/item/skateboard/hoverboard(src)
	spawned_loot = TRUE
