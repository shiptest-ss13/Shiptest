// -----------------------------
// Blood Bank Smartfridge
// -----------------------------
/obj/machinery/smartfridge/bloodbank
	name = "Refrigerated Blood Bank"
	desc = "A refrigerated storage unit for blood packs."
	icon = 'whitesands/icons/obj/vending.dmi'
	icon_state = "bloodbank"

/obj/machinery/smartfridge/bloodbank/accept_check(obj/item/O) //Literally copied bar smartfridge code
	if(!istype(O, /obj/item/reagent_containers) || (O.item_flags & ABSTRACT) || !O.reagents || !O.reagents.reagent_list.len)
		return FALSE
	if(istype(O, /obj/item/reagent_containers/blood))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/bloodbank/update_icon_state()
	return

/obj/machinery/smartfridge/bloodbank/preloaded
	initial_contents = list(
		/obj/item/reagent_containers/blood/AMinus = 1,
		/obj/item/reagent_containers/blood/APlus = 1,
		/obj/item/reagent_containers/blood/BMinus = 1,
		/obj/item/reagent_containers/blood/BPlus = 1,
		/obj/item/reagent_containers/blood/OMinus = 1,
		/obj/item/reagent_containers/blood/OPlus = 1,
		/obj/item/reagent_containers/blood/lizard = 1,
		/obj/item/reagent_containers/blood/ethereal = 1,
		/obj/item/reagent_containers/blood/squid = 1,
		/obj/item/reagent_containers/blood/random = 5)
