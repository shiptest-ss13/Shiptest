/obj/structure/salvageable
	name = "broken machinery"
	desc = "It's broken beyond repair. You may be able to salvage something from this."
	icon = 'icons/obj/salvage_structure.dmi'
	density = TRUE
	anchored = TRUE
	var/salvageable_parts = list()
	var/frame_type = /obj/structure/frame/machine

/obj/item/stack/ore/salvage/examine(mob/user)
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
	user.visible_message("<span class='notice'>[user] starts dismantling [src].</span>", \
					"<span class='notice'>You start salvaging anything useful from [src]...</span>")
	tool.play_tool_sound(src, 100)
	if(do_after(user, 8 SECONDS, target = src))
		user.visible_message("<span class='notice'>[user] dismantles [src].</span>", \
						"<span class='notice'>You salvage [src].</span>")
		dismantle(user)
		tool.play_tool_sound(src, 100)
		qdel(src)
	return TRUE

/obj/structure/salvageable/deconstruct_act(mob/living/user, obj/item/tool)
	. = ..()
	user.visible_message("<span class='notice'>[user] starts slicing [src].</span>", \
					"<span class='notice'>You start salvaging anything useful from [src]...</span>")
	if(tool.use_tool(src, user, 6 SECONDS))
		user.visible_message("<span class='notice'>[user] dismantles [src].</span>", \
						"<span class='notice'>You salvage [src].</span>")
		dismantle(user)
		qdel(src)
	return TRUE

//Types themself, use them, but not the parent object

/obj/structure/salvageable/machine
	name = "broken machine"
	icon_state = "wreck_pda"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapgold/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,

		/obj/effect/spawner/lootdrop/salvage_capacitor = 50,
		/obj/effect/spawner/lootdrop/salvage_capacitor = 50,
		/obj/effect/spawner/lootdrop/salvage_scanning = 50,
		/obj/effect/spawner/lootdrop/salvage_scanning = 50,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 40,
		/obj/effect/spawner/lootdrop/salvage_laser = 40,
		/obj/effect/spawner/lootdrop/salvage_laser = 40,
	)

/obj/structure/salvageable/computer
	name = "broken computer"
	icon_state = "computer_broken"
	frame_type = /obj/structure/frame/computer/retro
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 90,
		/obj/item/stack/ore/salvage/scrapsilver/five = 90,
		/obj/item/stack/ore/salvage/scrapgold/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,

		/obj/effect/spawner/lootdrop/salvage_capacitor = 60,

		/obj/item/computer_hardware/battery = 40,
		/obj/item/computer_hardware/battery = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/network_card/advanced = 20,

		/obj/effect/spawner/lootdrop/random_computer_circuit_common = 50,
		/obj/effect/spawner/lootdrop/random_computer_circuit_rare = 5,

		/obj/item/research_notes/loot/tiny = 10,
	)

/obj/structure/salvageable/autolathe
	name = "broken autolathe"
	icon_state = "wreck_autolathe"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scraptitanium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,


		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,

		/obj/item/circuitboard/machine/autolathe = 35,

		/obj/item/stack/sheet/metal/five = 10,
		/obj/item/stack/sheet/glass/five = 10,
		/obj/item/stack/sheet/plastic/five = 10,
		/obj/item/stack/sheet/plasteel/five = 10,
		/obj/item/stack/sheet/mineral/silver/five = 10,
		/obj/item/stack/sheet/mineral/gold/five = 10,
		/obj/item/stack/sheet/mineral/plasma/five = 10,
		/obj/item/stack/sheet/mineral/uranium/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1,
	)

/obj/structure/salvageable/protolathe
	name = "broken protolathe"
	icon_state = "wreck_protolathe"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapplasma/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,

		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,

		/obj/effect/spawner/lootdrop/tool_engie_proto = 45,
		/obj/effect/spawner/lootdrop/tool_surgery_proto = 55,
		/obj/effect/spawner/lootdrop/beaker_loot_spawner = 45,
		/obj/effect/spawner/lootdrop/random_prosthetic = 25,
		/obj/effect/spawner/lootdrop/random_gun_protolathe_lootdrop = 5, //:flushed:
		/obj/effect/spawner/lootdrop/random_ammo_protolathe_lootdrop = 5,

		/obj/item/storage/part_replacer = 20,
		/obj/item/storage/part_replacer/bluespace = 1,
		/obj/item/mop = 20,
		/obj/item/mop/advanced = 1, // the holy grail

		/obj/item/stack/sheet/metal/five = 15, //the point isnt the materials in the protolathe wreckage but you can still get them for flavor and stuff
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
	icon_state = "wreck_circuit_imprinter"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,

		/obj/item/stack/circuit_stack = 50, //this might be the only way in the game to get a poly circuit, and the only way for many ships to get essensial electronics. huh.
		/obj/effect/spawner/lootdrop/random_machine_circuit_mech = 45, //with all the wonderful broken mechs lying around, this might be a chance to get something stupidly overpowered.
		/obj/effect/spawner/lootdrop/random_machine_circuit_common = 50, //well.... "common"
		/obj/effect/spawner/lootdrop/random_machine_circuit_rare = 5,

		/obj/item/stack/sheet/metal/five = 15, //same as above but more geared towards stuff used by circuit imprinter
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/bluespace_crystal/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1,
	)

