/obj/item/melee/sword
	icon = 'icons/obj/weapon/sword.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	pickup_sound =  'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/handling/metal_drop.ogg'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = UNIQUE_RENAME
	block_chance = 25
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_SHARP
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF

/obj/item/melee/sword/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	force = 30
	throwforce = 10
	block_chance = 40
	max_integrity = 200

/obj/item/melee/sword/claymore/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 40, 105)

/obj/item/melee/sword/bone
	name = "bone sword"
	desc = "Jagged pieces of bone are tied to what looks like a goliaths femur."
	icon_state = "bone_sword"
	item_state = "bone_sword"
	force = 15
	throwforce = 10
	armour_penetration = 15

/obj/item/melee/sword/scrap
	name = "scrap sword"
	desc = "A jagged and painful weapon only effective on targets without an armour"
	icon_state = "machete0"
	force = 24
	throwforce = 10
	armour_penetration = -35
	max_integrity = 100

/obj/item/melee/sword/mass
	name = "mass produced machete"
	desc = "A middle ground between a machete and a short sword. A simple construction of stamped steel but its so cheap its hard to complain. Its right between being a one hand and two handed weapon"
	icon_state = "machete0"
	base_icon_state = "machete"
	force = 20
	throwforce = 15
	max_integrity = 50

/obj/item/melee/sword/mass/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=20, force_wielded=22, icon_wielded="[base_icon_state]1")

/obj/item/melee/sword/katana
	name = "katana"
	desc = "Woefully underpowered in D20."
	icon_state = "katana"
	item_state = "katana"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 30
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	block_chance = 10
	max_integrity = 200

/obj/item/melee/sword/chainsaw
	name = "sacred chainsaw sword"
	desc = "Suffer not a heretic to live."
	icon_state = "chainswordon"
	item_state = "chainswordon"
	force = 15
	throwforce = 10
	armour_penetration = 25
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw

/obj/item/melee/sword/sabre
	name = "officer's sabre"
	desc = "An elegant weapon, its monomolecular edge is capable of cutting through flesh and bone with ease."
	icon_state = "sabre"
	item_state = "sabre"
	force = 15
	throwforce = 10
	block_chance = 60
	armour_penetration = 75
	attack_verb = list("slashed", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/sword/sabre/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 95, 5) //fast and effective, but as a sword, it might damage the results.

/obj/item/melee/sword/sabre/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/sword/sabre/solgov
	name = "solarian sabre"
	desc = "A refined ceremonial blade often given to soldiers and high ranking officials of SolGov."
	icon_state = "sabresolgov"
	item_state = "sabresolgov"

/obj/item/melee/sword/sabre/suns
	name = "SUNS sabre"
	desc = "A blade of Solarian origin given to SUNS followers."
	icon_state = "suns-sabre"
	item_state = "suns-sabre"

/obj/item/melee/sword/sabre/suns/captain
	name = "SUNS captain sabre"
	desc = "An elegant blade awarded to SUNS captains. Despite its higher craftmanship, it appears to be just as effective as a normal sabre."
	icon_state = "suns-capsabre"
	item_state = "suns-capsabre"

/obj/item/melee/sword/sabre/suns/cmo
	name = "SUNS stick sabre"
	desc = "A thin blade used by SUNS medical instructors."
	icon_state = "suns-swordstick"
	item_state = "suns-swordstick"

/obj/item/melee/sword/sabre/suns/telescopic
	name = "telescopic sabre"
	desc = "A telescopic and retractable blade given to SUNS peacekeepers for easy concealment and carry. It's design makes it slightly less effective than normal sabres sadly, however it is still excelent at piercing armor."
	icon_state = "suns-tsword"
	item_state = "suns-tsword"
	force = 0
	throwforce = 0
	block_chance = 0

	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("smacked", "prodded")

	var/extended = FALSE
	var/extend_sound = 'sound/weapons/batonextend.ogg'

	var/on_icon_state = "suns-tsword_ext"
	var/on_item_state = "suns-tsword_ext"
	var/off_icon_state = "suns-tsword"
	var/off_item_state = "suns-tsword"

	var/force_on = 10
	var/on_throwforce = 10
	var/on_blockchance = 40

	var/force_off = 0
	var/off_throwforce = 0
	var/off_blockchance = 0

	var/weight_class_on = WEIGHT_CLASS_BULKY

