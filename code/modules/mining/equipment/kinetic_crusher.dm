/*********************Mining Hammer****************/
/obj/item/kinetic_crusher
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	item_state = "crusher0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "proto-magnetic crusher"
	desc = "A multipurpose disembarkation and self-defense tool designed by EXOCON using an incomplete Nanotransen prototype. \
	Found in the grime-stained hands of wannabee explorers across the frontier, it cuts rock and hews flora using magnetic osscilation and a heavy cleaving edge."
	force = 0 //You can't hit stuff unless wielded
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	armour_penetration = 10
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("smashed", "crushed", "cleaved", "chopped", "pulped")
	sharpness = IS_SHARP
	actions_types = list(/datum/action/item_action/toggle_light)
	obj_flags = UNIQUE_RENAME
	light_system = MOVABLE_LIGHT
	light_range = 5
	light_on = FALSE
	custom_price = 800
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 15
	var/detonation_damage = 25
	var/backstab_bonus = 30
	var/wielded = FALSE // track wielded status on item

/obj/item/kinetic_crusher/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/kinetic_crusher/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110) //technically it's huge and bulky, but this provides an incentive to use it
	AddComponent(/datum/component/two_handed, force_unwielded=0, force_wielded=20)

/obj/item/kinetic_crusher/Destroy()
	QDEL_LIST(trophies)
	return ..()

/// triggered on wield of two handed item
/obj/item/kinetic_crusher/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/kinetic_crusher/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/kinetic_crusher/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Induce magnetism in an enemy by striking them with a magnetospheric wave, then hit them in melee to force a waveform collapse for <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"

/obj/item/kinetic_crusher/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(trophies))
			to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/kinetic_crusher/attack(mob/living/target, mob/living/carbon/user)
	if(!wielded)
		to_chat(user, "<span class='warning'>[src] is too heavy to use with one hand! You fumble and drop everything.</span>")
		user.drop_all_held_items()
		return
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/kinetic_crusher/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(!wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/D = new /obj/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, TRUE)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, TRUE) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

/obj/item/kinetic_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)

/obj/item/kinetic_crusher/ui_action_click(mob/user, actiontype)
	set_light_on(!light_on)
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_icon()


/obj/item/kinetic_crusher/update_icon_state()
	item_state = "crusher[wielded]" // this is not icon_state and not supported by 2hcomponent

/obj/item/kinetic_crusher/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(light_on)
		. += "[icon_state]_lit"

//destablizing force
/obj/projectile/destabilizer
	name = "magnetic wave"
	icon_state = "pulse1"
	nodamage = TRUE
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	damage_type = BRUTE
	flag = "bomb"
	range = 6
	log_override = TRUE
	var/obj/item/kinetic_crusher/hammer_synced

/obj/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/projectile/destabilizer/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/had_effect = (L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)) //used as a boolean
		var/datum/status_effect/crusher_mark/CM = L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK, hammer_synced)
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
		M.gets_drilled(firer, TRUE)
	..()

//trophies
/obj/item/crusher_trophy
	name = "tail spike"
	desc = "A strange spike with no usage."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "tail_spike"
	var/bonus_value = 10 //if it has a bonus effect, this is how much that effect is
	var/denied_type = /obj/item/crusher_trophy

/obj/item/crusher_trophy/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Causes [effect_desc()] when attached to a kinetic crusher.</span>"

/obj/item/crusher_trophy/proc/effect_desc()
	return "errors"

/obj/item/crusher_trophy/attackby(obj/item/A, mob/living/user)
	if(istype(A, /obj/item/kinetic_crusher | /obj/item/syndie_crusher))
		add_to(A, user)
	else
		..()

/obj/item/crusher_trophy/proc/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	for(var/t in H.trophies)
		var/obj/item/crusher_trophy/T = t
		if(istype(T, denied_type) || istype(src, T.denied_type))
			to_chat(user, "<span class='warning'>You can't seem to attach [src] to [H]. Maybe remove a few trophies?</span>")
			return FALSE
	if(!user.transferItemToLoc(src, H))
		return
	H.trophies += src
	to_chat(user, "<span class='notice'>You attach [src] to [H].</span>")
	return TRUE

/obj/item/crusher_trophy/proc/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	forceMove(get_turf(H))
	H.trophies -= src
	return TRUE

/obj/item/crusher_trophy/proc/on_melee_hit(mob/living/target, mob/living/user) //the target and the user
/obj/item/crusher_trophy/proc/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user) //the projectile fired and the user
/obj/item/crusher_trophy/proc/on_mark_application(mob/living/target, datum/status_effect/crusher_mark/mark, had_mark) //the target, the mark applied, and if the target had a mark before
/obj/item/crusher_trophy/proc/on_mark_detonation(mob/living/target, mob/living/user) //the target and the user

