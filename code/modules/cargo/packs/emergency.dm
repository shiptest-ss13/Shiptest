/datum/supply_pack/emergency
	category = "Emergency & Life Support"
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

/datum/supply_pack/emergency/oxygen_candle
	name = "Oxygen Candle Crate"
	desc = "Contains an oxygen candle, a portable solution to filling rooms with breathable oxygen."
	cost = 50
	contains = list(/obj/item/oxygen_candle)
	crate_name = "oxygen candle crate"

/datum/supply_pack/emergency/plasmaman_tank
	name = "Phorid Internals Crate"
	desc = "Contains a Phorid belt tank, for when you just can't bear to refill a normal tank with plasma. Plasma canisters sold separately."
	cost = 50
	contains = list(/obj/item/tank/internals/plasmaman/belt/full)
	crate_name = "phorid internals crate"

/datum/supply_pack/emergency/plasmaman_suit
	name = "Phorid Suit Kit"
	desc = "Keep the Phorid in your life comfy with a Phorid envirosuit. Refills sold seperately."
	cost = 500 //halves the price, halves the equipment. It's unlikely you need to equip more than 1 phorid at a time anyway
	contains = list(/obj/item/clothing/under/plasmaman,
					/obj/item/clothing/head/helmet/space/plasmaman,
					/obj/item/clothing/gloves/color/plasmaman)
	crate_name = "phorid supply kit"

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
	desc = "Only you can prevent plasma fires. Contains a single set of firefighter's equipment."
	cost = 500
	contains = list(/obj/item/clothing/suit/fire/firefighter,
					/obj/item/clothing/mask/gas,
					/obj/item/extinguisher,
					/obj/item/clothing/head/hardhat/red)
	crate_name = "firefighting crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/radiation
	name = "Radiation Protection Crate"
	desc = "Survive nuclear wars and overclocked engines alike with this radiation suit. Contains a helmet, suit, and Geiger counter. Comes with a glass of vodka and Night of Fire commemorative shot glass."
	cost = 1250
	contains = list(/obj/item/clothing/head/radiation,
					/obj/item/clothing/suit/radiation,
					/obj/item/geiger_counter,
					/obj/item/reagent_containers/food/drinks/bottle/vodka,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/commemorative)
	crate_name = "radiation protection crate"
	crate_type = /obj/structure/closet/crate/radiation

/datum/supply_pack/emergency/bio
	name = "Biological Emergency Crate"
	desc = "This crate holds one full bio suit, a pair of latex gloves, a biohazard bag, and a spaceacillin syringe. Offers excellent protection from diseases and acid attacks alike."
	cost = 1250
	contains = list(/obj/item/clothing/head/bio_hood,
					/obj/item/clothing/suit/bio_suit,
					/obj/item/clothing/gloves/color/latex,
					/obj/item/storage/bag/bio,
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
