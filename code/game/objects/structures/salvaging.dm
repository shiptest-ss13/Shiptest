/obj/structure/salvageable
	name = "broken machinery"
	desc = "It's broken beyond repair. You may be able to salvage something from this."
	icon = 'icons/obj/salvage_structure.dmi'
	density = TRUE
	anchored = TRUE
	var/salvageable_parts = list()
	var/frame_type = /obj/structure/frame/machine

/obj/structure/salvageable/examine(mob/user)
	. = ..()
	. += "You can use a crowbar to salvage this."

/obj/structure/salvageable/proc/dismantle(mob/living/user)
	var/obj/frame = new frame_type(get_turf(src))
	frame.anchored = anchored
	frame.dir = dir
	for(var/path in salvageable_parts)
		if(prob(salvageable_parts[path]))
			new path (loc)

/obj/structure/salvageable/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		return FALSE
	user.visible_message(span_notice("[user] starts dismantling [src]."), \
					span_notice("You start salvaging anything useful from [src]..."))
	tool.play_tool_sound(src, 100)
	if(do_after(user, 8 SECONDS, target = src))
		user.visible_message(span_notice("[user] dismantles [src]."), \
						span_notice("You salvage [src]."))
		dismantle(user)
		tool.play_tool_sound(src, 100)
		qdel(src)
	return TRUE

/obj/structure/salvageable/deconstruct_act(mob/living/user, obj/item/tool)
	. = ..()
	if(.)
		return FALSE
	user.visible_message(span_notice("[user] starts slicing [src]."), \
					span_notice("You start salvaging anything useful from [src]..."))
	if(tool.use_tool(src, user, 6 SECONDS))
		user.visible_message(span_notice("[user] dismantles [src]."), \
						span_notice("You salvage [src]."))
		dismantle(user)
		qdel(src)
	return TRUE

// GENERIC MACHINE //
// Contains stock parts and some mats. Nothing too fancy, this is the "common" one
/obj/structure/salvageable/machine
	name = "broken machine"
	desc = "An unrecognizable hunk of destroyed machinery. Despite the damage, there may be something worthwhile within..."
	icon_state = "wreck_pda"
	salvageable_parts = list(
		// material components
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/sheet/glass = 50,
		/obj/item/stack/ore/salvage/scrapgold/five = 60,
		/obj/item/stack/ore/salvage/scrapgold = 50,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal = 20,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/cable_coil/cut = 80,

		// stock parts
		/obj/effect/spawner/random/salvage/part/capacitor = 40,
		/obj/effect/spawner/random/salvage/part/capacitor = 40,
		/obj/effect/spawner/random/salvage/part/scanning = 40,
		/obj/effect/spawner/random/salvage/part/scanning = 40,
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/manipulator = 40,
		/obj/effect/spawner/random/salvage/part/manipulator = 40,
		/obj/effect/spawner/random/salvage/part/laser = 40,
		/obj/effect/spawner/random/salvage/part/laser = 40)

// GENERIC COMPUTER //
// the main thing is computer boards here. some modcomp parts for flavor
/obj/structure/salvageable/computer
	name = "broken computer"
	desc = "The remnants of a particularly unlucky computer. If you're lucky, there may still be working parts inside."
	icon_state = "computer_broken"
	frame_type = /obj/structure/frame/computer/retro
	salvageable_parts = list(
		// material components
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/ore/salvage/scrapsilver/five = 90,
		/obj/item/stack/ore/salvage/scrapgold/five = 60,
		/obj/item/stack/ore/salvage/scrapgold/ = 20,
		/obj/item/stack/ore/salvage/scrapgold/ = 20,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/ = 20,
		/obj/item/stack/ore/salvage/scrapmetal/ = 20,
		/obj/item/stack/cable_coil/cut = 60,
		/obj/item/stack/cable_coil/cut = 60,

		// other fluff parts
		/obj/effect/spawner/random/salvage/part/capacitor = 60,
		/obj/item/gpu = 1,

		// modcomp parts
		/obj/effect/spawner/random/salvage/part/modcomp/three = 80,
		/obj/effect/spawner/random/salvage/part/modcomp = 20,
		/obj/effect/spawner/random/salvage/part/modcomp = 20,

		// and the main attraction, our circuit board
		/obj/effect/spawner/random/circuit/computer/mixed = 75
	)