//goliath
/obj/item/crusher_trophy/goliath_tentacle
	name = "goliath tentacle"
	desc = "A sliced-off goliath tentacle."
	icon_state = "goliath_tentacle"
	denied_type = /obj/item/crusher_trophy/goliath_tentacle
	bonus_value = 5
	var/missing_health_ratio = 0.1
	var/missing_health_desc = 10

/obj/item/crusher_trophy/goliath_tentacle/effect_desc()
	return "waveform collapse to do <b>[bonus_value]</b> more damage for every <b>[missing_health_desc]</b> health you are missing"

/obj/item/crusher_trophy/goliath_tentacle/on_mark_detonation(mob/living/target, mob/living/user)
	var/missing_health = user.maxHealth - user.health
	missing_health *= missing_health_ratio //bonus is active at all times, even if you're above 90 health
	missing_health *= bonus_value //multiply the remaining amount by bonus_value
	if(missing_health > 0)
		target.adjustBruteLoss(missing_health) //and do that much damage

//ancient goliath
/obj/item/crusher_trophy/elder_tentacle
	name = "elder tentacle"
	desc = "The barbed tip of a tentacle sliced from an incredibly ancient goliath."
	icon_state = "elder_tentacle"
	denied_type = /obj/item/crusher_trophy/elder_tentacle
	bonus_value = 3
	var/missing_health_ratio = 0.1
	var/missing_health_desc = 5
	icon = 'icons/obj/lavaland/elite_trophies.dmi'

/obj/item/crusher_trophy/elder_tentacle/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/elder_tentacle/effect_desc()
	return "waveform collapse to do <b>[bonus_value]</b> more damage for every <b>[missing_health_desc]</b> health you are missing"

/obj/item/crusher_trophy/elder_tentacle/on_mark_detonation(mob/living/target, mob/living/user)
	var/missing_health = user.maxHealth - user.health
	missing_health *= missing_health_ratio //bonus is active at all times, even if you're above 90 health
	missing_health *= bonus_value //multiply the remaining amount by bonus_value
	if(missing_health > 0)
		target.adjustBruteLoss(missing_health) //and do that much damage

//watcher
/obj/item/crusher_trophy/watcher_wing
	name = "watcher wing"
	desc = "A wing ripped from a watcher."
	icon_state = "watcher_wing"
	denied_type = /obj/item/crusher_trophy/watcher_wing
	bonus_value = 5

/obj/item/crusher_trophy/watcher_wing/effect_desc()
	return "waveform collapse to prevent certain creatures from using certain attacks for <b>[bonus_value*0.1]</b> second\s"

/obj/item/crusher_trophy/watcher_wing/on_mark_detonation(mob/living/target, mob/living/user)
	if(ishostile(target))
		var/mob/living/simple_animal/hostile/H = target
		if(H.ranged) //briefly delay ranged attacks
			if(H.ranged_cooldown >= world.time)
				H.ranged_cooldown += bonus_value
			else
				H.ranged_cooldown = bonus_value + world.time

//magmawing watcher
/obj/item/crusher_trophy/magma_wing
	name = "magmatic sinew"
	desc = "A fuming organ, dropped by beings hotter then lava."
	icon_state = "magma_wing"
	denied_type = /obj/item/crusher_trophy/magma_wing
	gender = NEUTER
	bonus_value = 5
	var/deadly_shot = FALSE

/obj/item/crusher_trophy/magma_wing/effect_desc()
	return "waveform collapse to make the next magnetic pulse deal <b>[bonus_value]</b> damage"

/obj/item/crusher_trophy/magma_wing/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/magma_wing/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "superheated [marker.name]"
		marker.icon_state = "lava"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		marker.speed = 2
		deadly_shot = FALSE

