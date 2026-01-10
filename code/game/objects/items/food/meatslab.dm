/obj/item/food/meat
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/meat.dmi'
	var/subjectname = "" //old, remove
	var/subjectjob = null

/obj/item/food/meat/slab
	name = "meat"
	desc = "A slab of raw meat."
	icon_state = "meat"
	microwaved_type = /obj/item/food/meat/steak/plain
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/cooking_oil = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	///Legacy code, handles the coloring of the overlay of the cutlets made from this.
	var/slab_color = "#FF0000"

/obj/item/food/meat/slab/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/sosjerky/healthy)

/obj/item/food/meat/slab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/plain, 4, 30)

////////////////////////////////////// OTHER MEATS ////////////////////////////////////////////////////////

/obj/item/food/meat/slab/synthmeat
	name = "synthmeat"
	desc = "A synthetic slab of... ethical* meat?"
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/synthmeat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/synth, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/meatproduct
	name = "meat product"
	//icon_state = "meatproduct"
	desc = "A slab of station reclaimed and chemically processed meat product."
	tastes = list("meat flavoring" = 2, "modified starches" = 2, "natural & artificial dyes" = 1, "butyric acid" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/monkey
	name = "monkey meat"
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/mouse
	name = "mouse meat"
	desc = "A slab of mouse meat. Best not eat it raw."
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/pug
	name = "pug meat"
	desc = "Tastes like... well you know..."
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/hamster
	name = "hamster meat"
	desc = "Hey, they eat eachother, so its justified... right..?"
	tastes = list("meat" = 4, "fluffly adorableness" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/killertomato
	name = "killer tomato meat"
	desc = "A slice from a huge tomato."
	icon_state = "tomatomeat"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("tomato" = 1)
	foodtypes = FRUIT // Yeah, tomatoes are FRUIT. Bite me.

/obj/item/food/meat/slab/killertomato/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/killertomato, rand(70 SECONDS, 85 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/killertomato/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/killertomato, 3, 30)

/obj/item/food/meat/slab/bear
	name = "bear meat"
	desc = "A very manly slab of meat."
	icon_state = "bearmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/medicine/morphine = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/cooking_oil = 6
	)
	tastes = list("meat" = 1, "salmon" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/bear/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/bear, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/bear/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/bear, 3, 30)

/obj/item/food/meat/slab/xeno
	name = "xeno meat"
	desc = "A slab of raw meat."
	icon_state = "xenomeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	bite_consumption = 4
	tastes = list("meat" = 1, "acid" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/xeno, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/xeno/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/xeno, 3, 30)

/obj/item/food/meat/slab/spider
	name = "spider meat"
	desc = "A slab of spider meat. That is so Kafkaesque."
	icon_state = "spidermeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("cobwebs" = 1)
	foodtypes = RAW | MEAT | TOXIC

/obj/item/food/meat/slab/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/spider, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/spider/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/spider, 3, 30)

/obj/item/food/meat/slab/goliath
	name = "goliath meat"
	desc = "A slab of goliath meat. It's not very edible now, but it cooks great in lava."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 5,
		/datum/reagent/consumable/cooking_oil = 3
	)
	icon_state = "goliathmeat"
	tastes = list("meat" = 1)
	foodtypes = RAW | MEAT | TOXIC

/obj/item/food/meat/slab/goliath/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/goliath, rand(40 SECONDS, 60 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/goliath/burn()
	visible_message(span_notice("[src] finishes cooking!"))
	new /obj/item/food/meat/steak/goliath(loc)
	qdel(src)

/obj/item/food/meat/slab/meatwheat
	name = "meatwheat clump"
	desc = "This doesn't look like meat, but your standards aren't <i>that</i> high to begin with."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/cooking_oil = 1
	)
	icon_state = "meatwheat_clump"
	bite_consumption = 4
	tastes = list("meat" = 1, "wheat" = 1)
	foodtypes = GRAIN

/obj/item/food/meat/slab/gorilla
	name = "gorilla meat"
	desc = "Much meatier than monkey meat."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/cooking_oil = 5 //Plenty of fat!
	)

