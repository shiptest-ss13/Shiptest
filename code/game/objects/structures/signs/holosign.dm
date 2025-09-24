#define POSTER_NORANDOM 0 //no random poster
#define POSTER_SUBTYPES 1 //chooses from subtypes of the poster_type var
#define POSTER_LIST 2 // chooses from a list
#define POSTER_ADD_FROM_LIST 3 //adds to the subtypes pool from list

/obj/machinery/holosign
	name = "holosign"
	desc = "A sign with weak holoemitters on the front, designed to display information in enviroments with many distractions."
	var/desc_add
	icon = 'icons/obj/machines/holoposter.dmi'
	icon_state = "holosign"
	var/overlay_state
	anchored = TRUE

	integrity_failure = 100

	idle_power_usage = IDLE_DRAW_MINIMAL

	light_power = 5

	/// Do we cycle between posters?
	var/cycle_posters = TRUE
	/// How long between cycles?
	var/cycle_time = 45 SECONDS
	/// The cycling cooldown
	COOLDOWN_DECLARE(cycle_cooldown)

	/// how do we want to handle the random poster pool? POSTER_SUBTYPES chooses randomly from subtypes, AKA how it was handled before
	var/random_type = POSTER_NORANDOM
	///if above is POSTER_SUBTYPES then what which subtypes we want to pull from?
	var/random_basetype
	///if random_type is either POSTER_LIST or POSTER_ADD_FROM_LIST then what is the pool of posters we want to pull from/ add from?
	var/list/random_pool
	/// Do we want to never appear in the random poster pool? Used in the random subtype to prevent infinite loops of random posters, and the NO ERP poster to make it effectively admin only.
	var/never_random = FALSE

/obj/machinery/holosign/Initialize()
	. = ..()
	if(random_type)
		randomise()
	if(!overlay_state)
		overlay_state = icon_state

	AddElement(/datum/element/beauty, 300)

/obj/machinery/holosign/proc/randomise()
	var/obj/machinery/holosign/selected
	//flick("switchadvert", src)


	if(random_type == POSTER_LIST)// i feel like im making the problem worse instead of fixing it
		if(!random_pool)
			CRASH("A poster is set to select from a list, but has none!")
		selected = pick(random_pool)
	if(random_type == POSTER_SUBTYPES || random_type == POSTER_ADD_FROM_LIST)
		var/list/poster_types = subtypesof(random_basetype)
		var/list/approved_types = list()
		if(random_type == POSTER_ADD_FROM_LIST)
			if(!random_pool)
				CRASH("A poster is set to select from a list, but has none!")
			LAZYADD(poster_types, random_pool)
		for(var/obj/machinery/holosign/current_poster as anything in poster_types)
			if(overlay_state == current_poster::icon_state)
				continue
			if((current_poster::icon_state) && !(current_poster::never_random))
				approved_types |= current_poster
		selected = pick(approved_types)

	name = selected::name
	desc_add = selected::desc_add
	overlay_state = selected::icon_state
	light_color = selected::light_color
	update_light()
	update_appearance()
	flick_overlay("switchadvert", src, 1 SECONDS)

/obj/machinery/holosign/update_overlays()
	. = ..()
	if(machine_stat & NOPOWER)
		return
	if(machine_stat & BROKEN)
		. += "glitch"
		SSvis_overlays.add_vis_overlay(src, icon, "glitch", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "glitch", layer, EMISSIVE_PLANE, dir)
		return
	SSvis_overlays.add_vis_overlay(src, icon, overlay_state, layer, plane, dir)
	SSvis_overlays.add_vis_overlay(src, icon, overlay_state, layer, EMISSIVE_PLANE, dir)

/obj/machinery/holosign/power_change()
	. = ..()
	if(machine_stat & (NOPOWER) || machine_stat & (BROKEN))
		set_light(0)
	else
		set_light(1)