// AUTOLATHE
// contains a decent amount of mats and some lathe garbage
/obj/structure/salvageable/autolathe
	name = "broken autolathe"
	desc = "Older models of autolathe were notorious for suffering mechanical failures. Oftentimes, it was cheaper and easier to just buy another than try to fix it. Maybe there's something of worth still jammed inside?"
	icon_state = "wreck_autolathe"
	salvageable_parts = list(
		// materials for the "frame"
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scraptitanium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,

		// stuff used to build autolathes
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,
		/obj/item/circuitboard/machine/autolathe = 35,

		// lathe junk - what was jammed inside?
		/obj/effect/spawner/random/salvage/autolathe_junk = 80,
		/obj/effect/spawner/random/salvage/autolathe_junk = 30,
		/obj/effect/spawner/random/salvage/autolathe_junk = 10,

		// lathe reserves (more substantial mats)
		/obj/item/stack/sheet/metal/five = 10,
		/obj/item/stack/sheet/metal/five = 10,
		/obj/item/stack/sheet/glass/five = 10,
		/obj/item/stack/sheet/glass/five = 10,
		/obj/item/stack/sheet/plastic/five = 10,
		/obj/item/stack/sheet/plasteel/five = 10,
		/obj/item/stack/sheet/mineral/silver/five = 10,
		/obj/item/stack/sheet/mineral/gold/five = 10,
		/obj/item/stack/sheet/mineral/plasma/five = 10,
		/obj/item/stack/sheet/mineral/uranium/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1)

/obj/structure/salvageable/protolathe
	name = "broken assembler"
	desc = "A high-end fabrication machine for producing specialized components. Or, at least it used to be. You may be able to find something of worth within the wreckage."
	icon_state = "wreck_protolathe"
	salvageable_parts = list(
		// materials
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapplasma/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,

		// stock parts
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,

		// protolathe loot pool spawns
		/obj/effect/spawner/random/medical/surgery_tool = 55,
		/obj/effect/spawner/random/engineering/tool = 45,
		/obj/effect/spawner/random/medical/beaker = 45,
		/obj/effect/spawner/random/medical/chem_jug = 30,
		/obj/effect/spawner/random/medical/prosthetic = 25,
		/obj/effect/spawner/random/salvage/prolathe/gun = 5, //:flushed:
		/obj/effect/spawner/random/salvage/prolathe/ammo = 10,

		// part replacers
		/obj/item/storage/part_replacer = 20,
		/obj/item/storage/part_replacer/bluespace = 1,

		// mop meme
		/obj/item/mop/advanced = 1, // the holy grail

		// material reserves
		/obj/item/stack/sheet/metal/five = 15,
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/plastic/five = 15,
		/obj/item/stack/sheet/plasteel/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/mineral/plasma/five = 10,
		/obj/item/stack/sheet/mineral/uranium/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1,
	)

/obj/structure/salvageable/circuit_imprinter
	name = "broken circuit imprinter"
	desc = "A machine that, at one point, was able to engrave circuit boards. Maybe you can find a few boards inside that aren't broken."
	icon_state = "wreck_circuit_imprinter"
	salvageable_parts = list(
		// materials
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		// stock parts
		/obj/effect/spawner/random/salvage/part/matter_bin = 40,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,

		// circuit pools
		/obj/item/stack/circuit_stack = 50,
		/obj/effect/spawner/random/circuit/machine/mech = 45,
		/obj/effect/spawner/random/circuit/machine/mixed = 60,
		/obj/effect/spawner/random/circuit/machine/mixed = 60,

		// material reserves
		/obj/item/stack/sheet/metal/five = 15,
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/bluespace_crystal/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1,
	)

