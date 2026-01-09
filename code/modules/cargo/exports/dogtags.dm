/datum/export/dogtag
	desc = "CLIP has posted several bounties for wanted members of both the Frontiersman and the Clique. Bring back their tags, they'll reward you well."
	cost = 200
	elasticity_coeff = 0

/datum/export/dogtag/frontiersmen
	unit_name = "frontiersmen dogtags"
	export_types = list(/obj/item/clothing/neck/dogtag/frontier)

/datum/export/dogtag/ramzi
	unit_name = "ramzi dogtags"
	export_types = list(/obj/item/clothing/neck/dogtag/ramzi)

/datum/export/dogtag/officer
	unit_name = "high value dogtags"
	desc = "The NGR operates a standing bounty for proof-of-death of known pirate ring-leaders. They'll pay over double what CLIP pays for a dogtag verifying the death of them."
	cost = 500
	export_types = list(/obj/item/clothing/neck/dogtag/gold)
