/datum/autowiki/weapons/ballistics
	page = "Template:Autowiki/Content/Ballistics"

/datum/autowiki/weapons/ballistics/proc/capacity_sizes(obj/item/gun/ballistic/gun)
	var/list/sizes = list()

	// dont need to check further if it has an internal mag
	if (gun.internal_magazine)
		if (gun.magazine?.max_ammo)
			sizes += gun.magazine.max_ammo
		return sizes

	for (var/mag_path in gun.allowed_ammo_types)
		var/obj/item/ammo_box/mag = mag_path
		var/size = initial(mag.max_ammo)
		if (size)
			sizes |= size

	// nothing declared, so fall back to whatever it happens to be loaded with
	if (!length(sizes) && gun.magazine?.max_ammo)
		sizes += gun.magazine.max_ammo

	sortTim(sizes, /proc/cmp_numeric_asc)
	return sizes

/datum/autowiki/weapons/ballistics/proc/capacity_summary(obj/item/gun/ballistic/gun, bold_default = FALSE)
	var/list/sizes = capacity_sizes(gun)

	var/list/carried = list()
	for (var/obj/item/gun/energy/secondary in gun)
		var/list/lenses = lens_entries(secondary)
		if (length(lenses))
			carried += "Energy: [lenses.Join("; ")]"

	if (!length(sizes))
		return length(carried) ? stack(carried) : "N/A"

	// get default capacity too
	var/obj/item/ammo_box/standard = initial(gun.default_ammo_type)
	var/default_size = standard ? initial(standard.max_ammo) : 0

	var/list/labels = list()
	for (var/size in sizes)
		// only worth marking when there is something to tell it apart from
		var/mark = bold_default && length(sizes) > 1 && size == default_size
		labels += mark ? "'''[size]'''" : "[size]"

	var/suffix = length(carried) ? stack(carried) : ""
	return "[labels.Join(" / ")][suffix]"

/datum/autowiki/weapons/ballistics/proc/capacity_sort(obj/item/gun/ballistic/gun)
	var/list/sizes = capacity_sizes(gun)
	return length(sizes) ? sizes[1] : 0

/datum/autowiki/weapons/ballistics/generate()
	var/list/tables = list()

	var/list/seen_rows = list()

	for (var/gun_path in sortList(subtypesof(/obj/item/gun/ballistic), /proc/cmp_typepaths_asc))
		if (!listable_gun(gun_path))
			continue

		var/obj/item/gun/ballistic/gun = new gun_path

		// snowflake check for shit like laser gatling/backpack
		if (QDELETED(gun))
			continue

		var/obj/item/ammo_casing/chambered = gun.magazine?.ammo_type
		var/caliber = chambered ? initial(chambered.caliber) : null

		if (!caliber)
			for (var/mag_path in gun.allowed_ammo_types)
				var/obj/item/ammo_box/mag = mag_path
				var/obj/item/ammo_casing/mag_casing = initial(mag.ammo_type)
				if (!mag_casing)
					continue
				caliber = initial(mag_casing.caliber)
				if (caliber)
					break

		var/manufacturer = manufacturer_name(gun.manufacturer)
		var/label = caliber ? escape_value(caliber_label(caliber)) : null

		var/list/details = list(
			"icon" = "",
			"name" = escape_value(capitalize(format_text(gun.name))),
			"ammo" = label || "N/A",
			"cost" = "",
			"cost_sort" = "",
			"firemodes" = firemode_summary(gun),
			"capacity" = capacity_summary(gun),
			"capacity_sort" = capacity_sort(gun),
			"slots" = escape_value(slot_summary(gun)),
			"spread" = stance_cell(gun.spread, gun.recoil),
			"spread_unwielded" = stance_cell(gun.spread_unwielded, gun.recoil_unwielded),
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

		var/bolded_capacity = capacity_summary(gun, bold_default = TRUE)
		qdel(gun)

		details["icon"] = filename
		details["capacity"] = bolded_capacity
		details["cost"] = cost_label(gun_path)
		details["cost_sort"] = cost_sort(gun_path)
		details["description"] = description

		var/list/rows = tables[manufacturer]
		if (!rows)
			rows = list()
			tables[manufacturer] = rows

		rows["[details["name"]] [gun_path]"] = include_template("Autowiki/BallisticGun", details)

	var/list/output = list()
	for (var/manufacturer in sortList(tables))
		var/list/rows = tables[manufacturer]
		var/page_text = ""
		for (var/key in sortList(rows))
			page_text += rows[key]
		output[manufacturer] = page_text

	return output
