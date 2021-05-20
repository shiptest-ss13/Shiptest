/**
Uplink Items
**/

/* Dangerous Weapons */
/datum/uplink_item/dangerous/weebstick
	name = "Nanoforged Katana"
	desc = "A tailor-made blade forged from one of the many ninja clans within the syndicate. \
			Merely weilding this weapon grants incredible agility."
	item = /obj/item/storage/belt/weebstick
	cost = 10
	surplus = 5
	limited_stock = 1

/datum/uplink_item/dangerous/tec9
	name = "TEC9 Machine Pistol"
	desc = "A powerful machine pistol sporting a high rate of fire and armor-piercing rounds."
	item = /obj/item/gun/ballistic/automatic/pistol/tec9
	cost = 12
	surplus = 20

/datum/uplink_item/dangerous/ebr
	name = "M514 EBR"
	desc = "A cheap rifle with high stopping power and low capacity."
	item = /obj/item/gun/ballistic/automatic/ebr
	cost = 8
	surplus = 20
	include_modes = list(/datum/game_mode/nuclear)

/*Stealthy Weapons*/
/datum/uplink_item/stealthy_weapons/derringerpack
	name = "Compact Derringer"
	desc = "An easily concealable handgun capable of firing .357 rounds. Comes in an inconspicuious packet of cigarettes with additional munitions."
	item = /obj/item/storage/fancy/cigarettes/derringer
	cost = 8
	surplus = 30
	surplus_nullcrates = 40

/datum/uplink_item/stealthy_weapons/derringerpack/purchase(mob/user, datum/component/uplink/U)
	if(prob(1)) //For the 1%
		item = /obj/item/storage/fancy/cigarettes/derringer/gold
	..()

/datum/uplink_item/stealthy_weapons/syndi_borer
	name = "Syndicate Brain Slug"
	desc = "A small cortical borer, modified to be completely loyal to the owner. \
			Genetically infertile, these brain slugs can assist medically in a support role, or take direct action \
			to assist their host."
	item = /obj/item/antag_spawner/syndi_borer
	refundable = TRUE
	cost = 10
	surplus = 20 //Let's not have this be too common
	exclude_modes = list(/datum/game_mode/nuclear)

/*Botany*/
/datum/uplink_item/role_restricted/lawnmower
	name = "Gas powered lawn mower"
	desc = "A lawn mower is a machine utilizing one or more revolving blades to cut a grass surface to an even height, or bodies if that's your thing"
	restricted_roles = list("Botanist")
	cost = 14
	item = /obj/vehicle/ridden/lawnmower/emagged

/*General Combat*/
/datum/uplink_item/device_tools/telecrystal/bonemedipen
	name = "C4L-Z1UM medipen"
	desc = "A medipen stocked with an agent that will help regenerate bones and organs. A single-use pocket Medbay visit."
	item = /obj/item/reagent_containers/hypospray/medipen/bonefixingjuice
	cost = 3

/*Ammo*/
/datum/uplink_item/ammo/tec9
	name = "TEC9 Magazine"
	desc = "An additional 20 round 9mm magazine for the TEC9."
	item = /obj/item/ammo_box/magazine/tec9
	cost = 3
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)

/datum/uplink_item/ammo/ebr
	name = "M2514 EBR Magazine"
	desc = "An additional 10 round .308 magazine for the EBR."
	item = /obj/item/ammo_box/magazine/ebr
	cost = 2
	include_modes = list(/datum/game_mode/nuclear)

/*Species Restricted*/
/datum/uplink_item/race_restricted/razorwing
	name = "Razorwing Implant"
	desc = "Put those wings to good use! This implant makes your wingtips razor sharp and gives you the ability to flourish them, slicing anyone in range."
	cost = 4
	item = /obj/item/storage/box/syndie_kit/razorwing
	restricted_species = list("moth")

/datum/uplink_item/race_restricted/lampbang
	name = "Lanternbang"
	desc = "This LepiCorp-brand lantern has the ability to overload its lightbulb, blinding and confusing anyone in a radius around it except for its holder."
	cost = 5
	item = /obj/item/flashlight/lantern/lanternbang
	restricted_species = list("moth")

/*Role Restricted*/
/datum/uplink_item/role_restricted/greykingsword
	name = "Blade of The Grey Tide"
	desc = "A weapon of legend, forged by the greatest crackheads of our generation."
	item = /obj/item/melee/greykingsword
	cost = 2
	restricted_roles = list("Assistant", "Chemist")
