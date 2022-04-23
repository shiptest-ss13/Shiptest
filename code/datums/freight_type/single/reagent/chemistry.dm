/datum/freight_type/single/reagent/chemistry
	containers = list( // We're not accepting chemicals in food
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/glass,
		/obj/item/reagent_containers/chemtank
	)

/datum/freight_type/single/reagent/chemistry/get_supply_request_form_segment()
	return "<span>Permissible reagent containers: spray bottles, beakers, bottles, chemical tanks</span><br>"