/obj/structure/salvageable/destructive_analyzer
	name = "broken destructive analyzer"
	desc = "A hefty sample analysis machine containing very strong laser emitter. If this thing could power up, it would probably slice you in half. There could be something inside that's worth the risk..." //this ones pretty dangerous
	icon_state = "wreck_d_analyzer"
	salvageable_parts = list(
		// materials
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapplasma = 60,

		// stock parts
		/obj/effect/spawner/random/salvage/part/scanning = 40,
		/obj/effect/spawner/random/salvage/part/laser = 30,
		/obj/effect/spawner/random/salvage/part/manipulator = 30,

		// special destructive analyzer pool
		/obj/effect/spawner/random/salvage/analyzer = 65,

		// material reserves
		/obj/item/stack/sheet/metal/five = 15,
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/bluespace_crystal/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1,
	)

/obj/structure/salvageable/destructive_analyzer/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level) //scary.
		if(1 to 40)
			audible_message(span_notice("You can hear the sound of broken glass in the [src]."))
		if(41 to 60)
			visible_message(span_danger("You flinch as the [src]'s laser apparatus lights up, but your tool destroys it before it activates..."))
		if(61 to 79)
			visible_message(span_danger("You see a dim light from the [src] before the laser reactivates in your face!"))
			shoot_projectile(user, /obj/projectile/beam/scatter)
		if(80 to 89)
			visible_message(span_danger("You see a bright light from the [src] before the laser reactivates in your face!"))
			shoot_projectile(user, /obj/projectile/beam)
		if(90 to 100)
			visible_message(span_danger("You see an intense light from the [src] before the laser reactivates in your face!"))
			shoot_projectile(user, /obj/projectile/beam/laser/heavylaser) //i'd like to make this flash people. but i'm not sure how to do that. shame!

/obj/structure/salvageable/destructive_analyzer/proc/shoot_projectile(mob/living/target, obj/projectile/projectile_to_shoot)
	var/obj/projectile/projectile_being_shot = new projectile_to_shoot(get_turf(src))
	projectile_being_shot.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	projectile_being_shot.firer = src
	projectile_being_shot.fire(Get_Angle(src,target))

/obj/structure/salvageable/server
	name = "broken server"
	desc = "A nearly-destroyed server rack. Maybe there is still usable hardware inside?"
	icon_state = "wreck_server"
	salvageable_parts = list(
		// materials
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		// disks (for fluff)
		/obj/item/disk/tech_disk = 20,
		/obj/item/disk/data = 20,
		/obj/item/disk/holodisk = 20,
		/obj/item/disk/plantgene = 20,

		// computer parts
		/obj/effect/spawner/random/salvage/part/modcomp/three = 60,
		/obj/effect/spawner/random/salvage/part/modcomp/three = 60,
		/obj/item/gpu = 5,

		// telecomms parts
		/obj/effect/spawner/random/salvage/part/tcomms/three = 60,
		/obj/effect/spawner/random/salvage/part/tcomms/three = 60)

/obj/structure/salvageable/server/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level) //ever wanted the extreme danger of turn based rng but in space station 13?
		if(1 to 45)
			audible_message(span_notice("The [src] makes a crashing sound as its salvaged."))

		if(46 to 89)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message(span_danger("You hear a buzz from the [src] and a voice,"))
			new /mob/living/simple_animal/bot/medbot/rockplanet(get_turf(src))

		if(95 to 100)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message(span_danger("You hear a buzz from the [src] and a voice,"))

			new /mob/living/simple_animal/bot/firebot/rockplanet(get_turf(src))

		if(90 to 94)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message(span_danger("You hear as buzz from the [src] as an abandoned security bot rolls out from the [src]!!"))

			new /mob/living/simple_animal/bot/secbot/ed209/rockplanet(get_turf(src))

/obj/structure/salvageable/safe_server //i am evil and horrible and i don't deserve to touch code
	name = "broken server"
	desc = "A nearly-destroyed server rack. Maybe there is still usable hardware inside?"
	icon_state = "wreck_server"
	salvageable_parts = list(
		// materials
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		// disks
		/obj/item/disk/tech_disk = 20,
		/obj/item/disk/data = 20,
		/obj/item/disk/holodisk = 20,
		/obj/item/disk/plantgene = 20,

		// computer parts
		/obj/effect/spawner/random/salvage/part/modcomp/three = 60,
		/obj/effect/spawner/random/salvage/part/modcomp/three = 60,
		/obj/item/gpu = 5,

		// telecomms parts
		/obj/effect/spawner/random/salvage/part/tcomms/three = 60,
		/obj/effect/spawner/random/salvage/part/tcomms/three = 60)

