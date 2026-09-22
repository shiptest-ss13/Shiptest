/datum/autowiki/weapons/attachments
	page = "Template:Autowiki/Content/Attachments"

/datum/autowiki/weapons/attachments/proc/slot_label(obj/item/attachment/attachment)
	return attachment.slot ? capitalize(attachment.slot) : "N/A"

// cant really get toggle_attachment() or apply_attachment() effects...
/datum/autowiki/weapons/attachments/proc/features(obj/item/attachment/attachment, attachment_path)
	var/list/facts = list()

	if (attachment.attach_features_flags & ATTACH_TOGGLE)
		facts += "Toggleable"
	if (attachment.attach_features_flags & ATTACH_AMMOMODE)
		facts += "Selectable lens"
	if (!(attachment.attach_features_flags & ATTACH_REMOVABLE_HAND))
		facts += (attachment.attach_features_flags & ATTACH_REMOVABLE_TOOL) ? "Tool to remove" : "Not removable"

	// if theres few enough we can just list them
	var/list/guns = attachment_guns(attachment_path)
	if (length(guns) && length(guns) <= 3)
		facts += length(guns) == 1 ? "[guns[1]] only" : "Weapon-specific"

	return length(facts) ? facts.Join(", ") : "N/A"

/datum/autowiki/weapons/attachments/generate()
	var/list/rows = list()
	var/list/seen_rows = list()

	for (var/attachment_path in sortList(subtypesof(/obj/item/attachment), /proc/cmp_typepaths_asc))
		var/obj/item/attachment/attachment_type = attachment_path

		if (attachment_type == initial(attachment_type.bad_type) || initial(attachment_type.autowiki_hidden))
			continue

		var/obj/item/attachment/attachment = new attachment_path

		if (QDELETED(attachment))
			continue

		var/list/details = list(
			"icon" = "",
			"name" = escape_value(capitalize(format_text(attachment.name))),
			"slot" = escape_value(slot_label(attachment)),
			"cost" = "",
			"cost_sort" = "",
			"features" = escape_value(features(attachment, attachment_path)),
		)

		var/description = escape_value(format_text(description(attachment)))

		// the nine folding stocks differ only in which gun they are sprited for
		var/dedupe_key = "[list2params(details)][description]"
		if (dedupe_key in seen_rows)
			qdel(attachment)
			continue
		seen_rows += dedupe_key

		var/filename = icon_name(attachment.type)
		upload_icon(getFlatIcon(attachment, no_anim = TRUE), filename)
		qdel(attachment)

		details["icon"] = filename
		details["cost"] = cost_label(attachment_path)
		details["cost_sort"] = cost_sort(attachment_path)
		details["description"] = description

		rows["[details["name"]] [attachment_path]"] = include_template("Autowiki/Attachment", details)

	var/output = ""
	for (var/key in sortList(rows))
		output += rows[key]

	return output
