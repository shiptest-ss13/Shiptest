/mob/living/simple_animal/hostile/retaliate/poison
	var/poison_per_bite = 0
	var/poison_type = /datum/reagent/toxin

/mob/living/simple_animal/hostile/retaliate/poison/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents && !poison_per_bite == 0)
			L.reagents.add_reagent(poison_type, poison_per_bite)
		return .

/mob/living/simple_animal/hostile/retaliate/poison/snake
	name = "snake"
	desc = "A slithery snake. These legless reptiles are the bane of mice and adventurers alike."
	icon_state = "snake"
	icon_living = "snake"
	icon_dead = "snake_dead"
	speak_emote = list("hisses")
	health = 20
	maxHealth = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	melee_damage_lower = 5
	melee_damage_upper = 6
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "shoos"
	response_disarm_simple = "shoo"
	response_harm_continuous = "steps on"
	response_harm_simple = "step on"
	faction = list(FACTION_HOSTILE)
	ventcrawler = VENTCRAWLER_ALWAYS
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_REPTILE
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	var/glasses_overlay_file = 'icons/mob/pets.dmi'
	var/obj/item/clothing/glasses/glasses = null //snek glasses

/mob/living/simple_animal/hostile/retaliate/poison/snake/Destroy()
	if(glasses)
		QDEL_NULL(glasses)
	return ..()

/mob/living/simple_animal/hostile/retaliate/poison/snake/ListTargets(atom/the_target)
	. = oview(vision_range, targets_from) //get list of things in vision range
	var/list/living_mobs = list()
	var/list/mice = list()
	for (var/HM in .)
		//Yum a tasty mouse
		if(istype(HM, /mob/living/basic/mouse))
			mice += HM
		if(isliving(HM))
			living_mobs += HM

	// if no tasty mice to chase, lets chase any living mob enemies in our vision range
	if(length(mice) == 0)
		//Filter living mobs (in range mobs) by those we consider enemies (retaliate behaviour)
		return  living_mobs & enemies
	return mice

/mob/living/simple_animal/hostile/retaliate/poison/snake/AttackingTarget()
	if(istype(target, /mob/living/basic/mouse))
		visible_message(span_notice("[name] consumes [target] in a single gulp!"), span_notice("You consume [target] in a single gulp!"))
		QDEL_NULL(target)
		adjustBruteLoss(-2)
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/poison/snake/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
	..()

/mob/living/simple_animal/hostile/retaliate/poison/snake/update_overlays()
	..()
	overlays.Cut()
	if(glasses && !stat)
		var/mutable_appearance/glasses_overlay = mutable_appearance(glasses_overlay_file, glasses.icon_state)
		add_overlay(glasses_overlay)

/mob/living/simple_animal/hostile/retaliate/poison/snake/show_inv(mob/user)
	user.set_machine(src)

	var/dat = 	"<div align='center'><b>Inventory of [name]</b></div><p>"
	dat += "<br><B>Glasses:</B> <A href='byond://?src=[REF(src)];[glasses ? "remove_inv=glasses'>[glasses]" : "add_inv=glasses'>Nothing"]</A>"

	var/datum/browser/popup = new(usr, "window=mob[REF(src)]", "<div align='center'>Inventory of [name]</div>", 325, 500)
	popup.set_content(dat)
	popup.open(0)

/mob/living/simple_animal/hostile/retaliate/poison/snake/Topic(href, href_list)
	if(!(iscarbon(usr) || iscyborg(usr)) || !usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		usr << browse(null, "window=mob[REF(src)]")
		usr.unset_machine()
		return

	//Removing from inventory
	if(href_list["remove_inv"])
		var/remove_from = href_list["remove_inv"]
		switch(remove_from)
			if("glasses")
				if(!glasses)
					to_chat(usr, span_warning("There is nothing to remove from it!"))
					return
				if(!stat)
					say("HISSSS!")
				glasses.forceMove(drop_location())
				glasses = null
				update_overlays()

	//Adding things to inventory
	else if(href_list["add_inv"])
		var/add_to = href_list["add_inv"]
		if(!usr.get_active_held_item())
			to_chat(usr, span_warning("You have nothing in your hand to put on it!"))
			return
		switch(add_to)
			if("glasses")
				if(glasses)
					to_chat(usr, span_warning("It's already wearing something!"))
					return
				else
					var/obj/item/item_to_add = usr.get_active_held_item()
					if(!item_to_add)
						return

					if(!istype(item_to_add, /obj/item/clothing/glasses))
						to_chat(usr, span_warning("This object won't fit!"))
						return

					var/obj/item/clothing/glasses/glasses_to_add = item_to_add

					if(!usr.transferItemToLoc(glasses_to_add, src))
						return
					glasses = glasses_to_add
					to_chat(usr, span_notice("You fit the glasses onto [src]."))
					update_overlays()

#define MAX_BOOKWORM_BOOKS 20

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm
	name = "Bookworm"
	icon = 'icons/mob/pets.dmi'
	icon_state = "bookworm"
	icon_living = "bookworm"
	icon_dead = "bookworm_dead"
	desc = "The Curator's beloved astigmatic corn snake. Probably best not to poke it too much..."
	speak_chance = 15 //less than poly
	speak = list("I can't find anything to read!")

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/Initialize()
	glasses = new /obj/item/clothing/glasses/regular(src)
	grant_all_languages()
	update_overlays()
	INVOKE_ASYNC(src, PROC_REF(update_phrases))
	. = ..()

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/proc/update_phrases()
	speak = get_phrases()

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/proc/get_phrases() //if someone sees this, be sure to actually literally really kill me
	var/list/phrase_buffer = list()
	create_random_books(20, src, TRUE)
	for(var/obj/item/book/B in contents)
		phrase_buffer += "[strip_booktext(B.dat, 25)]..."
		if(prob(25))
			phrase_buffer += "Have you read anything by [B.author] lately?"
		if(prob(35))
			phrase_buffer += "You should read [B.title]. It's [pick(list("hilarious", "wonderful", "atrocious", "interesting"))]."
		qdel(B)
	if(!phrase_buffer.len)
		phrase_buffer += "I can't find anything to read!"
	return phrase_buffer //and I mean really actually kill me with a gun or knife or something else that can kill people

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/handle_automated_speech(override)
	var/datum/language_holder/LH = get_language_holder()
	LH.selected_language = get_random_spoken_language()
	..()

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/examine(mob/user)
	. = ..()
	. += "[src] [glasses ? "is wearing glasses!" : "seems to be having trouble seeing..."]"

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/attack_hand(mob/living/carbon/human/M)
	..()
	if(stat != DEAD && M.a_intent == INTENT_HELP)
		handle_automated_speech(1) //assured speak/emote
	return

/mob/living/simple_animal/hostile/retaliate/poison/snake/bookworm/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/book) && user.a_intent == INTENT_HELP)
		var/obj/item/book/B = O
		if(B.dat)
			var/textdata = strip_booktext(B.dat, 25)
			if(!(textdata in speak))
				speak.Remove(pick(speak))
				speak.Add("[textdata]")
				say("[textdata]...")
				if(user in enemies)
					enemies -= user
				return
			else
				say("I've already read that one.")
				return
	if(istype(O, /obj/item/food/deadmouse))
		if(speak_chance >= 75)
			user.visible_message("[src] doesn't seem to want the [O]...")
		else
			user.visible_message("[user] feeds [src] the [O]!", "You feed [src] the [O]!")
			playsound(src.loc,'sound/items/eatfood.ogg', rand(10,50), TRUE)
			speak_chance = min(speak_chance * 2, 75)
			qdel(O)
			return
	..()