/obj/structure/salvageable/seed
	name = "ruined seed vendor"
	desc = "This is where the seeds lived. Maybe you can still get some?"//megaseed voiceline reference
	icon_state = "seeds-broken"
	icon = 'icons/obj/vending.dmi'
	color = "#808080"

	salvageable_parts = list(
		/obj/effect/spawner/random/food_or_drink/seed = 80,
		/obj/effect/spawner/random/food_or_drink/seed = 80,
		/obj/effect/spawner/random/food_or_drink/seed = 80,
		/obj/effect/spawner/random/food_or_drink/seed = 80,
		/obj/effect/spawner/random/food_or_drink/seed = 80,
		/obj/item/seeds/random = 80,
		/obj/item/seeds/random = 40,
		/obj/item/seeds/random = 40,
		/obj/item/stack/ore/salvage/scrapmetal/five = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/disk/plantgene = 20,
	)

/obj/structure/salvageable/seed/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level)
		if(1 to 50)
			audible_message(span_notice("The [src] buzzes softly as it falls apart."))

		if(51 to 80)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message(span_danger("As the [src] collapses, an oversized tomato lunges out from inside!"))
			new /mob/living/simple_animal/hostile/killertomato(get_turf(src))

		if(81 to 100)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message(span_danger("A bundle of vines unfurls from inside the [src]!"))
			new /mob/living/simple_animal/hostile/venus_human_trap(get_turf(src))

/obj/structure/salvageable/kitchenvend
	name = "broken-down kitchen vendor"
	desc = "A ruined kitchen vending machine. Some of its contents might still be intact."
	icon_state = "dinnerware-broken"
	icon = 'icons/obj/vending.dmi'
	salvageable_parts = list(
		/obj/item/kitchen/rollingpin = 80,
		/obj/item/reagent_containers/glass/bowl = 80,
		/obj/item/kitchen/fork = 40,
		/obj/item/shard = 80,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 80,
		/obj/item/plate/small = 80,
		/obj/item/plate/large = 40,
		/obj/item/clothing/suit/apron/chef = 40,
		/obj/item/stack/ore/salvage/scrapmetal/five = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 20,
		/obj/item/melee/knife/kitchen = 10,
	)

/obj/structure/salvageable/turret
	name = "destroyed turret"
	desc = "A long-deserviced automated twin-barrel ballistic turret. Layers of dust coat its cracked lens. Some of its parts might still be useful."
	icon_state = "syndie_broken"
	icon = 'icons/obj/turrets.dmi'
	salvageable_parts = list(
		/obj/item/shard = 80,
		/obj/item/ammo_casing/spent/rifle_steel = 80,
		/obj/item/ammo_casing/spent/rifle_steel = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapgold/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapplasma = 60,
		/obj/item/stack/ore/salvage/scrapuranium = 60,
		/obj/item/circuitboard/machine/turret = 55,
		/obj/effect/spawner/random/salvage/part/scanning = 50,
		/obj/effect/spawner/random/salvage/part/scanning = 50,
		/obj/item/weaponcrafting/receiver = 40,
		/obj/effect/spawner/random/salvage/part/laser = 40,
		/obj/item/storage/toolbox/ammo = 40,
	)

//scrap item, mostly for fluff
/obj/item/stack/ore/salvage
	name = "salvage"
	icon = 'icons/obj/salvage_structure.dmi'
	icon_state = "smetal"
	refined_type = null

/obj/item/stack/ore/salvage/examine(mob/user)
	. = ..()
	. += "You could probably reclaim this in an autolathe, Ore Redemption Machine, or smelter."

/obj/item/stack/ore/salvage/scrapmetal
	name = "scrap metal"
	desc = "A collection of metal parts and pieces."
	points = 1
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapmetal/five
	amount = 5

/obj/item/stack/ore/salvage/scrapmetal/ten
	amount = 10

/obj/item/stack/ore/salvage/scrapmetal/twenty
	amount = 20

