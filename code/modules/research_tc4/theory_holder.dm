/**
 * Dedicated datum for holding and managing theory points, does this need to be its own datum? not really.
 */
/datum/theory_holder
	var/name = "Default Theory Holder"
	var/_type = THEORY_BASIC

	var/points = 0
	var/points_max = THEORY_POINTS_MAX

/datum/theory_holder/New(_type)
	src._type = _type

/datum/theory_holder/proc/add_points(amount, force)
	if(force)
		points += amount
		return amount

	. = round(min(amount, points_max - points))
	points += .

/datum/theory_holder/proc/use_points(amount, allow_partial)
	if(!allow_partial && amount > points)
		return 0

	. = round(min(amount, points))
	points -= .
