/obj/item/melee/weebstick
	name = "Weeb Stick"
	desc = "Glorious nippon steel, folded 1000 times."
	icon = 'whitesands/icons/obj/items_and_weapons.dmi'
	icon_state = "weeb_blade"
	item_state = "weeb_blade"
	lefthand_file = 'whitesands/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_SHARP_ACCURATE
	force = 25
	throw_speed = 4
	throw_range = 5
	throwforce = 12
	block_chance = 40
	armour_penetration = 50
	hitsound = 'whitesands/sound/weapons/anime_slash.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "diced", "cut")

/obj/item/melee/weebstick/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 90, 5) //Not made for scalping victims, but will work nonetheless

/obj/item/melee/weebstick/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = block_chance / 2 //Pretty good...
	return ..()

/obj/item/melee/weebstick/on_exit_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/weebstick/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/weebstick/suicide_act(mob/user)
	if(prob(50))
		user.visible_message("<span class='suicide'>[user] carves deep into [user.p_their()] torso! It looks like [user.p_theyre()] trying to commit seppuku...</span>")
	else
		user.visible_message("<span class='suicide'>[user] carves a grid into [user.p_their()] chest! It looks like [user.p_theyre()] trying to commit sudoku...</span>")
	return (BRUTELOSS)

/obj/item/storage/belt/weebstick
	name = "nanoforged blade sheath"
	desc = "It yearns to bath in the blood of your enemies... but you hold it back!"
	icon = 'whitesands/icons/obj/items_and_weapons.dmi'
	icon_state = "weeb_sheath"
	item_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY
	force = 3
	var/primed = FALSE //Prerequisite to anime bullshit
	// ##The anime bullshit## - Mostly stolen from action/innate/dash
	var/dash_sound = 'whitesands/sound/weapons/unsheathed_blade.ogg'
	var/beam_effect = "blood_beam"
	var/phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	var/phaseout = /obj/effect/temp_visual/dir_setting/cult/phase

/obj/item/storage/belt/weebstick/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/weebstick
		))

/obj/item/storage/belt/weebstick/examine(mob/user)
	. = ..()
	if(length(contents))
		. += "<span class='notice'>Use [src] in-hand to prime for an opening strike."
		. += "<span class='info'>Alt-click it to quickly draw the blade.</span>"

/obj/item/storage/belt/weebstick/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)) || primed)
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		playsound(user, dash_sound, 25, TRUE)
		user.visible_message("<span class='notice'>[user] swiftly draws \the [I].</span>", "<span class='notice'>You draw \the [I].</span>")
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/weebstick/attack_self(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		if(primed)
			CP.locked = FALSE
			playsound(user, 'sound/items/sheath.ogg', 25, TRUE)
			to_chat(user, "<span class='notice'>You return your stance.</span>")
			primed = FALSE
			update_icon()
		else
			CP.locked = TRUE //Prevents normal removal of the blade while primed
			playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
			user.visible_message("<span class='warning'>[user] grips the blade within [src] and primes to attack.</span>", "<span class='warning'>You take an opening stance...</span>", "<span class='warning'>You hear a weapon being drawn...</span>")
			primed = TRUE
			update_icon()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/weebstick/afterattack(atom/A, mob/living/user, proximity_flag, params)
	. = ..()
	if(primed && length(contents))
		var/obj/item/I = contents[1]
		if(!user.put_in_inactive_hand(I))
			to_chat(user, "<span class='warning'>You need a free hand!</span>")
			return
		if(!(A in view(user.client.view, user)))
			return
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		CP.locked = FALSE
		primed = FALSE
		update_icon()
		primed_attack(A, user)
		if(CanReach(A, I))
			I.melee_attack_chain(user, A, params)
		user.swap_hand()

/obj/item/storage/belt/weebstick/proc/primed_attack(atom/target, mob/living/user)
	var/turf/end = get_turf(user)
	var/turf/start = get_turf(user)
	var/obj/spot1 = new phaseout(start, user.dir)
	var/halt = FALSE
	// Stolen dash code
	for(var/T in getline(start, get_turf(target)))
		var/turf/tile = T
		for(var/mob/living/victim in tile)
			if(victim != user)
				playsound(victim, 'whitesands/sound/weapons/anime_slash.ogg', 10, TRUE)
				victim.take_bodypart_damage(15)
		// Unlike actual ninjas, we stop noclip-dashing here.
		if(isclosedturf(T))
			halt = TRUE
		for(var/obj/O in tile)
			// We ignore mobs as we are cutting through them
			if(!O.CanPass(user, tile))
				halt = TRUE
		if(halt)
			break
		else
			end = T
	user.forceMove(end) // YEET
	playsound(start, dash_sound, 35, TRUE)
	var/obj/spot2 = new phasein(end, user.dir)
	spot1.Beam(spot2, beam_effect, time=20)
	user.visible_message("<span class='warning'>In a flash of red, [user] draws [user.p_their()] blade!</span>", "<span class='notice'>You dash forward while drawing your weapon!</span>", "<span class='warning'>You hear a blade slice through the air at impossible speeds!</span>")

/obj/item/storage/belt/weebstick/update_icon_state()
	icon_state = "weeb_sheath"
	item_state = "sheath"
	if(contents.len)
		if(primed)
			icon_state += "-primed"
		else
			icon_state += "-blade"
		item_state += "-sabre"

/obj/item/storage/belt/weebstick/PopulateContents()
	//Time to generate names now that we have the sword
	var/n_title = pick(GLOB.ninja_titles)
	var/n_name = pick(GLOB.ninja_names)
	var/obj/item/melee/weebstick/sword = new /obj/item/melee/weebstick(src)
	sword.name = "[n_title] blade of clan [n_name]"
	name = "[n_title] scabbard of clan [n_name]"
	update_icon()
