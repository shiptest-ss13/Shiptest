/datum/crafting_recipe/bonearmlet
	name = "Bone Armlet"
	result = /obj/item/clothing/accessory/bonearmlet
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/fangnecklace
	name = "Wolf Fang Necklace"
	result = /obj/item/clothing/neck/fangnecklace
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/mob_trophy/fang = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/mob_trophy/legion_skull = 1,
				/obj/item/stack/sheet/animalhide/goliath_hide = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/skilt
	name = "Sinew Kilt"
	result = /obj/item/clothing/accessory/skilt
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathcloak
	name = "Goliath Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2) //it takes 4 goliaths to make 1 cloak if the plates are skinned
	category = CAT_PRIMAL

/datum/crafting_recipe/drakecloak
	name = "Ash Drake Armour"
	result = /obj/item/clothing/suit/hooded/cloak/drake
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 10,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/ashdrake = 5)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonespear
	name = "Bone Spear"
	result = /obj/item/spear/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/boneaxe
	name = "Bone Axe"
	result = /obj/item/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonfire
	name = "Bonfire"
	time = 60
	reqs = list(/obj/item/grown/log = 5)
	parts = list(/obj/item/grown/log = 5)
	blacklist = list(/obj/item/grown/log/steel)
	result = /obj/structure/bonfire
	category = CAT_PRIMAL

/datum/crafting_recipe/headpike
	name = "Spike Head (Glass Spear)"
	time = 65
	reqs = list(/obj/item/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/spear = 1)
	blacklist = list(/obj/item/spear/explosive, /obj/item/spear/bonespear)
	result = /obj/structure/headpike
	category = CAT_PRIMAL

/datum/crafting_recipe/headpikebone
	name = "Spike Head (Bone Spear)"
	time = 65
	reqs = list(/obj/item/spear/bonespear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/spear/bonespear = 1)
	result = /obj/structure/headpike/bone
	category = CAT_PRIMAL

/datum/crafting_recipe/lasso
	name = "Bone Lasso"
	reqs = list(
			/obj/item/stack/sheet/bone = 1,
			/obj/item/stack/sheet/sinew = 5)
	result = /obj/item/key/lasso
	category = CAT_PRIMAL

/datum/crafting_recipe/heavybonearmor
	name = "Heavy Bone Armor"
	result = /obj/item/clothing/suit/hooded/cloak/bone
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/watcherbola
	name = "Watcher Bola"
	result = /obj/item/restraints/legcuffs/bola/watcher
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 2,
				/obj/item/restraints/handcuffs/cable/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathshield
	name = "Goliath shield"
	result = /obj/item/shield/riot/goliath
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonesword
	name = "Bone Sword"
	result = /obj/item/claymore/bone
	time = 40
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/hunterbelt
	name = "Hunters Belt"
	result = /obj/item/storage/belt/mining/primitive
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/quiver
	name = "Quiver"
	result = /obj/item/storage/bag/quiver/empty
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/bow/ashen
	time = 200
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/polarbearcloak
	name = "Polar Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath/polar
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 2)
	blacklist = list(/obj/item/stack/sheet/animalhide/goliath_hide)
	category = CAT_PRIMAL

/datum/crafting_recipe/distiller
	name = "Distiller"
	result = /obj/structure/fermenting_barrel/distiller
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8, /obj/item/stack/sheet/metal = 5, /datum/reagent/srm_bacteria = 30)
	time = 50
	category = CAT_PRIMAL

/datum/crafting_recipe/crystalamulet
	name = "Crystal Amulet"
	result = /obj/item/clothing/neck/crystal_amulet
	time = 4 SECONDS
	reqs = list(/obj/item/strange_crystal = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/crystalspear
	name = "Crystal Spear"
	result = /obj/item/spear/crystal
	time = 4 SECONDS
	reqs = list(/obj/item/strange_crystal = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/mushroom_bowl
	name = "Mushroom Bowl"
	result = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_PRIMAL

/datum/crafting_recipe/charcoal_stylus
	name = "Charcoal Stylus"
	result = /obj/item/pen/charcoal
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1, /datum/reagent/ash = 30)
	time = 30
	category = CAT_PRIMAL

/datum/crafting_recipe/mushroom_mortar
	name = "Mushroom Mortar"
	result = /obj/item/reagent_containers/glass/mortar/mushroom
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_PRIMAL

/datum/crafting_recipe/oar
	name = "Goliath Bone Oar"
	result = /obj/item/oar
	reqs = list(/obj/item/stack/sheet/bone = 2)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/boat
	name = "Goliath Hide Boat"
	result = /obj/vehicle/ridden/lavaboat
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	time = 50
	category = CAT_PRIMAL
