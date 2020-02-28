/obj/item/storage/bag/medical
	name = "medicine bag"
	icon = 'waspstation/icons/obj/bags.dmi'
	icon_state = "medbag"
	desc = "A bag for storing syringes, sutures, ointments, and pills."
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/medical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 200
	STR.max_items = 20
	STR.insert_preposition = "in"
	STR.set_holdable(list(
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/syringe,
		/obj/item/stack/medical
		))
