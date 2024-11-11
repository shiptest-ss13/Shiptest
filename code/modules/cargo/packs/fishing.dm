/datum/supply_pack/fish
	group = "Fishing Essentials"


/datum/supply_pack/fish/fishingkit
	name = "Fishing Starter Kit"
	desc = "The bare necessities to get out there and catch some fish, all in one convenient box!"
	cost = 500
	contains = list(/obj/item/storage/toolbox/fishing,
					/obj/item/book/fish_catalog,
					/obj/item/reagent_containers/food/drinks/beer,
					/obj/item/reagent_containers/food/drinks/beer)
	crate_name = "fishing starter crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/fish/fishstasis
	name = "Fish Stasis Kit Supply Crate"
	desc = "Contains four stasis cases meant to keep fish alive during transportation."
	cost = 1000
	contains = list(/obj/item/storage/fish_case,
					/obj/item/storage/fish_case,
					/obj/item/storage/fish_case,
					/obj/item/storage/fish_case)
	crate_name = "stasis case crate"

/datum/supply_pack/fish/premiumworms
	name = "High Quality Worm Pack"
	desc = "A selection of the system's finest worms, guaranteed to lure in only the largest of fish."
	cost = 1000
	contains = list(/obj/item/bait_can/worm/premium,
					/obj/item/bait_can/worm/premium,
					/obj/item/bait_can/worm/premium,
					/obj/item/bait_can/worm/premium)
	crate_name = "premium worm crate"

/datum/supply_pack/fish/masterworkpole
	name = "Custom Made Masterwork Fishing Rod"
	desc = "Fishing rod forged after grueling hours of labor by a master rodsmith, truly a work of fishing art. Required to catch size 2 fish."
	cost = 5000
	contains = list(/obj/item/fishing_rod/master)
	crate_name = "masterwork fishing rod case"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/fish/fishinghooks
	name = "Fishing Hook Variety Pack"
	desc = "A variety of fishing hooks to allow for more specialized fishing."
	cost = 1000
	contains = list(/obj/item/storage/box/fishing_hooks)
	crate_name = "fishing hook crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/fish/fishinglines
	name = "Fishing Line Pack"
	desc = "Contains the necessary fishing lines for catching more exotic fish."
	cost = 1000
	contains = list(/obj/item/storage/box/fishing_lines,
					/obj/item/storage/box/fishing_lines) //Comes with two boxes on account of these being more necessary than the hooks
	crate_name = "fishing line crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/fish/aquarium
	name = "Aquarium Construction Kit"
	desc = "Why seek rare fish if not to show them off? This all-in-one aquarium kit's all you'll ever need to keep a stable population of fish onboard your ship! (Building materials not included, Aquatech Ltd. is a limited liability company and not responsible for any fish related mishaps)"
	cost = 2000
	contains = list(/obj/item/aquarium_kit,
					/obj/item/storage/box/aquarium_props,
					/obj/item/fish_feed)
	crate_name = "aquarium kit crate"
