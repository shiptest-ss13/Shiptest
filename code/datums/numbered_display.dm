//Used in storage.
/datum/numbered_display
	var/obj/item/sample_object
	var/number

/datum/numbered_display/New(obj/item/sample, _number = 1, datum/component/storage/parent)
	if(!istype(sample))
		qdel(src)
	sample_object = new /atom/movable/screen/storage/item_holder(null, parent, sample)
	number = _number
