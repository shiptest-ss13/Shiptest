/datum/blackmarket_item/mecha
	category = "Exosuits"

/datum/blackmarket_item/mecha/spawn_item(loc)
	var/obj/mecha/new_mech = new item(loc)
	if(prob(50)) // mfs stole my mech parts, can't have shit on the frontier
		QDEL_NULL(new_mech.scanmod)
	if(prob(50))
		QDEL_NULL(new_mech.capacitor)
	if(prob(50))
		QDEL_NULL(new_mech.cell)
	else
		new_mech.cell?.charge = rand() * new_mech.cell?.maxcharge / 2 // randomize cell charge (if it's still there)
	new_mech.obj_integrity = rand(new_mech.max_integrity / 4, new_mech.max_integrity) // randomize integrity
	new_mech.structural_damage = rand() * (new_mech.max_integrity - new_mech.obj_integrity) // add some structural damage, for fun
	return new_mech

/datum/blackmarket_item/mecha/gygax
	name = "501p Security Exosuit"
	desc = "A 501p-series exosuit lost during the war or something. We're pretty sure it still works."
	item = /obj/mecha/combat/gygax
	cost_min = 12000
	cost_max = 20000
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/mecha/durand
	name = "Durand Combat Exosuit"
	desc = "This Durand is probably what, three decades old at this point? We don't know exactly, but it looks like there's a few parts missing either way. Good luck."
	item = /obj/mecha/combat/durand
	cost_min = 15000
	cost_max = 25000
	stock_max = 2
	availability_prob = 20

