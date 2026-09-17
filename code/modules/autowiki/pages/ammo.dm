/datum/autowiki/ammo
	page = "Template:Autowiki/Content/Ammo"

/datum/autowiki/ammo/proc/round_type(obj/item/ammo_casing/casing_type)
	var/caliber = initial(casing_type.caliber)
	var/list/parts = splittext("[casing_type]", "/")

	var/base_index = 0
	var/path_so_far = ""
	for (var/i in 2 to length(parts))
		path_so_far += "/[parts[i]]"
		var/obj/item/ammo_casing/ancestor = text2path(path_so_far)
		if (!ispath(ancestor, /obj/item/ammo_casing))
			continue
		if (initial(ancestor.caliber) == caliber)
			base_index = i
			break

	if (!base_index || base_index >= length(parts))
		return "Standard"

	var/name = format_text(initial(casing_type.name))

	var/list/pretty = list()
	for (var/segment in parts.Copy(base_index + 1))
		pretty += acronym_case(replacetext(segment, "_", " "), name)

	return pretty.Join(" ")

/datum/autowiki/ammo/proc/effects_summary(obj/item/ammo_casing/casing_type, obj/projectile/projectile_type)
	var/list/effects = list()

	if (ispath(projectile_type, /obj/projectile/bullet/incendiary))
		effects += "Incendiary"

	if (initial(projectile_type.embedding))
		effects += "Embeds"

	if (initial(projectile_type.dismemberment) > 0)
		effects += "Dismembers"

	if (initial(projectile_type.projectile_piercing) != NONE)
		effects += "Piercing"

	if (initial(projectile_type.nodamage))
		effects += "Non-damaging"

	if (initial(projectile_type.stun) > 0)
		effects += "Stun [initial(projectile_type.stun)]"

	if (initial(projectile_type.knockdown) > 0)
		effects += "Knockdown [initial(projectile_type.knockdown)]"

	if (initial(projectile_type.paralyze) > 0)
		effects += "Paralyze [initial(projectile_type.paralyze)]"

	if (initial(projectile_type.irradiate) > 0)
		effects += "Irradiate [initial(projectile_type.irradiate)]"

	if (initial(projectile_type.stutter) > 0)
		effects += "Stutter [initial(projectile_type.stutter)]"

	if (initial(projectile_type.drowsy) > 0)
		effects += "Drowsy [initial(projectile_type.drowsy)]"

	if (initial(projectile_type.jitter) > 0)
		effects += "Jitter [initial(projectile_type.jitter)]"

	var/wear = initial(casing_type.wear_modifier)
	if (wear > 1)
		effects += "Extra wear [wear]x"

	var/variance = initial(casing_type.variance)
	if (variance > 0)
		effects += "Scatter [variance]&deg;"

	if (initial(casing_type.harmful) == FALSE)
		effects += "Non-lethal"

	return length(effects) ? effects.Join(", ") : "N/A"

/datum/autowiki/ammo/proc/acronym_case(segment, source_name)
	var/static/list/known = list(
		"ap" = "AP",
		"hp" = "HP",
		"he" = "HE",
		"hc" = "HC",
		"emp" = "EMP",
		"trac" = "TRAC",
		"lmg" = "LMG",
		"smg" = "SMG",
	)

	if (known[segment])
		return known[segment]

	// findtextEx is case sensitive, so this only matches an actually capitalised acronym
	var/upper = uppertext(segment)
	if (findtextEx(source_name, upper))
		return upper

	return capitalize(segment)

// Grab the player-facing name if suitable.
/datum/autowiki/ammo/proc/round_label(obj/item/ammo_casing/casing_type, variant)
	var/label = format_text(initial(casing_type.name))
	var/caliber = initial(casing_type.caliber)

	// Clean up the string, don't need caliber or "bullet casing"
	if (caliber && findtext(label, caliber) == 1)
		label = copytext(label, length(caliber) + 1)

	for (var/suffix in list(" bullet casing", " casing", " shell", " round"))
		label = replacetext(label, suffix, "")

	label = trim(label)

	// More string processing to prevent repetition in the table
	if (!length(label) || findtext(lowertext(label), lowertext(variant)) || lowertext(label) == lowertext(caliber))
		return variant

	return "[variant] ([label])"

