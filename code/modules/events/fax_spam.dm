/datum/round_event_control/fax_spam
	name = "Fax Spam"
	typepath = /datum/round_event/fax_spam
	weight = 10
	max_occurrences = 2
	min_players = 1
	earliest_start = 5 MINUTES
	requires_ship = TRUE

/datum/round_event/fax_spam
	end_when = 60
	var/list/pick_faxes = list()
	var/spam_frequency = 5
	var/spam_prob = 50
	var/obj/item/paper/spam/spam_type

/datum/round_event/fax_spam/setup()
	end_when = rand(20, 40)
	spam_type = pick(subtypesof(/obj/item/paper/spam))

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine in GLOB.machines)
		if(fax_machine.visible_to_network)
			pick_faxes += fax_machine

/datum/round_event/fax_spam/tick()
	if((activeFor % spam_frequency) == 0)
		for(var/obj/machinery/fax/fax_machine in pick_faxes)
			if(!prob(spam_prob))
				continue
			var/obj/item/paper/spam/spam_message = new spam_type
			fax_machine.receive(spam_message, spam_message.sender)

/obj/item/paper/spam
	var/sender = "Spammer"

/obj/item/paper/spam/help
	name = "paper- 'HELP ME'"
	sender = "HELP ME"
	default_raw_text = {"HEEEEEEEEELP

HEEEEEEEEEEEEELP ME"}

/obj/item/paper/spam/pgf_marine_test
	name = "Aptitude Test"
	sender = "Pan-Gezeanan Mariner Cores Recruitment Office"
	default_raw_text = {"<center>
<h1>PAN-GEZENA MARINE CORP APTITUDE TEST</h1>
<h2>Using the crayon provided, join the two dots.<br> Your recruiter can help you.<br> You have one hour to complete.</h2>
(please do not eat the crayon)
</center>
<br>
<font size=5>
<pre>Ο\[_________________________________________\]Ο</pre>"}

/obj/item/paper/spam/sus_activity
	name = "NOTICE"
	sender = "Outpost Authorithy"
	default_raw_text = {"
<h1><center><font color="red">! ! ATTENTION ! !</h1></center> </font>
<b><center>SUSPICIOUS OR ILLICIT ACTIVITY HAS BEEN DETECTED FROM THIS FAX NETWORK. OUTGOING COMMUNICATIONS HAVE BEEN BLOCKED UNTIL FURTHER NOTICE.</center></b>
<p><center>In order to prove you are a human, please solve this Somewhat Automated Public Turing test to tell Computers and Humans Apart:</center></p>
<blockquote><code>
2+2 = ?
</blockquote></code>
<b>YOUR ANSWER AFTER THIS LINE</b>
<hr>"}
