//The chests dropped by mob spawner tendrils. Also contains associated loot.

#define HIEROPHANT_CLUB_CARDINAL_DAMAGE 30


/obj/structure/closet/crate/necropolis
	name = "necropolis chest"
	desc = "It's watching you closely."
	icon_state = "necrocrate"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/closet/crate/necropolis/tendril
	desc = "It's watching you suspiciously."

/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,29)
	switch(loot)
		if(1,2)
			new /obj/item/shared_storage/red(src)
		if(3)
			new /obj/item/necromantic_stone/lava(src)
		if(5)
			new /obj/item/pickaxe/diamond(src)
		if(6)
			new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
		if(7)
			new /obj/item/pickaxe/diamond(src)
			new /obj/item/t_scanner/adv_mining_scanner(src)
		if(8)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
			else
				new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
		if(9)
			new /obj/item/gem/bloodstone(src)
		if(10)
			new /obj/item/organ/heart/cursed/wizard(src)
		if(11)
			new /obj/item/ship_in_a_bottle(src)
		if(12)
			new /obj/item/clothing/suit/space/hardsuit/berserker(src)
		if(13)
			new /obj/item/borg/upgrade/modkit/lifesteal(src)
			new /obj/item/bedsheet/cult(src)
		if(14)
			new /obj/item/scythe(src)
		if(15)
			new /obj/item/book_of_babel(src)
		if(16)
			new /obj/item/ship_in_a_bottle(src)
		if(17)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
			else
				new /obj/item/disk/design_disk/modkit_disc/bounty(src)
		if(18)
			new /obj/item/warp_cube/red(src)
		if(19)
			new /obj/item/wisp_lantern(src)
		if(20)
			new /obj/item/immortality_talisman(src)
		if(22)
			new /obj/item/voodoo(src)
		if(23)
			new /obj/item/book/granter/spell/summonitem(src)
		if(24)
			new /obj/item/clothing/gloves/gauntlets(src)
		if(25)
			new /obj/item/toy/plush/blahaj(src)
		if(26)
			new /obj/item/freeze_cube(src)
		if(27)
			new /obj/item/gun/energy/spur(src)
		if(28)
			new /obj/item/clothing/suit/armor/ascetic(src)

/obj/structure/closet/crate/necropolis/tendril/greater
	desc = "It's watching you wearily. It seems terribly bloated."

/obj/structure/closet/crate/necropolis/tendril/greater/PopulateContents()
	for(var/i in 1 to 3)
		var/loot = rand(1,29)
		switch(loot)
			if(1)
				new /obj/item/shared_storage/red(src)
			if(2)
				new /obj/item/clothing/suit/space/hardsuit/cult(src)
			if(3)
				new /obj/item/necromantic_stone/lava(src)
			if(5)
				new /obj/item/pickaxe/diamond(src)
			if(6)
				new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
			if(7)
				new /obj/item/pickaxe/diamond(src)
				new /obj/item/t_scanner/adv_mining_scanner(src)
			if(8)
				if(prob(50))
					new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
				else
					new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
			if(9)
				new /obj/item/gem/bloodstone(src)
			if(10)
				new /obj/item/organ/heart/cursed/wizard(src)
			if(11)
				new /obj/item/ship_in_a_bottle(src)
			if(12)
				new /obj/item/clothing/suit/space/hardsuit/berserker(src)
			if(13)
				new /obj/item/borg/upgrade/modkit/lifesteal(src)
				new /obj/item/bedsheet/cult(src)
			if(14)
				new /obj/item/scythe(src)
			if(15)
				new /obj/item/book_of_babel(src)
			if(16)
				new /obj/item/ship_in_a_bottle(src)
			if(17)
				if(prob(50))
					new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
				else
					new /obj/item/disk/design_disk/modkit_disc/bounty(src)
			if(18)
				new /obj/item/warp_cube/red(src)
			if(19)
				new /obj/item/wisp_lantern(src)
			if(20)
				new /obj/item/immortality_talisman(src)
			if(22)
				new /obj/item/voodoo(src)
			if(23)
				new /obj/item/book/granter/spell/summonitem(src)
			if(24)
				new /obj/item/clothing/gloves/gauntlets(src)
			if(25)
				new /obj/item/toy/plush/blahaj(src)
			if(26)
				new /obj/item/freeze_cube(src)
			if(27)
				new /obj/item/gun/energy/spur(src)
			if(28)
				new /obj/item/clothing/suit/armor/ascetic(src)

/datum/design/unique_modkit
	category = list("Mining Designs", "Cyborg Upgrade Modules") //can't be normally obtained
	build_type = PROTOLATHE | MECHFAB
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/unique_modkit/offensive_turf_aoe
	name = "Kinetic Accelerator Offensive Mining Explosion Mod"
	desc = "A device which causes kinetic accelerators to fire AoE blasts that destroy rock and damage creatures."
	id = "hyperaoemod"
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 3000, /datum/material/silver = 3000, /datum/material/gold = 3000, /datum/material/diamond = 4000)
	build_path = /obj/item/borg/upgrade/modkit/aoe/turfs/andmobs

/datum/design/unique_modkit/rapid_repeater
	name = "Kinetic Accelerator Rapid Repeater Mod"
	desc = "A device which greatly reduces a kinetic accelerator's cooldown on striking a living target or rock, but greatly increases its base cooldown."
	id = "repeatermod"
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 5000, /datum/material/uranium = 8000, /datum/material/bluespace = 2000)
	build_path = /obj/item/borg/upgrade/modkit/cooldown/repeater

/datum/design/unique_modkit/resonator_blast
	name = "Kinetic Accelerator Resonator Blast Mod"
	desc = "A device which causes kinetic accelerators to fire shots that leave and detonate resonator blasts."
	id = "resonatormod"
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 5000, /datum/material/silver = 5000, /datum/material/uranium = 5000)
	build_path = /obj/item/borg/upgrade/modkit/resonator_blasts

/datum/design/unique_modkit/bounty
	name = "Kinetic Accelerator Death Syphon Mod"
	desc = "A device which causes kinetic accelerators to permanently gain damage against creature types killed with it."
	id = "bountymod"
	materials = list(/datum/material/iron = 4000, /datum/material/silver = 4000, /datum/material/gold = 4000, /datum/material/bluespace = 4000)
	reagents_list = list(/datum/reagent/blood = 40)
	build_path = /obj/item/borg/upgrade/modkit/bounty

//Spooky special loot

//Memento Mori
/obj/item/clothing/neck/memento_mori
	name = "Memento Mori"
	desc = "A mysterious pendant. An inscription on it says: \"Certain death tomorrow means certain life today.\""
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "memento_mori"
	mob_overlay_state = "crystal_talisman"
	actions_types = list(/datum/action/item_action/hands_free/memento_mori)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/mob/living/carbon/human/active_owner

/obj/item/clothing/neck/memento_mori/item_action_slot_check(slot)
	return slot == ITEM_SLOT_NECK

/obj/item/clothing/neck/memento_mori/dropped(mob/user)
	..()
	if(active_owner)
		mori()

//Just in case
/obj/item/clothing/neck/memento_mori/Destroy()
	if(active_owner)
		mori()
	return ..()