// no point showing the casing/bullet. box image is probably more helpful
/datum/autowiki/ammo/proc/box_for_casing(casing_type)
	var/static/list/boxes

	if (isnull(boxes))
		boxes = list()

		for (var/box_path in sortList(subtypesof(/obj/item/storage/box/ammo), /proc/cmp_typepaths_asc))
			var/obj/item/storage/box/ammo/box = new box_path
			for (var/obj/item/ammo_box/magazine/ammo_stack/stack in box)
				var/holds = stack.ammo_type
				if (holds && !boxes[holds])
					boxes[holds] = box_path
			qdel(box)

		for (var/box_path in sortList(subtypesof(/obj/item/ammo_box), /proc/cmp_typepaths_asc))
			var/obj/item/ammo_box/box = box_path
			if (ispath(box_path, /obj/item/ammo_box/magazine))
				continue
			if (initial(box.start_empty))
				continue

			var/holds = initial(box.ammo_type)
			if (holds && !boxes[holds])
				boxes[holds] = box_path

	return boxes[casing_type]

/datum/autowiki/ammo/generate()
	var/list/rows = list()
	var/list/seen_rows = list()

	for (var/obj/item/ammo_casing/casing_type as anything in subtypesof(/obj/item/ammo_casing))
		if (casing_type == initial(casing_type.bad_type) || initial(casing_type.autowiki_hidden))
			continue

		if (ispath(casing_type, /obj/item/ammo_casing/energy))
			continue

		if (!initial(casing_type.caliber))
			continue

		var/obj/projectile/projectile_type = initial(casing_type.projectile_type)
		if (!ispath(projectile_type, /obj/projectile))
			continue

		var/pellets = initial(casing_type.pellets)
		var/damage = initial(projectile_type.damage)
		var/caliber = autowiki_caliber_label(initial(casing_type.caliber))

		var/damage_type = initial(projectile_type.damage_type)
		var/damage_suffix = damage_type == BRUTE ? "" : " [damage_type]"

		var/stamina = initial(projectile_type.stamina)

		var/obj/item/box_type = box_for_casing(casing_type)
		var/box_name = ""
		if (box_type)
			box_name = autowiki_icon_name(box_type)
			var/obj/item/box = new box_type
			upload_icon(getFlatIcon(box, no_anim = TRUE), box_name)
			qdel(box)

		var/list/details = list(
			"icon" = box_name,
			"caliber" = escape_value(caliber),
			"anchor" = "",
			"round" = escape_value(round_label(casing_type, round_type(casing_type))),
			"damage" = "[damage][pellets > 1 ? " &times; [pellets]" : ""][damage_suffix]",
			"damage_sort" = damage * pellets,
			"armourpen" = initial(projectile_type.armour_penetration),
			"stamina" = stamina || "N/A",
			"stamina_sort" = stamina,
			"effects" = escape_value(effects_summary(casing_type, projectile_type)),
		)

		if (list2params(details) in seen_rows)
			continue
		seen_rows += list2params(details)

		rows["[details["caliber"]] [details["round"]] [casing_type]"] = details

	var/output = ""
	var/list/seen_calibers = list()

	for (var/key in sortList(rows))
		var/list/details = rows[key]
		var/caliber = details["caliber"]

		// The first row of each caliber carries the anchor a gun row links to.
		if (caliber && !(caliber in seen_calibers))
			seen_calibers += caliber
			details["anchor"] = include_template("anchor", list("1" = caliber))

		output += include_template("Autowiki/AmmoRound", details)

	return output
