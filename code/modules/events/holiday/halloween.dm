//Lore Document for Mexapix: https://hackmd.io/D-9st3kxThm93WlUY7gKig

/datum/round_event_control/spooky
	name = "Mexapix"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/spooky
	weight = -1							//forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES

/datum/round_event/spooky/start()
	..()
	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/human = i
		var/obj/item/storage/backpack/backpack = locate() in human.contents
		if(backpack)
			new /obj/item/storage/mexapix_candy(backpack)

/datum/round_event/spooky/announce(fake)
	priority_announce("Happy Mexapix. Read up about it <a href=\"https://hackmd.io/D-9st3kxThm93WlUY7gKig\">Here!</a>")

//spooky foods (you can't actually make these when it's not halloween)
/obj/item/reagent_containers/food/snacks/sugarcookie/spookyskull
	name = "skull cookie"
	desc = "Spooky! It's got delicious calcium flavouring!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "skeletoncookie"

/obj/item/reagent_containers/food/snacks/sugarcookie/spookycoffin
	name = "coffin cookie"
	desc = "Spooky! It's got delicious coffee flavouring!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "coffincookie"

// Mexapix
/obj/item/storage/mexapix_candy
	name = "mexapix bag"
	desc = "A bag with a random assorment of treats to celebrate Mexapix!"
	icon_state = "paperbag_None_closed"

/obj/item/storage/mexapix_candy/Initialize()
	. = ..()
	new /obj/effect/spawner/random/food_or_drink/mexapix(src)

/obj/effect/spawner/random/food_or_drink/mexapix
	spawn_loot_count = 6
	loot = list(
			/obj/item/reagent_containers/food/snacks/sugarcookie/spookyskull = 1,
			/obj/item/reagent_containers/food/snacks/sugarcookie/spookycoffin = 1,
			/obj/item/reagent_containers/food/snacks/candy_corn = 1,
			/obj/item/reagent_containers/food/snacks/candy = 1,
			/obj/item/reagent_containers/food/snacks/candiedapple = 1,
			/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
			/obj/item/reagent_containers/food/drinks/bottle/koerbalk = 10,
			/obj/item/reagent_containers/food/snacks/brextak = 10,
			/obj/item/reagent_containers/food/snacks/sucrika = 10,
		)

/obj/item/clothing/accessory/tooth_armlet
	name = "tooth armlet"
	desc = "One of the customary worn items of Mexapix are strings of teeth, made from the wearer's shedded teeth (if they are a Sarathi) or, more recently, plastic (if they are an Elzuosa) and worn on the neck or wrist."
	icon_state = "bone_armlet"
	attachment_slot = ARMS
	above_suit = TRUE

/obj/item/clothing/accessory/tooth_armlet/plastic
	name = "plastic tooth armlet"

/datum/supply_pack/civilian/mexapix
	name = "Mexapix supplies"
	desc = "Everything needed for a mexapix celerbration"
	cost = 300
	contains = list(
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/clothing/accessory/tooth_armlet/plastic,
		/obj/item/storage/mexapix_candy,
		/obj/item/storage/mexapix_candy,
		/obj/item/storage/mexapix_candy,
	)

/obj/item/bodybag/arxas
	name = "arxas"
	desc = "used to collect leaf"

/obj/item/leaves
	name = "a pile of loose leaves"
	w_class = BULKY


//Drink
/datum/reagent/consumable/ethanol/koerbalk
	name = "koerbalk"
	boozepwr = 10

/obj/item/reagent_containers/food/drinks/bottle/koerbalk
	name = "bottle of koerbalk"
	list_reagents = list(/datum/reagent/consumable/ethanol/koerbalk)

/obj/item/mixing_stick

/obj/item/reagent_containers/food/snacks/brextak
	name = "brextak"

/obj/item/reagent_containers/food/snacks/sucrika
	name = "sucrika"
