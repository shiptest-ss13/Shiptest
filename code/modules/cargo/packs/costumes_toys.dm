/datum/supply_pack/costumes_toys
	category = "Costumes & Toys"

/*
		Toys
*/

/datum/supply_pack/costumes_toys/foamforce/bonus
	name = "Foam Force Crate"
	desc = "No longer discontinued! Enjoy the fun Gezenan Family Tradition no matter where you are! Includes two automatic Foam Force Pistols with magazines and two Foam Force Shotguns."
	cost = 400
	contains = list(/obj/item/gun/ballistic/automatic/toy/pistol,
					/obj/item/gun/ballistic/automatic/toy/pistol,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/ammo_box/magazine/toy/pistol,
					/obj/item/ammo_box/magazine/toy/pistol)
	crate_name = "foam force pistol crate"

/datum/supply_pack/costumes_toys/lasertag
	name = "Laser Tag Crate"
	desc = "Are you tired of Foam Force? Looking for a real thrill? The new MW-Lasertag System is sure to Rock Your Socks, no cleanup required, just plain fun. The Makosso-Warra Way: includes enough equipment for a 3v3 laser-tag shootout."
	cost = 500
	contains = list(/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm)
	crate_name = "laser tag crate"

/datum/supply_pack/costumes_toys/arcade_toys
	name = "Toy Crate"
	desc = "A bulk assortment of five toys for filling up crane machines."
	cost = 250 // or play the arcade machines ya lazy bum
	contains = list()
	crate_name = "toy crate"

/datum/supply_pack/costumes_toys/arcade_toys/fill(obj/structure/closet/crate/C)
	var/the_toy
	for(var/i in 1 to 5)
		if(prob(50))
			the_toy = pick_weight(GLOB.arcade_prize_pool)
		else
			the_toy = pick(subtypesof(/obj/item/toy/plush))
		new the_toy(C)

/*
		Costumes
*/

/datum/supply_pack/costumes_toys/collectable_hats/fill(obj/structure/closet/crate/C)
	var/list/L = contains.Copy()
	for(var/i in 1 to 3)
		var/item = pick_n_take(L)
		new item(C)

/datum/supply_pack/costumes_toys/rilena_merch
	name = "RILENA Merchandise Crate"
	desc = "A crate full of all the RILENA merch you could ever want. Except the offbrand stuff. That's not in here."
	cost = 500 //lots of loot
	contains = list(/obj/item/toy/figure/tali,
					/obj/item/toy/plush/rilena,
					/obj/item/toy/plush/tali,
					/obj/item/toy/plush/sharai,
					/obj/item/toy/plush/xader,
					/obj/item/toy/plush/mora,
					/obj/item/poster/random_rilena,
					/obj/item/poster/random_rilena,
					/obj/item/poster/random_rilena,
					/obj/item/clothing/suit/hooded/hoodie/rilena,
					/obj/item/clothing/under/dress/rilena,
					/obj/item/gun/energy/buster)
	crate_name = "collectable merchandise crate"
