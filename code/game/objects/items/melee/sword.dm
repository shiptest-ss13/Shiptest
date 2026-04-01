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
	block_chance = 10
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	demolition_mod = 0.75

/obj/item/melee/sword/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 95, 5) //fast and effective, but as a sword, it might damage the results.
	AddComponent(/datum/component/jousting, max_tile_charge = 7, min_tile_charge = 4)

//cruft
/obj/item/melee/sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = projectile_block_chance //Don't bring a sword to a gunfight
	return ..()

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
	icon_state = "machete"
	force = 24
	throwforce = 10
	armour_penetration = -35
	max_integrity = 100

/obj/item/melee/sword/mass
	name = "mass produced machete"
	desc = "A mass-produced machete made of stamped steel, with a faux-leather grip for ease of handling. Right between that of a one-handed and two-handed weapon."
	icon_state = "machete"
	base_icon_state = "machete"
	supports_variations = VOX_VARIATION
	force = 23
	throwforce = 15
	max_integrity = 300
	integrity_failure = 0.50
	var/broken = FALSE


/obj/item/melee/sword/mass/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 23, force_wielded = 25, icon_wielded = "[base_icon_state]_w")


/obj/item/melee/sword/mass/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	. = ..()
	if(.)
		on_block(owner, hitby, attack_text, damage, attack_type)

/obj/item/melee/sword/mass/proc/on_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", damage = 0, attack_type = MELEE_ATTACK)
	take_damage(damage)

/obj/item/melee/sword/mass/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(broken)
		if(I.use_tool(src, user, 0, volume = 40))
			name = src::name
			broken = FALSE
			atom_integrity = max_integrity
		return TRUE

/obj/item/melee/sword/mass/atom_break(damage_flag)
	. = ..()
	if(!broken)
		if(isliving(loc))
			loc.balloon_alert(loc, "[src] cracks!")
		name = "broken [src::name]"
		broken = TRUE

/obj/item/melee/sword/mass/examine(mob/user)
	. = ..()
	var/healthpercent = round((atom_integrity/max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			. += span_info("It looks slightly damaged.")
		if(25 to 50)
			. += span_info("It appears heavily damaged.")
		if(0 to 25)
			. += span_warning("It's falling apart!")

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
	icon_state = "chainsword_on"
	item_state = "chainsword_on"
	force = 15
	throwforce = 10
	armour_penetration = 25
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("sawed", "tore", "lacerated", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw

/obj/item/melee/sword/kukri
	name = "kukri sword"
	desc = "A well-made titanium kukri. A knife with a curve ideal for rapid cuts and chops."
	icon_state = "kukri"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF

	attack_cooldown = LIGHT_WEAPON_CD
	force = 30
	wound_bonus = 5
	bare_wound_bonus = 10
	throwforce = 10
	block_chance = 10

/obj/item/melee/sword/kukri/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

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
	visible_message(span_warning("[src] appears, balanced ever so perfectly on its hilt. This isn't ominous at all."))

/obj/item/melee/sword/supermatter/process(seconds_per_tick)
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
	visible_message(span_danger("The blast wave smacks into [src] and rapidly flashes to ash."),\
	span_hear("You hear a loud crack as you are washed with a wave of heat."))
	consume_everything()

/obj/item/melee/sword/supermatter/acid_act()
	visible_message(span_danger("The acid smacks into [src] and rapidly flashes to ash."),\
	span_hear("You hear a loud crack as you are washed with a wave of heat."))
	consume_everything()

/obj/item/melee/sword/supermatter/bullet_act(obj/projectile/P)
	visible_message(span_danger("[P] smacks into [src] and rapidly flashes to ash."),\
	span_hear("You hear a loud crack as you are washed with a wave of heat."))
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
	T.visible_message(span_danger("[T] smacks into [src] and rapidly flashes to ash."),\
	span_hear("You hear a loud crack as you are washed with a wave of heat."))
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
		/datum/reagent/drug/mammoth = 5,
		/datum/reagent/drug/aranesp = 5,
		/datum/reagent/drug/pumpup = 10,
		/datum/reagent/medicine/panacea = 10,
		/datum/reagent/medicine/earthsblood = 15,
	)

/obj/item/melee/sword/greyking/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if (iscarbon(target) && prob(prick_chance))
		var/mob/living/carbon/C = target
		var/datum/reagent/R = pick(prick_chems)
		C.reagents.add_reagent(R, prick_chems[R])
		C.visible_message(span_danger("[user] is pricked!"), \
								span_userdanger("You've been pricked by the [src]!"))
		log_combat(user, C, "pricked", src.name, "with [prick_chems[R]]u of [R]")
	return ..()

//HF blade
/obj/item/melee/sword/vibro
	icon_state = "hfrequency"
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
	sharpness = SHARP_EDGED
	attack_verb = list("cut", "sliced", "diced")
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/melee/sword/vibro/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 105)
	AddComponent(/datum/component/two_handed, force_multiplier=2, icon_wielded="[base_icon_state]1")

/obj/item/melee/sword/vibro/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/melee/sword/vibro/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		final_block_chance *= 2
	if(HAS_TRAIT(src, TRAIT_WIELDED) || attack_type != PROJECTILE_ATTACK)
		if(prob(final_block_chance))
			if(attack_type == PROJECTILE_ATTACK)
				owner.visible_message(span_danger("[owner] deflects [attack_text] with [src]!"))
				playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
				return 1
			else
				owner.visible_message(span_danger("[owner] parries [attack_text] with [src]!"))
				return 1
	return 0

/obj/item/melee/sword/weebstick
	name = "Weeb Stick"
	desc = "Glorious nippon steel, folded 1000 times."
	icon_state = "weeb_blade"
	item_state = "weeb_blade"
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_POINTY
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
		. += span_info("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/weebstick/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)) || primed)
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		playsound(user, dash_sound, 25, TRUE)
		user.visible_message(span_notice("[user] swiftly draws \the [I]."), span_notice("You draw \the [I]."))
		user.put_in_hands(I)
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))

/obj/item/storage/belt/weebstick/attack_self(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		if(primed)
			CP.locked = FALSE
			playsound(user, 'sound/items/sheath.ogg', 25, TRUE)
			to_chat(user, span_notice("You return your stance."))
			primed = FALSE
			update_appearance()
		else
			CP.locked = TRUE //Prevents normal removal of the blade while primed
			playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
			user.visible_message(span_warning("[user] grips the blade within [src] and primes to attack."), span_warning("You take an opening stance..."), span_warning("You hear a weapon being drawn..."))
			primed = TRUE
			update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))

/obj/item/storage/belt/weebstick/afterattack(atom/A, mob/living/user, proximity_flag, params)
	. = ..()
	if(primed && length(contents))
		if(!(A in view(user.client.view, user)))
			return
		var/obj/item/I = contents[1]
		if(!user.put_in_inactive_hand(I))
			to_chat(user, span_warning("You need a free hand!"))
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
	user.visible_message(span_warning("In a flash of red, [user] draws [user.p_their()] blade!"), span_notice("You dash forward while drawing your weapon!"), span_warning("You hear a blade slice through the air at impossible speeds!"))

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
