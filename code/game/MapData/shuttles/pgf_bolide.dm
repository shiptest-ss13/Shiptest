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

/obj/item/paper/fluff/ship/bolide/one
	name = "Official Briefing"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Official Briefing<br> Elated Bolide Class Assault Lander</b>
			</td>
			<td>05 - 12 - 505</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>BRIEFING OF VESSEL COMMAND STAFF:</strong><br>
			<b>1.</b> The Office of Naval Deployment has seen fit to deploy you in command of an Elated Bolide class Frigate Assault Lander (Bolide-class). Congratulations on your assignment. You are expected to coordinate with the Marine Lieutenant assigned to the vessel for the duration of this deployment.<br><br>
			<b>2.</b> A Bolide-class Lander's mission profile is traditionally; landing in occupied regions, planetary assault in contested systems, construction of Navy Infrastructure, assistance of CLIP colonists, and aiding in conducting Federation Readiness Drills.<br><br>
			<b>3.</b> The assignment issued to your vessel is as follows: Identify locations of interest, construct infrastructure, avoid non-decisive confrontations, conduct readiness drills if possible. Deviation from these goals is accepted and expected. Failure to meet any of them will result in an investigatory effort on your command.<br><br>
			<b>4.</b> The Office Of Naval Deployment directs that it is supplied with the following: Reports on construction projects, reports on conflict in area, reports on crew readiness. Failure to supply pertinent reports in a timely fashion will lead to termination of your command.<br><br>
			<b>5.</b> The Office Of Naval Deployment directs that you coordinate with the Marine Lieutenant to ensure a chain of command is followed aboard at all times. The Office recommends assigning 'buddies' to risk-prone marines, assigning 'Team Leaders' to watch over any group of more than 3, and ensuring radio contact at all times.<br><br>
			<b>6.</b> The Office recommends that all other documents in this folder are read, and distributed to the crew as necessary.
			"}

/obj/item/paper/fluff/ship/bolide/two
	name = "Explosive Materials Handling"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Explosive Materials Handling<br> Elated Bolide Class Assault Lander</b>
			</td>
			<td>09 - 01 - 505</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>SAFE STORAGE OF EXPLOSIVE MATERIALS:</strong><br>
			<b>1.</b> The Office of Requisition has seen fit to deploy your command with a complement of explosive compounds. These compounds include - Composition C-4, Composition X-4.<br><br>
			<b>2.</b> Composition C-4 is an dense explosive package composed of; RDX, Plastic binders, plasticizer. Composition C-4 is a stable, malleable explosive meant for demolition usage. It is resistant to detonation from gunshots and jostling. The C-4 charges you have been issued include a detonator in their assembly, and should not be tinkered with by untrained hands.<br><br>
			<b>3.</b> Ensure that any usage of Composition C-4 is monitored and controlled. Do not issue Composition c-4 to your vessel without a cause for such.<br><br>
			<b>4.</b> Composition X-4 is a high powered explosive package composed of an RDX filling mixed with a teslium based detonator, allowing for a far more focused explosion. Unless the casing has degraded, it is safe to handle in the same manner as Composition C-4.<br><br>
			<b>5.</b> Take care in assigning usage of Composition X-4 due to it's increased potency. While focused, an injury resulting from being caught in a blast would likely prove fatal.<br><br>
			<b>6.</b> The Office recommends assigning a trained expert to monitor field usage of explosives.
			"}

/obj/item/paper/fluff/ship/bolide/three
	name = "Crew Relationships"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Crew Relationships<br> Elated Bolide Class Assault Lander</b>
			</td>
			<td>02 - 07 - 505</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>PREVENTION OF INNAPROPRIATE RELATIONSHIPS:</strong><br>
			The Office of Personnel recommends that the captain of any PGFN vessel keep an active eye out for inappropriate relationships in the ranks.<br><br>
			Inappropriate relationships are a relationship that fulfills one of the following criteria; Compromises the integrity of supervisory authority, causes unfairness, involves improper use of rank or position for personal gain, gives the perception that it is exploitive or coercive in nature, can create an adverse effect on good order and discipline or mission accomplishment.<br><br>
			As an officer, behaviors to avoid including enlisted in are; business matters, gambling, dating, sharing living accomodations.<br><br>
			<strong>Actual or perceived, these activities are prohibited. If it looks wrong, it's probably wrong.</strong>
			"}

