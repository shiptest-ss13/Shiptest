/obj/machinery/door/poddoor/crusher
	gender = PLURAL
	name = "industrial presser"
	desc = "A machine that presses materials into plates."
	icon = 'icons/obj/doors/crusher.dmi'
	damage_deflection = 70
	glass = TRUE

/obj/machinery/door/poddoor/crusher/crush()
	. = ..()
	for(var/mob/living/L in get_turf(src))
		var/mob/living/carbon/C = L
		if(istype(C))
			C.bleed(150)
			C.apply_damage(75, forced=TRUE, spread_damage=TRUE)
			C.AddElement(/datum/element/squish, 80 SECONDS)
		else
			L.apply_damage(75, forced=TRUE)

		L.Paralyze(60)
		playsound(L, 'sound/effects/blobattack.ogg', 40, TRUE)
		playsound(L, 'sound/effects/splat.ogg', 50, TRUE)

	for(var/obj/item/stack/ore/O in get_turf(src))
		var/obj/item/stack/ore/R = new O.refined_type(src)
		R.amount = O.amount
		O.use(O.amount)

/obj/machinery/door/poddoor/crusher/close()
	. = ..()
	playsound(src, 'sound/effects/bang.ogg', 30, TRUE)

/obj/machinery/door/poddoor/crusher/automatic
	desc = "A machine that presses materials into plates. This one seems to be still functioning."
	var/is_open = FALSE //because it doesnt even track it on machinery/door

/obj/machinery/door/poddoor/crusher/automatic/preopen
	icon_state = "open"
	is_open = FALSE
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/crusher/automatic/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	//COOLDOWN_START(src, 3 SECONDS)

/obj/machinery/door/poddoor/crusher/automatic/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/door/poddoor/crusher/automatic/open()
	. = ..()
	is_open = TRUE

/obj/machinery/door/poddoor/crusher/automatic/close()
	. = ..()
	is_open = FALSE

/obj/machinery/door/poddoor/crusher/automatic/process(delta_time)
	if(is_open)
		close()
	else
		open()

/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit
	name = "experimental gun upgrade kit"
	desc = "A suitcase containing the necessary gun parts to tranform a antique laser gun into something even better. A faded Nanotrasen Security symbol is on the side."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit/afterattack(atom/target, mob/user, proximity, params)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/item/gun)) //checks if they really clicked on a gun
		var/created_gun
		if(istype(target, /obj/item/gun/energy/laser/captain/brazil)) //the gun that comes with the ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil // hos gun with a fancy skin
		else if(istype(target, /obj/item/gun/energy/laser/captain)) //a actual antique gun, only on the skipper as of writing and a lavaland ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil/true // hos gun with a fancy skin, but also recharging!!
		else
			to_chat(user, "<span class='warning'>You can't upgrade this gun!.</span>") //wrong gun
			return
		playsound(src, 'sound/items/drill_use.ogg', 50, FALSE)
		if(do_after(user, 60, target = target))
			new created_gun(get_turf(src))
			to_chat(user, "<span class='notice'>With the [src], you upgrade the [target]!</span>")
			qdel(target)
			qdel(src)
			return

/obj/item/strange_crystal
	name = "strange crystal"
	desc = "A crystal that came from a dead creature. Its rapid growth and corruption is kept inert."
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'
	icon_state = "unnamed_crystal"
	grind_results = list(/datum/reagent/crystal_reagent = 4)

/obj/item/strange_crystal/attackby(obj/item/item, mob/user, params)
	. = ..()
	if(!istype(item, /obj/item/kitchen/knife))
		return
	playsound(src, 'sound/effects/glassbr1.ogg', 50, TRUE, -1)
	to_chat(user, "<span class='notice'>You start breaking [src] up into shards...</span>")
	if(!do_after(user, 1 SECONDS, src))
		return
	var/obj/item/result = new /obj/item/garnish/crystal(drop_location())
	var/give_to_user = user.is_holding(src)
	qdel(src)
	if(give_to_user)
		user.put_in_hands(result)
	to_chat(user, "<span class='notice'>You finish breaking [src]</span>")

