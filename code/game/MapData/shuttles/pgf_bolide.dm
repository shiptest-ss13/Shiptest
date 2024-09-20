/obj/machinery/air_sensor/ship/bolide/air
	id_tag = "bolide_air"

/obj/machinery/air_sensor/ship/bolide/fuel
	id_tag = "bolide_fuel_1"

/obj/machinery/air_sensor/ship/bolide/fuel_2
	id_tag = "bolide_fuel_2"

/obj/machinery/computer/atmos_control/ship/bolide
	sensors = list(
		"bolide_air" = "Airmix Chamber",
		"bolide_fuel_1" = "Port Fuel Chamber",
		"bolide_fuel_2" = "Starboard Fuel Chamber",
	)

//this should go somewhere else
/obj/structure/closet/crate/rations
	name = "ration crate"
	desc = "A rectangular steel crate, filled with marine food."
	var/ration_count = 10

/obj/structure/closet/crate/freezer/blood/PopulateContents()
	. = ..()
	for(var/i in 1 to ration_count)
		new /obj/effect/spawner/lootdrop/ration(src)

/obj/item/storage/toolbox/explosives
	name = "\improper explosives handling kit"
	desc = "Be careful to not jostle it."
	icon_state = "explosive"
	item_state = "toolbox_red"
	latches = "double_latch"

/obj/item/storage/toolbox/explosives/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	for(var/i in 1 to 4)
		new /obj/item/assembly/signaler(src)

/obj/structure/toilet/secret/bolide
	secret_type = /obj/item/storage/fancy/cigarettes/cigpack_mindbreaker

/obj/item/folder/pgf/blue/bolide
	var/to_spawn = list()

/mob/living/simple_animal/pet/fox/bolide
	name = "Saperzy"
	desc = "A lovable rogue that scampered aboard during a readiness drill. Now an honorary marine."
	gender = MALE
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE
	icon_state = "saperzy"
	icon_living = "saperzy"
	icon_dead = "fox_dead"
	speak = list("Ack-Ack","Ack-Ack-Ack-Ackawoooo","Geckers","Awoo","Tchoff","Aweh!")
	speak_emote = list("geckers!", "barks!", "yips!")
	emote_hear = list("yips!","barks!","geckers!")
	emote_see = list("sits at attention.", "shakes his fur out.", "wags a few times.", "perks up.","sniffs the air.")

/obj/item/paper/fluff/ship/bolide

/obj/item/paper/fluff/ship/bolide/one
	name = "Official Briefing"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<font face="Courier New">
				<table align=/"center/" width="100%">
					<tr>
						<td>logo here (one day)</td>
						<td style="padding-top:10%">
							<b>Pan Gezenan Federation Navy<br>Office of Naval Deployment</b>
						</td>
						<td>XX - XX - 506</td>
					</tr>
				</table>
			</font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>FOR IMMEDIATE DISTRIBUTION</strong><br>
			<strong>SUBJECT: Briefing Crew of Vessel</strong>
			<hr>
			<br>
			<p>1. The Office of Naval Deployment has seen fit to deploy you in command of an Elated Bolide class Frigate Assault Lander (Bolide-Class). Congratulations on your assignment. You are expected to coordinate with the Marine Lieutenant assigned to the vessel for the duration of this deployment.</p>
			<p>2. A Bolide-class Lander's mission profile is traditionally; landing in occupied regions, planetary assault in contested systems, construction of Navy Infrastructure, assistance of CLIP colonists, and aiding in conducting Federation Readiness Drills.</p>
			<p>3. The assignment issued to your vessel is as follows: Identify locations of interest, construct infrastructure, avoid non-decisive confrontations, conduct readiness drills if possible. Deviation from these goals is accepted and expected. Failure to meet any of them will result in an investigatory effort on your command.</p>
			<p>4. The Office Of Naval Deployment directs that it is supplied with the following: Reports on construction projects, reports on conflict in area, reports on crew readiness. Failure to supply pertinent reports in a timely fashion will lead to termination of your command.</p>
			<p>5. The Office Of Naval Deployment directs that you coordinate with the Marine Lieutenant to ensure a chain of command is followed aboard at all times. The Office recommends assigning 'buddies' to risk-prone marines, assigning 'Team Leaders' to watch over any group of more than 3, and ensuring radio contact at all times.</p>
			<p>6. The Office recommends that all other documents in this folder are read, and distributed to the crew as necessary.</p>
			<br>
			<br>
			</div>
			<p>
				<div align=/"left/" style=/"padding-left:65%/">
					<font face="Segoe Script">Eutei-Tar</font><br>
					Eutei-Tar<br>
					Vice Admiral, PGF Navy<br>
					Assistant Director Of the Office Of Navy Deployment</div>
			</p>
			"}