/obj/item/clothing/neck/memento_mori/proc/memento(mob/living/carbon/human/user)
	to_chat(user, span_warning("You feel your life being drained by the pendant..."))
	if(do_after(user, 40, target = user))
		to_chat(user, span_notice("Your lifeforce is now linked to the pendant! You feel like removing it would kill you, and yet you instinctively know that until then, you won't die."))
		ADD_TRAIT(user, TRAIT_NODEATH, "memento_mori")
		ADD_TRAIT(user, TRAIT_NOHARDCRIT, "memento_mori")
		ADD_TRAIT(user, TRAIT_NOCRITDAMAGE, "memento_mori")
		icon_state = "memento_mori_active"
		active_owner = user

/obj/item/clothing/neck/memento_mori/proc/mori()
	icon_state = "memento_mori"
	if(!active_owner)
		return
	var/mob/living/carbon/human/H = active_owner //to avoid infinite looping when dust unequips the pendant
	active_owner = null
	to_chat(H, span_userdanger("You feel your life rapidly slipping away from you!"))
	H.dust(TRUE, TRUE)

/datum/action/item_action/hands_free/memento_mori
	check_flags = NONE
	name = "Memento Mori"
	desc = "Bind your life to the pendant."

/datum/action/item_action/hands_free/memento_mori/Trigger()
	var/obj/item/clothing/neck/memento_mori/MM = target
	if(!MM.active_owner)
		if(ishuman(owner))
			MM.memento(owner)
			Remove(MM.active_owner) //Remove the action button, since there's no real use in having it now.

//Wisp Lantern
/obj/item/wisp_lantern
	name = "spooky lantern"
	desc = "This lantern gives off no light, but is home to a friendly wisp."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "lantern-blue"
	item_state = "lantern"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	var/obj/effect/wisp/wisp

/obj/item/wisp_lantern/attack_self(mob/user)
	if(!wisp)
		to_chat(user, span_warning("The wisp has gone missing!"))
		icon_state = "lantern"
		return

	if(wisp.loc == src)
		to_chat(user, span_notice("You release the wisp. It begins to bob around your head."))
		icon_state = "lantern"
		wisp.orbit(user, 20)
		ADD_TRAIT(user, ORBITED_TRAIT, "orbited")
		SSblackbox.record_feedback("tally", "wisp_lantern", 1, "Freed")

	else
		to_chat(user, span_notice("You return the wisp to the lantern."))
		icon_state = "lantern-blue"
		wisp.forceMove(src)
		REMOVE_TRAIT(user, ORBITED_TRAIT, "orbited")
		SSblackbox.record_feedback("tally", "wisp_lantern", 1, "Returned")

/obj/item/wisp_lantern/Initialize()
	. = ..()
	wisp = new(src)

/obj/item/wisp_lantern/Destroy()
	if(wisp)
		if(wisp.loc == src)
			qdel(wisp)
		else
			wisp.visible_message(span_notice("[wisp] has a sad feeling for a moment, then it passes."))
	return ..()

/obj/effect/wisp
	name = "friendly wisp"
	desc = "Happy to light your way."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "orb"
	light_system = MOVABLE_LIGHT
	light_range = 7
	light_flags = LIGHT_ATTACHED
	layer = ABOVE_ALL_MOB_LAYER
	var/sight_flags = SEE_MOBS
	var/lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

/obj/effect/wisp/orbit(atom/thing, radius, clockwise, rotation_speed, rotation_segments, pre_rotation, lockinorbit)
	. = ..()
	if(ismob(thing))
		RegisterSignal(thing, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(update_user_sight))
		var/mob/being = thing
		being.update_sight()
		to_chat(thing, span_notice("The wisp enhances your vision."))

/obj/effect/wisp/stop_orbit(datum/component/orbiter/orbits)
	. = ..()
	if(ismob(orbits.parent))
		UnregisterSignal(orbits.parent, COMSIG_MOB_UPDATE_SIGHT)
		to_chat(orbits.parent, span_notice("Your vision returns to normal."))

/obj/effect/wisp/proc/update_user_sight(mob/user)
	user.sight |= sight_flags
	if(!isnull(lighting_alpha))
		user.lighting_alpha = min(user.lighting_alpha, lighting_alpha)

//Red/Blue Cubes
/obj/item/warp_cube
	name = "blue cube"
	desc = "A mysterious blue cube."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "blue_cube"
	var/teleport_color = "#3FBAFD"
	var/obj/item/warp_cube/linked
	var/teleporting = FALSE

/obj/item/warp_cube/Destroy()
	if(!QDELETED(linked))
		qdel(linked)
	linked =  null
	return ..()

/obj/item/warp_cube/attack_self(mob/user)
	var/turf/current_location = get_turf(user)
	var/area/current_area = current_location.loc
	if(!linked || (current_area.area_flags & NOTELEPORT))
		to_chat(user, span_warning("[src] fizzles uselessly."))
		return
	if(teleporting)
		return
	teleporting = TRUE
	linked.teleporting = TRUE
	var/turf/T = get_turf(src)
	new /obj/effect/temp_visual/warp_cube(T, user, teleport_color, TRUE)
	SSblackbox.record_feedback("tally", "warp_cube", 1, type)
	new /obj/effect/temp_visual/warp_cube(get_turf(linked), user, linked.teleport_color, FALSE)
	var/obj/effect/warp_cube/link_holder = new /obj/effect/warp_cube(T)
	user.forceMove(link_holder) //mess around with loc so the user can't wander around
	sleep(2.5)
	if(QDELETED(user))
		qdel(link_holder)
		return
	if(QDELETED(linked))
		user.forceMove(get_turf(link_holder))
		qdel(link_holder)
		return
	link_holder.forceMove(get_turf(linked))
	sleep(2.5)
	if(QDELETED(user))
		qdel(link_holder)
		return
	teleporting = FALSE
	if(!QDELETED(linked))
		linked.teleporting = FALSE
	user.forceMove(get_turf(link_holder))
	qdel(link_holder)

/obj/item/warp_cube/red
	name = "red cube"
	desc = "A mysterious red cube."
	icon_state = "red_cube"
	teleport_color = "#FD3F48"

/obj/item/warp_cube/red/Initialize()
	. = ..()
	if(!linked)
		var/obj/item/warp_cube/blue = new(src.loc)
		linked = blue
		blue.linked = src

/obj/effect/warp_cube
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE

/obj/effect/warp_cube/ex_act(severity, target)
	return

//Immortality Talisman: Now with state-of-the-art panic button technology
/obj/item/immortality_talisman
	name = "\improper Immortality Talisman"
	desc = "A dread talisman, connecting to a plane of total emptiness. It can render you completely invulnerable."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "talisman"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	actions_types = list(/datum/action/item_action/hands_free/immortality)
	var/cooldown = 0
	w_class = 2
	var/warcry = "DOOOOOM"

/obj/item/immortality_talisman/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to set your activation wail.")

/obj/item/immortality_talisman/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you wish to bellow when dragged into the abyss? (Capitalization provides best impact)", ,"", 50)
			if(input)
				src.warcry = input