/obj/item/melee/sword/sabre/suns/telescopic/attack_self(mob/user)
	extended = !extended

	if(extended)
		to_chat(user, "<span class ='warning'>You extend the [src].</span>")
		icon_state = on_icon_state
		item_state = on_item_state
		slot_flags = 0
		w_class = weight_class_on
		force = force_on
		throwforce = on_throwforce
		block_chance = on_blockchance
		attack_verb = list("slashed", "cut")
	else
		to_chat(user, "<span class ='notice'>You collapse the [src].</span>")
		icon_state = off_icon_state
		item_state = off_item_state
		slot_flags = ITEM_SLOT_BELT
		w_class = WEIGHT_CLASS_SMALL
		force = force_off
		throwforce = off_throwforce
		block_chance = off_blockchance
		attack_verb = list("smacked", "prodded")

	playsound(get_turf(src), extend_sound, 50, TRUE)
	add_fingerprint(user)

/obj/item/melee/sword/supermatter
	name = "supermatter sword"
	desc = "In a universe full of bad ideas, this might just be the worst."
	icon_state = "supermatter_sword"
	item_state = "supermatter_sword"
	slot_flags = null
	force = 0.001
	armour_penetration = 1000
	var/obj/machinery/power/supermatter_crystal/shard
	var/balanced = 1
	force_string = "INFINITE"

/obj/item/melee/sword/supermatter/Initialize()
	. = ..()
	shard = new /obj/machinery/power/supermatter_crystal(src)
	qdel(shard.countdown)
	shard.countdown = null
	START_PROCESSING(SSobj, src)
	visible_message("<span class='warning'>[src] appears, balanced ever so perfectly on its hilt. This isn't ominous at all.</span>")

/obj/item/melee/sword/supermatter/process()
	if(balanced || throwing || ismob(src.loc) || isnull(src.loc))
		return
	if(!isturf(src.loc))
		var/atom/target = src.loc
		forceMove(target.loc)
		consume_everything(target)
	else
		var/turf/T = get_turf(src)
		if(!isspaceturf(T))
			consume_turf(T)

/obj/item/melee/sword/supermatter/afterattack(target, mob/user, proximity_flag)
	. = ..()
	if(user && target == user)
		user.dropItemToGround(src)
	if(proximity_flag)
		consume_everything(target)

/obj/item/melee/sword/supermatter/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(ismob(hit_atom))
		var/mob/M = hit_atom
		if(src.loc == M)
			M.dropItemToGround(src)
	consume_everything(hit_atom)

/obj/item/melee/sword/supermatter/pickup(user)
	..()
	balanced = 0

