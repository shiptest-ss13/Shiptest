//ngr prison jumpsuit

/obj/item/clothing/under/color/lightbrown/prisoner
	name = "light brown prisoner jumpsuit"
	desc = "A cheap, lightweight jumpsuit. Its suit sensors are locked to the maximum setting."
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

//ruin-exclusive frontie mob that doesnt fit with the rest

/mob/living/simple_animal/hostile/human/frontier/ranged/internals/ngr_colony_ramzifriend
	name = "Frontiersman Smuggler"
	desc = "Once a member of the vicious Frontiersmen fleet, this ex-smuggler seems to have befriended the far more vicious Ramzi Clique. They stroll around with less discipline than their new peers, a jet-black pistol at their hip."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ramzifriend_smuggler
	casingtype = /obj/item/ammo_casing/c57x39mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/asp
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	faction = list(FACTION_RAMZI, FACTION_ANTAG_FRONTIERSMEN) //theyre loyal to their new friends but still loyal to their old comrades
	armor_base = /obj/item/clothing/suit/armor/ramzi

/obj/effect/mob_spawn/human/corpse/frontier/ramzifriend_smuggler
	outfit = /datum/outfit/frontier/internals/smuggler

/datum/outfit/frontier/internals/smuggler
	name = "Frontiersman Smuggler Corpse"
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	suit = /obj/item/clothing/suit/armor/ramzi
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/flashlight
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/security/webbing/ramzi/alt
