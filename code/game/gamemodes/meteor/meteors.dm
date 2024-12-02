#define DEFAULT_METEOR_LIFETIME 1800
GLOBAL_VAR_INIT(meteor_wave_delay, 625) //minimum wait between waves in tenths of seconds
//set to at least 100 unless you want evarr ruining every round

//Meteors probability of spawning during a given wave
GLOBAL_LIST_INIT(meteors_normal, list(
	/obj/effect/meteor/dust=3,
	/obj/effect/meteor/medium=8,
	/obj/effect/meteor/big=3,
	/obj/effect/meteor/flaming=1,
	/obj/effect/meteor/irradiated=3
)) //for normal meteor event

GLOBAL_LIST_INIT(meteors_threatening, list(
	/obj/effect/meteor/medium=4,
	/obj/effect/meteor/big=8,
	/obj/effect/meteor/flaming=3,
	/obj/effect/meteor/irradiated=3
)) //for threatening meteor event

GLOBAL_LIST_INIT(meteors_catastrophic, list(
	/obj/effect/meteor/medium=5,
	/obj/effect/meteor/big=75,
	/obj/effect/meteor/flaming=10,
	/obj/effect/meteor/irradiated=10,
	/obj/effect/meteor/tunguska = 1
)) //for catastrophic meteor event

GLOBAL_LIST_INIT(meteorsB, list(/obj/effect/meteor/meaty=5, /obj/effect/meteor/meaty/xeno=1)) //for meaty ore event

GLOBAL_LIST_INIT(meteorsC, list(/obj/effect/meteor/dust)) //for space dust event


///////////////////////////////
//Meteor spawning global procs
///////////////////////////////

/proc/spawn_meteors(number = 10, list/meteortypes)
	for(var/i = 0; i < number; i++)
		spawn_meteor(meteortypes)

/proc/spawn_meteor(list/meteortypes, datum/virtual_level/vlevel, padding = MAP_EDGE_PAD, obj/docking_port/mobile/shuttle_port, speed)
	var/turf/pickedstart
	var/turf/pickedgoal
	var/max_i = 10//number of tries to spawn meteor.
	while(!isspaceturf(pickedstart))
		var/startSide = pick(GLOB.cardinals)
		if(shuttle_port)
			startSide = shuttle_port.preferred_direction

		pickedstart = vlevel.get_side_turf(startSide, padding)
		pickedgoal = vlevel.get_side_turf(REVERSE_DIR(startSide), padding, TRUE)
		max_i--
		if(max_i<=0)
			return
	var/Me = pick_weight(meteortypes)
	var/obj/effect/meteor/M = new Me(pickedstart, pickedgoal)
	M.hitpwr = speed
	M.dest = pickedgoal

///////////////////////
//The meteor effect
//////////////////////

//TODO: Fucking rewrite this from scratch this is not only unsalvagable but needs to be recoded from scratch

/obj/effect/meteor
	name = "\proper small meteor"
	desc = "You should probably run instead of gawking at this."
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small"
	density = TRUE
	anchored = TRUE
	var/hits = 4
	var/hitpwr = 2 //mutiplied by 10 is the damage we do to things we hit. added to depending on the velocity in Gm/s
	var/dest
	pass_flags = PASSTABLE
	var/heavy = TRUE
	var/meteorsound = 'sound/effects/meteorimpact.ogg'
	var/z_original
	var/threat = 0 // used for determining which meteors are most interesting
	var/lifetime = DEFAULT_METEOR_LIFETIME
	var/timerid = null
	var/list/meteordrop = list(/obj/item/stack/ore/hematite)
	var/dropamt = 2
	var/damage_mutiplier = 1

/obj/effect/meteor/Move()
	if(get_virtual_level() != z_original || loc == dest)
		qdel(src)
		return FALSE

	. = ..() //process movement...

	var/turf/T = get_turf(loc)
	if(. && hitpwr > 0)//.. if did move, ram the turf we get in
		ram_turf(T)

	if(!isspaceturf(T))//randomly takes a 'hit' from ramming
		get_hit()


/obj/effect/meteor/Destroy()
	if (timerid)
		deltimer(timerid)
	GLOB.meteor_list -= src
	SSaugury.unregister_doom(src)
	walk(src,0) //this cancels the walk_towards() proc
	. = ..()

/obj/effect/meteor/Initialize(mapload, target)
	. = ..()
	z_original = get_virtual_level()
	GLOB.meteor_list += src
	SSaugury.register_doom(src, threat)
	SpinAnimation()
	timerid = QDEL_IN(src, lifetime)
	chase_target(target)

/obj/effect/meteor/Bump(atom/A)
	if(A)
		ram_turf(get_turf(A))
		get_hit()

