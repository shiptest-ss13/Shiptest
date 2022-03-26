GLOBAL_LIST_EMPTY_TYPED(outpost_templates, /datum/map_template/outpost)

#define OUTPOST_JSON_REQUIRED_ENTRIES list("goods_buying", "goods_selling", "goods_available")
#define TEMPLATE_PATH(template) "_maps/outpost/templates/[template]"
/datum/controller/subsystem/overmap/proc/init_outpost_templates()
	var/list/template_files = flist("_maps/outpost/templates/")
	GLOB.outpost_templates = list()
	for(var/template in template_files)
		if(!fexists(TEMPLATE_PATH(template)))
			continue // HOW AND WHY ARE YOU LIKE THIS BYOND

		if(!findtext(template, ".json"))
			continue

		var/data = file2text(TEMPLATE_PATH(template))
		if(!data || !istext(data))
			continue

		var/list/json = json_decode(data)
		if(!islist(json))
			stack_trace("improperly formatted template '[template]'")
			continue

		var/missing_entry = FALSE
		for(var/required_entry in OUTPOST_JSON_REQUIRED_ENTRIES)
			if(!(required_entry in json))
				stack_trace("missing required entry '[required_entry]' for template '[template]'")
				missing_entry = TRUE
		if(missing_entry)
			continue

		var/mappath_cutoff = findlasttext(template, ".json")
		var/expected_mappath = "_maps/outpost/maps/[copytext(template, 1, mappath_cutoff)].dmm"
		if(!fexists(expected_mappath))
			stack_trace("expected outpost mappath '[expected_mappath]'does not exist")
			continue

		var/datum/map_template/outpost/entry = new
		entry.name = json["name"]
		entry.mappath = expected_mappath
		entry.goods_buying = json["goods_buying"]
		entry.goods_selling = json["goods_selling"]
		entry.goods_available = json["goods_available"]
		GLOB.outpost_templates += entry
#undef OUTPOST_JSON_REQUIRED_ENTRIES
#undef TEMPLATE_PATH

/datum/map_template/outpost
	/// A list of goods this outpost will buy. indexed by typepath with a value of the base price
	var/list/goods_buying
	/// A list of goods this outpost will sell. indexed by typepath with a value of the base price
	var/list/goods_selling
	/// A list of the initial inventory of this outpost when first spawned
	var/list/goods_available

/datum/map_template/outpost/proc/load_outpost_data(datum/overmap/outpost/target)
	target.name = name
	if(!target.template)
		target.template = src
	target.goods_buying = goods_buying.Copy()
	target.goods_selling = goods_selling.Copy()
	target.goods_available = goods_available.Copy()
	return
