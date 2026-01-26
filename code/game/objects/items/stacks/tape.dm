

/obj/item/stack/sticky_tape
	name = "sticky tape"
	singular_name = "sticky tape"
	desc = "Used for sticking to things for sticking said things to people."
	icon = 'icons/obj/tapes.dmi'
	icon_state = "tape_w"
	var/prefix = "sticky"
	item_flags = NOBLUDGEON
	amount = 5
	max_amount = 5
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 5)
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_SMALL

	var/list/conferred_embed = EMBED_HARMLESS
	var/overwrite_existing = FALSE

/obj/item/stack/sticky_tape/afterattack(obj/item/I, mob/living/user)
	if(!istype(I))
		return

	if(I.embedding && I.embedding == conferred_embed)
		to_chat(user, span_warning("[I] is already coated in [src]!"))
		return

	user.visible_message(span_notice("[user] begins wrapping [I] with [src]."), span_notice("You begin wrapping [I] with [src]."))

	if(do_after(user, 30, target=I))
		use(1)
		if(istype(I, /obj/item/clothing/gloves/fingerless))
			var/obj/item/clothing/gloves/tackler/offbrand/O = new /obj/item/clothing/gloves/tackler/offbrand
			to_chat(user, span_notice("You turn [I] into [O] with [src]."))
			QDEL_NULL(I)
			user.put_in_hands(O)
			return

		I.embedding = conferred_embed
		I.updateEmbedding()
		to_chat(user, span_notice("You finish wrapping [I] with [src]."))
		I.name = "[prefix] [I.name]"

		if(istype(I, /obj/item/grenade))
			var/obj/item/grenade/sticky_bomb = I
			sticky_bomb.sticky = TRUE

/obj/item/stack/sticky_tape/super
	name = "super sticky tape"
	singular_name = "super sticky tape"
	desc = "Quite possibly the most mischievous substance in the galaxy. Use with extreme lack of caution."
	icon_state = "tape_y"
	prefix = "super sticky"
	conferred_embed = EMBED_HARMLESS_SUPERIOR

/obj/item/stack/sticky_tape/pointy
	name = "pointy tape"
	singular_name = "pointy tape"
	desc = "Used for sticking to things for sticking said things inside people."
	icon_state = "tape_evil"
	prefix = "pointy"
	conferred_embed = EMBED_POINTY

/obj/item/stack/sticky_tape/pointy/super
	name = "super pointy tape"
	singular_name = "super pointy tape"
	desc = "You didn't know tape could look so sinister. Welcome to the frontier."
	icon_state = "tape_spikes"
	prefix = "super pointy"
	conferred_embed = EMBED_POINTY_SUPERIOR

