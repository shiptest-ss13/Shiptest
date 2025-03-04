#warn either expand this to an "economy" unit test and check you can't get free money from a lathe, or implement a protection against selling lathed items

/datum/unit_test/supply_pack/Run()
	for(var/pack_type in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/pack = new pack_type
		var/created = pack.generate(run_loc_bottom_left)

		var/datum/export_report/rep = export_item_and_contents(created, allowed_categories = ALL, apply_elastic = FALSE)
		var/value = 0
		for(var/thing in rep.total_value)
			value += rep.total_value[thing]

		if(value >= pack.cost)
			TEST_FAIL("[pack] ([pack_type]) was resold for [value], [value - pack.cost] greater than the buy price of [pack.cost]!")
