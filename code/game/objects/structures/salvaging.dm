/obj/structure/salvageable
	name = "broken machinery"
	desc = "It is broken beyond repair. You may be able to salvage something from this."
	icon = 'icons/obj/salvage_structure.dmi'
	density = TRUE
	anchored = TRUE
	var/salvageable_parts = list()

/obj/structure/salvageable/proc/dismantle(mob/living/user)
	var/obj/frame = new /obj/structure/frame/machine(get_turf(src))
	frame.anchored = TRUE
	for(var/path in salvageable_parts)
		if(prob(salvageable_parts[path]))
			new path (loc)
	return

/obj/structure/salvageable/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	user.visible_message(user,"<span class='notice'>[user] starts to salvage \the [src].</span>", \
					"<span class='notice'>You start salvage anything useful from \the [src].</span>")
	I.play_tool_sound(src, 100)
	if(do_after(user, 80, target = src))
		user.visible_message(user, "<span class='notice'>[user] dismantles \the [src].</span>", \
						"<span class='notice'>You dismantle \the [src].</span>")
		dismantle(user)
		I.play_tool_sound(src, 100)
		qdel(src)
		return


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
	icon_state = "computer"
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

		/obj/effect/spawner/lootdrop/random_computer_cicuit_common = 20,
		/obj/effect/spawner/lootdrop/random_computer_cicuit_rare = 5,

		/obj/item/research_notes/loot/tiny = 10
	)
/obj/structure/salvageable/autolathe
	name = "broken autolathe"
	icon_state = "wreck_autolathe"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scraptitanium/five = 60,
		/obj/item/stack/ore/salvage/scrapmetal/five = 60,


		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_matter_bin = 40,
		/obj/effect/spawner/lootdrop/salvage_manipulator = 30,

		/obj/item/circuitboard/machine/autolathe = 35,

		/obj/item/stack/sheet/metal/twenty = 10,
		/obj/item/stack/sheet/glass/twenty = 10,
		/obj/item/stack/sheet/plastic/twenty = 10,
		/obj/item/stack/sheet/plasteel/twenty = 10,
		/obj/item/stack/sheet/mineral/silver/twenty = 10,
		/obj/item/stack/sheet/mineral/gold/twenty = 10,
		/obj/item/stack/sheet/mineral/plasma/twenty = 10,
		/obj/item/stack/sheet/mineral/uranium/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1
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

		/obj/effect/spawner/lootdrop/tool_engie_proto = 40,
		/obj/effect/spawner/lootdrop/tool_surgery_proto = 50,
		/obj/effect/spawner/lootdrop/beaker_loot_spawner = 40,
		/obj/effect/spawner/lootdrop/random_prosthetic = 20,
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
		/obj/item/stack/sheet/mineral/diamond/five = 1
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
		/obj/effect/spawner/lootdrop/random_machine_cicuit_mech = 40, //with all the wonderful broken mechs lying around, this might be a chance to get something stupidly overpowered.
		/obj/effect/spawner/lootdrop/random_machine_cicuit_common = 25, //well.... "common"
		/obj/effect/spawner/lootdrop/random_machine_cicuit_rare = 5,

		/obj/item/stack/sheet/metal/five = 15, //same as above but more geared towards stuff used by circuit imprinter
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/bluespace_crystal/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1
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
		/obj/effect/spawner/lootdrop/destructive_anal_loot = 40,

		/obj/item/stack/sheet/metal/five = 15, //same as above but more geared towards stuff used by circuit imprinter
		/obj/item/stack/sheet/glass/five = 15,
		/obj/item/stack/sheet/mineral/silver/five = 15,
		/obj/item/stack/sheet/mineral/gold/five = 15,
		/obj/item/stack/sheet/bluespace_crystal/five = 5,
		/obj/item/stack/sheet/mineral/diamond/five = 1
	)

