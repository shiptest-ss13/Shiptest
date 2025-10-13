/obj/machinery/air_sensor/ship/shetland/air
	id_tag = "shetland_air"

/obj/machinery/air_sensor/ship/shetland/o2
	id_tag = "shetland_oxygen"

/obj/machinery/air_sensor/ship/shetland/n2
	id_tag = "shetland_nitrogen"

/obj/machinery/air_sensor/ship/shetland/plasma
	id_tag = "shetland_plasma"

/obj/machinery/air_sensor/ship/shetland/burn
	id_tag = "shetland_burn"

/obj/machinery/computer/atmos_control/ship/shetland
	sensors = list(
		"shetland_air" = "Starboard Airmix Chamber",
		"shetland_oxygen" = "Portside Oxygen Chamber",
		"shetland_nitrogen" = "Starboard Nitrogen Chamber",
		"shetland_plasma" = "Portside Plasma Chamber",
		"shetland_burn" = "TEG Burn Chamber",
	)

/obj/item/storage/backpack/satchel/flat/shetland/PopulateContents()
	new /obj/item/blackmarket_uplink(src)
	new /obj/item/spacecash/bundle/smallrand(src)
	new /obj/item/photo/old(src)
	new /obj/item/reagent_containers/food/drinks/bottle/absinthe(src)

