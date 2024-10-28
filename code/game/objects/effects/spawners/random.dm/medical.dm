/obj/effect/spawner/random/medical
	name = "medical loot spawner"
	desc = "Doc, gimmie something good."

/obj/effect/spawner/random/medical/minor_healing
	name = "minor healing spawner"
	icon_state = "gauze"
	loot = list(
		/obj/item/stack/medical/suture,
		/obj/item/stack/medical/mesh,
		/obj/item/stack/medical/gauze,
	)

/obj/effect/spawner/random/medical/organs
	name = "ayylien organ spawner"
	loot = list(
		/obj/item/organ/heart/gland/electric = 3,
		/obj/item/organ/heart/gland/trauma = 4,
		/obj/item/organ/heart/gland/egg = 7,
		/obj/item/organ/heart/gland/chem = 5,
		/obj/item/organ/heart/gland/mindshock = 5,
		/obj/item/organ/heart/gland/plasma = 7,
		/obj/item/organ/heart/gland/transform = 5,
		/obj/item/organ/heart/gland/slime = 4,
		/obj/item/organ/heart/gland/spiderman = 5,
		/obj/item/organ/heart/gland/ventcrawling = 1,
		/obj/item/organ/body_egg/alien_embryo = 1,
		/obj/item/organ/regenerative_core = 2)
	spawn_loot_count = 3

/obj/effect/spawner/random/medical/memeorgans
	name = "meme organ spawner"
	loot = list(
		/obj/item/organ/ears/penguin,
		/obj/item/organ/ears/cat,
		/obj/item/organ/eyes/compound,
		/obj/item/organ/eyes/snail,
		/obj/item/organ/tongue/bone,
		/obj/item/organ/tongue/fly,
		/obj/item/organ/tongue/snail,
		/obj/item/organ/tongue/lizard,
		/obj/item/organ/tongue/alien,
		/obj/item/organ/tongue/ethereal,
		/obj/item/organ/tongue/robot,
		/obj/item/organ/tongue/zombie,
		/obj/item/organ/appendix,
		/obj/item/organ/liver/fly,
		/obj/item/organ/lungs/plasmaman,
		/obj/item/organ/tail/cat,
		/obj/item/organ/tail/lizard
	)
	spawn_loot_count = 5

/obj/effect/spawner/random/medical/surgery_tool/common
	name = "Surgery tool spawner"
	icon_state = "scapel"
	loot = list(
		/obj/item/scalpel,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/circular_saw,
		/obj/item/surgicaldrill,
		/obj/item/cautery,
	)

/obj/effect/spawner/random/medical/surgery_tool/adv
	loot = list(
		/obj/item/scalpel/advanced,
		/obj/item/retractor/advanced,
		/obj/item/surgicaldrill/advanced,
	)

/obj/effect/spawner/random/medical/surgery_tool
	loot = list(
		/obj/effect/spawner/random/medical/surgery_tool/common = 120,
		/obj/effect/spawner/random/medical/surgery_tool/adv = 10,
	)

/obj/effect/spawner/random/medical/medkit
	name = "medkit spawner"
	icon_state = "medkit"
	loot = list(
		/obj/item/storage/firstaid/regular = 10,
		/obj/item/storage/firstaid/o2 = 10,
		/obj/item/storage/firstaid/fire = 10,
		/obj/item/storage/firstaid/brute = 10,
		/obj/item/storage/firstaid/toxin = 10,
		/obj/item/storage/firstaid/advanced = 1,
	)

/obj/effect/spawner/random/medical/patient_stretcher
	name = "patient stretcher spawner"
	icon_state = "rollerbed"
	loot = list(
		/obj/structure/bed/roller,
		/obj/vehicle/ridden/wheelchair,
	)

/obj/effect/spawner/random/medical/supplies
	name = "medical supplies spawner"
	icon_state = "box_small"
	loot = list(
		/obj/item/storage/box/hug,
		/obj/item/storage/box/pillbottles,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/rxglasses,
		/obj/item/storage/box/beakers,
		/obj/item/storage/box/gloves,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/syringes,
	)

/obj/effect/spawner/random/medical/beaker
	loot = list(
		/obj/item/reagent_containers/glass/beaker = 300,
		/obj/item/reagent_containers/glass/beaker/large = 200,
		/obj/item/reagent_containers/glass/beaker/plastic = 50,
		/obj/item/reagent_containers/glass/beaker/meta = 10,
		/obj/item/reagent_containers/glass/beaker/noreact = 5,
		/obj/item/reagent_containers/glass/beaker/bluespace = 1,
	)

/obj/effect/spawner/random/medical/prosthetic
	loot = list(
		/obj/item/bodypart/l_arm/robot/surplus = 1,
		/obj/item/bodypart/r_arm/robot/surplus = 1,
		/obj/item/bodypart/leg/left/robot/surplus = 1,
		/obj/item/bodypart/leg/right/robot/surplus = 1,
	)

/obj/effect/spawner/random/medical/chem_jug
	loot = list(
		/obj/item/reagent_containers/glass/chem_jug/carbon,
		/obj/item/reagent_containers/glass/chem_jug/oxygen,
		/obj/item/reagent_containers/glass/chem_jug/nitrogen,
		/obj/item/reagent_containers/glass/chem_jug/hydrogen,
		/obj/item/reagent_containers/glass/chem_jug/radium,
		/obj/item/reagent_containers/glass/chem_jug/aluminium,
		/obj/item/reagent_containers/glass/chem_jug/chlorine,
		/obj/item/reagent_containers/glass/chem_jug/copper,
		/obj/item/reagent_containers/glass/chem_jug/bromine,
		/obj/item/reagent_containers/glass/chem_jug/iodine,
		/obj/item/reagent_containers/glass/chem_jug/potassium,
		/obj/item/reagent_containers/glass/chem_jug/sulfur
	)