/obj/item/stack/sticky_tape/surgical
	name = "surgical tape"
	singular_name = "surgical tape"
	desc = "Made for patching broken bones back together alongside bone gel."
	prefix = "surgical"
	conferred_embed = list("embed_chance" = 30, "pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE)
	custom_price = 500

/obj/item/stack/tape
	name = "packaging tape"
	singular_name = "packaging tape"
	desc = "Sticks things together with minimal effort."
	icon = 'icons/obj/tapes.dmi'
	icon_state = "tape"
	item_flags = NOBLUDGEON | NO_MAT_REDEMPTION
	amount = 10
	max_amount = 10
	grind_results = list(/datum/reagent/cellulose = 5)
	usesound = 'sound/items/tape.ogg'

	var/lifespan = 300
	var/nonorganic_heal = 5
	var/self_delay = 3 SECONDS //! Also used for the tapecuff delay
	var/other_delay = 1 SECONDS
	var/prefix = "sticky"
	var/list/conferred_embed = EMBED_HARMLESS
	var/overwrite_existing = FALSE

/obj/item/stack/tape/Initialize(mapload, new_amount, merge)
	. = ..()
	AddElement(/datum/element/robotic_heal, brute_heal = nonorganic_heal, self_delay = self_delay, other_delay = other_delay)

/obj/item/stack/tape/merge(obj/item/stack/S) //Because we have unique children, we need to add an additional fail case
	if(src.type != S.type)
		return
	return ..()

/obj/item/stack/tape/attack(mob/living/carbon/C, mob/living/user)
	if(!istype(C))
		return

	//Relatable suffering
	if((HAS_TRAIT(user, TRAIT_CLUMSY) && prob(25)))
		to_chat(user, span_warning("Uh... where did the tape edge go?!"))
		return

	//Mouth taping and tapecuffs
	if(user.a_intent == INTENT_DISARM || user.a_intent == INTENT_HARM)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH) //mouth tape
			if(C.is_mouth_covered() || C.is_muzzled())
				to_chat(user, span_warning("There is something covering [C]s mouth!"))
				return
			if(use(1))
				playsound(loc, usesound, 30, TRUE, -2)
				if(do_after(user, other_delay, C) && (!C.is_mouth_covered() || !C.is_muzzled()))
					apply_gag(C, user)
					C.visible_message(span_notice("[user] tapes [C]s mouth shut."), \
										span_userdanger("[user] taped your mouth shut!"))
					log_combat(user, C, "gags")
				else
					to_chat(user, span_warning("You fail to tape up [C]!"))
			else
				to_chat(user, "<span class='warning'>There isn't enough tape left!")
		else if (!C.handcuffed) //tapecuffs
			if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
				to_chat(user, span_warning("Uh... which side sticks again?"))
				apply_tapecuffs(user, user)
				return
			if(C.canBeHandcuffed())
				if(use(5))
					C.visible_message(span_danger("[user] is trying to put [src.name] on [C]!"), \
										span_userdanger("[user] is trying to put [src.name] on you!"))

					playsound(loc, usesound, 30, TRUE, -2)
					if(do_after(user, self_delay, C) && (C.canBeHandcuffed()))
						apply_tapecuffs(C, user)
						C.visible_message(span_notice("[user] tapecuffs [C]."), \
											span_userdanger("[user] tapecuffs you."))
						SSblackbox.record_feedback("tally", "handcuffs", 1, type)

						log_combat(user, C, "tapecuffed")
					else
						to_chat(user, span_warning("You fail to tapecuff [C]!"))
				else
					to_chat(user, span_warning("There isn't enough tape left!"))
			else
				to_chat(user, span_warning("[C] doesn't have two hands..."))
	return ..()

/obj/item/stack/tape/proc/apply_gag(mob/living/carbon/target, mob/user)
	if(target.is_muzzled() || target.is_mouth_covered())
		return
	var/obj/item/clothing/mask/muzzle/tape/gag = new /obj/item/clothing/mask/muzzle/tape(get_turf(target))
	target.equip_to_slot_or_del(gag, ITEM_SLOT_MASK, 1, 0)
	return

/obj/item/stack/tape/proc/apply_tapecuffs(mob/living/carbon/target, mob/user)
	if(target.handcuffed)
		return
	var/obj/item/restraints/handcuffs/tape/tapecuff = new /obj/item/restraints/handcuffs/tape(get_turf(target))
	tapecuff.apply_cuffs(target, user, 0)
	return

/obj/item/stack/tape/afterattack(obj/O, mob/living/user, proximity, click_parameters)
	if(!istype(O) || !proximity)
		return TRUE
	if(LAZYACCESS(params2list(click_parameters), RIGHT_CLICK) && istype(O, /obj/item))
		var/obj/item/I = O
		if(I.embedding && I.embedding == conferred_embed)
			to_chat(user, span_warning("[I] is already coated in [src]!"))
			return
		user.visible_message(span_notice("[user] begins wrapping [I] with [src]."), span_notice("You begin wrapping [I] with [src]."))
		if(do_after(user, 30, target=I))
			use(1)
			wrap_item(I, user)
			return TRUE

