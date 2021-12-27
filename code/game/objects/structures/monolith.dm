/obj/structure/spawner/monolith
	name = "monolith"
	desc = "A strange, perfect rectanular structure. It's somehow bringing monsters out of itself."

	icon = 'icons/mob/nest.dmi'
	icon_state = "monolith"

	faction = list("mining")
	max_mobs = 3
	max_integrity = 800
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten)

	move_resist = INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF

	var/gps = null
	var/obj/effect/light_emitter/blue_energy_sword/emitted_light


/obj/structure/spawner/monolith/attackby(obj/item/I, mob/living/user)
	. = ..()
	if(I.force)
		update_icon()
	return ..()

/obj/structure/spawner/monolith/bullet_act(obj/projectile/P)
	. = ..()
	update_icon()

/obj/structure/spawner/monolith/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
			else
				playsound(src.loc, 'sound/effects/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/spawner/monolith/update_icon()
	. = ..()
	if(obj_integrity >= max_integrity*0.75)
		icon_state = "monolith"
	else if(obj_integrity >= max_integrity*0.50)
		icon_state = "monolith-25"
	else if(obj_integrity >= max_integrity*0.25)
		icon_state = "monolith-50"
	else
		icon_state = "monolith-75"

/obj/structure/spawner/monolith/goliath
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal/monolith)

/obj/structure/spawner/monolith/legion
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal/monolith)

/obj/structure/spawner/monolith/watcher
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten/monolith)

/obj/structure/spawner/monolith/Initialize()
	. = ..()
	emitted_light = new(loc)
	for(var/F in RANGE_TURFS(1, src))
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)
	AddComponent(/datum/component/gps, "Resonating Signal")

/obj/structure/spawner/monolith/deconstruct(disassembled)
	new /obj/effect/collapse_monolith(loc)
	new /obj/structure/closet/crate/ancientpot/loot(loc)
//	new /obj/structure/closet/crate/ancientcrate/loot(loc) ~~TODO: implment this, and give it a high tech pot spirte~~ add this for ancient ruins though
	return ..()


/obj/structure/spawner/monolith/Destroy()
	QDEL_NULL(emitted_light)
	QDEL_NULL(gps)
	return ..()

/obj/effect/collapse_monolith
	name = "shattering monolith"
	desc = "It's about to break!!"
	layer = TABLE_LAYER
	icon = 'icons/mob/nest.dmi'
	icon_state = "monolith-75"
	anchored = TRUE
	density = TRUE
	var/obj/effect/light_emitter/blue_energy_sword/emitted_light

/obj/effect/collapse_monolith/Initialize()
	. = ..()
	emitted_light = new(loc)
	visible_message("<span class='boldannounce'>The [src] shatters violently and starts to fall apart! Run away!</span>")
	visible_message("<span class='warning'>Something is grabbed from [pick("yellowspace","bluespace","redspace","somewhere from the depths of reality")]!</span>")
	playsound(loc,"shatter", 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, .proc/collapse), 50)

/obj/effect/collapse_monolith/Destroy()
	QDEL_NULL(emitted_light)
	return ..()

/obj/effect/collapse_monolith/proc/collapse()
	playsound(get_turf(src),'sound/effects/supermatter.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>The [src] shatters into strange crystaly liquid, not unlike a supermatter!</span>")
	for(var/turf/T in range(2,src))
		if(!T.density)
			T.TerraformTurf(/turf/open/indestructible/supermatter_cascade/stationary, /turf/open/indestructible/supermatter_cascade/stationary, flags = CHANGETURF_INHERIT_AIR) //if chasms werent deadly enough
	qdel(src)

/obj/structure/closet/crate/ancientpot
	name = "ancient pot"
	desc = "A ancient pot belonging to a ancient civilization. The markings show a being with no legs, and a weird looking crysal above. It's impossible to reach inside, you're going to have to break this."
	icon_state = "ancientpot"
	locked = TRUE

/obj/structure/closet/crate/ancientpot/open(mob/living/user)
	. = ..()
	if(user)
		to_chat(user, "<span class='danger'>You can't reach in the [src]!</span>")

/obj/structure/closet/crate/ancientpot/close(mob/living/user)
	if(user)
		to_chat(user, "<span class='danger'>The [src] is all broken!</span>")

/obj/structure/closet/crate/ancientpot/loot/PopulateContents()
	. = ..()
	new /obj/effect/spawner/lootdrop/ancientpot(src)

/obj/effect/spawner/lootdrop/ancientpot
	loot = list(/obj/item/strange_crystal = 20,
				/obj/item/coin/plasma = 10,
				/obj/item/coin/diamond = 10,
				/obj/item/gun/energy/e_gun/ancient_revolver = 10,
				/obj/item/gun/energy/decloner = 10,
				/obj/item/construction/rcd/combat = 10,
				/obj/item/clothing/suit/space/hardsuit/syndi = 10, //todo, make a non-syndi version
//				/obj/item/clothing/suit/space/hardsuit/ancient = 10, // TODO: make a sprite for this and give it busted stats, but make it unable to be put on by anyone so it disapoints everyone
				/obj/item/dnainjector/lasereyesmut = 10)
//TODO: Make another table but for more busted things