/obj/item/paper/fluff/ship/bolide/four
	name = "Chain Of Command"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Chain of Command<br> Elated Bolide Class Assault Lander</b>
			</td>
			<td>05 - 11 - 505</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>IMPLEMENTING AN EFFECTIVE CHAIN OF COMMAND:</strong><br>
			The Office of Personnel recommends that the Captain of a PGFN vessel in deployment establish a chain of command that encompasses all crew aboard the vessel.<br><br>
			The ranks of all serving members aboard a vessel creates a natural chain of command for the Captain and any other officers to base any further Chain Of Command alterations upon. It should be stressed that a Captain should avoid issuing field promotions to fulfill an artificial chain of command.<br><br>
			A Captain should discuss any change in chain of command with any other officers aboard before putting it into action. This allows multiple opinions to be fed into the process, thus creating a stronger product.<br><br>
			Aboard a Bolide-class Lander, the Office of Personnel recommends that the captain designate one 'team leader' per three marines aboard. These team leaders should report directly to the Marine Lieutenant, They should be reported to by the two marines in their team. It is not suggested to work the naval engineers into this program, as they are not expected to deploy in combat.<br><br>
			Marines should be made aware that being declared team leader carries no authority unless delegated. In the event of a conflicted chain of command, or contested order, the figure with rank should be obeyed.<br><br>
			This Office recommends monitoring marines for behavioral patterns before assigning a team leader. The ideal marine team leader is cool-headed, rational, and able to make tough choices.
			"}

/obj/item/paper/fluff/ship/pgf/triage
	name = "Emergency Triage"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<font face="serif" size="2">
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Emergency Triage<br> Medical Personnel Notice</b>
			</td>
			<td>03 - 09 - 505</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>UNDERSTANDING EMERGENCY MEDICAL TRIAGE:</strong><br><br>
			<b>PREFACE:</b> In the occurence of a mass casualty event, you may find the accommodations of your assigned medical suite innadequate. In this situation, understanding and using proper triage techniques is a nessecity.<br><br>
			<b>DIRECTING ASSISTANCE:</b> In a mass casualty situation, you as a medical provider are almost certain to be overwhelmed, but you <u>CANNOT</u> allow this to interrupt your ability to direct and provide care. Take volunteers and issue orders to idle hands when possible to help lighten your load. "Walking wounded" may be directed to render self-aid and assist in buying you time for more critically injured casualties. Every little bit can add up to saving a life.<br><br>
			<b>IMMEDIATE-RED:</b> Casualties who are Critically injured and are likely to succumb to their wounds quickly, but may be saved by immediate medical intervention should be marked <u>RED</u> and be prioritized for care over other casualties until stabilized.<br><br>
			<b>DELAYED-ORANGE:</b> Casualties who are severely injured, but are unlikely to succumb to their wounds quickly should be marked <u>ORANGE</u> and be stabilized as soon as possible once <u>IMMEDIATE</u> concern casualties have been stabilized.<br><br>
			<b>MINOR-YELLOW:</b> Casualties who are injured, but their wounds are not immediately life threatening should be marked <u>YELLOW</u> and be directed to render self care or assist with the first aid of others until both <u>IMMEDIATE</u> and <u>DELAYED</u> casualties have been stabilized.
			"}

