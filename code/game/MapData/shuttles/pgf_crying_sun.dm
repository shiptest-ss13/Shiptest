/obj/machinery/air_sensor/ship/c_sun/air
	id_tag = "c_sun_air"

/obj/machinery/air_sensor/ship/c_sun/fuel
	id_tag = "c_sun_fuel"

/obj/machinery/computer/atmos_control/ship/c_sun
	sensors = list(
		"c_sun_air" = "Air Mix Chamber",
		"c_sun_fuel" = "Fuel Mix Chamber",
	)

/obj/item/paper/fluff/ship/sun/nail
	name = "Nail Excursion Protocol"
	default_raw_text = {"<html>
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
			<b>Nail Shuttle Excursion Protocol<br> Crying Sun Class Light Frigate</b>
			</td>
			<td>04 - 07 - 504</td>
			</tr>
			</table>
			<font>
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>PREFACE:</strong><br>
			Should mission parameters deem the use of your vessel's Nail-class Boarding Vessel necessary, the maintenance of proper security and communication with your host vessel is paramount. This issuance will cover the basics of such procedures as to ensure mission success in the unpredictable circumstances of the modern battle space.
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>SECURITY:</strong><br>
			Not all missions are alike, and the field of combat is rarely a predictable one. In light of this, adhere to the following information as guidelines to aid in protecting the success of your mission, not as infallible standards. The following guidelines will be listed in order of most preferable to least preferable.<br><br>
			<b>1. If there is sufficient manpower:</b> Upon reaching your destination, a member of the unit shall be designated as a sentry, charged with the defense and maintenance of the Nail-class Boarding Vessel. This sentry is to be entrusted with the key to the vessel and is not to let the vessel out of their sight at any time. *(It is recommended that the pilot be chosen for this sentry position when possible)*  This sentry will maintain communication with the unit and relay vital information to the host vessel and vice versa. This strategy maintains the security of the Nail-class Boarding Vessel and allows for rapid evacuation should the unit come under serious threat<br><br>
			<b>2. If the unit must have all hands in the field:</b> Upon reaching your destination, the leader of the unit shall lock the Nail-class Boarding Vessel's navigation console and keep the key safely on their person. All members of the unit will disembark from the vessel and the unit leader shall designate one member to serve as a communications specialist.*(It is recommended that this specialist be chosen out of any non-combat personnel if applicable)* The unit shall endeavor to leave the Nail-class Boarding Vessel unattended for as short a time as possible to prevent damage, theft, sabotage, or destruction.
			<hr>
			<div style=/"margin-left:5%;margin-right:5%/"><strong>COMMUNICATIONS:</strong><br>
			As has long been the motto of armed forces throughout the galaxy, the adage "Shoot, Move, Communicate" holds true and will continue to hold true as long as armed conflict remains a fact of life. When deploying on the Nail-class Boarding Vessel, your unit will be leaving your host vessel and all of the ease of communication which it bears. In the likely absence of telecommunications, long distance coordination will be conducted via secure messaging channel, wideband radio, or holo-pad hologram. The strengths, weaknesses, and primary use of these methods will be addressed below.<br><br>
			<b>1. Secure Messaging Channel:</b> The most basic, but most practical of the three options, secure messaging channels will be set up by your host vessel for the purpose of relaying key information quickly and receiving updated orders while maintaining information security and situational awareness. At no point should your unit go without access to your vessel's secure messaging channel. This method of long range coordination should be considered the default method.<br><br>
			<b>2. Wideband Radio:</b> The least secure, but most rapid method of communication, wideband radio communication should only be used to relay non-compromising information between your unit and your host vessel. Seriously weigh the necessity of broadcasting sensitive information such as coordinate locations, casualty reports or mission objectives over wideband channels.<br><br>
			<b>3. Holo-pad Hologram:</b> The most reliable form of communication available, holo-pad communication is often slower, but ensures your message will be received. When initiated, holo-pad communication severely impedes your situational awareness making this method extremely dangerous to use alone when in potentially hostile environments. Use good judgment before initiating a holo-pad call, as connection will leave you extremely vulnerable without allies to keep watch for you.
			"}

/mob/living/simple_animal/pet/dog/pug/crying
	name = "Jumbo"
	desc = "Despite drawing the genetic short straw, Jumbo is an inspiration to every enlisted Gezenan to share a hull with him. Just a few more years."
	gender = MALE
	unique_pet = TRUE
	icon_state = "jumbo"
	icon_living = "jumbo"
	icon_dead = "pug_dead"
	collar_type = "pug"
	held_state = "pug"
	faction = list("neutral", FACTION_PLAYER_GEZENA)
	speak = list("YAP", "Woof!", "Bark!", "AUUUUUU")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks!", "woofs!", "yaps.","pants.","sneezes.")
	emote_see = list("shakes its head.", "chases its tail.","shivers.")