/obj/item/stack/ore/salvage/scraptitanium
	name = "scrap titanium"
	desc = "Lightweight, rust-resistant parts and pieces from high-performance equipment."
	icon_state = "stitanium"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scraptitanium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapsilver
	name = "worn crt"
	desc = "An old CRT display with the letters 'STANDBY' burnt into the screen."
	icon_state = "ssilver"
	points = 16
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapsilver/five
	amount = 5

/obj/item/stack/ore/salvage/scrapgold
	name = "scrap electronics"
	desc = "Various bits of electrical components."
	icon_state = "sgold"
	points = 18
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapgold/five
	amount = 5

/obj/item/stack/ore/salvage/scrapplasma
	name = "junk plasma cell"
	desc = "A nonfunctional plasma cell, once used as portable power generation."
	icon_state = "splasma"
	points = 15
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapplasma/five
	amount = 5

/obj/item/stack/ore/salvage/scrapuranium
	name = "broken detector"
	desc = "The label on the side warns the reader of radioactive elements."
	icon_state = "suranium"
	points = 30
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapuranium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapbluespace
	name = "damaged bluespace circuit"
	desc = "It's damaged beyond repair, but the crystal inside its housing looks fine."
	icon_state = "sbluespace"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/salvage/scrapbluespace/five
	amount = 5

// gpu item. does nothing except sell for quite a lot
/obj/item/gpu
	name = "high power GPU"
	desc = "A large, powerful graphics card for use in high-end computer systems. It seems to be in pretty good condition, given its surroundings."
	icon = 'icons/obj/module.dmi'
	icon_state = "card_mod" // looks like a gpu, vaguely

// RUSTED GUN SAFE //
// similar to abandoned crates but with more guns and less spewium bees
/obj/structure/rusted_gun_safe
	name = "rusted gun safe"
	desc = "A long-abandoned gun safe. Its dial is firmly corroded in place."
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = FALSE
	density = TRUE
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	max_integrity = 400
	armor = list("melee" = 30, "bullet" = 60, "laser" = 60, "energy" = 100, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 30)
	drag_slowdown = 2.5
	color = "#c3a28a" // orange-ish

	var/open = FALSE

/obj/structure/rusted_gun_safe/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	to_chat(user, span_warning("The floor bolts on this safe are completely corroded."))

// common drop pool
// contains unremarkable guns
/obj/structure/rusted_gun_safe/proc/drop_common()
	var/roll = rand(1,100)
	switch(roll)
		if(1 to 5)
			new /obj/item/

// uncommon drop pool
// contains noteworthy guns
/obj/structure/rusted_gun_safe/proc/drop_uncommon()
	var/roll = rand(1,100)
	switch(roll)
		if(1 to 5)

// rare drop pool
// contains rather good guns
/obj/structure/rusted_gun_safe/proc/drop_rare()
	var/roll = rand(1,100)
	switch(roll)
		if(1 to 5)

// weird drop pool
// contains weird stuff
/obj/structure/rusted_gun_safe/proc/drop_weird()
	var/roll = rand(1,100)
	switch(roll)
		if(1)
			var/juckport = new /obj/item/spacecash/bundle/c1
			juckport.name = "the juckport"


/obj/structure/rusted_gun_safe/proc/open_sesame()
	open = TRUE
	icon_state = "safe-open"
	desc = "A long-abandoned gun safe. It has been broken into, exposing its contents to the world."
	// spawn loot
	var/rarity = rand(1, 101)
	switch(rarity)
		if(1 to 60)
			drop_common()
		if(61 to 90)
			drop_uncommon()
		if(91 to 100)
			drop_rare()
		if(101)
			drop_weird()

/obj/structure/rusted_gun_safe/deconstruct_act(mob/living/user, obj/item/tool)
	if(open)
		return FALSE
	if(..())
		return TRUE
	user.visible_message(
		span_warning("[user] begin to cut through the lock of \the [src]."),
		span_notice("You start cutting through the lock of [src]."))
	if(tool.use_tool(src, user, 45 SECONDS))
		open_sesame()
		user.visible_message(
			span_warning("[user] successfully cuts through the lock of \the [src]."),
			span_notice("You successfully cut through the lock of [src]."))
	return TRUE

/obj/structure/rusted_gun_safe/ex_act(severity, target)
	if(!open) // barely explosion resistant - use the mines!
		open_sesame()