/obj/machinery/holosign/process(seconds_per_tick)
	if(machine_stat & (NOPOWER) || machine_stat & (BROKEN))
		return FALSE
	if(!cycle_posters)
		return FALSE
	if(!COOLDOWN_FINISHED(src, cycle_cooldown))
		return FALSE
	randomise()
	//rand() is used in case a bunch of holoposters are placed down, so they slowly desync
	COOLDOWN_START(src, cycle_cooldown, cycle_time + round(rand(-2 SECONDS, 2 SECONDS), 1 SECONDS))
	return TRUE

/obj/machinery/holosign/examine(mob/user)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(!desc_add)
		return
	. += span_notice("\nIt reads: \"[desc_add]\"")


/obj/machinery/holosign/nanotrasen
	name = "holosign - Buy Nanotrasen"
	desc_add = "Nanotrasen. Selling ships, medical supplies, and technology since 342 FSC. Shop now."
	icon_state = "nanotrasen"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/holosign/tadpole
	name = "holosign - Visit Tadpole City"
	desc_add = "Tadpole city: Get rich, Find love, or buy restricted weaponry, it doesn't matter, find your inner tadpole at the April sector at X:4, Y:30, Z:22."
	icon_state = "tadpole"
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/holosign/gec
	name = "holosign - GEC"
	desc_add = "GEC: United the workers build back the ruins. We can also repair your vessels, stations, and other facilities. We would be glad to help."
	icon_state = "gec"
	light_color = LIGHT_COLOR_INTENSE_RED

/obj/machinery/holosign/irmg
	name = "holosign - Inteq Risk Management Group"
	desc_add = span_italics("Inteq Risk Management Group") + ". I hear you got a problem. You won't have one with us. No bullshit, guranteed."
	icon_state = "inteq"
	light_color = LIGHT_COLOR_FIRE

/obj/machinery/holosign/hunterspride
	name = "holosign - Hunter's Pride"
	desc_add = "Hunter's Pride - Simple, deadly, cheap. No need to brag; you've seen us in action before."
	icon_state = "hunterspride"
	light_color = LIGHT_COLOR_FLARE

/obj/machinery/holosign/miskilamo
	name = "holosign - MISKILAMO SPACEFARING"
	desc_add = "MISKILAMO SPACEFARING: EVER WANTED A SHIP BUT ITS TOO MUCH $, $ ,$?! NO MORE! NOW YOU CAN BUY SHIPS FOR LITTE $ SALE! SALE! SALE FOREVER WITH MISKILAMO SPACEFARING!"
	icon_state = "miskilamo"
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/holosign/kfp
	name = "holosign - KFP"
	desc_add = "KFP"
	icon_state = "kfp"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/holosign/hardline
	name = "holosign - HARDLINE"
	desc_add = "HARDLINE - TOUGHEST SHIPS FOR THE TOUGHEST SITUATIONS"
	icon_state = "hardline"
	light_color = LIGHT_COLOR_HOLY_MAGIC

/obj/machinery/holosign/science
	name = "holosign - Science"
	desc_add = "Scientific Outreach requested"
	icon_state = "moebius"
	light_color = LIGHT_COLOR_LAVENDER

/obj/machinery/holosign/visitor
	name = "holosign - Attention Spacer Visitors"
	desc_add = "Attention Spacer Visitors!\nWe welcome you to Tadpole City! Before embarking onto downtown, a few things to remember:\n\
	You MUST bring a gas mask, cloak or covering suit, and a hat or head covering. The toxic rain will cause serious harm if none are on your person.\n\
	On your person, you are ALLOWED to conceal carry small arms, but are strictly forbidden from carrying long arms. Only Tadpoles are allowed to carry longarms on person.\n\
	Thank you, we hope you will love your visit as much as we love you!"
	icon_state = "visitors"
	light_color = COLOR_ASSEMBLY_WHITE
	never_random = TRUE
	cycle_posters = FALSE

/obj/machinery/holosign/random
	name = "randomized holosign"
	never_random = TRUE
	random_basetype = /obj/machinery/holosign
	random_type = POSTER_SUBTYPES

#undef POSTER_SUBTYPES
#undef POSTER_LIST
#undef POSTER_ADD_FROM_LIST
