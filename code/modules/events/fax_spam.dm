/datum/round_event_control/fax_spam
	name = "Fax Spam"
	typepath = /datum/round_event/fax_spam
	weight = 10
	max_occurrences = 1
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
	spam_type = pick(/obj/item/paper/spam/ifmc, /obj/item/paper/spam/help)

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine in GLOB.machines)
		if(fax_machine.visible_to_network)
			pick_faxes += fax_machine

/datum/round_event/fax_spam/tick()
	if(activeFor % spam_frequency == 0)
		var/obj/item/paper/spam/spam_message = new spam_type
		for(var/obj/machinery/fax/fax_machine in pick_faxes )
			if(!prob(spam_prob))
				continue
			fax_machine.receive(spam_message, spam_message.sender)

/obj/item/paper/spam
	var/sender = "Spammer"

/obj/item/paper/spam/ifmc
	name = "paper- 'Official Bulletin'"
	sender = "Interstellar Frontier Mining Conglormerate"
	default_raw_text = {"Greetings sir/madame/other,

I am representative of the Interstellar Frontier Mining Conglomerate, and recent lucerative mining operations in frontier systems have resulted in an approximate profit equal to 40,000,000 credits.

Unfortunately, due to Solar Confederation laws regarding monetary transfer, we are unable to transfer monetary profits to our local bank accounts, and we require your assistance in transferring our funding. For facilitating this transfer, the Interstellar Frontier Mining Conglomerate is willing to relinquish 10% or 4,000,000 credits in exchange for services rendered.

To assist us, please wire funding equal to or exceeding 500 credits to the SolCon Monetary Fund Account listed below. Upon confirmed reciept of the funding, we will send additional instructions on monetary transfer.

Forward funding to SolCon Monetary Fund Account ID: 846584.

Yours truly,

Interstellar Frontier Mining Conglormerate Board of Directors"}

/obj/item/paper/spam/help
	name = "paper- 'HELP ME'"
	sender = "HELP ME"
	default_raw_text = {"HEEEEEEEEELP

HEEEEEEEEEEEEELP ME"}
