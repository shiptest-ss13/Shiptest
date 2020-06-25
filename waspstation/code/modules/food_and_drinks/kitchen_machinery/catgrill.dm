//I JUST WANNYA GWIWW FOW GAWD'S SAKE

/obj/machinery/grill/cat
	name = "catgrill"
	desc = "Is this what the youngins are into now?"
	icon = 'waspstation/icons/obj/kitchen.dmi'
	icon_state = "catgrill_open"
	anchored = FALSE

/obj/machinery/grill/cat/update_icon_state()
	if(grilled_item)
		icon_state = "catgrill"
	else if(grill_fuel)
		icon_state = "catgrill_on"
	else
		icon_state = "catgrill_open"

/obj/machinery/grill/cat/proc/owoify()
	var/static/regex/owo = new("r|l", "g")
	var/static/regex/oWo = new("R|L", "g")
	var/static/regex/Nya = new("N(a|e|i|o|u)", "g")
	// Forgive me marg for I have sinned
	grilled_item.name = owo.Replace(grilled_item.name, "w")
	grilled_item.name = oWo.Replace(grilled_item.name, "w")
	grilled_item.name = Nya.Replace(grilled_item.name, "Ny$1")

/obj/machinery/grill/cat/finish_grill()
	..()
	owoify()
