///Checks for ammo stack capacity matching
/datum/unit_test/ammo_stacks/Run()
	for(var/ammo_stack_type in subtypesof(/obj/item/ammo_box/magazine/ammo_stack) - /obj/item/ammo_box/magazine/ammo_stack/prefilled - /obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun)

		var/obj/item/ammo_box/magazine/ammo_stack/target_ammo_stack = new ammo_stack_type()
		if(!target_ammo_stack.ammo_type)
			TEST_FAIL("Ammo stack created without ammo type.")
		if (!(target_ammo_stack.max_ammo == target_ammo_stack.ammo_type.stack_size))
			TEST_FAIL("Max ammo stack size on [target_ammo_stack.type] ([target_ammo_stack.max_ammo]) does not match declared stack size on assigned ammunition ([target_ammo_stack.ammo_type.name], [target_ammo_stack.ammo_type.stack_size]) type")
		qdel(target_ammo_stack)
