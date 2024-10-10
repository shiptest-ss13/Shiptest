/datum/unit_test/gun_sanity/Run()
	for(var/gun_path in subtypesof(/obj/item/gun/ballistic))
		var/obj/item/gun/target_gun = new gun_path()
		log_test("Testing [target_gun.type]")
		if(target_gun.default_ammo_type)
			if(!ispath(target_gun.default_ammo_type))
				TEST_FAIL("The default ammo in [target_gun.type] is not a type")

			if(!(target_gun.default_ammo_type in target_gun.allowed_ammo_types))
				TEST_FAIL("The default ammo in [target_gun.type] in not in its allowed ammo types")

			if(!(target_gun.magazine?.type == target_gun.default_ammo_type))
				TEST_FAIL("[target_gun.type]'s mag does not equal its default_ammo_type")
		else
			if(target_gun.internal_magazine)
				TEST_FAIL("[target_gun.type] with an internal mag has no mag")
		qdel(target_gun)