/obj/item/crusher_trophy/magma_wing/on_mark_detonation(mob/living/target, mob/living/user)
	deadly_shot = TRUE
	addtimer(CALLBACK(src, .proc/reset_deadly_shot), 300, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/item/crusher_trophy/magma_wing/proc/reset_deadly_shot()
	deadly_shot = FALSE

//icewing watcher
/obj/item/crusher_trophy/ice_wing
	name = "frigid sinew"
	desc = "A carefully-preserved freezing organ, dropped by chilling beings."
	icon_state = "ice_wing"
	bonus_value = 8
	denied_type = /obj/item/crusher_trophy/ice_wing

/obj/item/crusher_trophy/ice_wing/effect_desc()
	return "waveform collapse to prevent certain creatures from using certain attacks for <b>[bonus_value*0.1]</b> second\s"

/obj/item/crusher_trophy/ice_wing/on_mark_detonation(mob/living/target, mob/living/user)
	if(ishostile(target))
		var/mob/living/simple_animal/hostile/H = target
		if(H.ranged) //briefly delay ranged attacks
			if(H.ranged_cooldown >= world.time)
				H.ranged_cooldown += bonus_value
			else
				H.ranged_cooldown = bonus_value + world.time

//legion
/obj/item/crusher_trophy/legion_skull
	name = "legion skull"
	desc = "A dead and lifeless legion skull. Could be used in crafting."
	icon_state = "legion_skull"
	denied_type = /obj/item/crusher_trophy/legion_skull
	bonus_value = 3

/obj/item/crusher_trophy/legion_skull/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/legion_skull/effect_desc()
	return "a kinetic crusher to recharge <b>[bonus_value*0.1]</b> second\s faster"

/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time -= bonus_value

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time += bonus_value

//dwarf legion
/obj/item/crusher_trophy/dwarf_skull
	name = "shrunken skull"
	desc = "Looks like someone hasn't been drinking their milk. Could be used in crafting."
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	icon_state = "shrunk_skull"
	denied_type = /obj/item/crusher_trophy/legion_skull
	bonus_value = 6

/obj/item/crusher_trophy/dwarf_skull/effect_desc()
	return "a kinetic crusher to recharge <b>[bonus_value*0.1]</b> second\s faster"

/obj/item/crusher_trophy/dwarf_skull/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time -= bonus_value

/obj/item/crusher_trophy/dwarf_skull/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time += bonus_value

//blood-drunk hunter
/obj/item/crusher_trophy/miner_eye
	name = "eye of a blood-drunk hunter"
	desc = "Its pupil is collapsed and turned to mush."
	icon_state = "hunter_eye"
	denied_type = /obj/item/crusher_trophy/miner_eye

/obj/item/crusher_trophy/miner_eye/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/miner_eye/effect_desc()
	return "waveform collapse to grant stun immunity and <b>90%</b> damage reduction for <b>1</b> second"

/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user)
	user.apply_status_effect(STATUS_EFFECT_BLOODDRUNK)

//whelp
/obj/item/crusher_trophy/tail_spike
	desc = "A spike taken from a young dragon's tail. Sharp enough to stab someone with."
	denied_type = /obj/item/crusher_trophy/tail_spike
	bonus_value = 5
	force = 10
	throwforce = 15
	throw_speed = 4
	sharpness = IS_SHARP
	attack_verb = list("cut", "sliced", "diced")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/crusher_trophy/tail_spike/effect_desc()
	return "waveform collapse to do <b>[bonus_value]</b> damage to nearby creatures and push them back"

/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user)
	for(var/mob/living/L in oview(2, user))
		if(L.stat == DEAD)
			continue
		playsound(L, 'sound/magic/fireball.ogg', 20, TRUE)
		new /obj/effect/temp_visual/fire(L.loc)
		addtimer(CALLBACK(src, .proc/pushback, L, user), 1) //no free backstabs, we push AFTER module stuff is done
		L.adjustFireLoss(bonus_value, forced = TRUE)

/obj/item/crusher_trophy/tail_spike/proc/pushback(mob/living/target, mob/living/user)
	if(!QDELETED(target) && !QDELETED(user) && (!target.anchored || ismegafauna(target))) //megafauna will always be pushed
		step(target, get_dir(user, target))

//ash drake
/obj/item/crusher_trophy/ash_spike
	desc = "A molten spike taken from an ash drake's tail. Hot to the touch and extremely sharp."
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	icon_state = "ash_spike"
	denied_type = /obj/item/crusher_trophy/ash_spike
	bonus_value = 15
	force = 15
	throwforce = 20
	throw_speed = 4
	sharpness = IS_SHARP
	attack_verb = list("cut", "braised", "singed")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/crusher_trophy/ash_spike/effect_desc()
	return "waveform collapse to do <b>[bonus_value]</b> damage to nearby creatures and push them back"

/obj/item/crusher_trophy/ash_spike/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/ash_spike/on_mark_detonation(mob/living/target, mob/living/user)
	for(var/mob/living/L in oview(2, user))
		if(L.stat == DEAD)
			continue
		playsound(L, 'sound/magic/fireball.ogg', 20, TRUE)
		new /obj/effect/temp_visual/fire(L.loc)
		addtimer(CALLBACK(src, .proc/pushback, L, user), 1) //no free backstabs, we push AFTER module stuff is done
		L.adjustFireLoss(bonus_value, forced = TRUE)

