// not a page, helpers for weapons this is why this blank datum exists
/datum/autowiki/weapons

/datum/autowiki/weapons/proc/manufacturer_name(raw)
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

/datum/autowiki/weapons/proc/firemode_summary(obj/item/gun/gun)
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

		// guns that require manual racking or hammer manipulation per shot are still listed as semi-auto in gun_firemodes
		// but the actual behaviour is set by an extra semi_auto var in the type
		if (mode == FIREMODE_SEMIAUTO && istype(gun, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/ballistic = gun
			if (!ballistic.semi_auto)
				label = "Manual"

		if (mode == FIREMODE_BURST && gun.burst_size > 1)
			label += " ([gun.burst_size])"
		modes += label

	return length(modes) ? modes.Join(", ") : "N/A"

// this exists here instead of energy.dm because e40 also needs this
/datum/autowiki/weapons/proc/lens_entries(obj/item/gun/energy/gun, bold_default = FALSE)
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

	var/obj/item/stock_parts/cell/standard = initial(gun.default_ammo_type)
	var/default_charge = standard ? initial(standard.maxcharge) : 0

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
			var/list/seen = list()
			for (var/charge in charges)
				var/count = round(charge / lens.e_cost)
				if (count in seen)
					continue
				seen += count
				var/mark = bold_default && length(charges) > 1 && charge == default_charge
				counts += mark ? "'''[count]'''" : "[count]"
			facts += "[counts.Join(" / ")] shots"

		entries += length(facts) ? "'''[label]''': [facts.Join(", ")]" : "'''[label]'''"

	return entries

/datum/autowiki/weapons/proc/caliber_label(caliber)
	if (!caliber)
		return null

	return capitalize(replacetext(caliber, "_", " "))


// some weapons (pml9 rocket launcher) have a desc that changes at runtime. get the desc only so that it doesnt regen every push
/datum/autowiki/weapons/proc/description(atom/thing)
	var/declared = initial(thing.desc)
	return (declared && findtextEx(thing.desc, declared) == 1) ? declared : thing.desc

// the gun holds the list, not the attachment, so
// the mapping has to be built by walking every gun once and inverting it.
/datum/autowiki/weapons/proc/attachment_guns(attachment_path)
	var/static/list/fits

	if (isnull(fits))
		fits = list()

		for (var/gun_path in subtypesof(/obj/item/gun/ballistic) + subtypesof(/obj/item/gun/energy))
			if (!listable_gun(gun_path))
				continue

			var/obj/item/gun/gun = new gun_path
			if (QDELETED(gun))
				continue

			var/list/allowed = list()
			if (gun.valid_attachments)
				allowed |= gun.valid_attachments
			if (gun.unique_attachments)
				allowed |= gun.unique_attachments
			if (gun.refused_attachments)
				allowed -= gun.refused_attachments

			// the gun lists parent types and typecacheof() expands them, so listing
			// the gun obj permits every underbarrel gun under it
			var/label = capitalize(format_text(gun.name))
			for (var/attachment in allowed)
				for (var/subtype in typesof(attachment))
					var/list/guns = fits["[subtype]"]
					if (!guns)
						guns = list()
						fits["[subtype]"] = guns
					guns |= label

			qdel(gun)

	return fits["[attachment_path]"]

// autowiki icon file name handling to deal with nonsense around weapons/ammo
/datum/autowiki/weapons/proc/icon_name(atom_path)
	var/trimmed = replacetext("[atom_path]", "[/obj/item]/", "")
	return SANITIZE_FILENAME(replacetext(trimmed, "/", "_"))

// gun attachment slots
/datum/autowiki/weapons/proc/slot_summary(obj/item/gun/gun)
	var/static/list/order = list(
		ATTACHMENT_SLOT_MUZZLE,
		ATTACHMENT_SLOT_RAIL,
		ATTACHMENT_SLOT_SCOPE,
		ATTACHMENT_SLOT_GRIP,
		ATTACHMENT_SLOT_STOCK,
	)

	if (!gun.slot_available)
		return "None"

	// list the slot even if its pre occupied
	var/list/counts = gun.slot_available.Copy()
	var/list/occupied = list()
	for (var/obj/item/attachment/fitted in gun)
		counts[fitted.slot] += 1

		// something that cannot be taken off leaves a slot the reader can never use,
		// unlike a fitted underbarrel, which they can remove and replace
		if (!(fitted.attach_features_flags & (ATTACH_REMOVABLE_HAND|ATTACH_REMOVABLE_TOOL)))
			occupied[fitted.slot] = TRUE

	var/list/slots = list()
	for (var/slot in order)
		var/count = counts[slot]
		if (!count)
			continue

		var/label = capitalize(slot)
		if (count > 1)
			label += " &times; [count]"
		if (occupied[slot])
			label += " (fitted)"
		slots += label

	return length(slots) ? slots.Join(", ") : "None"

/datum/autowiki/weapons/proc/stack(list/items)
	if (!length(items))
		return null

	var/list/wrapped = list()
	for (var/item in items)
		wrapped += "<div style='margin:0.2em 0;'>[item]</div>"

	return wrapped.Join("")

// Looks in the supply packs to find the actual gun or attachment
/datum/autowiki/weapons/proc/items_in(item_path)
	if (ispath(item_path, /obj/item/gun) || ispath(item_path, /obj/item/attachment))
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
/datum/autowiki/weapons/proc/purchase(gun_type)
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
					for (var/gun in items_in(item))
						// get cheapest if it appears multiple times
						var/list/known = purchases[gun]
						if (known && known["cost"] <= pack.cost)
							continue

						var/datum/faction/faction = pack.faction
						purchases[gun] = list(
							"cost" = pack.cost,
							"faction" = faction ? faction_access(faction) : null,
							"locked" = pack.faction_locked,
							"discount" = pack.faction_discount,
						)

			qdel(pack)

	return purchases[gun_type]

/datum/autowiki/weapons/proc/discounted(cost, discount)
	return round(cost - cost * discount / 100)

// a locked pack can only be bought by the faction it is locked to, so only get its discounted price
/datum/autowiki/weapons/proc/effective_cost(list/deal)
	if (deal["locked"] && deal["faction"] && deal["discount"])
		return discounted(deal["cost"], deal["discount"])

	return deal["cost"]

/datum/autowiki/weapons/proc/cost_label(gun_type)
	var/list/deal = purchase(gun_type)
	if (!deal)
		return "N/A"

	var/cost = effective_cost(deal)
	var/list/lines = list("[cost]")

	if (deal["locked"] && deal["faction"])
		lines += "[deal["faction"]] only"

	// show both prices if faction discount is available for non faction locked weapon
	else if (deal["discount"] && deal["faction"])
		lines += "[discounted(cost, deal["discount"])] for [deal["faction"]]"

	return length(lines) > 1 ? stack(lines) : lines[1]

/datum/autowiki/weapons/proc/cost_sort(gun_type)
	var/list/deal = purchase(gun_type)
	return deal ? effective_cost(deal) : 0

// some real nonsense to get sensible faction labels for supply pack restrictions
/datum/autowiki/weapons/proc/faction_label(faction_type)
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
/datum/autowiki/weapons/proc/faction_access(faction_type)
	var/datum/faction/faction = SSfactions.factions[faction_type]
	if (!faction)
		return faction_label(faction_type)

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
		labels |= faction_label(path)

	if (!length(labels))
		return faction_label(faction_type)

	var/list/sorted = sortList(labels)
	return sorted.Join(", ")

// whether a gun belongs in the autowiki at all
/datum/autowiki/weapons/proc/listable_gun(obj/item/gun/gun_type)
	if (gun_type == initial(gun_type.bad_type))
		return FALSE
	if (initial(gun_type.autowiki_hidden))
		return FALSE
	return initial(gun_type.actually_shoots)

// jam spread and recoil into a single cell
/datum/autowiki/weapons/proc/stance_cell(spread, recoil)
	if (!recoil)
		return "[spread] spread"

	return stack(list("[spread] spread", "[recoil] recoil"))