/datum/action/item_action/hands_free/immortality
	name = "Immortality"

/obj/item/immortality_talisman/attack_self(mob/user)
	if(cooldown < world.time)
		SSblackbox.record_feedback("amount", "immortality_talisman_uses", 1)
		cooldown = world.time + 900
		user.say("[warcry]!!!", forced="talisman warcry")
		new /obj/effect/immortality_talisman(get_turf(user), user)
	else
		to_chat(user, span_warning("[src] is not ready yet!"))

/obj/effect/immortality_talisman
	name = "hole in reality"
	desc = "It's shaped an awful lot like a person."
	icon_state = "blank"
	icon = 'icons/effects/effects.dmi'
	var/vanish_description = "vanishes from reality"
	var/can_destroy = TRUE

/obj/effect/immortality_talisman/Initialize(mapload, mob/new_user)
	. = ..()
	if(new_user)
		vanish(new_user)

/obj/effect/immortality_talisman/proc/vanish(mob/user)
	user.visible_message(span_danger("[user] [vanish_description], leaving a hole in [user.p_their()] place!"))

	desc = "It's shaped an awful lot like [user.name]."
	setDir(user.dir)

	user.forceMove(src)
	user.notransform = FALSE
	user.status_flags |= GODMODE

	can_destroy = FALSE

	addtimer(CALLBACK(src, PROC_REF(unvanish), user), 15 SECONDS)

/obj/effect/immortality_talisman/proc/unvanish(mob/user)
	user.status_flags &= ~GODMODE
	user.notransform = FALSE
	user.forceMove(get_turf(src))

	user.visible_message(span_danger("[user] pops back into reality!"))
	can_destroy = TRUE
	qdel(src)

/obj/effect/immortality_talisman/attackby()
	return

/obj/effect/immortality_talisman/ex_act()
	return

/obj/effect/immortality_talisman/singularity_pull()
	return

/obj/effect/immortality_talisman/Destroy(force)
	if(!can_destroy && !force)
		return QDEL_HINT_LETMELIVE
	else
		. = ..()

/obj/effect/immortality_talisman/void
	vanish_description = "is dragged into the void"

//Shared Bag

/obj/item/shared_storage
	name = "paradox bag"
	desc = "Somehow, it's in two places at once."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "paradox_bag"
	mob_overlay_icon = 'icons/mob/clothing/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = INDESTRUCTIBLE

/obj/item/shared_storage/red
	name = "paradox bag"
	desc = "Somehow, it's in two places at once."

/obj/item/shared_storage/red/Initialize()
	. = ..()
	var/datum/component/storage/STR = AddComponent(/datum/component/storage/concrete)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 35
	STR.max_items = 21
	new /obj/item/shared_storage/blue(drop_location(), STR)

/obj/item/shared_storage/blue/Initialize(mapload, datum/component/storage/concrete/master)
	. = ..()
	if(!istype(master))
		return INITIALIZE_HINT_QDEL
	var/datum/component/storage/STR = AddComponent(/datum/component/storage, master)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 35
	STR.max_items = 21

//Book of Babel

/obj/item/book_of_babel
	name = "Book of Babel"
	desc = "An ancient tome written in countless tongues."
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	w_class = 2

/obj/item/book_of_babel/attack_self(mob/user)
	if(!user.can_read(src))
		return FALSE
	to_chat(user, span_notice("You flip through the pages of the book, quickly and conveniently learning every language in existence. Somewhat less conveniently, the aging book crumbles to dust in the process. Whoops."))
	user.grant_all_languages()
	new /obj/effect/decal/cleanable/ash(get_turf(user))
	qdel(src)


//Potion of Flight
/obj/item/reagent_containers/glass/bottle/potion
	icon_state = "potionflask"
	can_have_cap = TRUE
	cap_icon_state = "potionflask_cap"
	cap_on = FALSE
	fill_icon_thresholds = list(1, 40, 60, 80, 100)


/obj/item/reagent_containers/glass/bottle/potion/flight
	name = "strange elixir"
	desc = "A flask with an almost-holy aura emitting from it. The label on the bottle says: 'erqo'hyy tvi'rf lbh jv'atf'."
	icon_state = "potionflaskwinged"
	fill_icon_state = "potionflask"
	list_reagents = list(/datum/reagent/flightpotion = 5)

/datum/reagent/flightpotion
	name = "Flight Potion"
	description = "Strange mutagenic compound of unknown origins."
	reagent_state = LIQUID
	process_flags = ORGANIC | SYNTHETIC
	color = "#FFEBEB"

/datum/reagent/flightpotion/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		var/mob/living/carbon/C = M
		var/holycheck = ishumanbasic(C)
		if(reac_volume < 5 || !(holycheck || islizard(C) || isipc(C) || (ismoth(C) && C.dna.features["moth_wings"] != "Burnt Off"))) // implying xenohumans are holy //as with all things,
			if(method == INGEST && show_message)
				to_chat(C, span_notice("<i>You feel nothing but a terrible aftertaste.</i>"))
			return ..()
		if(C.dna.species.has_innate_wings)
			to_chat(C, span_userdanger("A terrible pain travels down your back as your wings change shape!"))
			C.dna.features["moth_wings"] = "None"
		else
			to_chat(C, span_userdanger("A terrible pain travels down your back as wings burst out!"))
		C.dna.species.GiveSpeciesFlight(C)
		if(holycheck)
			to_chat(C, span_notice("You feel blessed!"))
			ADD_TRAIT(C, TRAIT_HOLY, SPECIES_TRAIT)
		playsound(C.loc, 'sound/items/poster_ripped.ogg', 50, TRUE, -1)
		C.adjustBruteLoss(20)
		C.force_scream()
	..()

//nerfed necrostone
/obj/item/necromantic_stone/lava
	name = "cracked medallion"
	desc = "A damaged stone medallion, with a glowing gem set in it's center. You could probably resurrect people as skeletons with it. The controlling spirit seems to be malfunctioning."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "necrostone"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/list/skeletons = list()
	var/nolimit = 0

/obj/item/necromantic_stone/lava/nolimit
	nolimit = 1

/obj/item/necromantic_stone/lava/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(!istype(M))
		return ..()

	if(!istype(user) || !user.canUseTopic(M, BE_CLOSE))
		return

	if(M.stat != DEAD)
		to_chat(user, span_warning("This artifact can only affect the dead! Come on. Look, you're going to have to do that part yourself."))
		return

	for(var/mob/dead/observer/ghost in GLOB.dead_mob_list) //excludes new players
		if(ghost.mind && ghost.mind.current == M && ghost.client)  //the dead mobs list can contain clientless mobs
			ghost.reenter_corpse()
			break

	if(!M.mind || !M.client)
		to_chat(user, span_warning("There is no soul connected to this body... Could you put me in it? Just for a day. I swear I'll come back."))
		return

	check_skele()//clean out/refresh the list
	if(skeletons.len >= 5 && !nolimit)
		to_chat(user, span_warning("This artifact can only affect five undead at a time! Greedy guts."))
		return

	M.set_species(/datum/species/skeleton, icon_update=0)
	M.revive(full_heal = TRUE, admin_revive = TRUE)
	skeletons |= M
	to_chat(M, "[span_userdanger("You have been returned from death by ")]<B>[user.real_name]!</B>")
	to_chat(M, span_userdanger("[user.p_theyre(TRUE)] technically your master now, I guess. Help [user.p_them()] or something? I don't know. I'm not your dad. "))

	arm_skeleton(M)

	desc = "A damaged stone medallion, with a glowing gem set in it's center. You could probably resurrect people as skeletons with it. The controlling spirit seems to be malfunctioning. Remember to strip targets[nolimit ? "." : ", [skeletons.len]/5 active skeletons."]"