/obj/item/food/meat/slab/miras
	name = "miras"
	icon_state = "miras"
	desc = "A cut of meat from the Miras Lizard. When alone, it tends to be a sickly-sweet experience, requiring proper preparation to truly shine."
	tastes = list("sweet meat" = 4, "sickening sweetness" = 1, "gamey meat" = 2)
	foodtypes = MEAT | SUGAR | RAW

/obj/item/food/meat/slab/miras/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/miras, 2, 30)

/obj/item/food/meat/slab/miras/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/miras, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/tiris
	name = "tiris meat"
	icon_state = "tiris"
	desc = "A rough meat with rich deposits of fat. It is typically processed, spiced, and preserved."
	tastes = list("fatty meat" = 2, "raw fat" = 4)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/cooking_oil = 4
	)
	foodtypes = MEAT | RAW

/obj/item/food/meat/slab/tiris/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/tiris, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/tiris/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/tiris, 3, 30)

/obj/item/food/meat/slab/remes
	name = "remes meat"
	icon_state = "remes"
	desc = "The meat of a properly prepared Remes tends to melt away as it's consumed, leaving behind the flavors that it has soaked in."
	microwaved_type = null
	tastes = list("mellow flesh" = 6, "earthiness" = 2)
	foodtypes = MEAT

/obj/item/food/meat/slab/remes/make_grillable()
	return

/obj/item/food/meat/slab/dofitis
	name = "dofitis meat"
	icon_state = "dofi"
	desc = "A rich cut of meat with a sublime marble."
	tastes = list("hearty meat" = 4, "buttery fat" = 2)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	foodtypes = MEAT | RAW

/obj/item/food/meat/slab/dofitis/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/dofitis, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/* bacon */

/obj/item/food/meat/rawbacon
	name = "raw piece of bacon"
	desc = "A raw piece of bacon."
	icon_state = "bacon"
	microwaved_type = /obj/item/food/meat/bacon
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/cooking_oil = 3
	)
	tastes = list("bacon" = 1)
	foodtypes = RAW | MEAT | BREAKFAST

/obj/item/food/meat/rawbacon/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/bacon, rand(25 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/meat/bacon
	name = "piece of bacon"
	desc = "A delicious piece of bacon."
	icon_state = "baconcooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/cooking_oil = 2
	)
	tastes = list("bacon" = 1)
	foodtypes = MEAT | BREAKFAST

/obj/item/food/meat/slab/penguin
	name = "penguin meat"
	//icon_state = "birdmeat"
	desc = "A slab of penguin meat."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/cooking_oil = 3
	)
	tastes = list("beef" = 1, "cod fish" = 1)

/obj/item/food/meat/slab/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/penguin, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/penguin/make_processable()
	. = ..()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/penguin, 3, 30)

/obj/item/food/meat/rawcrab
	name = "raw crab meat"
	desc = "A pile of raw crab meat."
	icon_state = "crabmeatraw"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/cooking_oil = 3,
	)
	tastes = list("raw crab" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/rawcrab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/crab, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/crab
	name = "crab meat"
	desc = "Some deliciously cooked crab meat."
	icon_state = "crabmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/cooking_oil = 2,
	)
	tastes = list("crab" = 1)
	foodtypes = MEAT

/obj/item/food/meat/slab/chicken
	name = "chicken meat"
	icon_state = "birdmeat"
	desc = "A slab of raw chicken. Remember to wash your hands!"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("chicken" = 1)

/obj/item/food/meat/slab/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/chicken/make_processable()
	. = ..()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/chicken, 3, 30)

/obj/item/food/meat/slab/mothroach
	name = "mothroach meat"
	desc = "a light slab of mothroach meat"
	tastes = list("gross" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/dolphinmeat
	name = "uncooked dolphin fillet"
	desc = "A fillet of spess dolphin meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	bite_consumption = 6
	tastes = list("fish" = 1,"cruelty" = 2)
	foodtypes = MEAT | RAW

//Steaks

/obj/item/food/meat/steak
	name = "steak"
	desc = "A piece of hot spicy meat."
	icon_state = "meatsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = MEAT
	tastes = list("meat" = 1)

/obj/item/food/meat/steak/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED, PROC_REF(on_microwave_cooked))

/obj/item/food/meat/steak/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	SIGNAL_HANDLER

	name = "[source_item.name] steak"

