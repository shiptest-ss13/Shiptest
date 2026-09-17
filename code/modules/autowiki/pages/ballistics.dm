/datum/autowiki/ballistics
	page = "Template:Autowiki/Content/Ballistics"

/proc/autowiki_manufacturer_name(raw)
	var/static/list/names = list(
		MANUFACTURER_SHARPLITE = "Sharplite Defense",
		MANUFACTURER_SHARPLITE_NEW = "Makosso-Warra-Sharplite",
		MANUFACTURER_HUNTERSPRIDE = "Hunter's Pride",
		MANUFACTURER_SOLARARMORIES = "Solarbundswaffenkammer",
		MANUFACTURER_SCARBOROUGH = "Scarborough Arms",
		MANUFACTURER_EOEHOMA = "Eoehoma Firearms",
		MANUFACTURER_WARRA_OLD = "Makosso-Warra (old)",
		MANUFACTURER_WARRA = "Makosso-Warra",
		MANUFACTURER_VIGILITAS = "Makosso-Warra Advantage",
		MANUFACTURER_INTEQ = "Inteq Risk Management Group",
		MANUFACTURER_MINUTEMAN = "Lanchester City Firearms Plant",
		MANUFACTURER_MINUTEMAN_LASER = "Clover Photonics",
		MANUFACTURER_PGF = "Etherbor Industries",
		MANUFACTURER_IMPORT = "Lanchester Import Co.",
		MANUFACTURER_SERENE = "Serene Outdoors",
	)

	if (!raw)
		return "Unbranded"

	return names[raw] || raw

/proc/autowiki_firemode_summary(obj/item/gun/gun)
	var/static/list/labels = list(
		FIREMODE_SEMIAUTO = "Semi-auto",
		FIREMODE_BURST = "Burst",
		FIREMODE_FULLAUTO = "Full-auto",
		FIREMODE_AIMED = "Aimed",
		FIREMODE_OTHER = "Other",
		FIREMODE_OTHER_TWO = "Other 2",
	)

	var/static/list/stock_names
	if (!stock_names)
		var/obj/item/gun/reference = new
		stock_names = reference.gun_firenames.Copy()
		qdel(reference)

	var/list/modes = list()
	for (var/mode in gun.gun_firemodes)
		var/named = gun.gun_firenames[mode]

		//special case handling for weapons with special fire modes like e40
		var/label = (named && named != stock_names[mode]) ? capitalize(named) : (labels[mode] || mode)
		if (mode == FIREMODE_BURST && gun.burst_size > 1)
			label += " ([gun.burst_size])"
		modes += label

	return length(modes) ? modes.Join(", ") : "N/A"

// Every distinct magazine capacity the gun accepts, smallest first.
/datum/autowiki/ballistics/proc/capacity_sizes(obj/item/gun/ballistic/gun)
	var/list/sizes = list()

	for (var/mag_path in gun.allowed_ammo_types)
		var/obj/item/ammo_box/mag = mag_path
		var/size = initial(mag.max_ammo)
		if (size)
			sizes |= size

	// internal mag gun things
	if (!length(sizes) && gun.magazine?.max_ammo)
		sizes += gun.magazine.max_ammo

	sortTim(sizes, /proc/cmp_numeric_asc)
	return sizes

/datum/autowiki/ballistics/proc/capacity_summary(obj/item/gun/ballistic/gun)
	var/list/sizes = capacity_sizes(gun)

	var/list/carried = list()
	for (var/obj/item/gun/energy/secondary in gun)
		var/list/lenses = autowiki_lens_entries(secondary)
		if (length(lenses))
			carried += "Energy: [lenses.Join("; ")]"

	if (!length(sizes))
		return length(carried) ? autowiki_stack(carried) : "N/A"

	var/suffix = length(carried) ? autowiki_stack(carried) : ""
	return "[sizes.Join(" / ")][suffix]"

/datum/autowiki/ballistics/proc/capacity_sort(obj/item/gun/ballistic/gun)
	var/list/sizes = capacity_sizes(gun)
	return length(sizes) ? sizes[1] : 0

/datum/autowiki/ballistics/generate()
	var/list/tables = list()

	var/list/seen_rows = list()

	for (var/gun_path in sortList(subtypesof(/obj/item/gun/ballistic), /proc/cmp_typepaths_asc))
		var/obj/item/gun/ballistic/gun_type = gun_path

		if (gun_type == initial(gun_type.bad_type) || initial(gun_type.autowiki_hidden))
			continue

		// dont put weird shit like ballistic hammer
		if (!initial(gun_type.actually_shoots))
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

		var/manufacturer = autowiki_manufacturer_name(gun.manufacturer)
		var/label = caliber ? escape_value(autowiki_caliber_label(caliber)) : null

		var/list/details = list(
			"icon" = "",
			"name" = escape_value(capitalize(format_text(gun.name))),
			"ammo" = label || "N/A",
			"cost" = "",
			"cost_sort" = "",
			"firemodes" = autowiki_firemode_summary(gun),
			"capacity" = capacity_summary(gun),
			"capacity_sort" = capacity_sort(gun),
			"spread" = gun.spread,
			"spread_unwielded" = gun.spread_unwielded,
			"firedelay" = gun.fire_delay / 10,
		)

		var/description = escape_value(format_text(gun.desc))

		var/dedupe_key = "[manufacturer][list2params(details)]"
		if (dedupe_key in seen_rows)
			qdel(gun)
			continue
		seen_rows += dedupe_key

		var/filename = autowiki_icon_name(gun.type)
		upload_icon(getFlatIcon(gun, no_anim = TRUE), filename)
		qdel(gun)

		details["icon"] = filename
		details["cost"] = autowiki_cost_label(gun_path)
		details["cost_sort"] = autowiki_cost_sort(gun_path)
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
