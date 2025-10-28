/obj/structure/toilet
	name = "toilet"
	desc = "The HT-451, a torque rotation-based, waste disposal unit for small matter. This one seems remarkably clean."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "toilet00"
	density = FALSE
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 0
	var/open = FALSE			//if the lid is up
	var/cistern = 0			//if the cistern bit is open
	var/w_items = 0			//the combined w_class of all the items in the cistern
	var/mob/living/swirlie = null	//the mob being given a swirlie
	var/buildstacktype = /obj/item/stack/sheet/metal //they're metal now, shut up
	var/buildstackamount = 1

/obj/structure/toilet/Initialize()
	. = ..()
	open = round(rand(0, 1))
	update_appearance()


/obj/structure/toilet/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(swirlie)
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "swing_hit", 25, TRUE)
		swirlie.visible_message(span_danger("[user] slams the toilet seat onto [swirlie]'s head!"), span_userdanger("[user] slams the toilet seat onto your head!"), span_hear("You hear reverberating porcelain."))
		swirlie.adjustBruteLoss(5)

	else if(user.pulling && user.a_intent == INTENT_GRAB && isliving(user.pulling))
		user.changeNext_move(CLICK_CD_MELEE)
		var/mob/living/GM = user.pulling
		if(user.grab_state >= GRAB_AGGRESSIVE)
			if(GM.loc != get_turf(src))
				to_chat(user, span_warning("[GM] needs to be on [src]!"))
				return
			if(!swirlie)
				if(open)
					GM.visible_message(span_danger("[user] starts to give [GM] a swirlie!"), span_userdanger("[user] starts to give you a swirlie..."))
					swirlie = GM
					var/was_alive = (swirlie.stat != DEAD)
					if(do_after(user, 30, target = src, timed_action_flags = IGNORE_HELD_ITEM))
						GM.visible_message(span_danger("[user] gives [GM] a swirlie!"), span_userdanger("[user] gives you a swirlie!"), span_hear("You hear a toilet flushing."))
						if(iscarbon(GM))
							var/mob/living/carbon/C = GM
							if(!C.internal)
								C.adjustOxyLoss(5)
						else
							GM.adjustOxyLoss(5)
					if(was_alive && swirlie.stat == DEAD && swirlie.client)
						swirlie.client.give_award(/datum/award/achievement/misc/swirlie, swirlie) // just like space high school all over again!
					swirlie = null
				else
					playsound(src.loc, 'sound/effects/bang.ogg', 25, TRUE)
					GM.visible_message(span_danger("[user] slams [GM.name] into [src]!"), span_userdanger("[user] slams you into [src]!"))
					GM.adjustBruteLoss(5)
		else
			to_chat(user, span_warning("You need a tighter grip!"))

	else if(cistern && !open && user.CanReach(src))
		if(!contents.len)
			to_chat(user, span_notice("The cistern is empty."))
		else
			var/obj/item/I = pick(contents)
			if(ishuman(user))
				user.put_in_hands(I)
			else
				I.forceMove(drop_location())
			to_chat(user, span_notice("You find [I] in the cistern."))
			w_items -= I.w_class
	else
		open = !open
		update_appearance()


/obj/structure/toilet/update_icon_state()
	icon_state = "toilet[open][cistern]"
	return ..()

