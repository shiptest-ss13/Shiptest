#define CARGOTYPE_FOOD "food"
#define CARGOTYPE_CLOTHING "clothing"
#define CARGOTYPE_ORES "ores"
#define CARGOTYPE_METALS "metals"
#define CARGOTYPE_HEAVYMETALS "heavy metals"
#define CARGOTYPE_PLASTICS "plastics"
#define CARGOTYPE_EQUIPMENT "heavy metals"
#define CARGOTYPE_MILITARY_EQUIPMENT "military equipment"
#define CARGOTYPE_MEDICAL "military equipment"
#define CARGOTYPE_INDUSTRIAL "industrial"
#define CARGOTYPE_ELECTRONICS "electronics"
#define CARGOTYPE_CONSUMERGOODS "consumer goods"
#define CARGOTYPE_LUXURYGOODS "luxury goods"
#define CARGOTYPE_CIV_FIREARMS "civillian-grade firearms"
#define CARGOTYPE_MILITARY_FIREARMS "military-grade firearms"
#define CARGOTYPE_GARBAGE "garbage"
#define CARGOTYPE_CONSTRUCTION "construction"
#define CARGOTYPE_SHIP_PARTS "ship parts"
#define CARGOTYPE_SHIP_ALLOYS "ship alloys"
#define CARGOTYPE_FIRSTAID "ship alloys"

#define CARGOTYPE_DRUGS "recreational drugs"
#define CARGOTYPE_DRUGS_REGULATED "controlled substances"
#define CARGOTYPE_DRUGS_NARCOTICS "narcotics"

#define CARGOTYPE_ILLEGAL_CARGO "illegal"
#define CARGOTYPE_VERY_ILLEGAL_CARGO "very illegal"


/datum/cargo_type
	var/name = "genric cargotype"
	var/desc

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
	var/small_item = FALSE //Small items can be grouped into a single crate.

	var/datum/faction/faction
	var/faction_discount = 15
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
