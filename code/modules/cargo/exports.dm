// Simple holder datum to pass export results around
/datum/export_report
	var/list/exported_atoms = list()	//names of atoms sold/deleted by export
	var/list/total_amount = list()		//export instance => total count of sold objects of its type, only exists if any were sold
	var/list/total_value = list()		//export instance => total value of sold objects
	var/list/exported_atoms_ref = list()	//if they're not deleted they go in here for use.

// external_report works as "transaction" object, pass same one in if you're doing more than one export in single go
/proc/export_item_and_contents(atom/movable/AM, delete_unsold = TRUE, dry_run=FALSE, datum/export_report/external_report)
	var/profit_ratio = 1 //Percentage that gets sent to the seller, rest goes to cargo.

	var/list/contents = AM.GetAllContents()

	var/datum/export_report/report = external_report

	if(!report) //If we don't have any longer transaction going on
		report = new

	// We go backwards, so it'll be innermost objects sold first
	for(var/i in reverse_range(contents))
		var/atom/movable/thing = i
		var/sold = FALSE
		if(QDELETED(thing))
			continue

		for(var/datum/export/E in GLOB.outpost_exports)
			if(!E)
				continue
			if(E.applies_to(thing))
				sold = E.sell_object(thing, report, dry_run, profit_ratio)
				report.exported_atoms += " [thing.name]"
				if(!QDELETED(thing))
					report.exported_atoms_ref += thing
				break
		if(!dry_run && (sold || delete_unsold))
			if(ismob(thing))
				thing.investigate_log("deleted through cargo export",INVESTIGATE_CARGO)
	if(!dry_run)
		qdel(AM)

	return report

/datum/export
	var/unit_name = ""
	var/desc = ""
	/// The base amount of money gained when selling a "unit" of this item, as determined by get_amount().
	var/cost = 1
	/// The actual sale cost of the item, as adjusted by events and market changes.
	var/true_cost

	var/list/export_types = list()	// Type of the exported object. If none, the export datum is considered base type.
	var/include_subtypes = TRUE		// Set to FALSE to make the datum apply only to a strict type.
	var/list/exclude_types = list()	// Types excluded from export

	///can this export be targeted with high-value bounty?
	var/valid_event_target = TRUE

/datum/export/New()
	..()
	true_cost = cost

	export_types = typecacheof(export_types, FALSE, !include_subtypes)
	exclude_types = typecacheof(exclude_types)


// Checks the cost. 0 cost items are skipped in export.
/datum/export/proc/get_cost(amount)
	return round(true_cost * amount)

// Checks the amount of exportable in object. Credits in the bill, sheets in the stack, etc.
// Usually acts as a multiplier for a cost, so item that has 0 amount will be skipped in export.
/datum/export/proc/get_amount(obj/O)
	return 1

// Checks if the atom is fit for export datum.
/datum/export/proc/applies_to(obj/O)
	if(!is_type_in_typecache(O, export_types))
		return FALSE
	if(include_subtypes && is_type_in_typecache(O, exclude_types))
		return FALSE
	var/amount = get_amount(O)
	if(!amount)
		return FALSE
	if(!get_cost(amount))
		return FALSE
	if(O.flags_1 & HOLOGRAM_1)
		return FALSE
	return TRUE

/datum/export/proc/sell_object(obj/O, dry_run = TRUE)
	///Quantity of the object in question.
	var/amount = get_amount(O)
	///This is the value of the object, as derived from export datums.
	var/the_cost = get_cost(amount)
	///Utilized in the pricetag component. Splits the object's profit when it has a pricetag by the specified amount.
	var/profit_ratio = 0

	if(amount <= 0 || the_cost <= 0)
		return null

	profit_ratio = SEND_SIGNAL(O, COMSIG_ITEM_SPLIT_PROFIT)
	the_cost = the_cost * ((100 - profit_ratio) * 0.01)

	if(!dry_run)
		SSblackbox.record_feedback("nested tally", "export_sold_cost", 1, list("[O.type]", "[the_cost]"))
		SSblackbox.record_feedback("tally", "export_sold_cost_total", the_cost, O.type)
	return the_cost

/datum/export/proc/calc_total_payout(atoms_list = list())
	var/amount = 0
	for(var/atom/priced_atom in atoms_list)
		amount += get_amount(priced_atom)
	return get_cost(amount)

/datum/export/proc/get_payout_text()
	if(true_cost != cost)
		return "[true_cost]/[cost]"
	else
		return "[true_cost]"