/obj/structure/toilet/deconstruct()
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(loc, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
	..()

/obj/structure/toilet/attackby(obj/item/I, mob/living/user, params)
	add_fingerprint(user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		to_chat(user, span_notice("You start to [cistern ? "replace the lid on the cistern" : "lift the lid off the cistern"]..."))
		playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
		if(I.use_tool(src, user, 30))
			user.visible_message(span_notice("[user] [cistern ? "replaces the lid on the cistern" : "lifts the lid off the cistern"]!"), span_notice("You [cistern ? "replace the lid on the cistern" : "lift the lid off the cistern"]!"), span_hear("You hear grinding porcelain."))
			cistern = !cistern
			update_appearance()
	else if(I.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		I.play_tool_sound(src)
		deconstruct()
	else if(cistern)
		if(user.a_intent != INTENT_HARM)
			if(I.w_class > WEIGHT_CLASS_NORMAL)
				to_chat(user, span_warning("[I] does not fit!"))
				return
			if(w_items + I.w_class > WEIGHT_CLASS_HUGE)
				to_chat(user, span_warning("The cistern is full!"))
				return
			if(!user.transferItemToLoc(I, src))
				to_chat(user, span_warning("\The [I] is stuck to your hand, you cannot put it in the cistern!"))
				return
			w_items += I.w_class
			to_chat(user, span_notice("You carefully place [I] into the cistern."))

	else if(istype(I, /obj/item/reagent_containers))
		if (!open)
			return
		if(istype(I, /obj/item/food/monkeycube))
			var/obj/item/food/monkeycube/cube = I
			cube.Expand()
			return
		var/obj/item/reagent_containers/RG = I
		RG.reagents.add_reagent(/datum/reagent/water, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
		to_chat(user, span_notice("You fill [RG] from [src]. Gross."))
	else
		return ..()

/obj/structure/toilet/proc/handle_layer()
	if(has_buckled_mobs() && dir == NORTH)
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

/obj/structure/toilet/post_buckle_mob(mob/living/M)
	. = ..()
	handle_layer()

/obj/structure/toilet/post_unbuckle_mob()
	. = ..()
	handle_layer()

/obj/structure/toilet/secret
	var/obj/item/secret
	var/secret_type = null

/obj/structure/toilet/secret/Initialize(mapload)
	. = ..()
	if (secret_type)
		secret = new secret_type(src)
		secret.desc += " It's a secret!"
		w_items += secret.w_class
		contents += secret

/obj/structure/toilet/greyscale
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	buildstacktype = null

/obj/structure/urinal
	name = "urinal"
	desc = "The HU-452, an experimental urinal. Comes complete with experimental urinal cake."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	density = FALSE
	anchored = TRUE
	var/exposed = 0 // can you currently put an item inside
	var/obj/item/hiddenitem = null // what's in the urinal

/obj/structure/urinal/Initialize()
	. = ..()
	hiddenitem = new /obj/item/food/urinalcake

/obj/structure/urinal/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(user.pulling && user.a_intent == INTENT_GRAB && isliving(user.pulling))
		var/mob/living/GM = user.pulling
		if(user.grab_state >= GRAB_AGGRESSIVE)
			if(GM.loc != get_turf(src))
				to_chat(user, span_notice("[GM.name] needs to be on [src]."))
				return
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message(span_danger("[user] slams [GM] into [src]!"), span_danger("You slam [GM] into [src]!"))
			GM.adjustBruteLoss(8)
		else
			to_chat(user, span_warning("You need a tighter grip!"))

	else if(exposed)
		if(!hiddenitem)
			to_chat(user, span_warning("There is nothing in the drain holder!"))
		else
			if(ishuman(user))
				user.put_in_hands(hiddenitem)
			else
				hiddenitem.forceMove(get_turf(src))
			to_chat(user, span_notice("You fish [hiddenitem] out of the drain enclosure."))
			hiddenitem = null
	else
		..()

/obj/structure/urinal/attackby(obj/item/I, mob/living/user, params)
	if(exposed)
		if (hiddenitem)
			to_chat(user, span_warning("There is already something in the drain enclosure!"))
			return
		if(I.w_class > 1)
			to_chat(user, span_warning("[I] is too large for the drain enclosure."))
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("\[I] is stuck to your hand, you cannot put it in the drain enclosure!"))
			return
		hiddenitem = I
		to_chat(user, span_notice("You place [I] into the drain enclosure."))
	else
		return ..()

/obj/structure/urinal/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	to_chat(user, span_notice("You start to [exposed ? "screw the cap back into place" : "unscrew the cap to the drain protector"]..."))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(I.use_tool(src, user, 20))
		user.visible_message(span_notice("[user] [exposed ? "screws the cap back into place" : "unscrew the cap to the drain protector"]!"),
			span_notice("You [exposed ? "screw the cap back into place" : "unscrew the cap on the drain"]!"),
			span_hear("You hear metal and squishing noises."))
		exposed = !exposed
	return TRUE

/obj/item/food/urinalcake
	name = "urinal cake"
	desc = "The noble urinal cake, protecting the people's pipes from the people's pee. Edibility is suggested to be low."
	icon = 'icons/obj/items.dmi'
	icon_state = "urinalcake"
	w_class = WEIGHT_CLASS_SMALL
	food_reagents = list(
		/datum/reagent/chlorine = 3,
		/datum/reagent/ammonia = 1
	)
	foodtypes = TOXIC | GROSS

/obj/item/food/urinalcake/attack_self(mob/living/user)
	user.visible_message(span_notice("[user] squishes [src]!"), span_notice("You squish [src]."), "<i>You hear a squish.</i>")
	icon_state = "urinalcake_squish"
	addtimer(VARSET_CALLBACK(src, icon_state, "urinalcake"), 8)

/obj/item/bikehorn/rubberducky/plasticducky
	name = "plastic ducky"
	desc = "It's a cheap plastic knockoff of a loveable bathtime toy."
	custom_materials = list(/datum/material/plastic = 1000)

/obj/item/bikehorn/rubberducky
	name = "rubber ducky"
	desc = "Rubber ducky you're so fine, you make bathtime lots of fuuun. Rubber ducky I'm awfully fooooond of yooooouuuu~"	//thanks doohl
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky"
	item_state = "rubberducky"

/obj/structure/sink
	name = "sink"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink"
	desc = "A sink used for washing one's hands and face."
	anchored = TRUE
	var/busy = FALSE 	//Something's being washed at the moment
	var/dispensedreagent = /datum/reagent/water // for whenever plumbing happens
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 1

/obj/structure/sink/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!user || !istype(user))
		return
	if(!iscarbon(user))
		return
	if(!Adjacent(user))
		return

	if(busy)
		to_chat(user, span_warning("Someone's already washing here!"))
		return
	var/selected_area = parse_zone(user.zone_selected)
	var/washing_face = 0
	if(selected_area in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES))
		washing_face = 1
	user.visible_message(span_notice("[user] starts washing [user.p_their()] [washing_face ? "face" : "hands"]..."), \
						span_notice("You start washing your [washing_face ? "face" : "hands"]..."))
	busy = TRUE

	if(!do_after(user, 40, target = src))
		busy = FALSE
		return

	busy = FALSE

	if(washing_face)
		SEND_SIGNAL(user, COMSIG_COMPONENT_CLEAN_FACE_ACT, CLEAN_WASH)
		user.drowsyness = max(user.drowsyness - rand(2,3), 0) //Washing your face wakes you up if you're falling asleep
	else if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!human_user.wash_hands(CLEAN_WASH))
			to_chat(user, span_warning("Your hands are covered by something!"))
			return
	else
		user.wash(CLEAN_WASH)

	user.visible_message(span_notice("[user] washes [user.p_their()] [washing_face ? "face" : "hands"] using [src]."), \
						span_notice("You wash your [washing_face ? "face" : "hands"] using [src]."))

