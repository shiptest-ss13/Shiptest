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
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<center><h1>BUG INSPETION REPORT</h1>
			<body>
			<hr>
			<table align=/"center/" width="100%" style="width: 90%;" border="2">
			<tr>
			<td>fr.shoalscrub.com</td>
			<td style="padding-top:%">
			~250 Insection/year</font>
			</td>
			<td>150+ Year working</td>
			</tr>
			</table>
			<hr>
			<table align=/"center/" width="100%" style="width: 90%;" border="2">
			<tr>
			<td><center><font size=5 color="#b91717"><b>PROBLEM</b></font></center></td>
			</tr>
			</table>
			<table align=/"left/" width="100%" style="width: 90%;" border="2">
			<tr>
			<td><b>SIRVICES</b></td>
			</tr>
			<tr>
			<td style="padding-top:%">
			<b>Yes</b> Inspetion
			</td>
			</tr>
			<tr>
			<td><b>no</b> Treetmunt </td>
			</tr>
			</table>
			</center>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>REPORT:</strong><br>
			<b>1.</b> Searching ship. bug mostlies back-end, engines, pipes<br>
			<b>2.</b> clothes washroom. bug many in walls, here.. Egg. <br>
			<b>3.</b> seal Bugs in room. welds vent, airlock. close to visitor<br>
			<b>5.</b> Bug poison clean for cheap price, next week i call. Cheap price
			"}