/obj/structure/summon_beacon
	name = "strange beacon"
	desc = "This broken ship beacon seems to have sent out a distress signal. Curious, maybe it can be repaired?"
	icon = 'icons/obj/machines/dominator.dmi'
	icon_state = "dominator-broken"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/screwed = FALSE
	var/welded = FALSE
	var/powered = FALSE
	var/used = FALSE

/obj/structure/summon_beacon/Initialize()
	. = ..()
	AddComponent(/datum/component/gps, "Distress Signal")

/obj/structure/summon_beacon/examine(mob/user)
	. = ..()
	var/msg = "It looks fully functional."
	if(!powered)
		msg = "It's missing a <b>bluespace crystal</b>."
	if(!welded)
		msg = "It needs to be <b>welded</b> together."
	if(!screwed)
		msg = "It needs to be <b>screwed</b> together."
	. += "<span class='notice'>[msg]</span>"

/obj/structure/summon_beacon/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!screwed)
		if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
			if(attacking_item.use_tool(src, user, 3 SECONDS, volume = 50))
				to_chat(user, "<span class='notice'>You screw [src] together.")
				screwed = TRUE
				update_icon_state()
			return
		else
			return ..()
	if(!welded)
		if(attacking_item.tool_behaviour == TOOL_WELDER)
			if(attacking_item.use_tool(src, user, 5 SECONDS, amount = 3, volume = 50))
				to_chat(user, "<span class='notice'>You weld [src] together.")
				welded = TRUE
				update_icon_state()
			return
		else
			return ..()
	if(!powered)
		if(istype(attacking_item, /obj/item/stack/ore/bluespace_crystal))
			if(attacking_item.use_tool(src, user, 3 SECONDS, amount = 1))
				to_chat(user, "<span class='notice'>You finish [src] with [attacking_item].")
				powered = TRUE
				update_icon_state()
			return
		else
			return ..()
	return ..()

/obj/structure/summon_beacon/update_icon_state()
	icon_state = "dominator-broken"
	if(screwed)
		icon_state = "dominator"
	if(welded)
		icon_state = "dominator-active"
	if(powered)
		icon_state = "dominator-blue"

/obj/structure/summon_beacon/attack_hand(mob/user)
	if(!powered || used)
		return ..()
	used = TRUE
	new /mob/living/simple_animal/hostile/megafauna/heretic(loc)

/mob/living/simple_animal/hostile/megafauna/heretic
	name = "heretic"
	desc = "Now you've done it."
	icon = 'icons/mob/lavaland/40x40megafauna.dmi'
	icon_state = "heretic"

/obj/structure/closet/crate/chest
	name = "chest"
	anchored = TRUE
	anchorable = FALSE

/obj/structure/closet/crate/chest/PopulateContents()
	..()
	var/obj/item/spawned_item = pick(
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet,
		/obj/item/reagent_containers/food/snacks/egg,
		/obj/item/reagent_containers/food/snacks/nugget,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine,
		/obj/item/clothing/suit/nerdshirt,
		/obj/item/clothing/gloves/boxing,
		/obj/item/clothing/neck/stripedgreenscarf,
		/obj/item/clothing/glasses/red,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/clothing/head/bearpelt,
		/obj/item/clothing/shoes/workboots,
		/obj/item/storage/firstaid/regular,
		/obj/item/storage/box/hug,
		/obj/item/storage/bag/books,
		/obj/item/bodypart/head/alien,
		/obj/item/bodypart/r_leg/zombie,
		/obj/item/seeds/random,
		/obj/item/kirbyplants/fullysynthetic,
		/obj/item/restraints/handcuffs,
		/obj/item/banner/command/mundane,
		/obj/item/dice/d6,
		/obj/item/hourglass,
		/obj/item/grenade/flashbang,
		/obj/item/crowbar/red,
		/obj/item/kitchen/knife,
		/obj/item/hatchet,
		/obj/item/scythe,
		/obj/item/tank/internals/plasma/full,
		/obj/item/tank/jetpack/carbondioxide,
		/obj/item/stock_parts/cell/hyper,
		/obj/item/organ/heart/cybernetic/tier3,
		/obj/item/kitchen/knife/bloodletter,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/ballistic/rocketlauncher/unrestricted,
	)
	new spawned_item(src)

