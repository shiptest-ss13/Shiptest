//spears
/obj/item/spear
	icon_state = "spearglass0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "spear"
	desc = "A haphazardly-constructed yet still deadly weapon of ancient design."
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 4
	embedding = list("impact_pain_mult" = 3)
	armour_penetration = 10
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	species_exception = list(/datum/species/kepori)
	var/war_cry = "AAAAARGH!!!"
	var/icon_prefix = "spearglass"

/obj/item/spear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
	AddComponent(/datum/component/jousting)
	AddComponent(/datum/component/two_handed, force_unwielded=10, force_wielded=18, icon_wielded="[icon_prefix]1")

/obj/item/spear/update_icon_state()
	icon_state = "[icon_prefix]0"

/obj/item/spear/CheckParts(list/parts_list)
	var/obj/item/shard/tip = locate() in parts_list
	if (istype(tip, /obj/item/shard/plasma))
		throwforce = 21
		icon_prefix = "spearplasma"
		AddComponent(/datum/component/two_handed, force_unwielded=11, force_wielded=19, icon_wielded="[icon_prefix]1")
	update_icon()
	qdel(tip)
	..()

/obj/item/spear/explosive
	name = "explosive lance"
	var/obj/item/grenade/explosive = null
	var/wielded = FALSE // track wielded status on item

/obj/item/spear/explosive/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
	set_explosive(new /obj/item/grenade/iedcasing/spawned()) //For admin-spawned explosive lances

/obj/item/spear/explosive/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=10, force_wielded=18, icon_wielded="spearbomb1")

/// triggered on wield of two handed item
/obj/item/spear/explosive/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/spear/explosive/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/spear/explosive/update_icon_state()
	icon_state = "spearbomb0"

/obj/item/spear/explosive/proc/set_explosive(obj/item/grenade/G)
	if(explosive)
		QDEL_NULL(explosive)
	G.forceMove(src)
	explosive = G
	desc = "A makeshift spear with [G] attached to it"

/obj/item/spear/explosive/CheckParts(list/parts_list)
	var/obj/item/grenade/G = locate() in parts_list
	if(G)
		var/obj/item/spear/lancePart = locate() in parts_list
		var/datum/component/two_handed/comp_twohand = lancePart.GetComponent(/datum/component/two_handed)
		if(comp_twohand)
			var/lance_wielded = comp_twohand.force_wielded
			var/lance_unwielded = comp_twohand.force_unwielded
			AddComponent(/datum/component/two_handed, force_unwielded=lance_unwielded, force_wielded=lance_wielded)
		throwforce = lancePart.throwforce
		icon_prefix = lancePart.icon_prefix
		parts_list -= G
		parts_list -= lancePart
		set_explosive(G)
		qdel(lancePart)
	..()

/obj/item/spear/explosive/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to set your war cry.</span>"

/obj/item/spear/explosive/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you want your war cry to be? You will shout it when you hit someone in melee.", ,"", 50)
			if(input)
				src.war_cry = input

/obj/item/spear/explosive/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(wielded)
		user.say("[war_cry]", forced="spear warcry")
		explosive.forceMove(AM)
		explosive.prime()
		qdel(src)

//GREY TIDE
/obj/item/spear/grey_tide
	name = "\improper Grey Tide"
	desc = "Recovered from the aftermath of a revolt aboard Defense Outpost Theta Aegis, in which a seemingly endless tide of Assistants caused heavy casualities among Nanotrasen military forces."
	attack_verb = list("gored")
	force=15

/obj/item/spear/grey_tide/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=25, icon_wielded="[icon_prefix]1")

/obj/item/spear/grey_tide/afterattack(atom/movable/AM, mob/living/user, proximity)
	. = ..()
	if(!proximity)
		return
	user.faction |= "greytide([REF(user)])"
	if(isliving(AM))
		var/mob/living/L = AM
		if(istype (L, /mob/living/simple_animal/hostile/illusion))
			return
		if(!L.stat && prob(50))
			var/mob/living/simple_animal/hostile/illusion/M = new(user.loc)
			M.faction = user.faction.Copy()
			M.Copy_Parent(user, 100, user.health/2.5, 12, 30)
			M.GiveTarget(L)

/*
 * Bone Spear
 */
/obj/item/spear/bonespear	//Blatant imitation of spear, but made out of bone. Not valid for explosive modification.
	icon_state = "bone_spear0"
	name = "bone spear"
	desc = "A haphazardly-constructed yet still deadly weapon. The pinnacle of modern technology."
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	force = 12
	throwforce = 22
	armour_penetration = 15				//Enhanced armor piercing

