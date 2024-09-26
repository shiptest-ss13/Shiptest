/obj/structure/cabinet
	name = "\improper cabinet"
	desc = "There is a small label that reads \"For Emergency use only\". Yeah right."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "fireaxe"
	anchored = TRUE
	density = FALSE
	armor = list("melee" = 50, "bullet" = 20, "laser" = 0, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 50)
	max_integrity = 150
	integrity_failure = 0.33
	req_one_access_txt = "0"
	var/locked = TRUE
	var/open = FALSE
	var/start_empty = FALSE
	var/obj/item/stored
	var/allowed_type
	var/stored_sprite = "axe"

/obj/structure/cabinet/Initialize()
	. = ..()
	if(allowed_type && !start_empty)
		stored = new allowed_type(src)
	update_appearance()

/obj/structure/cabinet/Destroy()
	if(istype(stored))
		qdel(stored)
		stored = null
	return ..()

/obj/structure/cabinet/examine(mob/user)
	. = ..()
	if(!open)
		. += span_notice("Alt-click to [locked ? "unlock" : "lock"] [src]")
	if(stored)
		. += span_notice("[stored] is sitting inside, ripe for the taking.")

/obj/structure/cabinet/attackby(obj/item/I, mob/user, params)
	if(iscyborg(user) || I.tool_behaviour == TOOL_MULTITOOL)
		hack_lock(user)
	else if(I.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP && !broken)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=2))
				return
			to_chat(user, span_notice("You begin repairing [src]"))
			if(I.use_tool(src, user, 40, volume=50, amount=2))
				obj_integrity = max_integrity
				update_appearance()
				to_chat(user, span_notice("You repair [src]"))
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return
	else if(istype(I, /obj/item/stack/sheet/glass) && broken)
		var/obj/item/stack/sheet/glass/G = I
		if(G.get_amount() < 2)
			to_chat(user, span_warning("You need two [G.singular_name] to fix [src]!"))
			return
		to_chat(user, span_notice("You start fixing [src]..."))
		if(do_after(user, 20, target = src) && G.use(2))
			broken = 0
			obj_integrity = max_integrity
			update_appearance()
	else if(open || broken)
		if(istype(I, allowed_type) && !stored)
			var/obj/item/storee = I
			SIGNAL_HANDLER
			if(storee && HAS_TRAIT(storee, TRAIT_WIELDED))
				to_chat(user, span_warning("Unwield the [storee.name] first."))
				return
			if(!user.transferItemToLoc(I, src))
				return
			stored = storee
			to_chat(user, span_notice("You place the [storee.name] back in the [name]."))
			update_appearance()
			return
		else if(!broken)
			toggle_open()
	else
		return ..()

/obj/structure/cabinet/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(broken)
				playsound(loc, 'sound/effects/hit_on_shattered_glass.ogg', 90, TRUE)
			else
				playsound(loc, 'sound/effects/glasshit.ogg', 90, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/cabinet/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	if(open)
		return
	. = ..()
	if(.)
		update_appearance()

/obj/structure/cabinet/obj_break(damage_flag)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		update_appearance()
		broken = TRUE
		playsound(src, 'sound/effects/glassbr3.ogg', 100, TRUE)
		new /obj/item/shard(loc)
		new /obj/item/shard(loc)

/obj/structure/cabinet/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(stored && loc)
			stored.forceMove(loc)
			stored = null
		new /obj/item/stack/sheet/metal(loc, 2)
	qdel(src)

/obj/structure/cabinet/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(open || broken)
		if(stored)
			to_chat(user, span_notice("You take [stored] from [name]."))
			user.put_in_hands(stored)
			stored = null
			src.add_fingerprint(user)
			update_appearance()
			return
	if(locked)
		to_chat(user, span_warning("[name] won't budge!"))
		return
	else
		open = !open
		update_appearance()
		return

/obj/structure/cabinet/attack_paw(mob/living/user)
	return attack_hand(user)

/obj/structure/cabinet/attack_ai(mob/user)
	toggle_lock(user)
	return

/obj/structure/cabinet/attack_tk(mob/user)
	if(locked)
		to_chat(user, span_warning("[name] won't budge!"))
		return
	else
		open = !open
		update_appearance()
		return

/obj/structure/cabinet/update_overlays()
	. = ..()
	if(stored)
		. += "[stored_sprite]"
	if(open)
		. += "glass_raised"
		return
	var/hp_percent = obj_integrity/max_integrity * 100
	if(broken)
		. += "glass4"
	else
		switch(hp_percent)
			if(-INFINITY to 40)
				. += "glass3"
			if(40 to 60)
				. += "glass2"
			if(60 to 80)
				. += "glass1"
			if(80 to INFINITY)
				. += "glass"

	. += locked ? "locked" : "unlocked"

/obj/structure/cabinet/proc/toggle_lock(mob/user)
	if(!broken)
		if(allowed(user))
			if(iscarbon(user))
				add_fingerprint(user)
			locked = !locked
			user.visible_message(
				span_notice("[user] [locked ? "locks" : "unlocks"][src]."),
				span_notice("You [locked ? "lock" : "unlock"] [src]."))
			update_appearance()
		else
			to_chat(user, span_warning("Access denied!"))
	else if(broken)
		to_chat(user, span_warning("\The [src] is broken!"))

/obj/structure/cabinet/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE) || !isturf(loc) || open)
		return
	else
		toggle_lock(user)

/obj/structure/cabinet/proc/hack_lock(mob/user)
	to_chat(user, span_notice("Resetting circuitry..."))
	playsound(src, 'sound/machines/locktoggle.ogg', 50, TRUE)
	if(do_after(user, 20, target = src))
		to_chat(user, span_notice("You [locked ? "disable" : "re-enable"] the locking modules."))
		locked = !locked
		update_appearance()

/obj/structure/cabinet/verb/toggle_open()
	set name = "Open/Close"
	set category = "Object"
	set src in oview(1)

	if(locked)
		visible_message(span_warning("[name] won't budge!"))
		return
	else
		open = !open
		update_appearance()
		return
