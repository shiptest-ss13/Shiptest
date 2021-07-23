/obj/effect/mob_spawn/human/slime_rancher
	name = "slime receptical"
	desc = "A fairly rare machine that seems to be used for storing and molding jelly. You can see the vague shape of a humanoid in it."
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/jelly
	short_desc = "You are a humble slime rancher, taking care of your slimes and keeping them safe from the cold."
	flavour_text = "You bought this farm when it was a simple Syndicate bioweapons testing area, \
	and renovated it with your partner to become a real ranch. \
	Take care of the slimes, and make sure to keep them safe from the dangerous ice outside. "
	important_info = "Don't let the cold seep in and destroy your perfect life."
	uniform = /obj/item/clothing/under/rank/rnd/scientist/xenobiologist/skirt
	shoes = /obj/item/clothing/shoes/sneakers/white
	id = /obj/item/card/id/away/slime
	assignedrole = "Slime Rancher"

/obj/effect/mob_spawn/human/slime_rancher/special(mob/living/new_spawn)
	var/slime_name = pick("Maroon", "Funky", "Squishy", "Bubblegum", "Gummy", "Pinkie Pie", "Rainbow Dash", "Piss Brown", "Chartreuse", "Chocolate")
	new_spawn.fully_replace_character_name(null,slime_name)
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.update_body()

/obj/effect/mob_spawn/human/slime_rancher/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	return ..()
