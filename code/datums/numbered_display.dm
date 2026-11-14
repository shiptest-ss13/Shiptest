//Used in storage.
/datum/numbered_display
	var/atom/movable/screen/storage/item_holder/holder
	var/number

/datum/numbered_display/New(obj/item/sample, _number = 1, datum/component/storage/parent)
	if(!istype(sample))
		qdel(src)
	holder = new /atom/movable/screen/storage/item_holder(null, parent, sample)
	number = _number
