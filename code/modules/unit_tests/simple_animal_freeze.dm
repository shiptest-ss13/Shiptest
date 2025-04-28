/// Tests that no new simple_animal subtypes are added.
/datum/unit_test/simple_animal_freeze
	// !!! DO NOT ADD NEW ENTRIES TO THIS LIST !!!
	// NO new simple animals are allowed.
	// Use the new basic mobs system instead.
	// If you are refactoring a simple_animal, REMOVE it from this list
	var/list/allowed_types = list(
		/mob/living/simple_animal/bot,
		// DO NOT ADD NEW ENTRIES TO THIS LIST
		// READ THE COMMENT ABOVE
	)

/datum/unit_test/simple_animal_freeze/Run()
	var/list/seen = list()

	//need to generate a list real quick
	for (var/subtype in subtypesof(/mob/living/simple_animal))
		log_test(subtype)

	// Sanity check, to prevent people from just doing a mass find and replace
	for (var/allowed_type in allowed_types)
		if (allowed_type in seen)
			TEST_FAIL("[allowed_type] is in the allowlist more than once")
		else
			seen[allowed_type] = TRUE

		TEST_ASSERT(ispath(allowed_type, /mob/living/simple_animal), "[allowed_type] is not a simple_animal. Remove it from the list.")

	for (var/subtype in subtypesof(/mob/living/simple_animal))
		if (!(subtype in allowed_types))
			TEST_FAIL("No new simple_animal subtypes are allowed. Please refactor [subtype] into a basic mob.")