/obj/item/melee/sword/supermatter/ex_act(severity, target)
	visible_message("<span class='danger'>The blast wave smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='hear'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything()

/obj/item/melee/sword/supermatter/acid_act()
	visible_message("<span class='danger'>The acid smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='hear'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything()

/obj/item/melee/sword/supermatter/bullet_act(obj/projectile/P)
	visible_message("<span class='danger'>[P] smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='hear'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything(P)
	return BULLET_ACT_HIT


/obj/item/melee/sword/supermatter/proc/consume_everything(target)
	if(isnull(target))
		shard.Consume()
	else if(!isturf(target))
		shard.Bumped(target)
	else
		consume_turf(target)

/obj/item/melee/sword/supermatter/proc/consume_turf(turf/T)
	var/oldtype = T.type
	var/turf/newT = T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	if(newT.type == oldtype)
		return
	playsound(T, 'sound/effects/supermatter.ogg', 50, TRUE)
	T.visible_message("<span class='danger'>[T] smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='hear'>You hear a loud crack as you are washed with a wave of heat.</span>")
	shard.Consume()

/obj/item/melee/sword/supermatter/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/sword/greyking
	name = "blade of the grey-king"
	desc = "A legendary sword made with 3 replica katanas nailed together and dipped in heavy narcotics."
	icon_state = "grey_sword"
	item_state = "swordoff"
	slot_flags = ITEM_SLOT_BACK
	force = 15
	throwforce = 8
	block_chance = 30
	attack_verb = list("struck", "slashed", "mall-ninjad", "tided", "multi-shanked", "shredded")

	var/prick_chance = 50
	var/prick_chems = list(
		/datum/reagent/toxin = 10,
		/datum/reagent/toxin/mindbreaker = 10,
		/datum/reagent/drug/space_drugs = 10,
		/datum/reagent/drug/crank = 5,
		/datum/reagent/drug/methamphetamine = 5,
		/datum/reagent/drug/bath_salts = 5,
		/datum/reagent/drug/aranesp = 5,
		/datum/reagent/drug/pumpup = 10,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/medicine/earthsblood = 15,
		/datum/reagent/medicine/omnizine/protozine = 15
	)

/obj/item/melee/sword/greyking/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if (iscarbon(target) && prob(prick_chance))
		var/mob/living/carbon/C = target
		var/datum/reagent/R = pick(prick_chems)
		C.reagents.add_reagent(R, prick_chems[R])
		C.visible_message("<span class='danger'>[user] is pricked!</span>", \
								"<span class='userdanger'>You've been pricked by the [src]!</span>")
		log_combat(user, C, "pricked", src.name, "with [prick_chems[R]]u of [R]")
	return ..()

//HF blade
/obj/item/melee/sword/vibro
	icon_state = "hfrequency0"
	base_icon_state = "hfrequency"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "vibro sword"
	desc = "A potent weapon capable of cutting through nearly anything. Wielding it in two hands will allow you to deflect gunfire."
	armour_penetration = 100
	block_chance = 30
	force = 20
	throwforce = 20
	throw_speed = 4
	sharpness = IS_SHARP
	attack_verb = list("cut", "sliced", "diced")
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/wielded = FALSE // track wielded status on item

/obj/item/melee/sword/vibro/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/melee/sword/vibro/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 105)
	AddComponent(/datum/component/two_handed, force_multiplier=2, icon_wielded="[base_icon_state]1")

/// triggered on wield of two handed item
/obj/item/melee/sword/vibro/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/melee/sword/vibro/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/sword/vibro/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/melee/sword/vibro/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(wielded)
		final_block_chance *= 2
	if(wielded || attack_type != PROJECTILE_ATTACK)
		if(prob(final_block_chance))
			if(attack_type == PROJECTILE_ATTACK)
				owner.visible_message("<span class='danger'>[owner] deflects [attack_text] with [src]!</span>")
				playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
				return 1
			else
				owner.visible_message("<span class='danger'>[owner] parries [attack_text] with [src]!</span>")
				return 1
	return 0

/obj/item/melee/sword/weebstick
	name = "Weeb Stick"
	desc = "Glorious nippon steel, folded 1000 times."
	icon_state = "weeb_blade"
	item_state = "weeb_blade"
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_SHARP_ACCURATE
	force = 25
	throw_speed = 4
	throw_range = 5
	throwforce = 12
	block_chance = 20
	armour_penetration = 50
	hitsound = 'sound/weapons/anime_slash.ogg'

/obj/item/melee/sword/weebstick/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 90, 5) //Not made for scalping victims, but will work nonetheless

/obj/item/melee/sword/weebstick/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = block_chance / 2 //Pretty good...
	return ..()

/obj/item/melee/sword/weebstick/on_exit_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/sword/weebstick/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/storage/belt/weebstick
	name = "nanoforged blade sheath"
	desc = "It yearns to bath in the blood of your enemies... but you hold it back!"
	icon = 'icons/obj/weapon/sword.dmi'
	icon_state = "weeb_sheath"
	item_state = "sheath"
	force = 3
	var/primed = FALSE //Prerequisite to anime bullshit
	// ##The anime bullshit## - Mostly stolen from action/innate/dash
	var/dash_sound = 'sound/weapons/unsheathed_blade.ogg'
	var/beam_effect = "blood_beam"
	var/phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	var/phaseout = /obj/effect/temp_visual/dir_setting/cult/phase

/obj/item/storage/belt/weebstick/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.use_sound = null
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/sword/weebstick
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
		update_appearance()
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
			update_appearance()
		else
			CP.locked = TRUE //Prevents normal removal of the blade while primed
			playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
			user.visible_message("<span class='warning'>[user] grips the blade within [src] and primes to attack.</span>", "<span class='warning'>You take an opening stance...</span>", "<span class='warning'>You hear a weapon being drawn...</span>")
			primed = TRUE
			update_appearance()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/weebstick/afterattack(atom/A, mob/living/user, proximity_flag, params)
	. = ..()
	if(primed && length(contents))
		if(!(A in view(user.client.view, user)))
			return
		var/obj/item/I = contents[1]
		if(!user.put_in_inactive_hand(I))
			to_chat(user, "<span class='warning'>You need a free hand!</span>")
			return
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		CP.locked = FALSE
		primed = FALSE
		update_appearance()
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
				playsound(victim, 'sound/weapons/anime_slash.ogg', 10, TRUE)
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
	return ..()

/obj/item/storage/belt/weebstick/PopulateContents()
	//Time to generate names now that we have the sword
	var/n_title = pick(GLOB.ninja_titles)
	var/n_name = pick(GLOB.ninja_names)
	var/obj/item/melee/sword/weebstick/sword = new /obj/item/melee/sword/weebstick(src)
	sword.name = "[n_title] blade of clan [n_name]"
	name = "[n_title] scabbard of clan [n_name]"
	update_appearance()