/obj/item/stack/tape/proc/wrap_item(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/clothing/gloves/fingerless))
		var/obj/item/clothing/gloves/tackler/offbrand/O = new /obj/item/clothing/gloves/tackler/offbrand
		to_chat(user, span_notice("You turn [I] into [O] with [src]."))
		QDEL_NULL(I)
		if(!user.equip_to_slot_if_possible(O, ITEM_SLOT_GLOVES, 0))
			user.put_in_hands(O)
		return

	I.embedding = conferred_embed
	I.updateEmbedding()
	to_chat(user, span_notice("You finish wrapping [I] with [src]."))
	I.name = "[prefix] [I.name]"

	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/sticky_bomb = I
		sticky_bomb.sticky = TRUE

/obj/item/clothing/mask/muzzle/tape
	name = "tape muzzle"
	pickup_sound = 'sound/items/poster_ripped.ogg'
	item_flags = DROPDEL

/obj/item/clothing/mask/muzzle/tape/equipped(mob/M, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		M.visible_message(span_danger("[M] rips off the tape around [M.p_their()] face!"), \
							span_userdanger("You tear off the [src] and can speak again!"))
		M.dropItemToGround(src, TRUE, TRUE)

/obj/item/clothing/mask/muzzle/tape/dropped()
	.=..()
	qdel(src) //check my sanity

/obj/item/restraints/handcuffs/tape
	name = "tapecuffs"
	desc = "Seems you are in a sticky situation."
	breakouttime = 15 SECONDS
	trashtype = /obj/item/restraints/handcuffs/tape/used
	flags_1 = NONE

/obj/item/restraints/handcuffs/tape/used
	item_flags = DROPDEL

/obj/item/restraints/handcuffs/tape/used/dropped(mob/user)
	playsound(loc, 'sound/items/poster_ripped.ogg', 30, TRUE, -2)
	user.visible_message(span_danger("[user] rips off the tape around [user.p_their()] hands!"), \
							span_userdanger("You tear off the [src] and free yourself!"))
	. = ..()

/obj/item/stack/tape/industrial
	name = "duct tape"
	singular_name = "duct tape"
	desc = "This roll of silver sorcery can fix just about anything."
	icon_state = "tape_d"
	amount = 15
	max_amount = 15

	lifespan = 400
	nonorganic_heal = 20
	prefix = "super sticky"
	conferred_embed = EMBED_HARMLESS_SUPERIOR

/obj/item/stack/tape/industrial/afterattack(obj/O, mob/living/user, proximity)
	. = ..()
	if(.)
		return .
	if(user.a_intent == INTENT_HELP)
		if(O.atom_integrity < O.max_integrity)
			to_chat(user, span_notice("Nothing a little [src] can't fix..."))
			play_tool_sound(O, 30)
			if(src.use_tool(O, user, other_delay, 1))
				O.AddComponent(/datum/component/taped, src)
				to_chat(user, span_notice("You patch up the [O] with a bit of [src]."))
				return TRUE
		else
			to_chat(user, span_notice("[O] looks fine enough to me."))

/obj/item/stack/tape/industrial/electrical
	name = "electrical tape"
	singular_name = "electrical tape"
	desc = "Specialty insulated strips of adhesive plastic. Made for securing cables."
	icon_state = "tape_e"

	nonorganic_heal = 10
	prefix = "insulated sticky"
	siemens_coefficient = 0
	w_class = WEIGHT_CLASS_SMALL

/obj/item/stack/tape/industrial/electrical/wrap_item(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/clothing/gloves/color))
		var/obj/item/clothing/gloves/color/yellow/sprayon/tape/O = new /obj/item/clothing/gloves/color/yellow/sprayon/tape
		to_chat(user, span_notice("You turn [I] into [O] with [src]."))
		QDEL_NULL(I)
		user.put_in_hands(O)
		return

	I.embedding = conferred_embed
	I.updateEmbedding()
	to_chat(user, span_notice("You finish wrapping [I] with [src]."))
	I.name = "[prefix] [I.name]"
	I.siemens_coefficient = 0

/obj/item/stack/tape/industrial/pro
	name = "professional-grade duct tape"
	singular_name = "professional-grade duct tape"
	desc = "Now THIS is engineering."
	icon_state = "tape_y"

	lifespan = 500
	nonorganic_heal = 30
	prefix = "industry-standard sticky"