/obj/item/crusher_trophy/ash_spike/proc/pushback(mob/living/target, mob/living/user)
	if(!QDELETED(target) && !QDELETED(user) && (!target.anchored || ismegafauna(target))) //megafauna will always be pushed
		step(target, get_dir(user, target))

//bubblegum
/obj/item/crusher_trophy/demon_claws
	name = "demon claws"
	desc = "A set of blood-drenched claws from a massive demon's hand."
	icon_state = "demon_claws"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/demon_claws
	bonus_value = 10
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/obj/item/crusher_trophy/demon_claws/effect_desc()
	return "melee hits to do <b>[bonus_value * 0.2]</b> more damage and heal you for <b>[bonus_value * 0.1]</b>, with <b>5X</b> effect on waveform collapse"

/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force += bonus_value * 0.2
		H.detonation_damage += bonus_value * 0.8
		AddComponent(/datum/component/two_handed, force_wielded=(20 + bonus_value * 0.2))

/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force -= bonus_value * 0.2
		H.detonation_damage -= bonus_value * 0.8
		AddComponent(/datum/component/two_handed, force_wielded=20)

/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.1, damage_heal_order)

/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.4, damage_heal_order)

//colossus
/obj/item/crusher_trophy/blaster_tubes
	name = "blaster tubes"
	desc = "The blaster tubes from a colossus's arm."
	icon_state = "blaster_tubes"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/blaster_tubes
	bonus_value = 15
	var/deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/blaster_tubes/effect_desc()
	return "waveform collapse to make the next magnetic pulse deal <b>[bonus_value]</b> damage but move slower"

