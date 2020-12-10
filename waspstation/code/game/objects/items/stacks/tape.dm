/obj/item/stack/tape
	name = "packaging tape"
	singular_name = "tape strip"
	desc = "Sticks things together with minimal effort."
	icon = 'waspstation/icons/obj/tapes.dmi'
	icon_state = "tape"
	item_flags = NOBLUDGEON | NO_MAT_REDEMPTION
	amount = 10
	max_amount = 10
	grind_results = list(/datum/reagent/cellulose = 5)
	usesound = 'waspstation/sound/items/tape.ogg'

	var/stop_bleed = 600
	var/nonorganic_heal = 5
	var/self_delay = 30 //! Also used for the tapecuff delay
	var/other_delay = 10
	var/prefix = "sticky"
	var/list/conferred_embed = EMBED_HARMLESS
	var/overwrite_existing = FALSE

/obj/item/stack/tape/attack(mob/living/carbon/C, mob/living/user)
	if(!istype(C))
		return

	//Bootleg bandage
	if(user.a_intent == INTENT_HELP)
		try_heal(C, user)

	//Relatable suffering
	if((HAS_TRAIT(user, TRAIT_CLUMSY) && prob(25)))
		to_chat(user, "<span class='warning'>Uh... where did the tape edge go?!</span>")
		return

	//Mouth taping and tapecuffs
	if(user.a_intent == INTENT_DISARM)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH) //mouth tape
			if(C.is_mouth_covered() || C.is_muzzled())
				to_chat(user, "<span class='warning'>There is something covering [C]s mouth!</span>")
				return
			if(use(1))
				playsound(loc, usesound, 30, TRUE, -2)
				if(do_mob(user, C, other_delay) && (!C.is_mouth_covered() || !C.is_muzzled()))
					apply_gag(C, user)
					C.visible_message("<span class='notice'>[user] tapes [C]s mouth shut.</span>", \
										"<span class='userdanger'>[user] taped your mouth shut!</span>")
					log_combat(user, C, "gags")
				else
					to_chat(user, "<span class='warning'>You fail to tape up [C]!</span>")
			else
				to_chat(user, "<span class='warning'>There isn't enough tape left!")
		else if (!C.handcuffed) //tapecuffs
			if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
				to_chat(user, "<span class='warning'>Uh... which side sticks again?</span>")
				apply_tapecuffs(user, user)
				return
			if(C.canBeHandcuffed())
				if(use(5))
					C.visible_message("<span class='danger'>[user] is trying to put [src.name] on [C]!</span>", \
										"<span class='userdanger'>[user] is trying to put [src.name] on you!</span>")

					playsound(loc, usesound, 30, TRUE, -2)
					if(do_mob(user, C, self_delay) && (C.canBeHandcuffed()))
						apply_tapecuffs(C, user)
						C.visible_message("<span class='notice'>[user] tapecuffs [C].</span>", \
											"<span class='userdanger'>[user] tapecuffs you.</span>")
						SSblackbox.record_feedback("tally", "handcuffs", 1, type)

						log_combat(user, C, "tapecuffed")
					else
						to_chat(user, "<span class='warning'>You fail to tapecuff [C]!</span>")
				else
					to_chat(user, "<span class='warning'>There isn't enough tape left!</span>")
			else
				to_chat(user, "<span class='warning'>[C] doesn't have two hands...</span>")

/obj/item/stack/tape/proc/try_heal(mob/living/carbon/C, mob/user)
	if(C == user)
		playsound(loc, usesound, 30, TRUE, -2)
		user.visible_message("<span class='notice'>[user] starts to apply \the [src] on [user.p_them()]self...</span>", "<span class='notice'>You begin applying \the [src] on yourself...</span>")
		if(!do_mob(user, C, self_delay, extra_checks=CALLBACK(C, /mob/living/proc/can_inject, user, TRUE)))
			return
	else if(other_delay)
		user.visible_message("<span class='notice'>[user] starts to apply \the [src] on [C].</span>", "<span class='notice'>You begin applying \the [src] on [C]...</span>")
		if(!do_mob(user, C, other_delay, extra_checks=CALLBACK(C, /mob/living/proc/can_inject, user, TRUE)))
			return

	if(heal(C, user))
		log_combat(user, C, "tape bandaged", src.name)
		use(1)

