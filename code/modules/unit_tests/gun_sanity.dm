/datum/unit_test/gun_sanity/Run()
	for(var/gun_path in subtypesof(/obj/item/gun))
		var/obj/item/gun/target_gun = new gun_path()
		if(target_gun.default_ammo_type)
			if(!ispath(target_gun.default_ammo_type))
				TEST_FAIL("The default ammo ([target_gun.default_ammo_type]) in [gun_path] is not a type")

			if(!(target_gun.default_ammo_type in target_gun.allowed_ammo_types))
				TEST_FAIL("The default ammo ([target_gun.default_ammo_type]) in [gun_path] in not in its allowed ammo types")

			if(ispath(gun_path, /obj/item/gun/ballistic))
				if(!(target_gun.magazine?.type == target_gun.default_ammo_type))
					TEST_FAIL("[gun_path]'s mag ([target_gun.magazine?.type]) does not equal its default_ammo_type")
		else
			if(target_gun.internal_magazine)
				TEST_FAIL("[gun_path] with an internal mag has no mag")
		qdel(target_gun)
