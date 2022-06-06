//Fennec
/mob/living/simple_animal/pet/cat/fennec //fennecs are pretty cat like.
	name = "fennec"
	desc = "Some kind of fox that loves the heat. Also known as a dingle, or a goob."
	icon = 'icons/mob/pets.dmi'
	icon_state = "fennec"
	icon_living = "fennec"
	icon_dead = "fennec_dead"
	gender = MALE
	speak = list("Scree", "Screm!", "Squeak!", "Rrrrrf!")
	speak_emote = list("squeaky-purrs", "chitters")
	emote_hear = list("squeaks.", "screams.")
	emote_see = list("twitches its ears.", "zooms.", "stretches.")
	minbodytemp = 225
	maxbodytemp = 450
	animal_species = /mob/living/simple_animal/pet/cat/fennec
	childtype = list(/mob/living/simple_animal/pet/cat/fennec)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2)
	collar_type = "fennec"
	held_state = "fennec"
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/cat/fennec/faux
	name = "faux"
	desc = "Fox-thing who is apparently part of the crew."
	gold_core_spawnable = NO_SPAWN