/obj/item/food/meat/steak/plain
	foodtypes = MEAT

/obj/item/food/meat/steak/killertomato
	name = "killer tomato steak"
	tastes = list("tomato" = 1)
	foodtypes = FRUIT // And dont let anybody tell you otherwise!

/obj/item/food/meat/steak/bear
	name = "bear steak"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/meat/steak/xeno
	name = "xeno steak"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/meat/steak/spider
	name = "spider steak"
	tastes = list("cobwebs" = 1)

/obj/item/food/meat/steak/goliath
	name = "goliath steak"
	desc = "A delicious, goliath steak."
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon_state = "goliathsteak"
	trash_type = null
	tastes = list("meat" = 1, "rock" = 1)
	foodtypes = MEAT

/obj/item/food/meat/steak/penguin
	name = "penguin steak"
	//icon_state = "birdsteak"
	tastes = list("beef" = 1, "cod fish" = 1)

/obj/item/food/meat/steak/chicken
	name = "chicken breast" //Can you have chicken steaks? Maybe this should be renamed once it gets new sprites. //I concur //this is like seeing cave paintings
	icon_state = "birdsteak"
	tastes = list("chicken" = 1)

/obj/item/food/meat/steak/meatproduct
	name = "thermally processed meat product"
	//icon_state = "meatproductsteak"
	tastes = list("enhanced char" = 2, "suspicious tenderness" = 2, "natural & artificial dyes" = 2, "emulsifying agents" = 1)

/obj/item/food/meat/steak/synth
	name = "synthsteak"
	desc = "A synthetic meat steak. It doesn't look quite right, now does it?"
	icon_state = "meatsteak"
	tastes = list("meat" = 4, "cryoxandone" = 1)

/obj/item/food/meat/steak/ashflake
	name = "ashflaked steak"
	desc = "A common delicacy among miners."
	icon_state = "ashsteak"
	food_reagents = list(
		/datum/reagent/consumable/vitfro = 2
	)
	tastes = list("tough meat" = 2, "bubblegum" = 1)
	foodtypes = MEAT

/obj/item/food/meat/steak/dolphinmeat
	name = "dolphin fillet"
	desc = "A fillet of spess dolphin meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	bite_consumption = 6
	tastes = list("fish" = 1,"cruelty" = 2)
	foodtypes = MEAT

/obj/item/food/meat/steak/miras
	name = "miras steak"
	desc = "A cooked slice of Miras. A sweet meat with gamey overtones."
	icon_state = "miras-steak"
	tastes = list("gamey lizard" = 2, "sweet meat" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 2
	)
	foodtypes = MEAT | SUGAR

/obj/item/food/meat/steak/tiris
	name = "tiris steak"
	desc = "A cooked slice of tiris meat. Rough and fatty."
	icon_state = "tiris-celima"
	tastes = list("fatty meat")
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 2
	)
	foodtypes = MEAT

/obj/item/food/meat/steak/dofitis
	name = "dofitis steak"
	desc = "A cooked slab of dofitis meat. A rich, hearty experience."
	icon_state = "dofi-steak"
	tastes = list("hearty meat" = 1, "buttery fat" = 1)
	foodtypes = MEAT
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)

//Raw cutlets

/obj/item/food/meat/rawcutlet
	name = "raw cutlet"
	desc = "A raw meat cutlet."
	icon_state = "rawcutlet"
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	var/meat_type = "meat"

/obj/item/food/meat/rawcutlet/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/OnCreatedFromProcessing(mob/living/user, obj/item/work_tool, list/chosen_option, atom/original_atom)
	. = ..()
	if(istype(original_atom, /obj/item/food/meat/slab))
		var/obj/item/food/meat/slab/original_slab = original_atom
		var/mutable_appearance/filling = mutable_appearance(icon, "rawcutlet_coloration")
		filling.color = original_slab.slab_color
		add_overlay(filling)
		name = "raw [original_atom.name] cutlet"
		meat_type = original_atom.name

/obj/item/food/meat/rawcutlet/plain
	foodtypes = MEAT