/obj/structure/sink/attackby(obj/item/O, mob/living/user, params)
	if(busy)
		to_chat(user, span_warning("Someone's already washing here!"))
		return

	if(istype(O, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, span_notice("You fill [RG] from [src]."))
				return TRUE
			to_chat(user, span_notice("\The [RG] is full."))
			return FALSE

	if(istype(O, /obj/item/melee/baton))
		var/obj/item/melee/baton/B = O
		if(B.cell && B.cell.charge && B.turned_on)
			flick("baton_active", src)
			user.Paralyze(B.stun_time)
			user.stuttering = B.stun_time/20
			B.deductcharge(B.cell_hit_cost)
			user.visible_message(span_warning("[user] shocks [user.p_them()]self while attempting to wash the active [B.name]!"), \
								span_userdanger("You unwisely attempt to wash [B] while it's still on."))
			playsound(src, B.stun_sound, 50, TRUE)
			return

	if(istype(O, /obj/item/mop))
		O.reagents.add_reagent(dispensedreagent, 5)
		to_chat(user, span_notice("You wet [O] in [src]."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		return

	if(O.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		O.play_tool_sound(src)
		deconstruct()
		return

	if(istype(O, /obj/item/stack/medical/gauze))
		var/obj/item/stack/medical/gauze/G = O
		new /obj/item/reagent_containers/glass/rag(src.loc)
		to_chat(user, span_notice("You tear off a strip of gauze and make a rag."))
		G.use(1)
		return

	if(istype(O, /obj/item/stack/ore/glass))
		new /obj/item/stack/sheet/sandblock(loc)
		to_chat(user, span_notice("You wet the sand in the sink and form it into a block."))
		O.use(1)
		return

	if(!istype(O))
		return
	if(O.item_flags & ABSTRACT) //Abstract items like grabs won't wash. No-drop items will though because it's still technically an item in your hand.
		return

	if(user.a_intent != INTENT_HARM)
		to_chat(user, span_notice("You start washing [O]..."))
		busy = TRUE
		if(!do_after(user, 40, target = src))
			busy = FALSE
			return 1
		busy = FALSE
		O.wash(CLEAN_WASH)
		O.acid_level = 0
		create_reagents(5)
		reagents.add_reagent(dispensedreagent, 5)
		reagents.expose(O, TOUCH)
		user.visible_message(span_notice("[user] washes [O] using [src]."), \
							span_notice("You wash [O] using [src]."))
		return 1
	else
		return ..()

/obj/structure/sink/deconstruct()
	if(!(flags_1 & NODECONSTRUCT_1))
		drop_materials()
	..()

/obj/structure/sink/proc/drop_materials()
	if(buildstacktype)
		new buildstacktype(loc,buildstackamount)
	else
		for(var/i in custom_materials)
			var/datum/material/M = i
			new M.sheet_type(loc, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))

/obj/structure/sink/kitchen
	name = "kitchen sink"
	icon_state = "sink_alt"

/obj/structure/sink/chem
	name = "chemistry lab sink"
	desc = "A sink integrated into the table for easy access in case of emergency."
	icon_state = "sink_chem"
	buildstacktype = /obj/item/stack/sheet/mineral/plastitanium

/obj/structure/sink/puddle	//splishy splashy ^_^
	name = "puddle"
	desc = "A puddle used for washing one's hands and face."
	icon_state = "puddle"
	resistance_flags = UNACIDABLE

//***Oil well puddles.
/obj/structure/sink/oil_well
	name = "oil well"
	desc = "A bubbling pool of oil.This would probably be valuable, had bluespace technology not destroyed the need for fossil fuels 200 years ago."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel/oil

/obj/structure/sink/oil_well/Initialize()
	.=..()
	create_reagents(20)
	reagents.add_reagent(dispensedreagent, 20)

/obj/structure/sink/oil_well/attack_hand(mob/M)
	flick("puddle-oil-splash",src)
	reagents.expose(M, TOUCH, 20) //Covers target in 20u of oil.
	to_chat(M, span_notice("You touch the pool of oil, only to get oil all over yourself. It would be wise to wash this off with water."))

/obj/structure/sink/oil_well/attackby(obj/item/O, mob/user, params)
	flick("puddle-oil-splash",src)
	if(O.tool_behaviour == TOOL_SHOVEL && !(flags_1&NODECONSTRUCT_1)) //attempt to deconstruct the puddle with a shovel
		to_chat(user, "You fill in the oil well with soil.")
		O.play_tool_sound(src)
		deconstruct()
		return 1
	if(istype(O, /obj/item/reagent_containers)) //Refilling bottles with oil
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, span_notice("You fill [RG] from [src]."))
				return TRUE
			to_chat(user, span_notice("\The [RG] is full."))
			return FALSE
	if(user.a_intent != INTENT_HARM)
		to_chat(user, span_notice("You won't have any luck getting \the [O] out if you drop it in the oil."))
		return 1
	else
		return ..()

/obj/structure/sink/oil_well/drop_materials()
	new /obj/effect/decal/cleanable/oil(loc)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/sink/puddle/attack_hand(mob/M)
	icon_state = "puddle-splash"
	. = ..()
	icon_state = "puddle"

/obj/structure/sink/puddle/attackby(obj/item/O, mob/user, params)
	icon_state = "puddle-splash"
	. = ..()
	icon_state = "puddle"

/obj/structure/sink/puddle/deconstruct(disassembled = TRUE)
	qdel(src)

/obj/structure/sink/greyscale
	icon_state = "sink_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	buildstacktype = null

//Shower Curtains//
//Defines used are pre-existing in layers.dm//

/obj/structure/curtain
	name = "curtain"
	desc = "Contains less than 1% mercury."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "bathroom-open"
	var/icon_type = "bathroom"//used in making the icon state
	color = "#ACD1E9" //Default color, didn't bother hardcoding other colors, mappers can and should easily change it.
	alpha = 200 //Mappers can also just set this to 255 if they want curtains that can't be seen through
	layer = SIGN_LAYER
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	var/open = TRUE
	/// if it can be seen through when closed
	var/opaque_closed = FALSE

/obj/structure/curtain/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE,CALLBACK(src, PROC_REF(can_be_rotated)),null)

/obj/structure/curtain/proc/can_be_rotated(mob/user, rotation_type)
	return !anchored

/obj/structure/curtain/proc/toggle()
	open = !open
	if(open)
		layer = SIGN_LAYER
		density = FALSE
		set_opacity(FALSE)
	else
		layer = WALL_OBJ_LAYER
		if(opaque_closed)
			set_opacity(TRUE)

	update_appearance()

/obj/structure/curtain/update_icon_state()
	icon_state = "[icon_type]-[open ? "open" : "closed"]"
	return ..()

/obj/structure/curtain/attackby(obj/item/W, mob/user)
	if (istype(W, /obj/item/toy/crayon))
		color = input(user,"","Choose Color",color) as color
	else
		return ..()

/obj/structure/curtain/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 50)
	return TRUE

