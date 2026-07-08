/obj/machinery/air_sensor/ship/bolide/air
	id_tag = "bolide_air"

/obj/machinery/air_sensor/ship/bolide/fuel_port
	id_tag = "bolide_fuel_port"

/obj/machinery/air_sensor/ship/bolide/fuel_starboard
	id_tag = "bolide_fuel_starboard"

/obj/machinery/computer/atmos_control/ship/bolide
	sensors = list(
		"bolide_air" = "Air Mix Chamber",
		"bolide_fuel_port" = "Port Fuel Mix Chamber",
		"bolide_fuel_starboard" = "Starboard Fuel Mix Chamber",
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
	new /obj/item/paper/fluff/ship/pgf/relations(src)
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
			<b>1.</b> The Office of Naval Deployment has seen fit to deploy you in command of an Elated Bolide class Frigate Assault Lander (Bolide-class). Congratulations on your assignment. You are expected to coordinate with the Marine Squad Leader assigned to the vessel for the duration of this deployment.<br><br>
			<b>2.</b> A Bolide-class Lander's mission profile is traditionally; landing in occupied regions, planetary assault in contested systems, construction of Navy Infrastructure, assistance of CLIP colonists, and aiding in conducting Federation Readiness Drills.<br><br>
			<b>3.</b> The assignment issued to your vessel is as follows: Identify locations of interest, construct infrastructure, avoid non-decisive confrontations, conduct readiness drills if possible. Deviation from these goals is accepted and expected. Failure to meet any of them will result in an investigatory effort on your command.<br><br>
			<b>4.</b> The Office Of Naval Deployment directs that it is supplied with the following: Reports on construction projects, reports on conflict in area, reports on crew readiness. Failure to supply pertinent reports in a timely fashion will lead to termination of your command.<br><br>
			<b>5.</b> The Office Of Naval Deployment directs that you coordinate with the Marine Squad Leader to ensure a chain of command is followed aboard at all times. The Office recommends assigning 'buddies' to risk-prone marines, assigning 'Team Leaders' for any group of 3 or more, and ensuring radio contact at all times.<br><br>
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
			<b>3.</b> Ensure that any usage of Composition C-4 is monitored and controlled. Do not issue Composition C-4 to your vessel without a cause for such.<br><br>
			<b>4.</b> Composition X-4 is a high powered explosive package composed of an RDX filling mixed with a teslium based detonator, allowing for a far more focused explosion. Unless the casing has degraded, it is safe to handle in the same manner as Composition C-4.<br><br>
			<b>5.</b> Take care in assigning usage of Composition X-4 due to it's increased potency. While focused, an injury resulting from being caught in a blast would likely prove fatal.<br><br>
			<b>6.</b> The Office recommends the field usage of explosives is monitored and performed only by those with appropriate training.
			"}

/obj/item/paper/fluff/ship/bolide/three
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
			Aboard a Bolide-class Lander, the Office of Personnel recommends that the captain designate one 'team leader' per three marines aboard. These team leaders should report directly to the Marine Squad Leader, They should be reported to by the two marines in their team. It is not suggested to work the naval engineers into this program, as they are not expected to deploy in combat.<br><br>
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
			<hr>
			<font face="serif" size="2"><center><b>PAN-GEZENAN FEDERATION MARINE CORPS</b><br>THE BASIC SCHOOL<br>MARINE CORPS TRAINING COMMAND<br>CAMP AKHROZIN, YAZIR 88543-6809<br><br>
			<font face="serif" size="6"><div align="right"><b>
			COMBAT LIFESAVING STANDARDS AND PROCEDURES<br>
			R554926<br>
			REFRESHER HANDOUT</b><br><br>
			<font face="serif" size="3"><div align="left"><u>PREFACE:</u>
			<font face="serif" size="2"><br> Casualty assessment in a tactical environment and the care to follow are applied under very different circumstances than pre-hospital care in the civilian or medical treatment facility setting. Civilian and MTF care does not have to take into consideration incoming fire, darkness, or other environmental factors. In a tactical environment, the care rendered at the scene of the  injury will most likely occur while the caregiver and the casualty are under effective hostile fire; the threat has not been reduced or the area has not been secured.<br><br>
			It is for this reason that a medically correct intervention performed at the wrong time in combat may lead to further casualties. In other words, good medicine may be bad tactics. Because of this, <b>fire superiority is the best medicine on the battlefield</b>. Consider it the first and best measure to any casualty response plan.<br><br>
			<font face="serif" size="3"><u>FOUR BASIC LIFE SAVING STEPS:</u>
			<font face="serif" size="2"><br>
			1. <b>PREVENT MASSIVE HEMORRHAGE</b>:
			Upon beginning treatment of a casualty, the loss of blood must be stemmed immediately. After the loss of even 20% of the body's blood, the casualty will begin to go into hemorrhagic shock. The onset of this shock will happen quickly, as the body can potentially bleed out from <b>anywhere</b> in 60 to 120 seconds.<br><br>
			2. <b>FACILITATE SAFE RESPIRATION</b>:
			Oftentimes, combat operations will take your unit to an environment with an unsafe or otherwise unbreathable atmosphere. Oxygen is vital to the survival of a casualty and its availability must be ensured. If a casualty is suffocating, ensure their airway is clear and if applicable, provide internals. Oxygen tanks <b>MUST</b> be attached to the casualty's belt or suit storage for easy identification and valve operation. Newly applied oxygen tanks <b>MUST</b> have their valves opened and a mask applied before air will begin to flow.<br><br>
			3. <b>CHECK FOR BREATHING & CIRCULATION</b>:
			Once the airway is open and safe respiration is facilitated, "look, listen, and feel" for breathing. This means placing the side of your face close to the victim's mouth and feeling for exhalation on the side of your face, looking at his or her chest for movement and listening for escaping air. Finding signs of circulation can be difficult under even normal circumstances, so look first for signs of movement from the casualty. If there is none, assume that they do not have a pulse. If you are not entirely sure, make a manual check for circulation by means of the carotid or the radial pulse. Administer abdominal thrusts, rescue breaths, and CPR as needed.<br><br>
			4. <b>TREAT FOR SHOCK</b>:
			Advanced shock treatment should be undertaken by trained medical personnel, but until such care is available, ensure the casualty does not suffer from hypothermia and watch for signs of cardiac arrest, administering an epinephrine pen as emergency treatment.<br><br>
			<font face="serif" size="3"><u>MARINE FIRST AID DISTRIBUTION STANDARDS:</u>
			<font face="serif" size="2"><br>For every team of marines deployed, the following standard of first aid equipment should be allotted with at least 1 marine being designated "Combat Lifesaver". The marines, excluding the "Combat Lifesaver", should be issued or otherwise provided the following supplies <b>at minimum</b>.<br><br>
			- 5 Lengths of medical sutures<br>
			- 5 Portions of regenerative mesh<br>
			- 5 Lengths of hemostatic gauze<br>
			- 1 Epinephrine medipen<br>
			- 1 Extremity splint<br><br>
			These supplies are to be carried <b>at all times</b> while on combat deployment, either securely on their person or within a container which has been <b>clearly marked</b> "First Aid", "IFAK", "BooBoo Box" or another derivative there-of.<br><br>
			The "Combat Lifesaver" should be issued or otherwise provided the following supplies <b>at minimum</b>.<br><br>
			- 15 Lengths of medical Sutures<br>
			- 15 Portions of regenerative mesh<br>
			- 6 Lengths of hemostatic gauze<br>
			- 4 Extremity splints<br>
			- 1 Epinephrine medipen<br>
			- 1 Handheld health analyzer<br><br>
			Additional space in both detailed medical kits may be utilized however the bearer sees fit. Medical equipment may be added to or swapped out of the described kits and is an encouraged practice, treating the equipment listed above as a baseline.
			"}

/obj/item/paper/fluff/ship/pgf/general_quarters
	name = "General Quarters"
	default_raw_text = {"<html>
			<font face="serif" size="2">
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Action Stations Protocol<br> Shipside Personnel Notice </b>
			</td>
			<td>03 - 14 - 507</td>
			</tr>
			</table>
			<hr>
			<b>CALL TO GENERAL QUARTERS:</b><br> General Quarters, or action stations, is the announcement made aboard any Federation warship to signal that all hands (everyone available) aboard a ship must go to their action stations (the positions they are to assume when the vessel is in combat) as quickly as possible.<br><br>
			The generic, unspecialized announcement for General Quarters is as follows:<br><br>
			<b>"This is not a drill. This is not a drill. General Quarters. General Quarters. All hands to action stations."</b><br>
			<I>This announcement may be appended with information concerning the reason for or nature of the call to General Quarters at the discretion of command staff.</I><br><br>
			After this announcement is made, all hands are to react according to their responsibility as detailed below, deviating only as ordered or as the survival of their vessel depends on it.
			<hr>
			<b>BRIDGE STAFF:</b> Upon receiving the call to General Quarters, Bridge staff are to prepare for possible hazards, monitor all active and potential threats to the vessel, and coordinate an efficient ship-wide response. This entails donning or otherwise maintaining an EVA capable suit, relaying intelligence to relevant crew members, addressing and evading further threats, and potentially orchestrating responses personally based on situational need. <br><br>
			<b>CREWMEN:</b> Upon receiving the call to General Quarters, Crewmen are to prepare for fire control. This entails procuring firefighting equipment, equipping sealed internals and donning firesuits or EVA suits as the situation deems necessary. Crewmen are to report to the central accessways of the vessel and respond to fires and minor damages while otherwise awaiting tasking. <br><br>
			<b>ENGINEERS:</b> Upon receiving the call to General Quarters, Engineers are to prepare to conduct emergency repairs to the vessel’s key machinery and superstructure. This entails procuring repair material, equipping tools, and donning an EVA capable suit. Special priority should be allotted to the maintenance of the vessel’s power, propulsion, and control systems. Life support should be prioritized for the central accessways and infirmary with all other sections being regarded as secondary priority during General Quarters.<br><br>
			<b>MEDICAL STAFF:</b> Upon receiving the call to General Quarters, Medical staff are to prepare the infirmary for a possible mass casualty event. This entails procuring emergency medical supplies, preparing to conduct triage, and donning or otherwise maintaining an EVA capable suit. Medical staff are to treat casualties as they occur, potentially retrieving casualties and evacuating them to the infirmary based on situational need.<br><br>
			<b>MARINES:</b> Upon receiving the call to General Quarters, Marines are to prepare to ensure the security of the vessel, possibly launching an attack or repelling boarders. This entails procuring arms, ammunition, and first aid supplies, establishing teams, and donning EVA capable combat suits. Marines are to prioritize the security of the Bridge, CIC, and Engineering sections of the vessel, with all other sections being regarded as secondary priority during General Quarters.
			<hr>
			<b>STAND DOWN FROM GENERAL QUARTERS:</b><br> Once active or probable threat has been cleared from the vessel, the order to Stand Down may be announced, at which point all hands may relax from their action stations and return to Standards (standard conditions).<br><br>
			The Stand Down announcement from General Quarters is as follows:<br><br>
			<b>"Stand Down. Stand Down. All hands return to Standards."</b>
			"}

/obj/item/paper/fluff/ship/pgf/radio_etiquette
	name = "Radio Etiquette"
	default_raw_text = {"<html>
			<hr>
			<font face="serif" size="2"><center><b>PAN-GEZENAN FEDERATION MARINE CORPS</b><br>THE BASIC SCHOOL<br>MARINE CORPS TRAINING COMMAND<br>CAMP AKHROZIN, YAZIR 88543-6809<br><br>
			<font face="serif" size="6"><div align="right"><b>
			BASICS OF OPERATIONAL RADIO ETIQUETTE<br>
			R591483<br>
			REFRESHER HANDOUT</b><br><br>
			<font face="serif" size="3"><div align="left"><u>PREFACE:</u>
			<font face="serif" size="2"><br> The establishment of clear and efficient lines of communication is oftentimes the difference between the success and failure of an operation. While the relaxed etiquette commonly utilized in civilian radio communication maximizes convenience, such loose practices are inappropriate and oftentimes inadequate for personnel expected to engage in strategic organization.<br><br>
			Similarly, excessive utilization of operational radio etiquette may be detrimental to a unit’s performance by means of overcomplicating or delaying the transmission of orders and information. For this reason, it is the responsibility of all participants to find an appropriate balance of clarity, urgency, and detail as is necessitated by their current situation while minimizing room for miscommunication or doubt.<br><br>
			<font face="serif" size="3"><u>COMMUNICATION:</u>
			<font face="serif" size="2"><br>
			1. <b>CLARITY</b>:
			Proper radio communication should heavily prioritize the clarity of any sent message. Many aspects go into sending a clear and concise message, but one of the most distinct variables is the vocabulary used. Try to use prowords, or procedure words, when able.<br>
			<b>Some examples include:</b><br>
			- Instead of “yes” or “no” use “affirmative” or “negative”.<br>
			- Instead of “repeat” or “what?” use “I say again” or “say again”.<br>
			- Instead of “that was wrong” or “nevermind” use “correction” or “disregard”.<br><br>
			2. <b>TITLES AND CALLSIGNS</b>:
			Small units are often assigned simple callsigns for ease of communication and organization. These identifiers can vary or may not be used at all. Thusly, it is important to coordinate how your unit will be structured as well as ensure all participating parties are coordinated and aware.<br>
			<b>Some common titles include:</b><br>
			- “Command/Overwatch” = Refers to the collective command structure over your unit, most commonly referring to executive command staff.<br>
			- “Actual” = The individual at the top of the unit’s command hierarchy.<br>
			- “Lead” = An individual assigned to lead a section of the unit who may not be at the top of the unit’s command hierarchy.<br><br>
			3. <b>PROFESSIONALISM</b>:
			During periods of heightened stress, it is easy for even veteran personnel to lose their composure or allow emotion to influence their decisionmaking temporarily. This loss of composure can negatively affect the efficiency of radio communications in any number of ways and must be consciously avoided.<br>
			<b>Notable examples to avoid:</b><br>
			- The dilution of messages with profanities or vulgar language.<br>
			- Namecalling, fingerpointing, or otherwise directing blame.<br>
			- Expressing panic or resignation.<br><br>
			<font face="serif" size="3"><u>ANATOMY OF A MESSAGE:</u>
			<font face="serif" size="2"><br> A properly formatted radio communication should adhere approximately to the following format, especially when initially establishing a transmission.<br><br>
			<b>"{#1 Intended recipient}, this is {#2 Identity of sender}, {#2.5 optional intent} {#3 intended message}, {#4 disposition}"</b><br><br>
			For the sake of simplicity in this refresher, a brief radio conversation between a squad leader, Porter Lead, and their commanding officer, Baron Actual, is simulated below.<br>
			<hr>
			<b>(Porter Lead)</b> "<b>{#1}</b> Baron Actual, this is <b>{#2}</b> Porter Lead. <b>{#3}</b> Hostile compound is now clear. <b>{#4}</b> Awaiting orders, over."<br><br>
			<b>(Baron Actual)</b> "<b>{#1}</b> Porter Lead, <b>{#2}</b> Baron Actual. <b>{#2.5}</b> Interrogative. <b>{#3}</b> How many casualties? <b>{#4}</b> Over."<br><br>
			<b>(Porter Lead)</b> "<b>{#3}</b> Six hostile casualties. <b>{#4}</b> Break."<br><br>
			<b>(Porter Lead)</b> "<b>{#3}</b> One friendly casualty. <b>{#4}</b> Over."<br><br>
			<b>(Baron Actual)</b> "<b>{#2.5}</b> Acknowledged, Porter Lead. <b>{#3}</b> Evacuate the friendly casualty and set up security on the compound’s perimeter. <b>{#4}</b> Over."<br><br>
			<b>(Porter Lead)</b> "<b>{#2.5}</b> Wilco. <b>{#3}</b> Evacuating casualty and establishing a perimeter. <b>{#4}</b> Over."<br><br>
			<b>(Baron Actual)</b> "<b>{#3}</b> Roger. <b>{#4}</b> Out."<br>
			<hr>
			Remember, clarity and efficiency are always of the utmost priority. The presented pattern serves as a proven and effective baseline which may be streamlined or amplified based on your situation and needs.<br><br>
			<font face="serif" size="3"><u>PHONETICS:</u><br>
			<table><tbody><tr><td>A -</td><td>Alpha</td><td>N -</td><td>November</td></tr><tr><td>B -</td><td>Bravo</td><td>O -</td><td>Oscar</td></tr><tr><td>C -</td><td>Charlie</td><td>P -</td><td>Papa</td></tr><tr><td>D -</td><td>Delta</td><td>Q -</td><td>Quebec</td></tr><tr><td>E -</td><td>Echo</td><td>R -</td><td>Romeo</td></tr><tr><td>F -</td><td>Foxtrot</td><td>S -</td><td>Sierra</td></tr><tr><td>G -</td><td>Golf</td><td>T -</td><td>Tango</td></tr><tr><td>H -</td><td>Hotel</td><td>U -</td><td>Uniform</td></tr><tr><td>I -</td><td>India</td><td>V -</td><td>Victor</td></tr><tr><td>J -</td><td>Juliet</td><td>W -</td><td>Whiskey</td></tr><tr><td>K -</td><td>Kilo</td><td>X -</td><td>X-ray</td></tr><tr><td>L -</td><td>Lima</td><td>Y -</td><td>Yankee</td></tr><tr><td>M -</td><td>Mike</td><td>Z -</td><td>Zulu</td></tr></tbody></table>
			"}

/obj/item/paper/fluff/ship/pgf/relations
	name = "Crew Relationships"
	default_raw_text = {"<html>
			<font face="serif" size="2">
			<hr>
			<table align=/"center/" width="100%">
			<tr>
			<td>Department of<br>Navy Issuances</td>
			<td style="padding-top:%">
			<b>Crew Relationships<br> Armed Service Personnel Notice </b>
			</td>
			<td>02 - 07 - 505</td>
			</tr>
			</table>
			<hr>
			<b>PREVENTION OF INAPPROPRIATE RELATIONSHIPS:</b><br>
			The Office of Personnel recommends that the command staff of any PGFN vessel keep an active eye any out for inappropriate relationships in the ranks.<br><br>
			Inappropriate relationships are any relationship that fulfills one of the following criteria;<br><br>
			- Compromises the integrity of supervisory authority<br>
			- Causes unfairness<br>
			- Involves improper use of rank or position for personal gain<br>
			- Gives the perception that it is exploitive or coercive in nature<br>
			- Can create an adverse effect on good order and discipline or mission accomplishment.<br><br>
			As an officer, behaviors to avoid including enlisted in are;<br>
			- Business matters<br>
			- Gambling<br>
			- Dating<br>
			- Sharing living accommodations.<br><br>
			<b>Actual or perceived, these activities are prohibited. If it looks wrong, it's probably wrong.</b>
			"}