/obj/structure/salvageable/destructive_analyzer/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level) //scary.
		if(60 to 100)
			src.audible_message("<span class='notice'>You can hear the sound of broken glass in the [src].</span>")
		if(50 to 59)
			src.visible_message("<span class='danger'>You flinch as you think the [src] is going to turn on in your face, but your tool destroys the laser before it activates..</span>")
		if(20 to 49)
			src.visible_message("<span class='danger'>You see a bright light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam/scatter)
		if(8 to 19)
			src.visible_message("<span class='danger'>You see a bright light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam)
		if(2 to 7)
			src.visible_message("<span class='danger'>You see a bright light from the [src] before the laser reactivates in your face!</span>")
			shoot_projectile(user, /obj/projectile/beam/laser/heavylaser)
		if(1)
			src.audible_message("<span class='boldwarning'>You hear something crawling out of the [src]!!</span>")
			if(prob(70))
				new /obj/item/clothing/mask/facehugger/toy/(get_turf(src)) //gotcha!
			else
				new /obj/item/clothing/mask/facehugger/(get_turf(src)) //yeah

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
		/obj/item/computer_hardware/network_card/advanced = 20
	)

/obj/structure/salvageable/server/dismantle(mob/living/user)
	. = ..()
	var/danger_level = rand(1,100)
	switch(danger_level) //ever wanted the extreme dannger of turn based rng but in space station 13?
		if(46 to 100)
			src.audible_message("<span class='notice'>The [src] makes a crashing sound as its salvaged.</span>")
		if(40 to 45)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			src.audible_message("<span class='danger'>You hear a buzz from the [src] and a voice,</span>")
			say("SECURITY BREACH DETECTED, SENDING BACKUP IMMEDIATELY, PRIORITY GREEN, SENDING IN THE MEDBOT.")
			src.visible_message("<span class=danger>A strange target appears on the ground.</span>")

			var/obj/structure/closet/supplypod/bluespacepod/pod = new()
			new /mob/living/simple_animal/bot/medbot/rockplanet(pod)
			pod.style = STYLE_STANDARD
			pod.explosionSize = list(0,0,0,0)

		if(26 to 40)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			src.audible_message("<span class='danger'>You hear a buzz from the [src] and a voice,</span>")
			say("SECURITY BREACH DETECTED, SENDING BACKUP IMMEDIATELY, PRIORITY BLUE, SENDING IN THE FIREBOT.")
			src.visible_message("<span class=danger>A strange target appears on the ground.</span>")

			var/obj/structure/closet/supplypod/bluespacepod/pod = new()
			new /mob/living/simple_animal/bot/firebot/rockplanet(pod)
			pod.style = STYLE_STANDARD
			pod.explosionSize = list(0,0,0,0)

		if(1 to 25)
			playsound(src, 'sound/machines/buzz-two.ogg', 100, FALSE, FALSE)
			src.audible_message("<span class='danger'>You hear as buzz from the [src] and a voice,</span>")
			say("SECURITY BREACH DETECTED, SENDING BACKUP IMMEDIATELY, PRIORITY RED, SENDING IN THE ED 209.")
			src.visible_message("<span class=danger>A strange target appears on the ground.</span>")

			var/obj/structure/closet/supplypod/bluespacepod/pod = new()
			new /mob/living/simple_animal/bot/secbot/ed209/rockplanet(pod)
			pod.style = STYLE_STANDARD
			pod.explosionSize = list(0,0,0,0)
/*
		if(1 to 3)
			playsound(src, 'sound/machines/warning-buzzer.ogg', 100, FALSE, FALSE)
			src.audible_message("<span class='boldwarning'>You hear a loud buzzing from the [src] and a voice,</span>")
			say("SECURITY BREACH DETECTED, SENDING BACKUP IMMEDIATELY, PRIORITY DELTA, SENDING IN THE LOBSTER.")
			src.visible_message("<span class=danger>A strange target appears on the ground. It might be best to step back!</span>")

			var/obj/structure/closet/supplypod/bluespacepod/pod = new()
			new /mob/living/simple_animal/hostile/megafauna/ripley_lobster(pod)
			pod.style = STYLE_SEETHROUGH
			return
*/
//scrap item, mostly for fluff
/obj/item/stack/ore/salvage
	name = "salvage"
	icon = 'icons/obj/salvage_structure.dmi'

/obj/item/stack/ore/salvage/examine(mob/user)
	. = ..()
	. += "You can most likely reclaim this in a autolathe or Ore Redemption Machine."

/obj/item/stack/ore/salvage/scrapmetal
	name = "scrap metal"
	desc = "A collection of metal peices and parts."
	icon_state = "smetal"
	item_state = "smetal"
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
	desc = "A bunch of strong metal peices and parts from high-preformance equppment."
	icon_state = "stitanium"
	item_state = "stitanium"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/titanium

/obj/item/stack/ore/salvage/scraptitanium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapsilver
	name = "worn crt"
	desc = "An old CRT display. the letters 'STANDBY' in green are burned into the screen."
	icon_state = "ssilver"
	item_state = "ssilver"
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
	item_state = "sgold"
	points = 18
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold

/obj/item/stack/ore/salvage/scrapgold/five
	amount = 5

/obj/item/stack/ore/salvage/scrapplasma
	name = "junk plasma cell"
	desc = "This plasma cell looks nonfunctional."
	icon_state = "splasma"
	item_state = "splasma"
	points = 15
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/plasma

/obj/item/stack/ore/salvage/scrapplasma/five
	amount = 5

/obj/item/stack/ore/salvage/scrapuranium
	name = "broken detector"
	desc = "There is a label on the side of the old detector warning of radioactive elements."
	icon_state = "suranium"
	item_state = "suranium"
	points = 30
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/uranium

/obj/item/stack/ore/salvage/scrapuranium/five
	amount = 5

/obj/item/stack/ore/salvage/scrapbluespace
	name = "damaged bluespace circuit"
	desc = "The circuit looks too damaged to be operational, but the crystal inside its housing looks fine."
	icon_state = "sbluespace"
	item_state = "sbluespace"
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
			/obj/item/stock_parts/capacitor = 100,
			/obj/item/stock_parts/capacitor/adv = 20,
			/obj/item/stock_parts/capacitor/super = 5
		)

