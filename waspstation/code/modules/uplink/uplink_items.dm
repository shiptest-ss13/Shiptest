/**
Uplink Items
**/

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
