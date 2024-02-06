/datum/unit_test/outfit_names/Run()
	var/list/outfit_names = list()

	for(var/datum/outfit/outfit_type as anything in subtypesof(/datum/outfit))
		var/name = initial(outfit_type.name)

		if(name in outfit_names)
			TEST_FAIL("Outfit name [name] is not unique: [outfit_type], [outfit_names[name]]")

		outfit_names[name] = outfit_type


