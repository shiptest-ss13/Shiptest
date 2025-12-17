/datum/quirk/smoker
	name = "Smoker"
	desc = "Sometimes you just really want a smoke. Probably not great for your lungs."
	value = -1
	gain_text = span_danger("You could really go for a smoke right about now.")
	lose_text = span_notice("You feel like you should quit smoking.")
	medical_record_text = "Patient is a current smoker."
	///If this is defined, reagent_id will be unused and the defined reagent type will be instead.
	var/datum/reagent/reagent_type = /datum/reagent/drug/nicotine
	var/datum/reagent/reagent_instance //! actual instanced version of the reagent
	var/where_drug //! Where the drug spawned
	// This is the type of container the .
	var/obj/item/drug_container_type = /obj/item/storage/fancy/cigarettes
	var/where_accessory //! where the accessory spawned
	/// If this is null, an accessory won't be spawned.
	var/obj/item/accessory_type = /obj/item/lighter/greyscale
	var/process_interval = 30 MINUTES //! how frequently the quirk processes
	var/next_process = 0 //! ticker for processing

/datum/quirk/smoker/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/current_turf = get_turf(quirk_holder)
	if (!drug_container_type)
		drug_container_type = /obj/item/storage/pill_bottle
	var/obj/item/drug_instance = new drug_container_type(current_turf)

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

/datum/quirk/smoker/post_add()
	if(where_drug == "in your backpack" || where_accessory == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

/datum/quirk/smoker/proc/announce_drugs()
	to_chat(quirk_holder, span_boldnotice("There is a [initial(drug_container_type.name)] of [initial(reagent_type.name)] [where_drug]. Better hope you don't run out..."))

/datum/quirk/smoker/on_process(seconds_per_tick)
	if(world.time > next_process)
		next_process = world.time + (process_interval + rand(-300, 300))
		to_chat(quirk_holder, span_danger("You could go for a smoke right about now..."))