/obj/structure/curtain/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(anchored)
		return TRUE

	user.visible_message(span_warning("[user] cuts apart [src]."),
		span_notice("You start to cut apart [src]."), span_hear("You hear cutting."))
	if(I.use_tool(src, user, 50, volume=100) && !anchored)
		to_chat(user, span_notice("You cut apart [src]."))
		deconstruct()

	return TRUE


/obj/structure/curtain/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		return
	playsound(loc, 'sound/effects/curtain.ogg', 50, TRUE)
	toggle()

/obj/structure/curtain/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/cotton/cloth (loc, 2)
	new /obj/item/stack/sheet/plastic (loc, 2)
	new /obj/item/stack/rods (loc, 1)
	qdel(src)

/obj/structure/curtain/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src.loc, 'sound/weapons/slash.ogg', 80, TRUE)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 80, TRUE)

/obj/structure/curtain/bounty
	icon_type = "bounty"
	icon_state = "bounty-open"
	color = null
	alpha = 255
	opaque_closed = TRUE

/obj/structure/curtain/cloth/
	color = null
	alpha = 255
	opaque_closed = TRUE

/obj/structure/curtain/cloth/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/cotton/cloth (loc, 4)
	new /obj/item/stack/rods (loc, 1)
	qdel(src)

/obj/structure/curtain/cloth/fancy
	icon_type = "cur_fancy"
	icon_state = "cur_fancy-open"