/obj/structure/salvageable/destructive_analyzer
	name = "broken destructive analyzer"
	desc = "If this thing could power up, it would probably slice you in half. You may be able to salvage something from this." //this ones pretty dangerous
	icon_state = "wreck_d_analyzer"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapplasma = 60,

		/obj/effect/spawner/lootdrop/salvage_scanning = 40,
		/obj/effect/spawner/lootdrop/salvage_laser = 30,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,

		/obj/item/storage/toolbox/syndicate/empty = 80,
		/obj/effect/spawner/lootdrop/destructive_anal_loot = 65,

		/obj/item/stack/sheet/metal/five = 15, //same as above but more geared towards stuff used by circuit imprinter
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
			audible_message("<span class='notice'>You can hear the sound of broken glass in the [src].</span>")
		if(41 to 60)
			visible_message("<span class='danger'>You flinch as the [src]'s laser apparatus lights up, but your tool destroys it before it activates...</span>")
		if(61 to 79)
			visible_message("<span class='danger'>You see a dim light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam/scatter)
		if(80 to 89)
			visible_message("<span class='danger'>You see a bright light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam)
		if(90 to 100)
			visible_message("<span class='danger'>You see an intense light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam/laser/heavylaser) //i'd like to make this flash people. but i'm not sure how to do that. shame!

/obj/structure/salvageable/destructive_analyzer/proc/shoot_projectile(mob/living/target, obj/projectile/projectile_to_shoot)
	var/obj/projectile/projectile_being_shot = new projectile_to_shoot(get_turf(src))
	projectile_being_shot.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	projectile_being_shot.firer = src
	projectile_being_shot.fire(Get_Angle(src,target))

/obj/structure/salvageable/server
	name = "broken server"
	icon_state = "wreck_server"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		/obj/item/research_notes/loot/tiny = 50,
		/obj/item/research_notes/loot/medium = 20,
		/obj/item/research_notes/loot/big = 5, //you have a chance at summoning god damn ripley lobster from this thing, might as well

		/obj/item/disk/tech_disk/major = 3,
		/obj/item/disk/tech_disk = 20,
		/obj/item/disk/data = 20,
		/obj/item/disk/holodisk = 20,
		/obj/item/disk/plantgene = 20,

		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/computer_hardware/network_card/advanced = 20,
	)

/obj/structure/salvageable/server/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level) //ever wanted the extreme danger of turn based rng but in space station 13?
		if(1 to 45)
			audible_message("<span class='notice'>The [src] makes a crashing sound as its salvaged.</span>")

		if(46 to 89)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message("<span class='danger'>You hear a buzz from the [src] and a voice,</span>")
			new /mob/living/simple_animal/bot/medbot/rockplanet(get_turf(src))

		if(95 to 100)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message("<span class='danger'>You hear a buzz from the [src] and a voice,</span>")

			new /mob/living/simple_animal/bot/firebot/rockplanet(get_turf(src))

		if(90 to 94)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message("<span class='danger'>You hear as buzz from the [src] as an abandoned security bot rolls out from the [src]!!</span>")

			new /mob/living/simple_animal/bot/secbot/ed209/rockplanet(get_turf(src))

/obj/structure/salvageable/safe_server //i am evil and horrible and i don't deserve to touch code
	name = "broken server"
	icon_state = "wreck_server"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapuranium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,
		/obj/item/stack/ore/salvage/scrapbluespace = 60,

		/obj/item/research_notes/loot/tiny = 50,
		/obj/item/research_notes/loot/medium = 20,
		/obj/item/research_notes/loot/big = 5,

		/obj/item/disk/tech_disk/major = 3,
		/obj/item/disk/tech_disk = 20,
		/obj/item/disk/data = 20,
		/obj/item/disk/holodisk = 20,
		/obj/item/disk/plantgene = 20,

		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/computer_hardware/network_card/advanced = 20,
	)

