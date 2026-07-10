// This exists to catch limbs or organs being where they shouldn't
/datum/unit_test/species_limbs_and_organs/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)

	var/datum/species/test_species
	var/obj/item/organ/test_organ
	var/obj/item/bodypart/test_bodypart

	for(var/species_type in subtypesof(/datum/species))
		human.set_species(species_type)
		test_species = human.dna.species

		for(var/zone in test_species.species_limbs)
			test_bodypart = test_species.species_limbs[zone]
			TEST_ASSERT_EQUAL(zone, test_bodypart::body_zone, "Species [species_type] has invalid bodypart [test_bodypart] in zone [zone]")

		for(var/slot in test_species.species_organs)
			test_organ = test_species.species_organs[slot]
			TEST_ASSERT_EQUAL(slot, test_organ::slot, "Species [species_type] has invalid organ [test_organ] in slot [slot]")
