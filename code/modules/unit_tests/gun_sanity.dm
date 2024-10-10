/datum/unit_test/gun_sanity/Run()
	for(var/gun_path in subtypesof(/obj/item/gun))
		var/obj/item/gun/target_gun = gun_path
		target_gun = new()
		log_test("Testing [target_gun.type]")
		if(target_gun.default_ammo_type)
			TEST_ASSERT(ispath(target_gun.default_ammo_type), "The default ammo in [target_gun.type] is not a type")
			TEST_ASSERT(target_gun.default_ammo_type in target_gun.allowed_ammo_types, "The default ammo in [target_gun.type] in not in its allowed ammo types")
			TEST_ASSERT_EQUAL(target_gun.magazine?.type, target_gun.default_ammo_type, "[target_gun.type]'s mag does not equal its default_ammo_type")
		else
			TEST_ASSERT(!target_gun.internal_magazine, "A gun with an internal mag has no mag")
		qdel(target_gun)
