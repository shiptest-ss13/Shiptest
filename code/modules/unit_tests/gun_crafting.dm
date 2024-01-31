//Makes sure preinstalled frame parts can be removed an reinstalled
/datum/unit_test/gun_crafting/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
	for(var/frame_type in subtypesof(/obj/item/part/gun/frame))
		var/obj/item/part/gun/frame/frame = new frame_type
		var/list/frame_parts = frame.installedParts
		for(var/obj/item/part/installedPart in frame.installedParts)
			frame.eject_item(installedPart, human)
			frame.handle_part(installedPart, human)
		TEST_ASSERT_EQUAL(frame_parts, frame.installedParts, "Frame parts to match there original contents. I assume frame parts were not reinstalled correctly.")