/obj/item/paper/fluff/ship/pgf/lifesaving
	name = "Combat Lifesaving"
	default_raw_text = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<hr>
			<font face="serif" size="2"><center><b>PAN-GEZENAN FEDERATION MARINE CORPS</b><br>THE BASIC SCHOOL<br>MARINE CORPS TRAINING COMMAND<br>CAMP AKHROZIN, YAVIR 88543-6809<br><br>
			<font face="serif" size="6"><div align="right"><b>
			COMBAT LIFESAVING STANDARDS AND PROCEDURES
			R554926
			REFRESHER HANDOUT</b><br><br>
			<font face="serif" size="3"><div align="left"><u>PREFACE:</u>
			<font face="serif" size="2"> Casualty assessment in a tactical environment and the care to follow are applied under very different circumstances than pre-hospital care in the civilian or medical treatment facility setting. Civilian and MTF care does not have to take into consideration incoming fire, darkness, or other environmental factors. In a tactical environment, the care rendered at the scene of the  injury will most likely occur while the caregiver and the casualty are under effective hostile fire; the threat has not been reduced or the area has not been secured.<br><br>
			It is for this reason that a medically correct intervention performed at the wrong time in combat may lead to further casualties. In other words, good medicine may be bad tactics. Because of this, <b>fire superiority is the best medicine on the battlefield</b>. Consider it the first and best measure to any casualty response plan.<br><br>
			<font face="serif" size="3"><u>FOUR BASIC LIFE SAVING STEPS:</u>
			<font face="serif" size="2"><br><br>
			1. <b>PREVENT MASSIVE HEMORRHAGE</b>:
			Upon beginning treatment of a casualty, the loss of blood must be stemmed immediately. After the loss of even 20% of the body's blood, the casualty will begin to go into hemorrhagic shock. The onset of this shock will happen quickly, as the body can potentially bleed out from <b>anywhere</b> in 60 to 120 seconds.<br><br>
			2. <b>FACILITATE SAFE RESPIRATION</b>:
			Oftentimes, combat operations will take your unit to an environment with an unsafe or otherwise unbreathable atmosphere. Oxygen is vital to the survival of a casualty and its availability must be ensured. If a casualty is suffocating, ensure their airway is clear and if applicable, provide internals. Oxygen tanks <b>MUST</b> be attached to the casualty's belt or suit storage for easy identification and valve operation. Newly applied oxygen tanks <b>MUST</b> have their valves opened and a mask applied before air will begin to flow.<br><br>
			3. <b>CHECK FOR BREATHING & CIRCULATION</b>:
			Once the airway is open and safe respiration is facilitated, "look, listen, and feel" for breathing. This means placing the side of your face close to the victim's mouth and feeling for exhalation on the side of your face, looking at his or her chest for movement and listening for escaping air. Finding signs of circulation can be difficult under even normal circumstances, so look first for signs of movement from the casualty. If there is none, assume that they do not have a pulse. If you are not entirely sure, make a manual check for circulation by means of the carotid or the radial pulse. Administer abdominal thrusts, rescue breaths, and CPR as needed.<br><br>
			4. <b>TREAT FOR SHOCK</b>:
			Advanced shock treatment should be undertaken by trained medical personnel, but until such care is available, ensure the casualty does not suffer from hypothermia and watch for signs of cardiac arrest, administering an epinephrine pen as emergency treatment.<br><br>
			<font face="serif" size="3"><u>MARINE FIRST AID DISTRIBUTION STANDARDS:</u>
			<font face="serif" size="2"><br><br>For every 4 marines deployed, 1 standard first aid kit should be allotted. 1 of the 4 marines shall be designated "Combat Lifesaver". The 3 remaining marines, excluding the "Combat Lifesaver", will be issued from the first aid kit or otherwise provided the following supplies <b>at minimum</b>.<br><br>
			- 5 Lengths of medical sutures<br>
			- 5 Portions of regenerative mesh<br>
			- 5 Lengths of hemostatic gauze<br>
			- 1 Epinephrine medipen<br>
			- 1 Extremity splint<br><br>
			These supplies are to be carried <b>at all times</b> while on combat deployment, either securely on their person or within a container which has been <b>clearly marked</b> "First Aid", "IFAK", "BooBoo Box" or another derivative there-of.<br><br>
			The "Combat Lifesaver" should retain the standard first aid kit and keep it on their person. The contents within should include the following supplies <b>at minimum</b>.<br><br>
			- 15 Lengths of medical Sutures<br>
			- 15 Portions of regenerative mesh<br>
			- 6 Lengths of hemostatic gauze<br>
			- 4 Extremity splints<br>
			- 1 Epinephrine medipen<br>
			- 1 Handheld health analyzer<br><br>
			Additional space in both detailed medical kits may be utilized however the bearer sees fit. Medical equipment may be added to or swapped out of the described kits and is an encouraged practice, treating the equipment listed above as a baseline.
			"}