/obj/item/crusher_trophy/blaster_tubes/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "ominous [marker.name]"
		marker.icon_state = "chronobolt"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		marker.speed = 2
		deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/on_mark_detonation(mob/living/target, mob/living/user)
	deadly_shot = TRUE
	addtimer(CALLBACK(src, .proc/reset_deadly_shot), 300, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/item/crusher_trophy/blaster_tubes/proc/reset_deadly_shot()
	deadly_shot = FALSE

//hierophant
/obj/item/crusher_trophy/vortex_talisman
	name = "vortex talisman"
	desc = "A glowing trinket that was originally the Hierophant's beacon."
	icon_state = "vortex_talisman"
	denied_type = /obj/item/crusher_trophy/vortex_talisman

/obj/item/crusher_trophy/vortex_talisman/effect_desc()
	return "waveform collapse to create a barrier you can pass"

/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/turf/current_location = get_turf(user)
	var/area/current_area = current_location.loc
	if(current_area.area_flags & NOTELEPORT)
		to_chat(user, "[src] fizzles uselessly.")
		return
	var/turf/T = get_turf(user)
	new /obj/effect/temp_visual/hierophant/wall/crusher(T, user) //a wall only you can pass!
	var/turf/otherT = get_step(T, turn(user.dir, 90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)
	otherT = get_step(T, turn(user.dir, -90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)

/obj/effect/temp_visual/hierophant/wall/crusher
	duration = 75

//I am afraid of this code. It also does not function(in terms of doing damage to enemies) as of my last test.
/obj/item/crusher_trophy/king_goat
	name = "king goat hoof"
	desc = "A hoof from the king of all goats, it still glows with a fraction of its original power..."
	icon_state = "goat_hoof" //needs a better sprite but I cant sprite .
	denied_type = /obj/item/crusher_trophy/king_goat

/obj/item/crusher_trophy/king_goat/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Suitable as a trophy for a proto-kinetic crusher.</span>"

/obj/item/crusher_trophy/king_goat/effect_desc()
	return "you also passively recharge pulses 5x as fast while this is equipped and do a decent amount of damage at the cost of dulling the blade"

/obj/item/crusher_trophy/king_goat/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.damage = 10 //in my testing only does damage to simple mobs so should be fine to have it high //it does damage to nobody. Please fix -M

/obj/item/crusher_trophy/king_goat/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time = 3
		H.AddComponent(/datum/component/two_handed, force_wielded=5)

/obj/item/crusher_trophy/king_goat/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time = 15
		H.AddComponent(/datum/component/two_handed, force_wielded=20)

/obj/item/crusher_trophy/shiny
	name = "shiny nugget"
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	desc = "A glimmering nugget of dull metal. As it turns out, the fools were right- pyrite is a far rarer substance than gold in the space age. You could probably sell this for a fair price."
	icon_state = "nugget"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/shiny

/obj/item/crusher_trophy/shiny/effect_desc()
	return "empowered butchering chances"

/obj/item/crusher_trophy/shiny/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.AddComponent(/datum/component/butchering, 60, 210)

/obj/item/crusher_trophy/shiny/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.AddComponent(/datum/component/butchering, 60, 110)

//outdated nanotransen prototype of the crusher. Incredibly heavy, but the blade was made at a premium. //to alter this I had to duplicate some code, big moment.
/obj/item/kinetic_crusher/old
	icon_state = "crusherold"
	item_state = "crusherold0"
	name = "proto-kinetic crusher"
	desc = "During the early design process of the Kinetic Accelerator, a great deal of money and time was invested in magnetic distruption technology. \
	Though eventually replaced with concussive blasts, the ever-practical NT designed a second mining tool. \
	Only a few were ever produced, mostly for NT research institutions, and they are a valulable relic in the postwar age."
	slowdown = 0.5//hevy
	attack_verb = list("mashed", "flattened", "bisected", "eradicated","destroyed")

/obj/item/kinetic_crusher/old/examine(mob/user)
	. = ..()
	. += "<span class='notice'>This hunk of junk's so heavy that you can barely swing it! Though, that blade looks pretty sharp...</span>"

/obj/item/kinetic_crusher/old/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110)
	AddComponent(/datum/component/two_handed, force_unwielded=0, force_wielded=45)//big choppa!

/obj/item/kinetic_crusher/old/melee_attack_chain(mob/user, atom/target, params)
	..()
	user.changeNext_move(CLICK_CD_MELEE * 2.0)//...slow swinga.

/obj/item/kinetic_crusher/old/update_icon_state()
	item_state = "crusherold[wielded]" // still not supported by 2hcomponent

//100% original syndicate oc, plz do not steal. More effective against human targets then the typical crusher, with a bit of block chance.
/obj/item/syndie_crusher
	icon = 'icons/obj/mining.dmi'
	icon_state = "crushersyndie"
	item_state = "crushersyndie0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "magnetic cleaver"
	desc = "Designed by Syndicate Research and Development for their resource-gathering operations on hostile worlds. Syndicate Legal Ops would like to stress that you've never seen anything like this before. Ever."
	armour_penetration = 69//nice cut
	force = 0 //You can't hit stuff unless wielded
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	block_chance = 30
	custom_materials = list(/datum/material/titanium=5000, /datum/material/iron=2075)
	hitsound = 'sound/weapons/blade1.ogg'
	attack_verb = list("sliced", "bisected", "diced", "chopped", "filleted")
	sharpness = IS_SHARP
	obj_flags = UNIQUE_RENAME
	light_color = "#fb6767"
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	custom_price = 7500//a rare syndicate prototype.
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 15
	var/detonation_damage = 10
	var/backstab_bonus = 30
	var/wielded = FALSE // track wielded status on item

/obj/item/syndie_crusher/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
	set_light_on(wielded)
	START_PROCESSING(SSobj, src)

/obj/item/syndie_crusher/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 150)
	AddComponent(/datum/component/two_handed, force_unwielded=0, force_wielded=35)

/obj/item/syndie_crusher/Destroy()
	QDEL_LIST(trophies)
	STOP_PROCESSING(SSobj, src)
	return ..()

/// triggered on wield of two handed item
/obj/item/syndie_crusher/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	icon_state = "crushersyndie1"
	playsound(user, 'sound/weapons/saberon.ogg', 35, TRUE)
	set_light_on(wielded)

/// triggered on unwield of two handed item
/obj/item/syndie_crusher/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE
	icon_state = "crushersyndie"
	playsound(user, 'sound/weapons/saberoff.ogg', 35, TRUE)
	set_light_on(wielded)

/obj/item/syndie_crusher/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Induce magnetism in an enemy by striking them with a magnetospheric wave, then hit them in melee to force a waveform collapse for <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"

/obj/item/syndie_crusher/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(trophies))
			to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/syndie_crusher/attack(mob/living/target, mob/living/carbon/user)
	if(!wielded)
		to_chat(user, "<span class='warning'>[src] is too heavy to use with one hand! You fumble and drop everything.</span>")
		user.drop_all_held_items()
		return
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/syndie_crusher/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(!wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/D = new /obj/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, TRUE)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, TRUE) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

/obj/item/syndie_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)

/obj/item/syndie_crusher/ui_action_click(mob/user, actiontype)
	set_light_on(!light_on)
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_icon()

/obj/item/syndie_crusher/update_icon_state()
	item_state = "crushersyndie[wielded]" // this is not icon_state and not supported by 2hcomponent

/obj/item/syndie_crusher/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(wielded)
		. += "[icon_state]_lit"
