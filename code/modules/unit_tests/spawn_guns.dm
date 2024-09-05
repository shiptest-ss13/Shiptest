/datum/unit_test/spawn_gun/Run()
	for(var/gun_to_test in subtypesof(/obj/item/gun))
		var/obj/item/gun/gun = allocate(gun_to_test, TRUE)
		if(gun.default_ammo_type && !(gun.default_ammo_type in gun.allowed_ammo_types))
			TEST_FAIL("[gun] has a specified default_ammo_type [gun.default_ammo_type] that is not present in the allowed_ammo_types.")
		for(var/attachment_type in gun.default_attachments)
			var/in_list = FALSE
			for(var/valid_type in gun.valid_attachments)
				// spawns without mag, skip it
				if(!istype(valid_type))
					continue
				if(istype(attachment_type, valid_type))
					in_list = TRUE
			if(!in_list)
				TEST_FAIL("[gun] has a invalid attachment [attachment_type] that is not present in the valid_attachments.")
