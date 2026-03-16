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
	var/cycle_time = 47 SECONDS
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

	var/previous_icon_state

/obj/machinery/holosign/Initialize()
	. = ..()
	if(random_type)
		randomise()
	if(!overlay_state)
		overlay_state = icon_state
	icon_state = "holosign"

	AddElement(/datum/element/beauty, 300)

/obj/machinery/holosign/proc/do_switch_advert()
	change_to_poster(/obj/machinery/holosign/switchadvert)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/holosign, randomise)), 2 SECONDS)

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
			if(previous_icon_state && overlay_state == previous_icon_state)
				continue
			if((current_poster::icon_state) && !(current_poster::never_random))
				approved_types |= current_poster
		selected = pick(approved_types)
	change_to_poster(selected)

/obj/machinery/holosign/proc/change_to_poster(obj/machinery/holosign/selected)
	previous_icon_state = icon_state

	name = selected::name
	desc_add = selected::desc_add
	overlay_state = selected::icon_state
	light_color = selected::light_color
	update_light()
	update_appearance()

/obj/machinery/holosign/update_overlays()
	. = ..()
	if(overlay_state == /obj/machinery/holosign/switchadvert::icon_state)
		return
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
	if(!COOLDOWN_FINISHED(src, cycle_cooldown) || random_type == POSTER_NORANDOM)
		return FALSE
	do_switch_advert()
	//rand() is used in case a bunch of holoposters are placed down, so they slowly desync
	COOLDOWN_START(src, cycle_cooldown, cycle_time + round(rand(-3 SECONDS, 3 SECONDS), 1 SECONDS))
	return TRUE

/obj/machinery/holosign/examine(mob/user)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(!desc_add)
		return
	. += span_notice("\nIt reads: \"[desc_add]\"")


/obj/machinery/holosign/makossowarra
	name = "holosign - Buy Makosso"
	desc_add = "Makosso-Warra. Selling ships, medical supplies, and technology since 342 FSC. Shop now."
	icon_state = "mw"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/holosign/lanchester
	name = "holosign - Visit Lanchester City"
	desc_add = "Lanchester city: Party all night, cause the night almost never ends, find your fun at Lanchester City."
	icon_state = "lanchester"
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/holosign/gec
	name = "holosign - GEC"
	desc_add = "GEC: United the workers build back the ruins. We can repair your vessels, stations, and other equipment. We would be glad to help."
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
	desc_add = "The most affordable and reliable spacecraft, without compromising on safety or quality."
	icon_state = "kfp"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/holosign/hardline
	name = "holosign - HARDLINE"
	desc_add = "HARDLINE - TOUGHEST SHIPS FOR THE TOUGHEST SITUATIONS"
	icon_state = "hardline"
	light_color = LIGHT_COLOR_HOLY_MAGIC

/obj/machinery/holosign/clover
	name = "holosign - Clover Corporation"
	desc_add = "Clover Corporation - Lucky products for lucky people. Postrionics? Computers? Washing machines? Moible phones? Lucky you, we got them too!"
	icon_state = "clover"
	light_color = LIGHT_COLOR_ELECTRIC_CYAN

/obj/machinery/holosign/isf
	name = "holosign - ISF Spacecraft"
	desc_add = "ISF Spacecraft - Made to perfection. If you need to ask, it's solved."
	icon_state = "isf"
	light_color = LIGHT_COLOR_LAVENDER

/obj/machinery/holosign/ihejirika
	name = "holosign - Ihejirika Civilian Manufacturing"
	desc_add = "Enviromentally friendly and recycled ships for everyone. What ship can we get you today?"
	icon_state = "ihejirika"
	light_color = LIGHT_COLOR_DARK_BLUE

/obj/machinery/holosign/cybersun
	name = "holosign - Cybersun Industries"
	desc_add = "Cybersun Industries - Ships, Robotics, Personal Defense, and Pharmaceuticals at extreme premium quality? Try not to get dazzled, that's just the Cybersun way."
	icon_state = "cybersun"
	light_color = LIGHT_COLOR_FLARE

/obj/machinery/holosign/scarborough
	name = "holosign - Scarborough Arms"
	desc_add = "Scarborough Arms - Premium firearms and Postrionics, for the tactical and effective civilian."
	icon_state = "scarborough"
	light_color = LIGHT_COLOR_FLARE

/obj/machinery/holosign/atua
	name = "holosign - Atua Synkinetics Parça"
	desc_add = "Atua Synkinetics Parça - Introducing the latest spec update to the Parça. Same friendy and iconic design, modern parts for a new generation. Buy now!"
	icon_state = "atua"
	light_color = LIGHT_COLOR_ELECTRIC_CYAN

/obj/machinery/holosign/lanchestermechanics
	name = "holosign - Lanchester Mechanics"
	desc_add = "Lanchester Mechanics - A hard chassis for hard work; Lanchester Mechanics' line of postrionics have you covered."
	icon_state = "lanchestermechanics"
	light_color = LIGHT_COLOR_HOLY_MAGIC

/obj/machinery/holosign/ns_logistics
	name = "holosign - N+S Logistics"
	desc_add = "N+S Logistics - Need something delivered fast? Our frontierwide network of warehouses and bodies gurantee that your parcels will anywhere quickly and safely."
	icon_state = "ns_logistics"
	light_color = LIGHT_COLOR_FLARE

/obj/machinery/holosign/vigilitas
	name = "holosign - Vigilitas Interstellar"
	desc_add = "Vigilitas Interstellar - The number one private security for buisnesses. Others may be newer and cheaper, yet we have the experience to make your money worth."
	icon_state = "vi"
	light_color = LIGHT_COLOR_FLARE

/obj/machinery/holosign/exocom
	name = "holosign - EXOCOM"
	desc_add = "EXOCOM - Helping the people to break the earth with more advanced and inexpensive technology. Try our new heavy mining suit, guranteed to satisfy any miner!"
	icon_state = "exocom"
	light_color = LIGHT_COLOR_LAVENDER

/obj/machinery/holosign/trifuge
	name = "holosign - Installation Trifuge"
	desc_add = "Installation Trifuge - If stuck in the middle of nowhere, why not stop by Trifuge? Well worn but respected, with Caldwell at the helm, you'll be safe here."
	icon_state = "trifuge"
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/holosign/vitcom
	name = "holosign - VitCom Consumer Electronics"
	desc_add = "VitCom - Keeping the galaxy connected, our new flip-phone and PDA help you stay in touch with the galaxy!"
	icon_state = "ihejirika"
	light_color = LIGHT_COLOR_DARK_BLUE

/obj/machinery/holosign/random
	name = "randomized holosign"
	icon_state = "random"
	never_random = TRUE
	random_basetype = /obj/machinery/holosign
	random_type = POSTER_SUBTYPES

/obj/machinery/holosign/switchadvert
	name = "blank holosign"
	desc_add = "It's blank. It seems like it's changing adverts at the moment."
	icon_state = "switchadvert"
	light_color = "#000000"
	never_random = TRUE

#undef POSTER_SUBTYPES
#undef POSTER_LIST
#undef POSTER_ADD_FROM_LIST
