/datum/supply_pack
	var/name = "Crate"
	var/group = "Unsorted"
	var/hidden = FALSE
	var/base_cost
	var/cost = 700
	var/list/contains = null
	var/crate_name = "crate"
	var/desc = ""
	var/crate_type = /obj/structure/closet/crate
	var/admin_spawned = FALSE

/datum/supply_pack/New()
	. = ..()
	base_cost = cost

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
