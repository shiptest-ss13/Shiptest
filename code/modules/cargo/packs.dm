/datum/supply_pack
	var/name = "Crate"
	var/group = "UNCATEGORIZED BULLSHIT"
	var/hidden = FALSE
	var/cost = 700
	var/list/contains = null
	var/crate_name = "crate"
	var/desc = ""//no desc by default
	var/crate_type = /obj/structure/closet/crate
	var/admin_spawned = FALSE
	var/no_bundle = FALSE

	// Associative list of datum/faction with the discount (as a percentage) checked with faction/allowed_faction
	//-1 if it should be included but not discounted (such as when faction_locked = TRUE)
	//-2 if it should be blacklisted from purchase
	var/list/faction_unique = list()

	// If buying should be restricted to factions included in faction_unique
	var/faction_locked = FALSE

/datum/supply_pack/proc/generate(atom/A, datum/bank_account/paying_account)
	var/obj/structure/closet/crate/C
	if(paying_account)
		C = new /obj/structure/closet/crate/secure/owned(A, paying_account)
		C.name = "[crate_name] - Purchased by [paying_account.account_holder]"
	else
		C = new crate_type(A)
		C.name = crate_name

	fill(C)
	return C

/datum/supply_pack/proc/fill(obj/structure/closet/crate/C)
	if (admin_spawned)
		for(var/item in contains)
			var/atom/A = new item(C)
			A.flags_1 |= ADMIN_SPAWNED_1
	else
		for(var/item in contains)
			new item(C)
