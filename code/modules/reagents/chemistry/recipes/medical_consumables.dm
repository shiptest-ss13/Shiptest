/datum/chemical_reaction/medmesh
	required_reagents = list(/datum/reagent/cellulose = 20, /datum/reagent/consumable/aloejuice = 20, /datum/reagent/space_cleaner/sterilizine = 10)
	mob_react = FALSE

/datum/chemical_reaction/medmesh/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/stack/medical/mesh/advanced(location)

/datum/chemical_reaction/medmesh/ash
	required_reagents = list(/datum/reagent/ash_fibers = 20, /datum/reagent/consumable/aloejuice = 20, /datum/reagent/space_cleaner/sterilizine = 10)