/obj/item/necromantic_stone/lava/proc/check_skele()
	if(nolimit) //no point, the list isn't used.
		return

	for(var/X in skeletons)
		if(!ishuman(X))
			skeletons.Remove(X)
			continue
		var/mob/living/carbon/human/H = X
		if(H.stat == DEAD)
			H.dust(TRUE)
			skeletons.Remove(X)
			continue
	listclearnulls(skeletons)

//Funny gimmick, skeletons always seem to wear roman/ancient armour
/obj/item/necromantic_stone/lava/proc/arm_skeleton(mob/living/carbon/human/H)
	for(var/obj/item/I in H)
		H.dropItemToGround(I)

	var/hat = pick(/obj/item/clothing/head/helmet/roman, /obj/item/clothing/head/helmet/roman/legionnaire)
	H.equip_to_slot_or_del(new hat(H), ITEM_SLOT_HEAD)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/costume/roman(H), ITEM_SLOT_ICLOTHING)
	H.put_in_hands(new /obj/item/melee/sword/claymore(H), TRUE)
	H.equip_to_slot_or_del(new /obj/item/melee/spear(H), ITEM_SLOT_BACK)

//ice cube
/obj/item/freeze_cube
	name = "freeze cube"
	desc = "A block of semi-clear ice, enchanted by an ancient wizard to keep his drinks cold forever. \
		Unfortunately, it appears to be malfunctioning, and now encases those it impacts with a cube of frost."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "freeze_cube"
	throwforce = 10
	damtype = BURN
	var/cooldown_time = 5 SECONDS
	COOLDOWN_DECLARE(freeze_cooldown)
	throw_speed = 1

/obj/item/freeze_cube/examine(mob/user)
	. = ..()
	. += ("<span class= 'danger'>Throw this at objects or creatures to freeze them, it will boomerang back so be cautious!</span>")

/obj/item/freeze_cube/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, quickstart = TRUE)
	. = ..()
	if(!.)
		return
	icon_state = "freeze_cube_thrown"
	addtimer(VARSET_CALLBACK(src, icon_state, initial(icon_state)), 1 SECONDS)

/obj/item/freeze_cube/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	icon_state = initial(icon_state)
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	var/mob/thrown_by = thrownby.resolve()
	if(ismovable(hit_atom) && !caught && (!thrown_by || thrown_by && COOLDOWN_FINISHED(src, freeze_cooldown)))
		freeze(hit_atom)
	if(thrown_by && !caught)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, throw_at), thrown_by, throw_range+2, throw_speed, null, TRUE), 1)

/obj/item/freeze_cube/proc/freeze(atom/movable/hit_atom)
	playsound(src, 'sound/effects/glassbr3.ogg', 50, TRUE)
	COOLDOWN_START(src, freeze_cooldown, cooldown_time)
	if(isobj(hit_atom))
		var/obj/hit_object = hit_atom
		if(hit_object.resistance_flags & FREEZE_PROOF)
			hit_object.visible_message(span_warning("[hit_object] is freeze-proof! "))
			return
		if(!(hit_object.obj_flags & FROZEN))
			hit_object.make_frozen_visual()
	else if(isliving(hit_atom))
		var/mob/living/hit_mob = hit_atom
		walk(hit_mob, 0) //stops them mid pathing even if they're stunimmune
		hit_mob.apply_status_effect(/datum/status_effect/ice_block_talisman, 5 SECONDS)

/datum/status_effect/ice_block_talisman
	id = "ice_block_talisman"
	duration = 40
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/ice_block_talisman
	/// Stored icon overlay for the hit mob, removed when effect is removed
	var/icon/cube

/atom/movable/screen/alert/status_effect/ice_block_talisman
	name = "Frozen Solid"
	desc = "You're frozen inside an ice cube, and cannot move!"
	icon_state = "frozen"

/datum/status_effect/ice_block_talisman/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(owner_moved))
	if(!owner.stat)
		to_chat(owner, span_userdanger("You become frozen in a cube!"))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	var/icon/size_check = icon(owner.icon, owner.icon_state)
	cube.Scale(size_check.Width(), size_check.Height())
	owner.add_overlay(cube)
	return ..()

/// Blocks movement from the status effect owner
/datum/status_effect/ice_block_talisman/proc/owner_moved()
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/status_effect/ice_block_talisman/on_remove()
	if(!owner.stat)
		to_chat(owner, span_notice("The cube melts!"))
	owner.cut_overlay(cube)
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)

//earthquake gauntlets
/obj/item/clothing/gloves/gauntlets
	name = "concussive gauntlets"
	desc = "Buried deep beneath the earth, these ancient gauntlets absorbed the tectonic power of earthquakes. "
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "concussive_gauntlets"
	toolspeed = 0.1
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = LAVA_PROOF | FIRE_PROOF //they are from lavaland after all
	armor = list(melee = 25, bullet = 25, laser = 15, energy = 25, bomb = 100, bio = 0, rad = 0, fire = 100, acid = 30)

/obj/item/clothing/gloves/gauntlets/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		tool_behaviour = TOOL_MINING
		RegisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(rocksmash))
		RegisterSignal(user, COMSIG_MOVABLE_BUMP, PROC_REF(rocksmash))
	else
		stopmining(user)

/obj/item/clothing/gloves/gauntlets/dropped(mob/user)
	. = ..()
	stopmining(user)

/obj/item/clothing/gloves/gauntlets/proc/stopmining(mob/user)
	tool_behaviour = initial(tool_behaviour)
	UnregisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)
	UnregisterSignal(user, COMSIG_MOVABLE_BUMP)

/obj/item/clothing/gloves/gauntlets/proc/rocksmash(mob/living/carbon/human/H, atom/A, proximity)
	SIGNAL_HANDLER
	if(!(istype(A, /turf/closed/mineral) || istype(A, /turf/closed/wall/concrete)))
		return
	A.attackby(src, H)
	return COMPONENT_NO_ATTACK_OBJ

//A version of the Cave Story refrence that a deranged scientist got their hands on. Better? Not really. Different? Definitely.
//TODO: replace with a proper polar star and spur, not to mention a  proper sprite
/obj/item/gun/energy/spur
	name = "Slowpoke"
	desc = "The work of a truly genius gunsmith, altered and \"improved\" by a truly deranged Nanotrasen scientist, using components from a kinetic accelerator and beam rifle. Draw, partner!"
	icon = 'icons/obj/guns/energy.dmi'
	lefthand_file = GUN_LEFTHAND_ICON
	righthand_file = GUN_RIGHTHAND_ICON
	icon_state = "spur"
	item_state = "spur"
	selfcharge = 1
	charge_delay = 1
	slot_flags = ITEM_SLOT_BELT
	fire_delay = 0.1 SECONDS
	recoil = 1
	default_ammo_type = /obj/item/stock_parts/cell/gun
	ammo_type = list(/obj/item/ammo_casing/energy/spur)
	supports_variations = VOX_VARIATION
	var/chargesound

