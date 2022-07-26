/obj/item/melee/transforming/cleaving_saw/old
	name = "old cleaving saw"
	desc = "This saw, old and rusted, is still an effective tool at bleeding beasts and monsters."
	force = 10
	force_on = 15 //force when active
	throwforce = 15
	throwforce_on = 15
	faction_bonus_force = 5
	nemesis_factions = list("mining", "boss")
	bleed_stacks_per_hit = 1.5


/obj/structure/closet/secure_closet/medicalsrm
	name = "hunter doctor closet"
	desc = "Everything the Hunter Doctor needs to heal the hurting masses."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/secure_closet/shadow
	name = "shadow's locker"
	desc = "The closet of equipment and attire for the aspiring shadow."
	icon_door = "black"

/obj/structure/closet/secure_closet/hunter
	name = "hunter's locker"
	desc = "Everything a hunter will need, held in one secure closet."
	icon_door = "black"
	req_access = list(ACCESS_SECURITY)

/obj/structure/closet/secure_closet/montagnes
	name = "\proper head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/miningcloset
	name = "mining equipment locker"
	desc = "The closet of mining equipment."
	icon_state = "mining"

/turf/open/floor/plating/dirt/jungle/dark/actuallydark
	light_range = 0
	light_power = 0
	slowdown = 0

/turf/open/floor/plating/grass/jungle/actuallydark
	light_range = 0
	light_power = 0

/turf/open/water/jungle/actuallydark
	light_range = 0
	light_power = 0

/area/ship/external/dark
	name = "Dark External"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	icon_state = "space_near"

/area/ship/roumain
	name = "Hunter's Glade"
	icon_state = "Sleep"

/datum/preset_holoimage/montagne
	outfit_type = /datum/outfit/job/chaplain/roumain

/obj/item/disk/holodisk/roumain
	name = "Grand Ideology Sermon"
	desc = "A holodisk containing an SRM sermon."
	preset_image_type = /datum/preset_holoimage/montagne
	preset_record_text = {"
	NAME Montagne Gehrman
	SAY Oh ye followers of the Saint-Roumain.
	DELAY 25
	SAY Men and women of The Militia, Conquerers of nature, montagne, hunter, and shadow alike.
	DELAY 25
	SAY In His name, we maintain dominion over nature,
	DELAY 25
	SAY Dominion over the chaos of our lives and dominion over ourselves.
	DELAY 25
	DAY By defending ourselves and others, we defend His embers.
	DELAY 15
	"}


/obj/item/storage/firstaid/roumain
	name = "Roumain first aid kit"
	desc = "A common first aid kit used amongst the followers of the Ashen Huntsman."
	icon_state = "radfirstaid"
	item_state = "firstaid-rad"
	custom_premium_price = 1100

/obj/item/storage/firstaid/roumain/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/puce = 1,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/reagent_containers/glass/bowl/mushroom_bowl = 1,
		/obj/item/pestle = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/bear = 3,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf = 3)
	generate_items_inside(items_inside,src)