/obj/item/spear/bonespear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=12, force_wielded=20, icon_wielded="bone_spear1")

/obj/item/spear/bonespear/update_icon_state()
	icon_state = "bone_spear0"

/obj/item/spear/dragonspear//version of the bone spear crafted from the trophy dropped by the Ash Drake. High damage, high ap, burns.
	name = "dragonslayer's spear"
	desc = "A bone spear crafted from the leading spine of a fully-grown drake, razor-sharp and hotter then magma. Wielded by the deranged, pyromaniacs, and champions of lavaland."
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	force = 20
	throwforce = 25
	block_chance = 15//lol,lmao
	armour_penetration = 30
	embedding = list("impact_pain_mult" = 5)
	icon_prefix = "dragonspear"
	var/list/nemesis_factions = list("mining", "boss")
	var/faction_bonus_force = 25
	attack_verb = list("seared", "braided", "impaled", "smote", "gored")
	hitsound = 'sound/weapons/sear.ogg'
	var/cooldown_time = 0 SECONDS
	COOLDOWN_DECLARE(freeze_cooldown)

/obj/item/spear/dragonspear/attack(mob/living/target, mob/living/carbon/human/user)
	var/nemesis_faction = FALSE
	if(LAZYLEN(nemesis_factions))
		for(var/F in target.faction)
			if(F in nemesis_factions)
				nemesis_faction = TRUE
				force += faction_bonus_force
				throwforce += faction_bonus_force
				nemesis_effects(user, target)
				break
	. = ..()
	if(nemesis_faction)
		force -= faction_bonus_force
		throwforce -= faction_bonus_force

/obj/item/spear/dragonspear/proc/nemesis_effects(mob/living/user, mob/living/target)
	return

/obj/item/spear/dragonspear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=20, force_wielded=25, icon_wielded="[icon_prefix]1")
	AddComponent(/datum/component/butchering, 60, 150)
	icon_state = "[icon_prefix]0"

/obj/item/spear/dragonspear/update_icon_state()
	icon_state = "[icon_prefix]0"

/obj/item/spear/dragonspear/attack(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.IgniteMob()
		M.apply_damage(5, BURN)
		M.adjust_bodytemperature(150)
	if(isanimal(target))
		var/mob/living/simple_animal/M = target
		M.apply_damage(15, BURN)
	..()

//crystal spear
/obj/item/spear/crystal
	icon_state = "crystal_spear0"
	name = "crystal spear"
	desc = "While more 'sharp stick' than spear, this thing is extremely dangerous neverless. Crafted out of the mysterous crystals, it can hit for very high damage, although it will break with repeated use."
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	force = 12
	throwforce = 40
	armour_penetration = 20
	max_integrity = 300 //you can repair this with duct tape
	var/damage_to_take_on_hit = 25 //every time we hit something, deal how much damage?

/obj/item/spear/crystal/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=12, force_wielded=30, icon_wielded="crystal_spear1") //4 hit crit

/obj/item/spear/crystal/update_icon_state()
	icon_state = "crystal_spear0"

/obj/item/spear/crystal/examine(mob/user)
	. = ..()
	. += "You can throw it for very high damage and stuns fauna, though this will shatter it instantly."
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			. += "It looks slightly damaged."
		if(25 to 50)
			. += "It appears heavily damaged."
		if(0 to 25)
			. += "<span class='warning'>It's falling apart!</span>"

/obj/item/spear/crystal/attack(mob/living/M, mob/living/user)
	. = ..()
	take_damage(damage_to_take_on_hit)

/obj/item/spear/crystal/attack_obj(obj/O, mob/living/user)
	. = ..()
	take_damage(damage_to_take_on_hit)

/obj/item/spear/crystal/obj_destruction(damage_flag)
	visible_message("<span class='danger'>[src] shatters into a million pieces!</span>")
	playsound(src,"shatter", 70)
	new /obj/effect/decal/cleanable/glass/strange(get_turf(src))
	return ..()

/obj/item/spear/crystal/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum) //destroyes when thrown
	. = ..()
	if(ishostile(hit_atom))
		var/mob/living/simple_animal/hostile/hostile_target = hit_atom
		var/hostile_ai_status = hostile_target.AIStatus
		hostile_target.AIStatus = AI_OFF
		addtimer(VARSET_CALLBACK(hostile_target, AIStatus, hostile_ai_status), 5 SECONDS)

	new /obj/effect/temp_visual/goliath_tentacle/crystal/visual_only(get_turf(src))
	visible_message("<span class='danger'>[src] shatters into a million pieces!</span>")
	playsound(src,"shatter", 70)
	new /obj/effect/decal/cleanable/glass/strange(get_turf(src))
	qdel(src)
