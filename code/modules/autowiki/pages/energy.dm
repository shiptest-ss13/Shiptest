/datum/autowiki/energy
	page = "Template:Autowiki/Content/EnergyWeapons"

/proc/autowiki_lens_entries(obj/item/gun/energy/gun)
	var/list/entries = list()
	var/list/charges = list()
	for (var/cell_path in gun.allowed_ammo_types)
		var/obj/item/stock_parts/cell/candidate = cell_path
		if (findtext("[cell_path]", "/empty"))
			continue
		var/charge = initial(candidate.maxcharge)
		if (charge)
			charges |= charge

	if (!length(charges) && gun.cell?.maxcharge)
		charges += gun.cell.maxcharge

	sortTim(charges, /proc/cmp_numeric_asc)

	for (var/obj/item/ammo_casing/energy/lens in gun.ammo_type)
		var/label = capitalize(lens.select_name || format_text(lens.name))

		var/obj/projectile/shot = lens.projectile_type
		var/list/facts = list()
		if (ispath(shot, /obj/projectile))
			var/damage = initial(shot.damage)
			var/pellets = lens.pellets
			facts += "[damage][pellets > 1 ? " &times; [pellets]" : ""] [initial(shot.damage_type)]"
			if (initial(shot.armour_penetration))
				facts += "[initial(shot.armour_penetration)] AP"
			if (initial(shot.stamina))
				facts += "[initial(shot.stamina)] stamina"

		if (lens.e_cost > 0 && length(charges))
			var/list/counts = list()
			for (var/charge in charges)
				counts |= round(charge / lens.e_cost)
			facts += "[counts.Join(" / ")] shots"

		entries += length(facts) ? "'''[label]''': [facts.Join(", ")]" : "'''[label]'''"

	return entries

/proc/autowiki_lens_summary(obj/item/gun/energy/gun)
	var/list/entries = autowiki_lens_entries(gun)
	return length(entries) ? autowiki_stack(entries) : "N/A"

/datum/autowiki/energy/proc/cell_summary(obj/item/gun/energy/gun)
	var/list/names = list()

	for (var/cell_path in gun.allowed_ammo_types)
		var/obj/item/stock_parts/cell/cell = cell_path
		if (ispath(cell_path, /obj/item/stock_parts/cell) && findtext("[cell_path]", "/empty"))
			continue

		var/label = capitalize(format_text(initial(cell.name)))
		if (label)
			names |= label

	return length(names) ? autowiki_stack(names) : "N/A"

/datum/autowiki/energy/generate()
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

		var/manufacturer = autowiki_manufacturer_name(gun.manufacturer)

		var/list/details = list(
			"icon" = "",
			"name" = escape_value(capitalize(format_text(gun.name))),
			"cell" = escape_value(cell_summary(gun)),
			"cost" = "",
			"cost_sort" = "",
			"firemodes" = autowiki_firemode_summary(gun),
			"lenses" = escape_value(autowiki_lens_summary(gun)),
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

		rows["[details["name"]] [gun_path]"] = include_template("Autowiki/EnergyGun", details)

	var/list/output = list()
	for (var/manufacturer in sortList(tables))
		var/list/rows = tables[manufacturer]
		var/page_text = ""
		for (var/key in sortList(rows))
			page_text += rows[key]
		output[manufacturer] = page_text

	return output
