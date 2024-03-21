/datum/crafting_recipe/bonearmor
	name = "Bone Armor"
	result = /obj/item/clothing/suit/armor/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonenecklace
	name = "Hunter's Necklace"
	result = /obj/item/clothing/accessory/wolftalisman
	time = 35
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 3,
				/obj/item/crusher_trophy/wolf_ear = 2,
				/obj/item/crusher_trophy/fang = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/crusher_trophy/legion_skull = 1,
				/obj/item/stack/sheet/animalhide/goliath_hide = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonestaff
	name = "Legion Staff"
	result = /obj/item/legion_staff
	time = 35
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/crusher_trophy/legion_skull = 2,\
				/obj/item/crusher_trophy/dwarf_skull = 1,
				/obj/item/organ/regenerative_core/legion = 1)
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

/datum/crafting_recipe/skullhelm
	name = "Skull Helmet"
	result = /obj/item/clothing/head/helmet/skull
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4)
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

/datum/crafting_recipe/firebrand
	name = "Firebrand"
	result = /obj/item/match/firebrand
	time = 100 //Long construction time. Making fire is hard work.
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonedagger
	name = "Bone Dagger"
	result = /obj/item/kitchen/knife/combat/bone
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2)
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

/datum/crafting_recipe/rake //Category resorting incoming
	name = "Rake"
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	result = /obj/item/cultivator/rake
	category = CAT_PRIMAL

/datum/crafting_recipe/woodbucket
	name = "Wooden Bucket"
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)
	result = /obj/item/reagent_containers/glass/bucket/wooden
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

/datum/crafting_recipe/legionpike
	name = "Legion on a Spear"
	time = 55
	reqs = list(/obj/item/spear = 1,
				/obj/item/organ/regenerative_core = 1,
				/obj/item/crusher_trophy/legion_skull = 2)
	result = /obj/structure/legionpike
	category = CAT_PRIMAL

/datum/crafting_recipe/tribal_torch
	name = "Tribal Torch"
	result = /obj/item/candle/tribal_torch
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 4)
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

/datum/crafting_recipe/rib
	name = "Collosal Rib"
	always_availible = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 10,
			/datum/reagent/fuel/oil = 5)
	result = /obj/structure/statue/bone/rib
	subcategory = CAT_PRIMAL

/datum/crafting_recipe/skull
	name = "Skull Carving"
	always_availible = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 6,
			/datum/reagent/fuel/oil = 5)
	result = /obj/structure/statue/bone/skull
	category = CAT_PRIMAL

/datum/crafting_recipe/halfskull
	name = "Cracked Skull Carving"
	always_availible = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 3,
			/datum/reagent/fuel/oil = 5)
	result = /obj/structure/statue/bone/skull/half
	category = CAT_PRIMAL

/datum/crafting_recipe/boneshovel
	name = "Serrated Bone Shovel"
	always_availible = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 4,
			/datum/reagent/fuel/oil = 5,
			/obj/item/shovel/spade = 1)
	result = /obj/item/shovel/serrated
	category = CAT_PRIMAL

/datum/crafting_recipe/lasso
	name = "Bone Lasso"
	reqs = list(
			/obj/item/stack/sheet/bone = 1,
			/obj/item/stack/sheet/sinew = 5)
	result = /obj/item/key/lasso
	category = CAT_PRIMAL

/datum/crafting_recipe/dragonspear
	name = "Dragonslayer's Spear"
	result = /obj/item/spear/dragonspear
	time = 45
	reqs = list(/obj/item/crusher_trophy/ash_spike = 1,
				/obj/item/crusher_trophy/tail_spike = 2,
				/obj/item/stack/sheet/bone = 5,
				/obj/item/stack/sheet/sinew = 3)
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

/datum/crafting_recipe/boneclub
	name = "Bone Club"
	result = /obj/item/melee/baseball_bat/bone
	time = 40
	reqs = list(/obj/item/stack/sheet/bone = 6)
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

/datum/crafting_recipe/fermenting_barrel
	name = "Wooden Barrel"
	result = /obj/structure/fermenting_barrel
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8)
	time = 50
	category = CAT_PRIMAL

/datum/crafting_recipe/distiller
	name = "Distiller"
	result = /obj/structure/fermenting_barrel/distiller
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8, /obj/item/stack/sheet/metal = 5, /datum/reagent/srm_bacteria = 30)
	time = 50
	category = CAT_PRIMAL
