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
	new /obj/item/food/grown/cannabis(src)

/obj/item/paper/fluff/ship/shetland/inspection
	name = "Inspection Notice"
	default_raw_text = {"<html>
			<center>
			<font size=6><b>BUG INSPETION</b></font>
			<center><table style="width: 90%;" border="2">
			<tr>
			<td>fr.shoalscrub.com</font></td><td>~250 Insection/Year</td><td>150+ Year Working</td>
			</tr>
			</table>
			</center>
			<hr>
			<table style align="center" width="60%" border="3">
			<tr>
			<td>
			<center><font color="#b91717" size=5><b>[PROBLEM]
			</td>
			</tr>
			</table>
			Complimentry inpetion finish, bug many in walls, laundry here. I is offer fumigate follow up next week, cheap price!!! 52 credit!!  Get rid of bug 🐜 permnent. Contact soon
			"}
