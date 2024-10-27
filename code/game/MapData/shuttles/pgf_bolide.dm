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

/obj/structure/closet/crate/rations/PopulateContents()
	. = ..()
	for(var/i in 1 to ration_count)
		new /obj/effect/spawner/random/food_or_drink/ration(src)

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

/obj/item/folder/pgf/blue/bolide/Initialize()
	. = ..()
	new /obj/item/paper/fluff/ship/bolide/one(src)
	new /obj/item/paper/fluff/ship/bolide/two(src)
	new /obj/item/paper/fluff/ship/bolide/three(src)
	new /obj/item/paper/fluff/ship/bolide/four(src)
	update_appearance()

/obj/item/folder/pgf/empty_sheets
	name = "PGF Fax Templates"

/obj/item/folder/pgf/empty_sheets/Initialize()
	. = ..()
	for(var/i in 1 to 7)
		new /obj/item/paper/fluff/ship/bolide(src)

/mob/living/simple_animal/pet/fox/bolide
	name = "Saperzy"
	desc = "A lovable rogue that scampered aboard during a readiness drill. Now an honorary marine."
	gender = MALE
	unique_pet = TRUE
	icon_state = "saperzy"
	icon_living = "saperzy"
	icon_dead = "fox_dead"
	faction = list("neutral", FACTION_PLAYER_GEZENA)
	speak = list("Ack-Ack","Ack-Ack-Ack-Ackawoooo","Geckers","Awoo","Tchoff","Aweh!")
	speak_emote = list("geckers!", "barks!", "yips!")
	emote_hear = list("yips!","barks!","geckers!")
	emote_see = list("sits at attention.", "shakes his fur out.", "wags a few times.", "perks up.","sniffs the air.")

/obj/item/paper/fluff/ship/bolide
	name = "Blank Federated Navy Paperwork"
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
							<b>Pan Gezenan Federation Navy<br> Bolide-Class Lander</b>
						</td>
						<td>XX - XX - 506</td>
					</tr>
				</table>
			</font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>FOR IMMEDIATE DISTRIBUTION</strong><br>
			<strong>SUBJECT: </strong>
			"}

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

/obj/item/paper/fluff/ship/bolide/two
	name = "Explosive Materials Handling"
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
							<b>Pan Gezenan Federation Navy<br>Office Of Requisitions</b>
						</td>
						<td>XX - XX - 506</td>
					</tr>
				</table>
			</font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>FOR IMMEDIATE DISTRIBUTION</strong><br>
			<strong>SUBJECT: Safe storage of explosive materials</strong>
			<hr>
			<br>
			<p>1. The Office of Requisition has seen fit to deploy your command with a complement of explosive compounds. These compounds include - Composition C-4, Composition X-4.</p>
			<p>2. Composition C-4 is an dense explosive package composed of; RDX, Plastic binders, plasticizer. Composition C-4 is a stable, malleable explosive meant for demolition usage. It is resistant to detonation from gunshots and jostling. The C-4 charges you have been issued include a detonator in their assembly, and should not be tinkered with by untrained hands.</p>
			<p>3. Ensure that any usage of Composition C-4 is monitored and controlled. Do not issue Composition c-4 to your vessel without a cause for such.</p>
			<p>4. Composition X-4 is a high powered explosive package composed of an RDX filling mixed with a teslium based detonator, allowing for a far more focused explosion. Unless the casing has degraded, it is safe to handle in the same manner as Composition C-4.</p>
			<p>5. Take care in assigning usage of Composition X-4 due to it's increased potency. While focused, an injury resulting from being caught in a blast would likely prove fatal. </p>
			<p>6. The Office recommends assigning a trained expert to monitor field usage of explosives.</p>
			<br>
			<br>
			</div>
			"}

/obj/item/paper/fluff/ship/bolide/three
	name = "Marine Relationships"
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
							<b>Pan Gezenan Federation Navy<br>Office Of Personnel</b>
						</td>
						<td>XX - XX - 506</td>
					</tr>
				</table>
			</font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>FOR IMMEDIATE DISTRIBUTION</strong><br>
			<strong>SUBJECT: Prevention of Inappropriate Relationships.</strong>
			<hr>
			<br>
			<p>The Office of Personnel recommends that the captain of any PGFN vessel keep an active eye out for inappropriate relationships in the ranks.</p>
			<p>Inappropriate relationships are a relationship that fulfills one of the following criteria; Compromises the integrity of supervisory authority, causes unfairness, involves improper use of rank or position for personal gain, gives the perception that it is exploitive or coercive in nature, can create an adverse effect on good order and discipline or mission accomplishment.  </p>
			<p>As an officer, behaviors to avoid including enlisted in are; business matters, gambling, dating, sharing living accomodations.</p>
			<p><strong>Actual or percieved, these activities are prohibited. If it looks wrong, it's probably wrong.</strong></p>
			<br>
			<br>
			</div>
			"}

/obj/item/paper/fluff/ship/bolide/four
	name = "Chain Of Command"
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
							<b>Pan Gezenan Federation Navy<br>Office Of Personnel</b>
						</td>
						<td>XX - XX - 506</td>
					</tr>
				</table>
			</font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>FOR IMMEDIATE DISTRIBUTION</strong><br>
			<strong>SUBJECT: Chain of Command aboard vessel.</strong>
			<hr>
			<br>
			<p>The Office of Personnel recommends that the Captain of a PGFN vessel in deployment establish a chain of command that encompasses all crew aboard the vessel.</p>
			<p>The ranks of all serving members aboard a vessel creates a natural chain of command for the Captain and any other officers to base any further Chain Of Command alterations upon. It should be stressed that a Captain should avoid issuing field promotions to fulfill an artifical chain of command.</p>
			<p>A Captain should discuss any change in chain of command with any other officers aboard before putting it into action. This allows multiple opinions to be fed into the process, thus creating a stronger product. </p>
			<p>Aboard a Bolide-Class Lander, the Office of Personnel recommends that the captain designate one 'team leader' per three marines aboard. These team leaders should report directly to the Marine Lieutenant, They should be reported to by the two marines in their team. It is not suggested to work the naval engineers into this program, as they are not expected to deploy in combat.</p>
			<p>Marines should be made aware that being declared team leader carries no authority unless delegated. In the event of a conflicted chain of command, or contested order, the figure with rank should be obeyed.</p>
			<p>This Office recommends monitoring marines for behavioral patterns before assigning a team leader. The ideal marine team leader is cool-headed, rational, and able to make tough choices.</p>
			<br>
			<br>
			</div>
			"}