/obj/item/food/meat/rawcutlet/killertomato
	name = "raw killer tomato cutlet"
	tastes = list("tomato" = 1)
	foodtypes = FRUIT
	microwaved_type = /obj/item/food/meat/cutlet/killertomato

/obj/item/food/meat/rawcutlet/bear
	name = "raw bear cutlet"
	tastes = list("meat" = 1, "salmon" = 1)
	microwaved_type = /obj/item/food/meat/cutlet/bear

/obj/item/food/meat/rawcutlet/xeno
	name = "raw xeno cutlet"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/meat/rawcutlet/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/xeno, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/spider
	name = "raw spider cutlet"
	tastes = list("cobwebs" = 1)

/obj/item/food/meat/rawcutlet/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/spider, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/penguin
	name = "raw penguin cutlet"
	tastes = list("beef" = 1, "cod fish" = 1)

/obj/item/food/meat/rawcutlet/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/penguin, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/chicken
	name = "raw chicken cutlet"
	tastes = list("chicken" = 1)

/obj/item/food/meat/rawcutlet/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/chicken, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/grub
	name = "redgrub cutlet"
	desc = "A tough, slimy cut of raw Redgrub. Very toxic, and probably infectious, but delicious when cooked. Do not handle without proper biohazard equipment."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "grubmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/toxin/slimejelly = 2
	)
	bite_consumption = 1
	tastes = list("slime" = 1, "grub" = 1)
	foodtypes = RAW | MEAT | TOXIC

/obj/item/food/meat/rawcutlet/grub/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/grub, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/miras
	name = "raw miras cutlet"
	microwaved_type = /obj/item/food/meat/cutlet/miras
	tastes = list("gamey lizard" = 4, "sweet meat" = 1)
	foodtypes = MEAT | SUGAR | RAW

/obj/item/food/meat/rawcutlet/tiris
	name = "raw tiris cutlet"
	microwaved_type = /obj/item/food/meat/cutlet/tiris
	tastes = list("fatty meat" = 2, "raw fat" = 1)
	foodtypes = MEAT | RAW

//Cooked cutlets

/obj/item/food/meat/cutlet
	name = "cutlet"
	desc = "A cooked meat cutlet."
	icon_state = "cutlet"
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT

/obj/item/food/meat/cutlet/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED, PROC_REF(on_microwave_cooked))

///This proc handles setting up the correct meat name for the cutlet, this should definitely be changed with the food rework.
/obj/item/food/meat/cutlet/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	SIGNAL_HANDLER

	if(!istype(source_item, /obj/item/food/meat/rawcutlet))
		return

	var/obj/item/food/meat/rawcutlet/original_cutlet = source_item
	name = "[original_cutlet.meat_type] cutlet"

/obj/item/food/meat/cutlet/plain

/obj/item/food/meat/cutlet/killertomato
	name = "killer tomato cutlet"
	tastes = list("tomato" = 1)
	foodtypes = FRUIT

/obj/item/food/meat/cutlet/bear
	name = "bear cutlet"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/meat/cutlet/xeno
	name = "xeno cutlet"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/meat/cutlet/spider
	name = "spider cutlet"
	tastes = list("cobwebs" = 1)

/obj/item/food/meat/cutlet/penguin
	name = "penguin cutlet"
	tastes = list("beef" = 1, "cod fish" = 1)

/obj/item/food/meat/cutlet/chicken
	name = "chicken cutlet"
	tastes = list("chicken" = 1)

/obj/item/food/meat/cutlet/grub
	name = "redgrub rind"
	desc = "Cooking redgrub meat causes it to 'pop', and renders it non-toxic, crunchy and deliciously sweet"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "grubsteak"
	trash_type = null
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/medicine/panacea/effluvial = 1,
	)
	tastes = list("jelly" = 1, "sweet meat" = 1, "oil" = 1)
	foodtypes = MEAT

/obj/item/food/meat/cutlet/miras
	name = "miras cutlet"
	tastes = list("gamey lizard" = 4, "sweet meat" = 1)
	foodtypes = MEAT | SUGAR
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/sugar = 1
	)

/obj/item/food/meat/cutlet/tiris
	name = "tiris cutlet"
	tastes = list("fatty meat")
	foodtypes = MEAT
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/cooking_oil = 1
	)
