/datum/supply_pack/emergency
	group = "Emergency & Life Support"
	crate_type = /obj/structure/closet/crate/internals

/*
		Life support
*/

/datum/supply_pack/emergency/internals
	name = "Internals Crate"
	desc = "Contains four breathing masks, three advanced emergency oxygen tanks and one large oxygen tank. Oxygen canister sold separately."
	cost = 100
	contains = list(/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath,
					/obj/item/tank/internals/emergency_oxygen/engi,
					/obj/item/tank/internals/emergency_oxygen/engi,
					/obj/item/tank/internals/emergency_oxygen/engi,
					/obj/item/tank/internals/oxygen)
	crate_name = "internals crate"

/datum/supply_pack/emergency/plasmaman_tank
	name = "Plasmaman Internals Crate"
	desc = "Contains two plasmaman belt tanks, for when you just can't bear to refill a normal tank with plasma. Plasma canisters sold separately."
	cost = 100
	contains = list(/obj/item/tank/internals/plasmaman/belt/full,
					/obj/item/tank/internals/plasmaman/belt/full)
	crate_name = "plasmaman internals crate"

/datum/supply_pack/emergency/plasmaman_suit
	name = "Plasmaman Suit Kit"
	desc = "Keep the Plasmaman in your life comfy with two sets of Plasmaman envirosuits. Each set contains a plasmaman jumpsuit and helmet; refills sold separately."
	cost = 1000
	contains = list(/obj/item/clothing/under/plasmaman,
					/obj/item/clothing/under/plasmaman,
					/obj/item/clothing/head/helmet/space/plasmaman,
					/obj/item/clothing/head/helmet/space/plasmaman,
					/obj/item/clothing/gloves/color/plasmaman,
					/obj/item/clothing/gloves/color/plasmaman)
	crate_name = "plasmaman supply kit"

/*
		Niche protection
*/

/datum/supply_pack/emergency/atmostank
	name = "Firefighting Tank Backpack"
	desc = "Mow down fires with this high-capacity fire fighting tank backpack."
	cost = 1500
	contains = list(/obj/item/watertank/atmos)
	crate_name = "firefighting backpack crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/firefighting
	name = "Firefighting Crate"
	desc = "Only you can prevent plasma fires. Partner up with two firefighter suits, gas masks, extinguishers, and hardhats!"
	cost = 2000
	contains = list(/obj/item/clothing/suit/fire/firefighter,
					/obj/item/clothing/suit/fire/firefighter,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/extinguisher,
					/obj/item/extinguisher,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/clothing/head/hardhat/red)
	crate_name = "firefighting crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/radiation
	name = "Radiation Protection Crate"
	desc = "Survive nuclear wars and overclocked engines alike with two sets of radiation suits. Each set contains a helmet, suit, and Geiger counter. Comes with a glass of vodka and two Night of Fire commemorative shot glasses."
	cost = 2500
	contains = list(/obj/item/clothing/head/radiation,
					/obj/item/clothing/head/radiation,
					/obj/item/clothing/suit/radiation,
					/obj/item/clothing/suit/radiation,
					/obj/item/geiger_counter,
					/obj/item/geiger_counter,
					/obj/item/reagent_containers/food/drinks/bottle/vodka,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/commemorative,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/commemorative)
	crate_name = "radiation protection crate"
	crate_type = /obj/structure/closet/crate/radiation

/datum/supply_pack/emergency/bio
	name = "Biological Emergency Crate"
	desc = "This crate holds 2 full bio suits, 2 pairs of latex gloves, and a pair of spaceacillin syringes. Offers excellent protection from diseases and acid attacks alike."
	cost = 2500
	contains = list(/obj/item/clothing/head/bio_hood,
					/obj/item/clothing/head/bio_hood,
					/obj/item/clothing/suit/bio_suit,
					/obj/item/clothing/suit/bio_suit,
					/obj/item/clothing/gloves/color/latex,
					/obj/item/clothing/gloves/color/latex,
					/obj/item/storage/bag/bio,
					/obj/item/reagent_containers/syringe/antiviral,
					/obj/item/reagent_containers/syringe/antiviral)
	crate_name = "bio suit crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/emergency/bomb
	name = "Explosive Emergency Crate"
	desc = "Contains a bomb suit, gas mask, and set of basic bomb defusal tools. Good luck."
	cost = 3000
	contains = list(/obj/item/clothing/head/bomb_hood,
					/obj/item/clothing/suit/bomb_suit,
					/obj/item/clothing/mask/gas,
					/obj/item/screwdriver,
					/obj/item/wirecutters,
					/obj/item/multitool)
	crate_name = "bomb suit crate"
	crate_type = /obj/structure/closet/crate/science
