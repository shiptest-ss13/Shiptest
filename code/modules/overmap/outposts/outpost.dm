/datum/overmap/outpost
	name = "Outpost"
	allow_dock = TRUE
	allow_interact = TRUE
	/// The template we are based upon
	var/datum/map_template/outpost/template
	/// A list of the current products we are willing to purchase
	var/list/goods_buying
	/// A list of the current products for sale
	var/list/goods_selling
	/// A list of the actual inventory of the outpost
	var/list/goods_available

/datum/overmap/outpost/Initialize(datum/map_template/outpost/template)
	. = ..()
	if(!istype(template))
		qdel(src)
		CRASH("[template] is not a valid outpost_template datum")
	template.load_outpost_data(src)
	if(src.template != template)
		qdel(src)
		CRASH("template did not populate outpost data correctly")