/obj/item/stack/tape/proc/heal(mob/living/carbon/C, mob/user)
	if(C.stat == DEAD)
		to_chat(user, "<span class='notice'>There isn't enough [src] in the universe to fix that...</span>")
		return
	if(!iscarbon(C))
		return
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
		return
	if(affecting.status == BODYPART_ORGANIC)
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			if(!H.bleedsuppress && H.bleed_rate)
				H.suppress_bloodloss(stop_bleed)
				to_chat(user, "<span class='notice'>You tape up the bleeding of [C]!</span>")
				return TRUE
		to_chat(user, "<span class='warning'>[C] has a problem \the [src] won't fix!</span>")
	else //Robotic patch-up
		if(affecting.brute_dam)
			user.visible_message("<span class='notice'>[user] applies \the [src] on [C]'s [affecting.name].</span>", "<span class='green'>You apply \the [src] on [C]'s [affecting.name].</span>")
			if(affecting.heal_damage(nonorganic_heal))
				C.update_damage_overlays()
			return TRUE
		to_chat(user, "<span class='warning'>[src] can't patch what [C] has...</span>")

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

/obj/item/stack/tape/afterattack(obj/O, mob/living/user, proximity)
	if(!istype(O) || !proximity)
		return TRUE
	if(user.a_intent == INTENT_DISARM && istype(O, /obj/item))
		var/obj/item/I = O
		if(I.embedding && I.embedding == conferred_embed)
			to_chat(user, "<span class='warning'>[I] is already coated in [src]!</span>")
			return
		user.visible_message("<span class='notice'>[user] begins wrapping [I] with [src].</span>", "<span class='notice'>You begin wrapping [I] with [src].</span>")
		if(do_after(user, 30, target=I))
			use(1)
			wrap_item(I, user)
			return TRUE

/obj/item/stack/tape/proc/wrap_item(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/clothing/gloves/fingerless))
		var/obj/item/clothing/gloves/tackler/offbrand/O = new /obj/item/clothing/gloves/tackler/offbrand
		to_chat(user, "<span class='notice'>You turn [I] into [O] with [src].</span>")
		QDEL_NULL(I)
		if(!user.equip_to_slot_if_possible(O, ITEM_SLOT_GLOVES, 0))
			user.put_in_hands(O)
		return

	I.embedding = conferred_embed
	I.updateEmbedding()
	to_chat(user, "<span class='notice'>You finish wrapping [I] with [src].</span>")
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
		M.visible_message("<span class='danger'>[M] rips off the tape around [M.p_their()] face!</span>", \
							"<span class='userdanger'>You tear off the [src] and can speak again!</span>")
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
	user.visible_message("<span class='danger'>[user] rips off the tape around [user.p_their()] hands!</span>", \
							"<span class='userdanger'>You tear off the [src] and free yourself!</span>")
	. = ..()

/obj/item/stack/tape/industrial
	name = "duct tape"
	desc = "This roll of silver sorcery can fix just about anything."
	icon_state = "tape_d"

	stop_bleed = 800
	nonorganic_heal = 20
	prefix = "super sticky"
	conferred_embed = EMBED_HARMLESS_SUPERIOR

/obj/item/stack/tape/industrial/afterattack(obj/O, mob/living/user, proximity)
	. = ..()
	if(.)
		return .
	if(user.a_intent == INTENT_HELP)
		if(O.obj_integrity < O.max_integrity)
			to_chat(user, "<span class='notice'>Nothing a little [src] can't fix...</span>")
			play_tool_sound(O, 30)
			if(src.use_tool(O, user, other_delay, 1))
				O.AddComponent(/datum/component/taped, src)
				to_chat(user, "<span class='notice'>You patch up the [O] with a bit of [src].</span>")
				return TRUE
		else
			to_chat(user, "<span class='notice'>[O] looks fine enough to me.</span>")

/obj/item/stack/tape/industrial/electrical
	name = "electrical tape"
	desc = "Specialty insulated strips of adhesive plastic. Made for securing cables."
	icon_state = "tape_e"

	stop_bleed = 400
	nonorganic_heal = 10
	prefix = "insulated sticky"
	siemens_coefficient = 0

/obj/item/stack/tape/industrial/electrical/wrap_item(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/clothing/gloves/color))
		var/obj/item/clothing/gloves/color/yellow/sprayon/tape/O = new /obj/item/clothing/gloves/color/yellow/sprayon/tape
		to_chat(user, "<span class='notice'>You turn [I] into [O] with [src].</span>")
		QDEL_NULL(I)
		user.put_in_hands(O)
		return

	I.embedding = conferred_embed
	I.updateEmbedding()
	to_chat(user, "<span class='notice'>You finish wrapping [I] with [src].</span>")
	I.name = "[prefix] [I.name]"
	I.siemens_coefficient = 0

/obj/item/stack/tape/industrial/pro
	name = "professional-grade duct tape"
	desc = "Now THIS is engineering."
	icon_state = "tape_y"

	stop_bleed = 1000
	nonorganic_heal = 30
	prefix = "industry-standard sticky"