/obj/effect/meteor/proc/ram_turf(turf/turf_to_ram)
	//first bust whatever is in the turf
	var/list/hitlist
	hitlist += turf_to_ram.contents
	hitlist += turf_to_ram
	for(var/atom/atom_to_ram in hitlist)
		if(!istype(atom_to_ram))
			continue
		var/turf/closed/turf_closed = atom_to_ram
		if(istype(turf_closed))
			turf_closed.alter_integrity(damage_mutiplier*-10*hitpwr)
			if(get_hit())
				return
		var/obj/object = atom_to_ram
		if(istype(object))
			object.take_damage(damage_mutiplier*10*hitpwr, damage_flag = "bomb")
			if(get_hit())
				return
		var/mob/living/mob_to_ram = atom_to_ram
		if(istype(mob_to_ram))
			mob_to_ram.visible_message("<span class='warning'>[src] slams into [mob_to_ram].</span>", "<span class='userdanger'>[src] slams into you!.</span>")
			mob_to_ram.take_overall_damage(damage_mutiplier*20*hitpwr)

			var/throw_target = get_edge_target_turf(mob_to_ram, get_dir(mob_to_ram, get_step_away(mob_to_ram, mob_to_ram)))
			mob_to_ram.throw_at(throw_target, 200, 4)
			mob_to_ram.Knockdown(5 SECONDS)


//process getting 'hit' by colliding with a dense object
//or randomly when ramming turfs
/obj/effect/meteor/proc/get_hit()
	hits--
	if(hits <= 0)
		make_debris()
		meteor_effect()
		qdel(src)
		return TRUE
	return FALSE

/obj/effect/meteor/ex_act()
	return

/obj/effect/meteor/examine(mob/user)
	. = ..()
	if(!(flags_1 & ADMIN_SPAWNED_1) && isliving(user))
		user.client.give_award(/datum/award/achievement/misc/meteor_examine, user)

/obj/effect/meteor/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_MINING)
		make_debris()
		qdel(src)
	else
		. = ..()

/obj/effect/meteor/proc/make_debris()
	if(isspaceturf(get_turf(src))) //don't clog up transit levels with shit
		return
	for(var/throws = dropamt, throws > 0, throws--)
		var/thing_to_spawn = pick(meteordrop)
		new thing_to_spawn(get_turf(src))

/obj/effect/meteor/proc/chase_target(atom/chasing, delay = 1)
	set waitfor = FALSE
	if(chasing)
		walk_towards(src, chasing, delay)

/obj/effect/meteor/proc/meteor_effect()
	var/sound/meteor_sound = meteorsound
	var/random_frequency = get_rand_frequency()
	var/do_shake_cam = FALSE

	switch(hitpwr)
		if(-2 to 1)
			meteor_sound = sound(meteorsound)
		if(1 to 2)
			meteor_sound = meteorsound
		if(2 to INFINITY)
			do_shake_cam = TRUE

	if(heavy)
		for(var/mob/M in GLOB.player_list)
			if((M.orbiting) && (SSaugury.watchers[M]))
				continue
			var/turf/T = get_turf(M)
			if(!T || T.virtual_z() != src.virtual_z())
				continue
			var/dist = get_dist(M.loc, src.loc)
			if(do_shake_cam)
				shake_camera(M, dist > 20 ? 1 : 2, dist > 20 ? 1 : 2)
			M.playsound_local(src.loc, null, 50, 1, random_frequency, 10, S = meteor_sound)

///////////////////////
//Meteor types
///////////////////////

//Dust
/obj/effect/meteor/dust
	name = "space dust"
	icon_state = "dust"
	pass_flags = PASSTABLE | PASSGRILLE
	hits = 1
	hitpwr = 3
	heavy = FALSE
	meteorsound = 'sound/weapons/gun/smg/shot.ogg'
	meteordrop = list(/obj/item/stack/ore/glass)
	threat = 1
	damage_mutiplier = 0.1

//Medium-sized
/obj/effect/meteor/medium
	name = "meteor"
	dropamt = 3
	threat = 5

/obj/effect/meteor/medium/meteor_effect()
	..()
	if(hitpwr > 2)
		explosion(src, 0, 1, 2, 3, 0)




//Large-sized
/obj/effect/meteor/big
	name = "big meteor"
	icon_state = "large"
	hits = 6
	heavy = 1
	dropamt = 4
	threat = 10

/obj/effect/meteor/big/meteor_effect()
	..()
	if(hitpwr > 2)
		explosion(src, 1, 2, 3, 4, 0)


//Flaming meteor
/obj/effect/meteor/flaming
	name = "flaming meteor"
	icon_state = "flaming"
	hits = 5
	heavy = 1
	meteorsound = 'sound/effects/overmap/solar_flare.ogg'
	meteordrop = list(/obj/item/stack/ore/sulfur)
	threat = 20

