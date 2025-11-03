/datum/quirk/junkie
	name = "Junkie"
	desc = "You can't get enough of hard drugs."
	value = -2
	gain_text = span_danger("You suddenly feel the craving for drugs.")
	lose_text = span_notice("You feel like you should kick your drug habit.")
	medical_record_text = "Patient has a history of hard drugs."
	var/drug_list = list(/datum/reagent/drug/crank, /datum/reagent/medicine/morphine, /datum/reagent/drug/happiness, /datum/reagent/drug/methamphetamine) //List of possible IDs
	var/datum/reagent/reagent_type //!If this is defined, reagent_id will be unused and the defined reagent type will be instead.
	var/datum/reagent/reagent_instance //! actual instanced version of the reagent
	var/where_drug //! Where the drug spawned
	var/obj/item/drug_container_type //! If this is defined before pill generation, pill generation will be skipped. This is the type of the pill bottle.
	var/where_accessory //! where the accessory spawned
	var/obj/item/accessory_type //! If this is null, an accessory won't be spawned.
	var/process_interval = 30 SECONDS //! how frequently the quirk processes
	var/next_process = 0 //! ticker for processing

/datum/quirk/junkie/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	if (!reagent_type)
		reagent_type = pick(drug_list)
	reagent_instance = new reagent_type()
	H.reagents.addiction_list.Add(reagent_instance)
	var/current_turf = get_turf(quirk_holder)
	if (!drug_container_type)
		drug_container_type = /obj/item/storage/pill_bottle
	var/obj/item/drug_instance = new drug_container_type(current_turf)
	if (istype(drug_instance, /obj/item/storage/pill_bottle))
		var/pill_state = "pill[rand(1,20)]"
		for(var/i in 1 to 7)
			var/obj/item/reagent_containers/pill/P = new(drug_instance)
			P.icon_state = pill_state
			P.reagents.add_reagent(reagent_type, 1)

	var/obj/item/accessory_instance
	if (accessory_type)
		accessory_instance = new accessory_type(current_turf)
	var/list/slots = list(
		"in your left pocket" = ITEM_SLOT_LPOCKET,
		"in your right pocket" = ITEM_SLOT_RPOCKET,
		"in your backpack" = ITEM_SLOT_BACKPACK
	)
	where_drug = H.equip_in_one_of_slots(drug_instance, slots, FALSE) || "at your feet"
	if (accessory_instance)
		where_accessory = H.equip_in_one_of_slots(accessory_instance, slots, FALSE) || "at your feet"
	announce_drugs()

/datum/quirk/junkie/post_add()
	if(where_drug == "in your backpack" || where_accessory == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

/datum/quirk/junkie/proc/announce_drugs()
	to_chat(quirk_holder, span_boldnotice("There is a [initial(drug_container_type.name)] of [initial(reagent_type.name)] [where_drug]. Better hope you don't run out..."))

/datum/quirk/junkie/on_process(seconds_per_tick)
	var/mob/living/carbon/human/H = quirk_holder
	if(world.time > next_process)
		next_process = world.time + process_interval
		if(!(reagent_instance in H.reagents.addiction_list))
			if(QDELETED(reagent_instance))
				reagent_instance = new reagent_type()
			else
				reagent_instance.addiction_stage = 0
			H.reagents.addiction_list += reagent_instance
			to_chat(quirk_holder, span_danger("You thought you kicked it, but you suddenly feel like you need [reagent_instance.name] again..."))

/datum/quirk/junkie/smoker
	name = "Smoker"
	desc = "Sometimes you just really want a smoke. Probably not great for your lungs."
	value = -1
	gain_text = span_danger("You could really go for a smoke right about now.")
	lose_text = span_notice("You feel like you should quit smoking.")
	medical_record_text = "Patient is a current smoker."
	reagent_type = /datum/reagent/drug/nicotine
	accessory_type = /obj/item/lighter/greyscale
	drug_container_type = /obj/item/storage/fancy/cigarettes