/obj/item/gun/energy/spur/examine(mob/user)
	. = ..()
	. += span_notice("This weapon contains a gradual heat accelerator that increases shot power as the weapon's energy stores are depleted. Shots at low power are significantly stronger, but also have incredibly short range.")

/obj/item/gun/energy/spur/update_appearance()
	if(!cell)
		chargesound = null
		recoil = 1
		fire_sound = 'sound/weapons/spur_high.ogg'
		return

	var/maxcharge = cell.maxcharge
	var/charge = cell.charge

	var/oldsound = chargesound
	var/obj/item/ammo_casing/energy/AC = ammo_type[select]
	if(charge >= ((maxcharge/3) * 2)) // 2 third charged
		chargesound = 'sound/weapons/spur_chargehigh.ogg'
		recoil = 0
		fire_sound = 'sound/weapons/spur_low.ogg'
	else if(charge >= ((maxcharge/3) * 1)) // 1 third charged
		chargesound = 'sound/weapons/spur_chargemed.ogg'
		recoil = 0
		fire_sound = 'sound/weapons/spur_medium.ogg'
	else if(charge >= AC.e_cost) // less than that
		chargesound = 'sound/weapons/spur_chargehigh.ogg'
		recoil = 0
		fire_sound = 'sound/weapons/spur_high.ogg'
	else
		chargesound = null
		recoil = 1
		fire_sound = 'sound/weapons/spur_high.ogg'

	if(chargesound != oldsound)
		playsound(src, chargesound, 100)
		return ..()
	return ..()

/obj/item/ammo_casing/energy/spur
	projectile_type = /obj/projectile/bullet/spur
	select_name = "polar star lens"
	e_cost = 1300
	fire_sound = null
	harmful = TRUE

/obj/projectile/bullet/spur
	name = "sparkling repulsor"
	range = 20
	damage = 30
	damage_type = BRUTE
	wall_damage_flags = PROJECTILE_BONUS_DAMAGE_MINERALS
	wall_damage_override = MINERAL_WALL_INTEGRITY
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "spur_high"
	var/skip = FALSE //this is the hackiest thing ive ever done but i dont know any other solution other than deparent the spur projectile

/obj/projectile/bullet/spur/fire(angle, atom/direct_target)
	if(!fired_from || !istype(fired_from,/obj/item/gun/energy) || skip)
		return ..()

	var/obj/item/gun/energy/spur/fired_gun = fired_from
	var/maxcharge = fired_gun.cell.maxcharge
	var/charge = fired_gun.cell.charge

	if(charge >= ((maxcharge/3) * 2)) // 2 third charged
		icon_state = "spur_low"
		damage = 15
		armour_penetration = 10
		range = 10
		homing = TRUE
		speed = 0.5
		stamina = 10
	else if(charge >= ((maxcharge/3) * 1)) // 1 third charged
		icon_state = "spur_medium"
		damage = 20
		armour_penetration = 10
		range = 5
	else
		icon_state = "spur_high"//when you're regularly firing these from a dry clip, they're basically shotgun slugs.
		damage = 35
		armour_penetration = 20
		range = 2
	..()

/obj/projectile/bullet/spur/on_range()
	if(!loc)
		return
	var/turf/T = loc
	var/image/impact = image('icons/obj/projectiles.dmi',T,"spur_range")
	impact.layer = ABOVE_MOB_LAYER
	T.overlays += impact
	sleep(2)
	T.overlays -= impact
	qdel(impact)
	..()

/obj/projectile/bullet/spur/on_hit(atom/target, blocked)
	. = ..()
	var/impact_icon = null
	var/impact_sound = null

	if(ismob(target))
		impact_icon = "spur_hitmob"
		impact_sound = 'sound/weapons/spur_hitmob.ogg'
	else
		impact_icon = "spur_hitwall"
		impact_sound = 'sound/weapons/spur_hitwall.ogg'

	var/image/impact = image('icons/obj/projectiles.dmi',target,impact_icon)
	target.overlays += impact
	spawn(15)
		target.overlays -= impact
	playsound(loc, impact_sound, 30)
	..()

/obj/item/ammo_casing/energy/spur/spur
	projectile_type = /obj/projectile/bullet/spur
	select_name = "spur lens"


/obj/projectile/bullet/spur/spur
	name = "spur bullet"
	range = 20
	damage = 40
	damage_type = BRUTE
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "spur_high"
	skip = TRUE

/obj/projectile/bullet/spur/spur/fire(angle, atom/direct_target)
	if(!fired_from || !istype(fired_from,/obj/item/gun/energy))
		return ..()

	var/obj/item/gun/energy/spur/fired_gun = fired_from
	var/maxcharge = fired_gun.cell.maxcharge
	var/charge = fired_gun.cell.charge

	if(charge >= ((maxcharge/3) * 2)) // 2 third charged
		icon_state = "spur_high"
		damage = 40
		range = 20
	else if(charge >= ((maxcharge/3) * 1)) // 1 third charged
		icon_state = "spur_medium"
		damage = 30
		range = 13
	else
		icon_state = "spur_low"
		damage = 20
		range = 7
	..()

//ascetic's robe, provides quickly-recovering layers of total damage immunity, causes massive damage vulnerability when shield is down. Increases speed slightly.
/obj/item/clothing/suit/armor/ascetic
	name = "dunewalker's garb"
	desc = "Sand-bitten robes of roughspun cloth, fit for the hardy life of a travelling hermit. There's a strange aura about them- like a fragile desert haze."
	icon_state = "brittle_master"//suffering
	equip_delay_other = 80
	strip_delay = 100//to prevent hotswapping in battle
	equip_delay_other = 10
	slowdown =  -0.3
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_BULKY
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = -75, bullet = -15, laser = -75, energy = -55, bomb = -55, bio = 0, rad = 100, fire = 100, acid = -45)//bio causes negative chem effects to be multiplied. Bad times.
	var/current_charges = 3
	var/max_charges = 3 //How many charges total the shielding has
	var/recharge_delay = 45 //How long after we've been shot before we can start recharging. 3 seconds here
	var/recharge_cooldown = 0 //Time since we've last been shot
	var/recharge_rate = 3 //How quickly the shield recharges once it starts charging
	var/shield_state = "shimmerair"
	var/shield_on = "shimmerair"

/obj/item/clothing/suit/armor/ascetic/examine(mob/user)
	. = ..()
	. += span_notice("The ascetic's magic woven into this robe increases the owner's speed and deflects harm from their person- however, once it's mirages have melted away, it causes significantly more damage to be taken. The magic can withstand three attacks before it must recover, but it begins regenerating quickly.")

