/datum/autowiki/weapons/energy
	page = "Template:Autowiki/Content/EnergyWeapons"

/datum/autowiki/weapons/energy/proc/lens_summary(obj/item/gun/energy/gun, bold_default = FALSE)
	var/list/entries = lens_entries(gun, bold_default)
	return length(entries) ? stack(entries) : "N/A"

/datum/autowiki/weapons/energy/proc/cell_summary(obj/item/gun/energy/gun, bold_default = FALSE)
	var/list/names = list()

	for (var/cell_path in gun.allowed_ammo_types)
		var/obj/item/stock_parts/cell/cell = cell_path
		if (ispath(cell_path, /obj/item/stock_parts/cell) && findtext("[cell_path]", "/empty"))
			continue

		var/label = capitalize(format_text(initial(cell.name)))
		if (label)
			names |= label

	if (!length(names))
		return "N/A"

	// check default cell
	var/obj/item/stock_parts/cell/standard = initial(gun.default_ammo_type)
	var/default_label = standard ? capitalize(format_text(initial(standard.name))) : null

	if (bold_default && length(names) > 1 && (default_label in names))
		names[names.Find(default_label)] = "'''[default_label]'''"

	return stack(names)

/datum/autowiki/weapons/energy/generate()
	var/list/tables = list()
	var/list/seen_rows = list()

	for (var/gun_path in sortList(subtypesof(/obj/item/gun/energy), /proc/cmp_typepaths_asc))
		var/obj/item/gun/energy/gun_type = gun_path

		if (gun_type == initial(gun_type.bad_type) || initial(gun_type.autowiki_hidden))
			continue

		if (!initial(gun_type.actually_shoots))
			continue

		var/obj/item/gun/energy/gun = new gun_path

		if (QDELETED(gun))
			continue

		var/manufacturer = manufacturer_name(gun.manufacturer)

		var/list/details = list(
			"icon" = "",
			"name" = escape_value(capitalize(format_text(gun.name))),
			"cell" = escape_value(cell_summary(gun)),
			"cost" = "",
			"cost_sort" = "",
			"firemodes" = firemode_summary(gun),
			"lenses" = escape_value(lens_summary(gun)),
			"slots" = escape_value(slot_summary(gun)),
			"spread" = gun.spread,
			"spread_unwielded" = gun.spread_unwielded,
			"firedelay" = gun.fire_delay / 10,
		)

		var/description = escape_value(format_text(description(gun)))

		var/dedupe_key = "[manufacturer][list2params(details)]"
		if (dedupe_key in seen_rows)
			qdel(gun)
			continue
		seen_rows += dedupe_key

		var/filename = icon_name(gun.type)
		upload_icon(getFlatIcon(gun, no_anim = TRUE), filename)

		var/bolded_cell = cell_summary(gun, bold_default = TRUE)
		var/bolded_lenses = escape_value(lens_summary(gun, bold_default = TRUE))
		qdel(gun)

		details["icon"] = filename
		details["cell"] = bolded_cell
		details["lenses"] = bolded_lenses
		details["cost"] = cost_label(gun_path)
		details["cost_sort"] = cost_sort(gun_path)
		details["description"] = description

		var/list/rows = tables[manufacturer]
		if (!rows)
			rows = list()
			tables[manufacturer] = rows

		rows["[details["name"]] [gun_path]"] = include_template("Autowiki/EnergyGun", details)

	var/list/output = list()
	for (var/manufacturer in sortList(tables))
		var/list/rows = tables[manufacturer]
		var/page_text = ""
		for (var/key in sortList(rows))
			page_text += rows[key]
		output[manufacturer] = page_text

	return output