/obj/effect/spawner/lootdrop/salvage_scanning
	loot = list(
			/obj/item/stock_parts/scanning_module = 100,
			/obj/item/stock_parts/scanning_module/adv = 20,
			/obj/item/stock_parts/scanning_module/phasic = 5
		)

/obj/effect/spawner/lootdrop/salvage_manipulator
	loot = list(
			/obj/item/stock_parts/manipulator = 100,
			/obj/item/stock_parts/manipulator/adv = 20,
			/obj/item/stock_parts/manipulator/pico = 5
		)

/obj/effect/spawner/lootdrop/salvage_matter_bin
	loot = list(
			/obj/item/stock_parts/matter_bin = 100,
			/obj/item/stock_parts/matter_bin/adv = 20,
			/obj/item/stock_parts/matter_bin/super = 5
		)

/obj/effect/spawner/lootdrop/salvage_laser
	loot = list(
			/obj/item/stock_parts/micro_laser = 100,
			/obj/item/stock_parts/micro_laser/adv = 20,
			/obj/item/stock_parts/micro_laser/ultra = 5
		)

//PROTOLATHE
/obj/effect/spawner/lootdrop/tool_engie_proto
	loot = list(
			/obj/effect/spawner/lootdrop/tool_engie_common = 100,
			/obj/effect/spawner/lootdrop/tool_engie_sydnie = 20,
			/obj/effect/spawner/lootdrop/tool_engie_adv = 5
		)

/obj/effect/spawner/lootdrop/tool_engie_common
	loot = list(
			/obj/item/wrench/crescent = 1,
			/obj/item/screwdriver = 1,
			/obj/item/weldingtool = 1,
			/obj/item/crowbar = 1,
			/obj/item/wirecutters = 1,
			/obj/item/multitool = 1
		)

/obj/effect/spawner/lootdrop/tool_engie_sydnie
	loot = list(
			/obj/item/wrench/syndie = 1,
			/obj/item/screwdriver/nuke = 1,
			/obj/item/weldingtool/industrial = 1,
			/obj/item/crowbar/syndie = 1,
			/obj/item/wirecutters/syndie = 1,
			/obj/item/multitool/syndie = 1
		)