/obj/item/clothing/suit/armor/ascetic/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	recharge_cooldown = world.time + recharge_delay
	if(current_charges > 0)
		var/datum/effect_system/spark_spread/s = new
		s.set_up(2, 1, src)
		s.start()
		owner.visible_message(span_danger("The air seems to shift and boil around [owner]'s body, causing the [attack_text] to fly uselessly past!"))
		current_charges--
		if(recharge_rate)
			START_PROCESSING(SSobj, src)
		if(current_charges <= 1)
			to_chat(owner, span_warning("The defensive wind is faltering!"))
		if(current_charges <= 0)
			owner.visible_message(span_warning("The desert storm protecting [owner] fades away, leaving only ionized sparks!"))
			playsound(loc, 'sound/weather/ashstorm/outside/weak_end.ogg', 100, TRUE)
			shield_state = "broken"
			owner.update_inv_wear_suit()
		return 1
	return 0

/obj/item/clothing/suit/armor/ascetic/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/armor/ascetic/process(seconds_per_tick)
	if(world.time > recharge_cooldown && current_charges < max_charges)
		current_charges = clamp((current_charges + recharge_rate), 0, max_charges)
		playsound(loc, 'sound/effects/magic.ogg', 40, TRUE)
		if(current_charges == max_charges)
			visible_message(span_warning("The strange wind returns to full strength!"))
			STOP_PROCESSING(SSobj, src)
		shield_state = "[shield_on]"
		if(ishuman(loc))
			var/mob/living/carbon/human/C = loc
			C.update_inv_wear_suit()

/obj/item/clothing/suit/armor/ascetic/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_state, MOB_LAYER - 0.01)

///Bosses

//Dragon

/obj/structure/closet/crate/necropolis/dragon
	name = "dragon chest"

/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/sword/claymore(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
		if(4)
			new /obj/item/dragons_blood(src)

//Blood

/obj/item/dragons_blood
	name = "bottle of dragons blood"
	desc = "You're not actually going to drink this, are you?"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/dragons_blood/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return

	var/mob/living/carbon/human/H = user
	var/random = rand(1,4)

	switch(random)
		if(1)
			to_chat(user, span_danger("Your appearance morphs to that of a very small humanoid ash dragon! You get to look like a dragon without the cool abilities."))
			H.dna.features = list("mcolor" = "A02720", "tail_lizard" = "Dark Tiger", "tail_human" = "None", "face_markings" = "None", "horns" = "Curled", "ears" = "None", "wings" = "None", "frills" = "None", "spines" = "Long", "body_markings" = "Dark Tiger Body")
			H.eye_color = "fee5a3"
			H.set_species(/datum/species/lizard)
		if(2)
			to_chat(user, span_danger("Your flesh begins to melt! Miraculously, you seem fine otherwise."))
			H.set_species(/datum/species/skeleton)
		if(3)
			to_chat(user, span_danger("Power courses through you! You can now shift your form at will."))
			if(user.mind)
				var/obj/effect/proc_holder/spell/targeted/shapeshift/dragon/D = new
				user.mind.AddSpell(D)
		if(4)
			to_chat(user, span_danger("You feel like you could walk straight through lava now."))
			H.weather_immunities |= "lava"

	playsound(user.loc,'sound/items/drink.ogg', rand(10,50), TRUE)
	qdel(src)

/datum/disease/transformation/dragon
	name = "dragon transformation"
	cure_text = "nothing"
	cures = list(/datum/reagent/medicine/adminordrazine)
	agent = "dragon's blood"
	desc = "What do dragons have to do with Space Station 13?"
	stage_prob = 20
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = 0
	stage1	= list("Your bones ache.")
	stage2	= list("Your skin feels scaly.")
	stage3	= list(span_danger("You have an overwhelming urge to terrorize some peasants."), span_danger("Your teeth feel sharper."))
	stage4	= list(span_danger("Your blood burns."))
	stage5	= list(span_danger("You're a fucking dragon. However, any previous allegiances you held still apply. It'd be incredibly rude to eat your still human friends for no reason."))
	new_form = /mob/living/simple_animal/hostile/megafauna/dragon/lesser


//Lava Staff

/obj/item/lava_staff
	name = "staff of lava"
	desc = "The ability to fill the emergency shuttle with lava. What more could you want out of life?"
	icon_state = "staffofstorms"
	item_state = "staffofstorms"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 25
	damtype = BURN
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	hitsound = 'sound/weapons/sear.ogg'
	var/turf_type = /turf/open/lava/smooth
	var/transform_string = "lava"
	var/reset_turf_type = /turf/open/floor/plating/asteroid/basalt
	var/reset_string = "basalt"
	var/create_cooldown = 100
	var/create_delay = 30
	var/reset_cooldown = 50
	var/timer = 0
	var/static/list/banned_turfs = typecacheof(list(/turf/open/space/transit, /turf/closed))

/obj/item/lava_staff/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(timer > world.time)
		return

	if(is_type_in_typecache(target, banned_turfs))
		return

	if(target in view(user.client.view, get_turf(user)))

		var/turf/open/T = get_turf(target)
		if(!istype(T))
			return
		if(!istype(T, turf_type))
			var/obj/effect/temp_visual/lavastaff/L = new /obj/effect/temp_visual/lavastaff(T)
			L.alpha = 0
			animate(L, alpha = 255, time = create_delay)
			user.visible_message(span_danger("[user] points [src] at [T]!"))
			timer = world.time + create_delay + 1
			if(do_after(user, create_delay, target = T))
				var/old_name = T.name
				if(T.TerraformTurf(turf_type, flags = CHANGETURF_INHERIT_AIR))
					user.visible_message(span_danger("[user] turns \the [old_name] into [transform_string]!"))
					message_admins("[ADMIN_LOOKUPFLW(user)] fired the lava staff at [ADMIN_VERBOSEJMP(T)]")
					log_game("[key_name(user)] fired the lava staff at [AREACOORD(T)].")
					timer = world.time + create_cooldown
					playsound(T,'sound/magic/fireball.ogg', 200, TRUE)
			else
				timer = world.time
			qdel(L)
		else
			var/old_name = T.name
			if(T.TerraformTurf(reset_turf_type, flags = CHANGETURF_INHERIT_AIR))
				user.visible_message(span_danger("[user] turns \the [old_name] into [reset_string]!"))
				timer = world.time + reset_cooldown
				playsound(T,'sound/magic/fireball.ogg', 200, TRUE)

/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"
	duration = 50

//Bubblegum
/obj/structure/closet/crate/necropolis/bubblegum
	name = "bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	var/loot = rand(1,2)
	switch(loot)
		if(1)
			new /obj/item/mayhem(src)
		if(2)
			new /obj/item/blood_contract(src)

/obj/item/mayhem
	name = "mayhem in a bottle"
	desc = "A magically infused bottle of blood, the scent of which will drive anyone nearby into a murderous frenzy."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/mayhem/attack_self(mob/user)
	for(var/mob/living/carbon/human/H in range(7,user))
		var/obj/item/mine/pressure/pickup/bloodbath/B = new(H)
		INVOKE_ASYNC(B, TYPE_PROC_REF(/obj/item/mine/pressure/pickup/bloodbath, mine_effect), H)
	to_chat(user, span_notice("You shatter the bottle!"))
	playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
	message_admins(span_adminnotice("[ADMIN_LOOKUPFLW(user)] has activated a bottle of mayhem!"))
	log_combat(user, null, "activated a bottle of mayhem", src)
	qdel(src)

/obj/item/blood_contract
	name = "blood contract"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	color = "#FF0000"
	desc = "Mark your target for death."
	var/used = FALSE

/obj/item/blood_contract/attack_self(mob/user)
	if(used)
		return
	used = TRUE

	var/list/da_list = list()
	for(var/I in GLOB.alive_mob_list & GLOB.player_list)
		var/mob/living/L = I
		da_list[L.real_name] = L

	var/choice = input(user,"Who do you want dead?","Choose Your Victim") as null|anything in sortList(da_list)

	choice = da_list[choice]

	if(!choice)
		used = FALSE
		return
	if(!(isliving(choice)))
		to_chat(user, span_warning("[choice] is already dead!"))
		used = FALSE
		return
	if(choice == user)
		to_chat(user, span_warning("You feel like writing your own name into a cursed death warrant would be unwise."))
		used = FALSE
		return

	var/mob/living/L = choice

	message_admins(span_adminnotice("[ADMIN_LOOKUPFLW(L)] has been marked for death by [ADMIN_LOOKUPFLW(user)]!"))

	var/datum/antagonist/blood_contract/A = new
	L.mind.add_antag_datum(A)

	log_combat(user, L, "took out a blood contract on", src)
	qdel(src)

//Colossus
/obj/structure/closet/crate/necropolis/colossus
	name = "colossus chest"

/obj/structure/closet/crate/necropolis/colossus/bullet_act(obj/projectile/P)
	if(istype(P, /obj/projectile/colossus))
		return BULLET_ACT_FORCE_PIERCE
	return ..()

/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)