/obj/structure/salvageable/seed
	name = "ruined seed vendor"
	desc = "This is where the seeds lived. Maybe you can still get some?"//megaseed voiceline reference
	icon_state = "seeds-broken"
	icon = 'icons/obj/vending.dmi'
	color = "#808080"

	salvageable_parts = list(
		/obj/effect/spawner/lootdrop/seeded = 80,
		/obj/effect/spawner/lootdrop/seeded = 80,
		/obj/effect/spawner/lootdrop/seeded = 80,
		/obj/effect/spawner/lootdrop/seeded = 80,
		/obj/effect/spawner/lootdrop/seeded = 80,
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
			audible_message("<span class='notice'>The [src] buzzes softly as it falls apart.</span>")

		if(51 to 80)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message("<span class='danger'>As the [src] collapses, an oversized tomato lunges out from inside!</span>")
			new /mob/living/simple_animal/hostile/killertomato(get_turf(src))

		if(81 to 100)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			audible_message("<span class='danger'>A bundle of vines unfurls from inside the [src]!</span>")
			new /mob/living/simple_animal/hostile/venus_human_trap(get_turf(src))

//scrap item, mostly for fluff
/obj/item/stack/ore/salvage
	name = "salvage"
	icon = 'icons/obj/salvage_structure.dmi'
	icon_state = "smetal"

/obj/item/stack/ore/salvage/examine(mob/user)
	. = ..()
	. += "You could probably reclaim this in an autolathe, Ore Redemption Machine, or smelter."

/obj/item/stack/ore/salvage/scrapmetal
	name = "scrap metal"
	desc = "A collection of metal parts and pieces."
	points = 1
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/metal

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
	refined_type = /obj/item/stack/sheet/mineral/titanium

/obj/item/stack/ore/salvage/scraptitanium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapsilver
	name = "worn crt"
	desc = "An old CRT display with the letters 'STANDBY' burnt into the screen."
	icon_state = "ssilver"
	points = 16
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/silver

/obj/item/stack/ore/salvage/scrapsilver/five
	amount = 5

/obj/item/stack/ore/salvage/scrapgold
	name = "scrap electronics"
	desc = "Various bits of electrical components."
	icon_state = "sgold"
	points = 18
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold

/obj/item/stack/ore/salvage/scrapgold/five
	amount = 5

/obj/item/stack/ore/salvage/scrapplasma
	name = "junk plasma cell"
	desc = "A nonfunctional plasma cell, once used as portable power generation."
	icon_state = "splasma"
	points = 15
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/plasma

/obj/item/stack/ore/salvage/scrapplasma/five
	amount = 5

/obj/item/stack/ore/salvage/scrapuranium
	name = "broken detector"
	desc = "The label on the side warns the reader of radioactive elements."
	icon_state = "suranium"
	points = 30
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/uranium

/obj/item/stack/ore/salvage/scrapuranium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapbluespace
	name = "damaged bluespace circuit"
	desc = "It's damaged beyond repair, but the crystal inside its housing looks fine."
	icon_state = "sbluespace"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/bluespace_crystal

/obj/item/stack/ore/salvage/scrapbluespace/five
	amount = 5

//loot spawners as shown above

//GENERIC
/obj/effect/spawner/lootdrop/salvage_capacitor
	loot = list(
			/obj/item/stock_parts/capacitor = 120,
			/obj/item/stock_parts/capacitor/adv = 20,
			/obj/item/stock_parts/capacitor/super = 5,
		)

/obj/effect/spawner/lootdrop/salvage_scanning
	loot = list(
			/obj/item/stock_parts/scanning_module = 120,
			/obj/item/stock_parts/scanning_module/adv = 20,
			/obj/item/stock_parts/scanning_module/phasic = 5,
		)

/obj/effect/spawner/lootdrop/salvage_manipulator
	loot = list(
			/obj/item/stock_parts/manipulator = 120,
			/obj/item/stock_parts/manipulator/nano = 20,
			/obj/item/stock_parts/manipulator/pico = 5,
		)

/obj/effect/spawner/lootdrop/salvage_matter_bin
	loot = list(
			/obj/item/stock_parts/matter_bin = 120,
			/obj/item/stock_parts/matter_bin/adv = 20,
			/obj/item/stock_parts/matter_bin/super = 5,
		)

/obj/effect/spawner/lootdrop/salvage_laser
	loot = list(
			/obj/item/stock_parts/micro_laser = 120,
			/obj/item/stock_parts/micro_laser/high = 20,
			/obj/item/stock_parts/micro_laser/ultra = 5,
		)

//PROTOLATHE
/obj/effect/spawner/lootdrop/tool_engie_proto
	loot = list(
			/obj/effect/spawner/lootdrop/tool_engie_common = 120,
			/obj/effect/spawner/lootdrop/tool_engie_sydnie = 20,
			/obj/effect/spawner/lootdrop/tool_engie_adv = 5,
		)

/obj/effect/spawner/lootdrop/tool_engie_common
	loot = list(
			/obj/item/wrench/crescent = 1,
			/obj/item/screwdriver = 1,
			/obj/item/weldingtool = 1,
			/obj/item/crowbar = 1,
			/obj/item/wirecutters = 1,
			/obj/item/multitool = 1,
		)

/obj/effect/spawner/lootdrop/tool_engie_sydnie
	loot = list(
			/obj/item/wrench/syndie = 1,
			/obj/item/screwdriver/nuke = 1,
			/obj/item/weldingtool/largetank = 1,
			/obj/item/crowbar/syndie = 1,
			/obj/item/wirecutters/syndie = 1,
			/obj/item/multitool/syndie = 1,
		)

/obj/effect/spawner/lootdrop/tool_engie_adv
	loot = list(
			/obj/item/screwdriver/power = 1,
			/obj/item/weldingtool/experimental = 1,
			/obj/item/crowbar/power = 1,
		)

/obj/effect/spawner/lootdrop/tool_surgery_proto
	loot = list(
			/obj/effect/spawner/lootdrop/tool_surgery_common = 120,
			/obj/effect/spawner/lootdrop/tool_surgery_adv = 10,
		)

/obj/effect/spawner/lootdrop/tool_surgery_common
	loot = list(
			/obj/item/scalpel = 1,
			/obj/item/hemostat = 1,
			/obj/item/cautery = 1,
			/obj/item/retractor = 1,
			/obj/item/circular_saw = 1,
			/obj/item/surgicaldrill = 1,
		)

/obj/effect/spawner/lootdrop/tool_surgery_adv
	loot = list(
			/obj/item/scalpel/advanced = 1,
			/obj/item/retractor/advanced = 1,
			/obj/item/surgicaldrill/advanced = 1,
		)

/obj/effect/spawner/lootdrop/beaker_loot_spawner
	loot = list(
			/obj/item/reagent_containers/glass/beaker = 300,
			/obj/item/reagent_containers/glass/beaker/large = 200,
			/obj/item/reagent_containers/glass/beaker/plastic = 50,
			/obj/item/reagent_containers/glass/beaker/meta = 10,
			/obj/item/reagent_containers/glass/beaker/noreact = 5,
			/obj/item/reagent_containers/glass/beaker/bluespace = 1,
		)
/obj/effect/spawner/lootdrop/random_prosthetic
	loot = list(
			/obj/item/bodypart/l_arm/robot/surplus = 1,
			/obj/item/bodypart/r_arm/robot/surplus = 1,
			/obj/item/bodypart/leg/left/robot/surplus = 1,
			/obj/item/bodypart/leg/right/robot/surplus = 1,
		)
/obj/effect/spawner/lootdrop/random_gun_protolathe_lootdrop
	loot = list(
			/obj/item/gun/energy/lasercannon = 1,
			/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/proto = 1,
			/obj/item/gun/energy/temperature/security = 1,
		)
/obj/effect/spawner/lootdrop/random_ammo_protolathe_lootdrop
	loot = list(
			/obj/item/stock_parts/cell/gun/upgraded = 5,
			/obj/item/ammo_box/magazine/smgm9mm = 7,
		)

//CIRCUIT IMPRINTER
/obj/effect/spawner/lootdrop/random_machine_circuit_common
	loot = list(
			/obj/item/circuitboard/machine/autolathe = 5,
			/obj/item/circuitboard/machine/bepis = 5,
			/obj/item/circuitboard/machine/biogenerator = 5,
			/obj/item/circuitboard/machine/cell_charger = 5,
			/obj/item/circuitboard/machine/chem_heater = 5,
			/obj/item/circuitboard/machine/chem_master = 5,
			/obj/item/circuitboard/machine/clonescanner = 5,
			/obj/item/circuitboard/machine/cryo_tube = 5,
			/obj/item/circuitboard/machine/cyborgrecharger = 5,
			/obj/item/circuitboard/machine/deep_fryer = 5,
			/obj/item/circuitboard/machine/experimentor = 5,
			/obj/item/circuitboard/machine/holopad = 5,
			/obj/item/circuitboard/machine/hydroponics = 5,
			/obj/item/circuitboard/machine/limbgrower = 5,
			/obj/item/circuitboard/machine/ltsrbt = 5,
			/obj/item/circuitboard/machine/mech_recharger = 5,
			/obj/item/circuitboard/machine/mechfab = 5,
			/obj/item/circuitboard/machine/medical_kiosk = 5,
			/obj/item/circuitboard/machine/medipen_refiller = 5,
			/obj/item/circuitboard/machine/microwave = 5,
			/obj/item/circuitboard/machine/monkey_recycler = 5,
			/obj/item/circuitboard/machine/ore_redemption = 5,
			/obj/item/circuitboard/machine/ore_silo = 5,
			/obj/item/circuitboard/machine/reagentgrinder = 5,
			/obj/item/circuitboard/machine/recharger = 5,
			/obj/item/circuitboard/machine/seed_extractor = 5,
			/obj/item/circuitboard/machine/selling_pad = 5,
			/obj/item/circuitboard/machine/emitter = 5,
		)

/obj/effect/spawner/lootdrop/random_machine_circuit_rare
	loot = list(
			/obj/item/circuitboard/aicore = 5,
			/obj/item/circuitboard/machine/chem_dispenser = 5,
			/obj/item/circuitboard/machine/circuit_imprinter = 5,
			/obj/item/circuitboard/machine/protolathe = 5,
			/obj/item/circuitboard/machine/clonepod/experimental = 5,
			/obj/item/circuitboard/machine/rad_collector = 5,
			/obj/item/circuitboard/machine/launchpad = 5,
		)

/obj/effect/spawner/lootdrop/random_machine_circuit_mech
	loot = list(
			/obj/item/circuitboard/mecha/ripley/main = 100,
			/obj/item/circuitboard/mecha/ripley/peripherals = 100,
			/obj/item/circuitboard/mecha/honker/main = 5,
			/obj/item/circuitboard/mecha/honker/peripherals = 5,
			/obj/item/circuitboard/mecha/odysseus/main = 5,
			/obj/item/circuitboard/mecha/odysseus/peripherals = 5,
			/obj/item/circuitboard/mecha/gygax/main = 1,
			/obj/item/circuitboard/mecha/gygax/peripherals = 1,
			/obj/item/circuitboard/mecha/gygax/targeting = 1,
			/obj/item/circuitboard/mecha/durand/main = 1,
			/obj/item/circuitboard/mecha/durand/peripherals = 1,
			/obj/item/circuitboard/mecha/durand/targeting = 1,
		)

//COMPUTER
/obj/effect/spawner/lootdrop/random_computer_circuit_common
	loot = list(
			/obj/item/circuitboard/computer/aifixer = 5,
			/obj/item/circuitboard/computer/arcade/amputation = 5,
			/obj/item/circuitboard/computer/arcade/battle = 5,
			/obj/item/circuitboard/computer/arcade/orion_trail = 5,
			/obj/item/circuitboard/computer/atmos_alert = 5,
			/obj/item/circuitboard/computer/card = 5,
			/obj/item/circuitboard/computer/cloning = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/launchpad_console = 5,
			/obj/item/circuitboard/computer/mech_bay_power_console = 5,
			/obj/item/circuitboard/computer/pandemic = 5,
			/obj/item/circuitboard/computer/powermonitor/secret = 5,
			/obj/item/circuitboard/computer/prototype_cloning = 5,
			/obj/item/circuitboard/computer/stationalert = 5,
			/obj/item/circuitboard/computer/xenobiology = 5,
			/obj/item/circuitboard/computer/teleporter = 5,
			/obj/item/circuitboard/computer/operating = 5,
			/obj/item/circuitboard/computer/crew = 5,
			/obj/item/circuitboard/computer/scan_consolenew = 5,
		)

/obj/effect/spawner/lootdrop/random_computer_circuit_rare
	loot = list(
			/obj/item/circuitboard/computer/cargo = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/shuttle/helm = 5,
			/obj/item/circuitboard/computer/med_data = 5,
		)

//DESTRUCTIVE ANAL //i'm killing you
/obj/effect/spawner/lootdrop/destructive_anal_loot //what do people usually put in these things anayways
	loot = list(
			/obj/item/storage/toolbox/syndicate/empty = 650,
			/obj/item/gun/ballistic/automatic/pistol/ringneck = 500,
			/obj/item/camera_bug = 500,
			/obj/item/clothing/gloves/combat = 200,
			/obj/item/clothing/head/chameleon = 200,
			/obj/item/pen/sleepy = 200,
			/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor = 100,

			/obj/item/grenade/c4 = 100,

			/obj/item/wrench/syndie = 30,
			/obj/item/screwdriver/nuke = 30,
			/obj/item/crowbar/syndie = 30,
			/obj/item/wirecutters/syndie = 30,
			/obj/item/multitool/syndie = 30,
		)
