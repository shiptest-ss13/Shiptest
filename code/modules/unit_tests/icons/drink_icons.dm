/// Unit tests glass style datums are applied to drinking glasses
/datum/unit_test/glass_style_functionality

/datum/unit_test/glass_style_functionality/Run()
	// The tested drink
	// Should ideally have multiple drinking glass datums associated (to check the correct one is seletced)
	// As well as a value set from every var (name, description, icon, and icon state)
	var/tested_reagent_type = /datum/reagent/consumable/ethanol/jack_rose
	var/obj/item/reagent_containers/food/drinks/drinkingglass/glass = allocate(/obj/item/reagent_containers/food/drinks/drinkingglass)
	var/datum/glass_style/expected_glass_type = GLOB.glass_style_singletons[glass.type][tested_reagent_type]
	TEST_ASSERT_NOTNULL(expected_glass_type, "Glass style datum for the tested reagent ([tested_reagent_type]) and container ([glass.type]) was not found.")

	// Add 5 units of the reagent to the glass. This will change the name, desc, icon, and icon state
	glass.reagents.add_reagent(tested_reagent_type, 5)
	TEST_ASSERT_EQUAL(glass.icon, expected_glass_type.icon, "Glass icon file did not change after gaining a reagent that would change it.")
	TEST_ASSERT_EQUAL(glass.icon_state, expected_glass_type.icon_state, "Glass icon state did not change after gaining a reagent that would change it")
	TEST_ASSERT_EQUAL(glass.name, expected_glass_type.name, "Glass name did not change after gaining a reagent that would change it")
	TEST_ASSERT_EQUAL(glass.desc, expected_glass_type.desc, "Glass desc did not change after gaining a reagent that would change it")
	// Clear all units from the glass, This will reset all the previously changed values
	glass.reagents.clear_reagents()
	TEST_ASSERT_EQUAL(glass.icon, initial(glass.icon), "Glass icon file did not reset after clearing reagents")
	TEST_ASSERT_EQUAL(glass.icon_state, initial(glass.icon_state), "Glass icon state did not reset after clearing reagents")
	TEST_ASSERT_EQUAL(glass.name, initial(glass.name), "Glass name did not reset after clearing reagents")
	TEST_ASSERT_EQUAL(glass.desc, initial(glass.desc), "Glass desc did not reset after clearing reagents")

/// Unit tests glass subtypes have a valid icon setup
/datum/unit_test/drink_icons

/datum/unit_test/drink_icons/Run()
	for(var/obj/item/reagent_containers/food/drinks/glass_subtypes as anything in subtypesof(/obj/item/reagent_containers/food/drinks))
		var/glass_icon = initial(glass_subtypes.icon)
		var/glass_icon_state = initial(glass_subtypes.icon_state)
		if(!glass_icon_state)
			continue
		if(!glass_icon)
			TEST_FAIL("[glass_subtypes] had an icon state ([glass_icon_state]) but no icon file.")
			continue
		if(icon_exists(glass_icon, glass_icon_state))
			continue
		TEST_FAIL("[glass_subtypes] had an icon state ([glass_icon_state]) not present in its icon ([glass_icon]).")