//Hierophant
/obj/item/hierophant_club
	name = "hierophant club"
	desc = "The strange technology of this large club allows various nigh-magical feats. It used to beat you, but now you can set the beat."
	icon_state = "hierophant_club_ready_beacon"
	item_state = "hierophant_club_ready_beacon"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	attack_verb = list("clubbed", "beat", "pummeled")
	hitsound = 'sound/weapons/sonic_jackhammer.ogg'
	actions_types = list(/datum/action/item_action/vortex_recall, /datum/action/item_action/toggle_unfriendly_fire)
	var/cooldown_time = 20 //how long the cooldown between non-melee ranged attacks is
	var/chaser_cooldown = 81 //how long the cooldown between firing chasers at mobs is
	var/chaser_timer = 0 //what our current chaser cooldown is
	var/chaser_speed = 0.8 //how fast our chasers are
	var/timer = 0 //what our current cooldown is
	var/blast_range = 13 //how long the cardinal blast's walls are
	var/obj/effect/hierophant/beacon //the associated beacon we teleport to
	var/teleporting = FALSE //if we ARE teleporting
	var/friendly_fire_check = FALSE //if the blasts we make will consider our faction against the faction of hit targets

/obj/item/hierophant_club/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/hierophant_club/examine(mob/user)
	. = ..()
	. += span_hierophant_warning("The[beacon ? " beacon is not currently":"re is a beacon"] attached.")

/obj/item/hierophant_club/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/turf/T = get_turf(target)
	if(!T || timer > world.time)
		return
	calculate_anger_mod(user)
	timer = world.time + CLICK_CD_MELEE //by default, melee attacks only cause melee blasts, and have an accordingly short cooldown
	if(proximity_flag)
		INVOKE_ASYNC(src, PROC_REF(aoe_burst), T, user)
		log_combat(user, target, "fired 3x3 blast at", src)
	else
		if(ismineralturf(target) && get_dist(user, target) < 6) //target is minerals, we can hit it(even if we can't see it)
			INVOKE_ASYNC(src, PROC_REF(cardinal_blasts), T, user)
			timer = world.time + cooldown_time
		else if(target in view(5, get_turf(user))) //if the target is in view, hit it
			timer = world.time + cooldown_time
			if(isliving(target) && chaser_timer <= world.time) //living and chasers off cooldown? fire one!
				chaser_timer = world.time + chaser_cooldown
				var/obj/effect/temp_visual/hierophant/chaser/C = new(get_turf(user), user, target, chaser_speed, friendly_fire_check)
				C.damage = 30
				C.monster_damage_boost = FALSE
				log_combat(user, target, "fired a chaser at", src)
			else
				INVOKE_ASYNC(src, PROC_REF(cardinal_blasts), T, user) //otherwise, just do cardinal blast
				log_combat(user, target, "fired cardinal blast at", src)
		else
			to_chat(user, span_warning("That target is out of range!") )
			timer = world.time
	INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))

/obj/item/hierophant_club/proc/calculate_anger_mod(mob/user) //we get stronger as the user loses health
	chaser_cooldown = initial(chaser_cooldown)
	cooldown_time = initial(cooldown_time)
	chaser_speed = initial(chaser_speed)
	blast_range = initial(blast_range)
	if(isliving(user))
		var/mob/living/L = user
		var/health_percent = L.health / L.maxHealth
		chaser_cooldown += round(health_percent * 20) //two tenths of a second for each missing 10% of health
		cooldown_time += round(health_percent * 10) //one tenth of a second for each missing 10% of health
		chaser_speed = max(chaser_speed + health_percent, 0.5) //one tenth of a second faster for each missing 10% of health
		blast_range -= round(health_percent * 10) //one additional range for each missing 10% of health

/obj/item/hierophant_club/update_icon_state()
	icon_state = item_state = "hierophant_club[timer <= world.time ? "_ready":""][(beacon && !QDELETED(beacon)) ? "":"_beacon"]"
	return ..()

/obj/item/hierophant_club/proc/prepare_icon_update()
	update_appearance()
	sleep(timer - world.time)
	update_appearance()

