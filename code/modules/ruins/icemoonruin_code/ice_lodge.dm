/obj/item/paper/crumpled/bloody/fluff/ruin/icemoon/cellar_warning
	name = "\improper Scrawled Note"
	default_raw_text = "<center> <br><h1>HEY! YOU. </h1><br><h2>Yeah. You. <br>One of the Hunters got away and holed up in the cellar and set up a whole bunch of traps. Crazy asshole has already killed like four of our guys in the murder basement. So boss says keep the door sealed and let the prick starve.<br><br> SO DONT OPEN IT.</h2>"

/obj/item/paper/crumpled/bloody/fluff/ruin/icemoon/tally_sheet
	name = "\improper Tally Sheet"
	default_raw_text = "<center><h1> Marksmanship Leaderboard </h1></center><br><head><table bgcolor=white width=100% height=15%><center><td><div align = left><table style=width: 100%; border=2><tbody><td width=30%><center><b><code>Name</td><td width= 10%><center><b><code>Points</td><td width= 60%><center><b><code>Notes</td><tr bgcolor =#D6EEEE><td><center>Lance Phillips</td><td><center>10</td><td><center>Hit 2 out of 3 targets.</td></tr><tr><td><center>Hetchel Catuwe-Plakat</td><td><center>0</td><td><center>Missed every shot. Relegated to knife duty.</td></tr><tr bgcolor =#D6EEEE><td><center>Weer-Topith</td><td><center>30</td><td><center>Hit all three targets.</td></tr><tr><td><center>Kahyarawkkahskre</td><td><center>50</td><td><center>Hit all three targets one handed with a revolver.</td></tr><tr bgcolor =#D6EEEE><td><center>Salhree-Yik</td><td><center>100</td><td><center>Hit all three targets while blindfolded.</td><tr><td><center>Kiahkkati</td><td><center>-1000</td><td><center>Tried to one up Salhree and spun three times blindfolded before firing. Hit me in the knee.</td></tr>"

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals/ice_lodge
	name = "Commander Tiyak"
	desc = "A towering Vox holding a gun almost big as they are. The shotgun slugs on their bandolier hum with a menacing energy."
	rapid = 8
	casingtype = /obj/item/ammo_casing/shotgun/pulseslug
	r_hand = /obj/item/gun/ballistic/automatic/hmg/shredder
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals/ice_lodge
	armor_base = /obj/item/clothing/suit/armor/vest/marine/frontier
	weapon_drop_chance = 0
	species_spawner = /datum/species/vox

/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals/ice_lodge
	mob_species = /datum/species/vox
	outfit = /datum/outfit/frontier/officer/internals/ice_lodge

/datum/outfit/frontier/officer/internals/ice_lodge
	name = "Frontiersman Officer Corpse Internals (Ice Lodge)"
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/armor/vest/marine/frontier
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/pulseslug = 2)