/obj/effect/meteor/flaming/meteor_effect()
	..()
	if(hitpwr > 2)
		flame_radius(get_turf(src), 5)

//Radiation meteor
/obj/effect/meteor/irradiated
	name = "glowing meteor"
	icon_state = "glowing"
	heavy = 1
	meteordrop = list(/obj/item/stack/ore/autunite)
	threat = 15


/obj/effect/meteor/irradiated/meteor_effect()
	..()
	if(hitpwr > 2)
		explosion(src.loc, 0, 0, 4, 3, 0)
	new /obj/effect/decal/cleanable/greenglow(get_turf(src))
	radiation_pulse(src, 200)

//Meaty Ore
/obj/effect/meteor/meaty
	name = "meaty ore"
	icon_state = "meateor"
	desc = "Just... don't think too hard about where this thing came from."
	hits = 2
	heavy = 1
	meteorsound = 'sound/effects/blobattack.ogg'
	meteordrop = list(/obj/item/reagent_containers/food/snacks/meat/slab/human, /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant, /obj/item/organ/heart, /obj/item/organ/lungs, /obj/item/organ/tongue, /obj/item/organ/appendix/)
	var/meteorgibs = /obj/effect/gibspawner/generic
	threat = 2

/obj/effect/meteor/meaty/Initialize()
	for(var/path in meteordrop)
		if(path == /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant)
			meteordrop -= path
			meteordrop += pick(subtypesof(path))

	for(var/path in meteordrop)
		if(path == /obj/item/organ/tongue)
			meteordrop -= path
			meteordrop += pick(typesof(path))
	return ..()

/obj/effect/meteor/meaty/make_debris()
	..()
	new meteorgibs(get_turf(src))


/obj/effect/meteor/meaty/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood(T)

/obj/effect/meteor/meaty/Bump(atom/A)
	A.ex_act(hitpwr)
	get_hit()

//Meaty Ore Xeno edition
/obj/effect/meteor/meaty/xeno
	color = "#5EFF00"
	meteordrop = list(/obj/item/reagent_containers/food/snacks/meat/slab/xeno, /obj/item/organ/tongue/alien)
	meteorgibs = /obj/effect/gibspawner/xeno

/obj/effect/meteor/meaty/xeno/Initialize()
	meteordrop += subtypesof(/obj/item/organ/alien)
	return ..()

/obj/effect/meteor/meaty/xeno/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/xenoblood(T)

//Station buster Tunguska
/obj/effect/meteor/tunguska
	name = "tunguska meteor"
	icon_state = "flaming"
	desc = "Your life briefly passes before your eyes the moment you lay them on this monstrosity."
	hits = 30
	hitpwr = 1
	heavy = 1
	meteorsound = 'sound/effects/bamf.ogg'
	meteordrop = list(/obj/item/stack/ore/plasma)
	threat = 50

/obj/effect/meteor/tunguska/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/revenant(get_turf(src))

/obj/effect/meteor/tunguska/meteor_effect()
	..()
	if(hitpwr > 2)
		explosion(src.loc, 5, 10, 15, 20, 0)

/obj/effect/meteor/tunguska/Bump()
	..()
	if(hitpwr > 2)
		explosion(src.loc,2,4,6,8)

/obj/effect/meteor/carp
	name = "high velocity space carp"
	desc = "What the devil?"
	icon_state = "carp"
	hits = 1
	hitpwr = 0
	pass_flags = PASSTABLE
	meteorsound = 'sound/effects/blobattack.ogg'
	meteordrop = list(/mob/living/simple_animal/hostile/carp)
	dropamt = 1

/obj/effect/meteor/carp/big
	name = "high velocity space carp"
	desc = "What the devil?"
	icon = 'icons/mob/broadMobs.dmi'
	icon_state = "megacarp"
	hits = 1
	hitpwr = 1
	pass_flags = PASSTABLE
	meteordrop = list(/mob/living/simple_animal/hostile/carp/megacarp)
	dropamt = 1


//////////////////////////
//Spookoween meteors
/////////////////////////

GLOBAL_LIST_INIT(meteorsSPOOKY, list(/obj/effect/meteor/pumpkin))

/obj/effect/meteor/pumpkin
	name = "PUMPKING"
	desc = "THE PUMPKING'S COMING!"
	icon = 'icons/obj/meteor_spooky.dmi'
	icon_state = "pumpkin"
	hits = 10
	heavy = 1
	dropamt = 1
	meteordrop = list(/obj/item/clothing/head/hardhat/pumpkinhead, /obj/item/reagent_containers/food/snacks/grown/pumpkin)
	threat = 100

/obj/effect/meteor/pumpkin/Initialize()
	. = ..()
	meteorsound = pick('sound/hallucinations/im_here1.ogg','sound/hallucinations/im_here2.ogg')
//////////////////////////
#undef DEFAULT_METEOR_LIFETIME