/obj/item/hierophant_club/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_unfriendly_fire)) //toggle friendly fire...
		friendly_fire_check = !friendly_fire_check
		to_chat(user, span_warning("You toggle friendly fire [friendly_fire_check ? "off":"on"]!"))
		return
	if(timer > world.time)
		return
	if(!user.is_holding(src)) //you need to hold the staff to teleport
		to_chat(user, span_warning("You need to hold the club in your hands to [beacon ? "teleport with it":"detach the beacon"]!"))
		return
	if(!beacon || QDELETED(beacon))
		if(isturf(user.loc))
			user.visible_message(span_hierophant_warning("[user] starts fiddling with [src]'s pommel..."), \
			span_notice("You start detaching the hierophant beacon..."))
			timer = world.time + 51
			INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
			if(do_after(user, 50, target = user) && !beacon)
				var/turf/T = get_turf(user)
				playsound(T,'sound/magic/blind.ogg', 200, TRUE, -4)
				new /obj/effect/temp_visual/hierophant/telegraph/teleport(T, user)
				beacon = new/obj/effect/hierophant(T)
				user.update_action_buttons_icon()
				user.visible_message(span_hierophant_warning("[user] places a strange machine beneath [user.p_their()] feet!"), \
				"[span_hierophant("You detach the hierophant beacon, allowing you to teleport yourself and any allies to it at any time!")]\n\
				[span_notice("You can remove the beacon to place it again by striking it with the club.")]")
			else
				timer = world.time
				INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
		else
			to_chat(user, span_warning("You need to be on solid ground to detach the beacon!"))
		return
	if(get_dist(user, beacon) <= 2) //beacon too close abort
		to_chat(user, span_warning("You are too close to the beacon to teleport to it!"))
		return
	var/turf/beacon_turf = get_turf(beacon)
	if(beacon_turf?.is_blocked_turf(TRUE))
		to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
		return
	if(!isturf(user.loc))
		to_chat(user, span_warning("You don't have enough space to teleport from here!"))
		return
	teleporting = TRUE //start channel
	user.update_action_buttons_icon()
	user.visible_message(span_hierophant_warning("[user] starts to glow faintly..."))
	timer = world.time + 50
	INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
	beacon.icon_state = "hierophant_tele_on"
	var/obj/effect/temp_visual/hierophant/telegraph/edge/TE1 = new /obj/effect/temp_visual/hierophant/telegraph/edge(user.loc)
	var/obj/effect/temp_visual/hierophant/telegraph/edge/TE2 = new /obj/effect/temp_visual/hierophant/telegraph/edge(beacon.loc)
	if(do_after(user, 40, target = user) && user && beacon)
		var/turf/T = get_turf(beacon)
		var/turf/source = get_turf(user)
		if(T.is_blocked_turf(TRUE))
			teleporting = FALSE
			to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
			user.update_action_buttons_icon()
			timer = world.time
			INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
			beacon.icon_state = "hierophant_tele_off"
			return
		new /obj/effect/temp_visual/hierophant/telegraph(T, user)
		new /obj/effect/temp_visual/hierophant/telegraph(source, user)
		playsound(T,'sound/magic/wand_teleport.ogg', 200, TRUE)
		playsound(source,'sound/machines/airlockopen.ogg', 200, TRUE)
		if(!do_after(user, 3, target = user) || !user || !beacon || QDELETED(beacon)) //no walking away shitlord
			teleporting = FALSE
			if(user)
				user.update_action_buttons_icon()
			timer = world.time
			INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
			if(beacon)
				beacon.icon_state = "hierophant_tele_off"
			return
		if(T.is_blocked_turf(TRUE))
			teleporting = FALSE
			to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
			user.update_action_buttons_icon()
			timer = world.time
			INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
			beacon.icon_state = "hierophant_tele_off"
			return
		user.log_message("teleported self from [AREACOORD(source)] to [beacon]", LOG_GAME)
		new /obj/effect/temp_visual/hierophant/telegraph/teleport(T, user)
		new /obj/effect/temp_visual/hierophant/telegraph/teleport(source, user)
		for(var/t in RANGE_TURFS(1, T))
			var/obj/effect/temp_visual/hierophant/blast/B = new /obj/effect/temp_visual/hierophant/blast(t, user, TRUE) //blasts produced will not hurt allies
			B.damage = 30
		for(var/t in RANGE_TURFS(1, source))
			var/obj/effect/temp_visual/hierophant/blast/B = new /obj/effect/temp_visual/hierophant/blast(t, user, TRUE) //but absolutely will hurt enemies
			B.damage = 30
		for(var/mob/living/L in range(1, source))
			INVOKE_ASYNC(src, PROC_REF(teleport_mob), source, L, T, user) //regardless, take all mobs near us along
		sleep(6) //at this point the blasts detonate
		if(beacon)
			beacon.icon_state = "hierophant_tele_off"
	else
		qdel(TE1)
		qdel(TE2)
		timer = world.time
		INVOKE_ASYNC(src, PROC_REF(prepare_icon_update))
	if(beacon)
		beacon.icon_state = "hierophant_tele_off"
	teleporting = FALSE
	if(user)
		user.update_action_buttons_icon()

/obj/item/hierophant_club/proc/teleport_mob(turf/source, mob/M, turf/target, mob/user)
	var/turf/turf_to_teleport_to = get_step(target, get_dir(source, M)) //get position relative to caster
	if(!turf_to_teleport_to || turf_to_teleport_to.is_blocked_turf(TRUE))
		return
	animate(M, alpha = 0, time = 2, easing = EASE_OUT) //fade out
	sleep(1)
	if(!M)
		return
	M.visible_message(span_hierophant_warning("[M] fades out!"))
	sleep(2)
	if(!M)
		return
	M.forceMove(turf_to_teleport_to)
	sleep(1)
	if(!M)
		return
	animate(M, alpha = 255, time = 2, easing = EASE_IN) //fade IN
	sleep(1)
	if(!M)
		return
	M.visible_message(span_hierophant_warning("[M] fades in!"))
	if(user != M)
		log_combat(user, M, "teleported", null, "from [AREACOORD(source)]")

/obj/item/hierophant_club/proc/cardinal_blasts(turf/T, mob/living/user) //fire cardinal cross blasts with a delay
	if(!T)
		return
	new /obj/effect/temp_visual/hierophant/telegraph/cardinal(T, user)
	playsound(T,'sound/effects/bin_close.ogg', 200, TRUE)
	sleep(2)
	var/obj/effect/temp_visual/hierophant/blast/B = new(T, user, friendly_fire_check)
	B.damage = HIEROPHANT_CLUB_CARDINAL_DAMAGE
	B.monster_damage_boost = FALSE
	for(var/d in GLOB.cardinals)
		INVOKE_ASYNC(src, PROC_REF(blast_wall), T, d, user)

/obj/item/hierophant_club/proc/blast_wall(turf/T, dir, mob/living/user) //make a wall of blasts blast_range tiles long
	if(!T)
		return
	var/range = blast_range
	var/turf/previousturf = T
	var/turf/J = get_step(previousturf, dir)
	for(var/i in 1 to range)
		if(!J)
			return
		var/obj/effect/temp_visual/hierophant/blast/B = new(J, user, friendly_fire_check)
		B.damage = HIEROPHANT_CLUB_CARDINAL_DAMAGE
		B.monster_damage_boost = FALSE
		previousturf = J
		J = get_step(previousturf, dir)

/obj/item/hierophant_club/proc/aoe_burst(turf/T, mob/living/user) //make a 3x3 blast around a target
	if(!T)
		return
	new /obj/effect/temp_visual/hierophant/telegraph(T, user)
	playsound(T,'sound/effects/bin_close.ogg', 200, TRUE)
	sleep(2)
	for(var/t in RANGE_TURFS(1, T))
		var/obj/effect/temp_visual/hierophant/blast/B = new(t, user, friendly_fire_check)
		B.damage = 15 //keeps monster damage boost due to lower damage


//Just some minor stuff
/obj/structure/closet/crate/necropolis/puzzle
	name = "puzzling chest"

/obj/structure/closet/crate/necropolis/puzzle/PopulateContents()
	var/loot = rand(1,2)
	switch(loot)
		if(1)
			new /obj/item/wisp_lantern(src)
		if(2)
			new /obj/item/prisoncube(src)
