/datum/round_event_control/fax_spam
	name = "Fax Spam"
	typepath = /datum/round_event/fax_spam
	weight = 10
	max_occurrences = 2
	earliest_start = 5 MINUTES
	requires_ship = TRUE

/datum/round_event/fax_spam
	var/obj/item/advertisement/spam_type

/datum/round_event/fax_spam/setup()
	spam_type = pick(subtypesof(/obj/item/advertisement))

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine in GLOB.machines)
		if(fax_machine.visible_to_network)
			var/obj/item/advertisement/spam_message = new spam_type
			fax_machine.receive(spam_message, "Unknown Sender")

/obj/item/advertisement
	name = "advertisement"
	icon = 'icons/obj/fliers.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	pressure_resistance = 0
	resistance_flags = FLAMMABLE
	max_integrity = 50
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	grind_results = list(/datum/reagent/cellulose = 3)

/obj/item/advertisement/gec
	name = "robust advertisement"
	desc = "A recruitment pamphlet for the Galactic Engineer's Concordat, listing several benefits to union members compared to the average worker."
	icon_state = "gec"

/obj/item/advertisement/vitcom
	desc = "A pamphlet advertising VitCom Consumer Electronic's new model of \"bowman\" headset, focusing on benefits for salvage crews working with loud machinery."
	icon_state = "vitcom"

/obj/item/advertisement/vanity
	name = "fancy advertisement"
	desc = "A fancifully decorated pamphlet advertising Vanity's premier line of gemstone studded electronics, you wonder if you'll ever be able to afford one working in the Frontier..."
	icon_state = "vanity"

/obj/item/advertisement/cliptour
	desc = "A pamphlet advertising tour guides on Luna-Town, most prominently an interior tour of certain restricted sections of the UNSV Lichtenstein."
	icon_state = "cliptour"
