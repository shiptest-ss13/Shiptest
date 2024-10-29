/datum/round_event_control/spooky
	name = "2 SPOOKY! (Halloween)"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/spooky
	weight = -1							//forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES

/datum/round_event/spooky/start()
	..()
	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/H = i
		var/obj/item/storage/backpack/b = locate() in H.contents
		if(b)
			new /obj/item/storage/mexapix_candy(b)

/datum/round_event/spooky/announce(fake)
	priority_announce(pick("RATTLE ME BONES!","THE RIDE NEVER ENDS!", "A SKELETON POPS OUT!", "SPOOKY SCARY SKELETONS!", "CREWMEMBERS BEWARE, YOU'RE IN FOR A SCARE!") , "THE CALL IS COMING FROM INSIDE THE HOUSE")

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
			/obj/item/reagent_containers/food/snacks/sugarcookie/spookyskull,
			/obj/item/reagent_containers/food/snacks/sugarcookie/spookycoffin,
			/obj/item/reagent_containers/food/snacks/candy_corn,
			/obj/item/reagent_containers/food/snacks/candy,
			/obj/item/reagent_containers/food/snacks/candiedapple,
			/obj/item/reagent_containers/food/snacks/chocolatebar,
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
	name = "Mexapix supplies
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