/obj/effect/spawner/lootdrop/tool_engie_adv
	loot = list(
			/obj/item/screwdriver/power = 1,
			/obj/item/weldingtool/experimental = 1,
			/obj/item/crowbar/power = 1
		)

/obj/effect/spawner/lootdrop/tool_surgery_proto
	loot = list(
			/obj/effect/spawner/lootdrop/tool_surgery_common = 100,
			/obj/effect/spawner/lootdrop/tool_surgery_adv = 10,
		)

/obj/effect/spawner/lootdrop/tool_surgery_common
	loot = list(
			/obj/item/scalpel = 1,
			/obj/item/hemostat = 1,
			/obj/item/cautery = 1,
			/obj/item/retractor = 1,
			/obj/item/circular_saw = 1,
			/obj/item/surgicaldrill = 1
		)

/obj/effect/spawner/lootdrop/tool_surgery_adv
	loot = list(
			/obj/item/scalpel/advanced = 1,
			/obj/item/retractor/advanced = 1,
			/obj/item/surgicaldrill/advanced = 1
		)

/obj/effect/spawner/lootdrop/beaker_loot_spawner
	loot = list(
			/obj/item/reagent_containers/glass/beaker = 500,
			/obj/item/reagent_containers/glass/beaker/large = 200,
			/obj/item/reagent_containers/glass/beaker/plastic = 50,
			/obj/item/reagent_containers/glass/beaker/meta = 10,
			/obj/item/reagent_containers/glass/beaker/noreact = 5,
			/obj/item/reagent_containers/glass/beaker/bluespace = 1
		)
/obj/effect/spawner/lootdrop/random_prosthetic
	loot = list(
			/obj/item/bodypart/l_arm/robot/surplus = 1,
			/obj/item/bodypart/r_arm/robot/surplus = 1,
			/obj/item/bodypart/l_leg/robot/surplus = 1,
			/obj/item/bodypart/r_leg/robot/surplus = 1,
		)
/obj/effect/spawner/lootdrop/random_gun_protolathe_lootdrop
	loot = list(
			/obj/item/gun/energy/lasercannon = 1,
			/obj/item/gun/ballistic/automatic/proto = 1,
			/obj/item/gun/energy/temperature = 1
		)
/obj/effect/spawner/lootdrop/random_ammo_protolathe_lootdrop
	loot = list(
			/obj/item/stock_parts/cell/gun/upgraded = 5,
			/obj/item/ammo_box/magazine/smgm9mm = 7
		)

//CIRCUIT IMPRINTER
/obj/effect/spawner/lootdrop/random_machine_cicuit_common
	loot = list(
			/obj/item/circuitboard/machine/autodoc = 5,
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
			/obj/item/circuitboard/machine/emitter = 5
		)

/obj/effect/spawner/lootdrop/random_machine_cicuit_rare
	loot = list(
			/obj/item/circuitboard/aicore = 5,
			/obj/item/circuitboard/machine/chem_dispenser = 5,
			/obj/item/circuitboard/machine/circuit_imprinter = 5,
			/obj/item/circuitboard/machine/protolathe = 5,
			/obj/item/circuitboard/machine/clonepod/experimental = 5,
			/obj/item/circuitboard/machine/rad_collector = 5
		)

/obj/effect/spawner/lootdrop/random_machine_cicuit_mech
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
			/obj/item/circuitboard/mecha/durand/targeting = 1
		)

//COMPUTER
/obj/effect/spawner/lootdrop/random_computer_cicuit_common
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
			/obj/item/circuitboard/computer/teleporter = 5
		)

/obj/effect/spawner/lootdrop/random_computer_cicuit_rare
	loot = list(
			/obj/item/circuitboard/computer/crew = 5,
			/obj/item/circuitboard/computer/cargo/express = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/shuttle/helm = 5,
			/obj/item/circuitboard/computer/operating = 5,
			/obj/item/circuitboard/computer/med_data = 5
		)