/obj/machinery/door/keycard/medbay
	name = "medbay airlock"
	puzzle_id = "contactlightmdb"

/obj/item/keycard/medbay
	name = "medbay keycard"
	puzzle_id = "contactlightmdb"
	color = "#0099ff"

/obj/machinery/door/keycard/storage
	name = "storage airlock"
	puzzle_id = "contactlightstrg"

/obj/item/keycard/storage
	name = "storage keycard"
	puzzle_id = "contactlightstrg"
	color = "#cc9900"

/obj/structure/fluff/teleporter
	name = "ancient teleporter"
	desc = "An old, nonfunctional teleporter. What is it doing here?"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "pad-idle-o"
	deconstructible = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	pixel_y = 8

/obj/item/instrument/guitar/ukulele
	name = "ukulele"
	desc = "An ancient ukulele, from the legendary artist born on Mars. \
		It was said that he was a son of a god, gifted with the power of lightning himself. \
		People say that he was the most humble man, and that his music was simply...  electric!"
	force = 15
	slot_flags = ITEM_SLOT_BACK
	var/lightning_chance = 35
	var/lightning_damage = 30
	var/lightning_range = 6
	var/list/lightning_targets = list()

/obj/item/instrument/guitar/ukulele/equipped(mob/user, slot, initial)
	. = ..()
	if(slot == ITEM_SLOT_BACK)
		RegisterSignal(user, COMSIG_PROJECTILE_FIRER_ON_HIT, .proc/on_fire)
	else
		UnregisterSignal(user, COMSIG_PROJECTILE_FIRER_ON_HIT)

/obj/item/instrument/guitar/ukulele/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_PROJECTILE_FIRER_ON_HIT)

/obj/item/instrument/guitar/ukulele/attack(mob/living/attacked_mob, mob/living/user)
	. = ..()
	try_shock(attacked_mob, user)

/obj/item/instrument/guitar/ukulele/proc/on_fire(mob/user, atom/target, angle)
	SIGNAL_HANDLER

	if(!isliving(target))
		return
	try_shock(target, user)

/obj/item/instrument/guitar/ukulele/proc/try_shock(mob/living/attacked_mob, mob/living/user)
	if(length(lightning_targets) || !prob(lightning_chance))
		return
	if(!shock(attacked_mob))
		return
	user.visible_message("<span class='warning'>[user]'s [name] releases a chain of lightning!</span>", \
		"<span class='notice'>Your [name] releases a chain of lightning!</span>")
	playsound(src, 'sound/weapons/zapbang.ogg', 75, TRUE)
	lightning_targets.Cut()

/obj/item/instrument/guitar/ukulele/proc/shock(mob/living/attacked_mob, atom/beam_source)
	if(iscarbon(attacked_mob) || attacked_mob.stat == DEAD || (attacked_mob in lightning_targets))
		return FALSE
	if(beam_source)
		beam_source.Beam(attacked_mob, "lightning[rand(1,12)]", time = 1 SECONDS, beam_type = /obj/effect/ebeam/chain)
	lightning_targets += attacked_mob
	for(var/mob/living/shock_target in view(lightning_range, attacked_mob))
		if(!prob(lightning_chance))
			continue
		shock(shock_target, attacked_mob)
	attacked_mob.apply_damage(lightning_damage, BURN)
	attacked_mob.Jitter(10)
	attacked_mob.color = list(0,0,0,0, 0,1.5,0,0, 0,0,2,0, 0,0,0,3)
	animate(attacked_mob, 1 SECONDS, color = null)
	to_chat(attacked_mob, "<span class='danger'>You've been shocked by [ismob(loc) ? "[loc]'s [name]" : src]!")
	return TRUE
