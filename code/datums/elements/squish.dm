#define SHORT 5/7
#define TALL 7/5
#define VERYSHORT 1/10
#define VERYTALL 10/1

/**
	# squish.dm
	*
	* It's an element that squishes things. After the duration passes, it reverses the transformation it squished with, taking into account if they are a different orientation than they started (read: rotationally-fluid)
	*
	* Normal squishes apply vertically, as if the target is being squished from above, but you can set reverse to TRUE if you want to squish them from the sides, like if they pancake into a wall from the East or West
*/
/datum/element/squish
	element_flags = ELEMENT_DETACH

/datum/element/squish/Attach(datum/target, duration=20 SECONDS, reverse=FALSE, very=FALSE, permanent=FALSE)
	. = ..()
	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	var/mob/living/carbon/C = target
	var/was_lying = C.body_position == LYING_DOWN
	if(!permanent)
		addtimer(CALLBACK(src, PROC_REF(Detach), C, was_lying, reverse, very), duration)
	if(!very)
		if(reverse)
			C.transform = C.transform.Scale(SHORT, TALL)
		else
			C.transform = C.transform.Scale(TALL, SHORT)
	else
		if(reverse)
			C.transform = C.transform.Scale(VERYSHORT, VERYTALL)
		else
			C.transform = C.transform.Scale(VERYTALL, VERYSHORT)

/datum/element/squish/Detach(mob/living/carbon/C, was_lying, reverse, very)
	. = ..()
	if(istype(C))
		var/is_lying = C.body_position == LYING_DOWN

		if(reverse)
			is_lying = !is_lying
		if(!very)
			if(was_lying == is_lying)
				C.transform = C.transform.Scale(SHORT, TALL)
			else
				C.transform = C.transform.Scale(TALL, SHORT)
		else
			if(was_lying == is_lying)
				C.transform = C.transform.Scale(VERYSHORT, VERYTALL)
			else
				C.transform = C.transform.Scale(VERYTALL, VERYSHORT)

#undef SHORT
#undef TALL
#undef VERYSHORT
#undef VERYTALL
