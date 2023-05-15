/datum/fish_source/ocean
	fish_table = list(
		FISHING_DUD = 15,
		/obj/item/spacecash/bundle/c1 = 10,
		/obj/item/spacecash/bundle/c5 = 5,
		/obj/item/clothing/shoes/workboots = 5,
		/obj/item/fish/clownfish = 15,
		/obj/item/fish/pufferfish = 15,
		/obj/item/fish/cardinal = 15,
		/obj/item/fish/greenchromis = 15,
		/obj/item/fish/needlefish = 15,
		/obj/item/fish/armorfish = 15,
		/obj/item/fish/trout = 10,
		/obj/item/fish/salmon = 10,
		/obj/item/fish/dwarf_moonfish = 10,
		/obj/item/fish/gunner_jellyfish = 10,
		/obj/item/fish/lanternfish = 5,
		/obj/item/fish/firefish = 5,
		/obj/item/fish/emulsijack = 1
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 5

/datum/fish_source/ocean/beach
	catalog_description = "Beach shore water"

/datum/fish_source/jungle
	fish_table = list(
		FISHING_DUD = 15,
		/obj/item/spacecash/bundle/c1 = 10,
		/obj/item/spacecash/bundle/c5 = 5,
		/obj/item/fish/perch = 20,
		/obj/item/fish/goldfish = 15,
		/obj/item/fish/angelfish = 15,
		/obj/item/fish/guppy = 15,
		/obj/item/fish/plasmatetra = 15,
		/obj/item/fish/trout = 10,
		/obj/item/fish/catfish = 10,
		/obj/item/fish/bass = 10,
		/obj/item/fish/donkfish = 5,
		/obj/item/fish/emulsijack = 1
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 5

/datum/fish_source/jungle
	catalog_description = "Jungle lake water"

/datum/fish_source/portal
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/fish/goldfish = 10,
		/obj/item/fish/guppy = 10,
	)
	catalog_description = "Fish dimension (Fishing portal generator)"

/datum/fish_source/lavaland
	catalog_description = "Lava vents"
	background = "fishing_background_lavaland"
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/stack/ore/slag = 20,
		/obj/structure/closet/crate/necropolis/tendril = 1,
		/obj/effect/mob_spawn/human/corpse/charredskeleton = 1
	)
	fish_counts = list(
		/obj/structure/closet/crate/necropolis/tendril = 1
	)

	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 10

/datum/fish_source/lavaland/can_fish(obj/item/fishing_rod/rod, mob/fisherman)
	. = ..()
	if(!rod.line || !(rod.line.fishing_line_traits & FISHING_LINE_REINFORCED))
		return "You'll need reinforced fishing line to fish in there"


/datum/fish_source/moisture_trap
	catalog_description = "moisture trap basins"
	fish_table = list(
		FISHING_DUD = 20,
		/obj/item/fish/ratfish = 10
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 10
