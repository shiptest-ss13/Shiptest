/proc/autowiki_caliber_label(caliber)
	if (!caliber)
		return null

	return capitalize(replacetext(caliber, "_", " "))

// autowiki icon file name handling to deal with nonsense around weapons/ammo
/proc/autowiki_icon_name(atom_path)
	var/trimmed = replacetext("[atom_path]", "/obj/item/", "")
	return SANITIZE_FILENAME(replacetext(trimmed, "/", "_"))

// stacks several values in one cell so they read as separate entries.
/proc/autowiki_stack(list/items)
	if (!length(items))
		return null

	var/list/wrapped = list()
	for (var/item in items)
		wrapped += "<div style='margin:0.2em 0;'>[item]</div>"

	return wrapped.Join("")

// Looks in the supply packs to find the actual gun
/proc/autowiki_guns_in(item_path)
	if (ispath(item_path, /obj/item/gun))
		return list(item_path)

	if (!ispath(item_path, /obj/item/storage))
		return list()

	var/list/found = list()
	var/obj/item/storage/container = new item_path

	if (!QDELETED(container))
		for (var/obj/item/gun/carried in container.GetAllContents())
			found |= carried.type
		qdel(container)

	return found

// see what supply packs cost, not the "value" of the gun itself, but realistically you can only buy it in packs
/proc/autowiki_purchase(gun_type)
	var/static/list/purchases

	if (isnull(purchases))
		purchases = list()

		for (var/pack_path in subtypesof(/datum/supply_pack))
			var/datum/supply_pack/pack = new pack_path

			if (pack.cost && !pack.admin_spawned)
				var/list/items = list()
				if (pack.contains)
					items += pack.contains
				if (pack.contains_factional)
					items += pack.contains_factional

				for (var/item in items)
					for (var/gun in autowiki_guns_in(item))
						// get cheapest if it appears multiple times
						var/list/known = purchases[gun]
						if (known && known["cost"] <= pack.cost)
							continue

						var/datum/faction/faction = pack.faction
						purchases[gun] = list(
							"cost" = pack.cost,
							"faction" = faction ? autowiki_faction_access(faction) : null,
							"locked" = pack.faction_locked,
						)

			qdel(pack)

	return purchases[gun_type]

/proc/autowiki_cost_label(gun_type)
	var/list/purchase = autowiki_purchase(gun_type)
	if (!purchase)
		return "N/A"

	if (purchase["locked"] && purchase["faction"])
		return autowiki_stack(list("[purchase["cost"]]", "[purchase["faction"]] only"))

	return "[purchase["cost"]]"

// need cost_sort so we can sort by cost but not can have other text in the table, since
// autowiki_cost_label basically edits it to have richer text so cost is no longer just a numeric field
/proc/autowiki_cost_sort(gun_type)
	var/list/purchase = autowiki_purchase(gun_type)
	return purchase ? purchase["cost"] : 0

// some real nonsense to get sensible faction labels for supply pack restrictions
/proc/autowiki_faction_label(faction_type)
	var/datum/faction/reference = faction_type
	var/faction_name = initial(reference.name)
	var/short = initial(reference.short_name)

	if (!short || !faction_name)
		return faction_name

	if (short == uppertext(copytext_char(faction_name, 3)))
		return faction_name

	var/initials = ""
	var/word_start = TRUE
	for (var/i in 1 to length(faction_name))
		var/letter = copytext(faction_name, i, i + 1)
		if (letter == " " || letter == "-")
			word_start = TRUE
			continue
		if (!word_start)
			continue
		word_start = FALSE
		if (letter != lowertext(letter))
			initials += uppertext(letter)

	if (initials == uppertext(short))
		return short

	if (short != uppertext(short))
		return short

	var/cased = ""
	word_start = TRUE
	for (var/i in 1 to length(short))
		var/letter = copytext(short, i, i + 1)
		cased += word_start ? uppertext(letter) : lowertext(letter)
		word_start = (letter == " " || letter == "-")

	return cased

// bit of a mess, but tries to get the faction roots for weapon supply packs
/proc/autowiki_faction_access(faction_type)
	var/datum/faction/faction = SSfactions.factions[faction_type]
	if (!faction)
		return autowiki_faction_label(faction_type)

	var/list/allowed = list()
	for (var/path in faction.allowed_factions)
		if (ispath(path, /datum/faction))
			allowed |= path

	var/list/roots = list()
	for (var/path in allowed)
		var/covered = FALSE
		for (var/other in allowed)
			if (other != path && ispath(path, other))
				covered = TRUE
				break
		if (!covered)
			roots += path

	var/list/labels = list()
	for (var/path in roots)
		labels |= autowiki_faction_label(path)

	if (!length(labels))
		return autowiki_faction_label(faction_type)

	var/list/sorted = sortList(labels)
	return sorted.Join(", ")
