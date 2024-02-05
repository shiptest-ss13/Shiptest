//Makes sure preinstalled frame parts can be removed an reinstalled
/datum/unit_test/gun_crafting/Run()
	var/list/guns = typesof(/obj/item/gun)
	for(var/gunType in guns)
		var/obj/item/gun/G = new gunType  // Create an instance of the gun
		if(G.magazine)  // If the gun has a magazine
			TEST_FAIL("Gun: [G.type], Magazine: [G.magazine.type], Caliber: [G.magazine.caliber]")
/*
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
	for(var/frame_type in subtypesof(/obj/item/part/gun/frame))
		var/obj/item/part/gun/frame/frame = new frame_type
		var/list/frame_parts = frame.installed_parts
		for(var/obj/item/part/installedPart in frame.installed_parts)
			frame.eject_item(installedPart, human)
			frame.handle_part(installedPart, human)
		TEST_ASSERT_EQUAL(frame_parts, frame.installed_parts, "Frame parts to match there original contents. I assume frame parts were not reinstalled correctly.")
*/
