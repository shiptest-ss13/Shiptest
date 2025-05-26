

/obj/item/reagent_containers/food/snacks/chewable
	slot_flags = ITEM_SLOT_MASK
	///How long it lasts before being deleted in seconds
	var/succ_dur = 360
	///The delay between each time it will handle reagents
	var/succ_int = 100
	///Stores the time set for the next handle_reagents
	var/next_succ = 0

	//makes snacks actually wearable as masks and still edible the old fashioned way.
/obj/item/reagent_containers/food/snacks/chewable/proc/handle_reagents()
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(!reagents.trans_to(C, REAGENTS_METABOLISM, method = INGEST))
					reagents.remove_any(REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)

/obj/item/reagent_containers/food/snacks/chewable/process(seconds_per_tick)
	if(iscarbon(loc))
		if(succ_dur <= 0)
			qdel(src)
			return
		succ_dur -= seconds_per_tick
		if((reagents && reagents.total_volume) && (next_succ <= world.time))
			handle_reagents()
			next_succ = world.time + succ_int

/obj/item/reagent_containers/food/snacks/chewable/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_MASK)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/chewable/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/reagent_containers/food/snacks/chewable/bubblegum
	name = "bubblegum"
	desc = "A rubbery strip of gum. Not exactly filling, but it keeps you busy."
	icon_state = "bubblegum"
	supports_variations = VOX_VARIATION
	item_state = "bubblegum"
	color = "#E48AB5" // craftable custom gums someday?
	list_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/nicotine
	name = "nicotine gum"
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/consumable/menthol = 5)
	tastes = list("mint" = 1)
	color = "#60A584"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/happiness
	name = "HP+ gum"
	desc = "A rubbery strip of gum, originating from a fad of using gum as a vessel for recreational drugs. This one tastes particularly acrid..."
	list_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("intense chemical sweetness" = 1)
	color = "#EE35FF"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum
	name = "bubblegum gum"
	desc = "A rubbery strip of gum, which reeks of iron and sulfur."
	color = "#913D3D"
	list_reagents = list(/datum/reagent/blood = 15)
	tastes = list("coppery, sulfuric sugar" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/process(seconds_per_tick)
	. = ..()
	if(iscarbon(loc))
		hallucinate(loc)


/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/On_Consume(mob/living/eater)
	. = ..()
	if(iscarbon(eater))
		hallucinate(eater)

///This proc has a 5% chance to have a bubblegum line appear, with an 85% chance for just text and 15% for a bubblegum hallucination and scarier text.
/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/proc/hallucinate(mob/living/carbon/victim)
	if(!prob(5)) //cursed by bubblegum
		return
	if(prob(15))
		new /datum/hallucination/oh_yeah(victim)
		to_chat(victim, span_colossus("<b>[pick("I AM IMMORTAL.","I SHALL TAKE YOUR WORLD.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","NOTHING CAN HOLD ME.")]</b>"))
	else
		to_chat(victim, span_warning("[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]"))
