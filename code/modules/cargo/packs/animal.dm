/datum/supply_pack/animal
	group = "Animals"
	crate_type = /obj/structure/closet/crate/critter

/*
		Vaguely useful animals
*/

/datum/supply_pack/animal/monkey
	name = "Monkey Cube Crate"
	desc = "Stop monkeying around! Contains seven monkey cubes. Just add water!"
	cost = 2000
	contains = list (/obj/item/storage/box/monkeycubes)
	crate_name = "monkey cube crate"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/animal/chick
	name = "Chicken Crate"
	desc = "The chicken goes bwaak!"
	cost = 2000
	contains = list(/mob/living/simple_animal/chick)
	crate_name = "chicken crate"

/datum/supply_pack/animal/goat
	name = "Goat Crate"
	desc = "The goat goes baa! Warranty void if used as a replacement for Pete."
	cost = 2500
	contains = list(/mob/living/simple_animal/hostile/retaliate/goat)
	crate_name = "goat crate"

/datum/supply_pack/animal/cow
	name = "Cow Crate"
	desc = "The cow goes moo!"
	cost = 3000
	contains = list(/mob/living/simple_animal/cow)
	crate_name = "cow crate"

/*
		Normal pets
*/

/datum/supply_pack/animal/cat
	name = "Cat Crate"
	desc = "The cat goes meow! Comes with a collar and a nice cat toy! Cheeseburger not included."//i can't believe im making this reference
	cost = 5000 //Cats are worth as much as corgis.
	contains = list(/mob/living/simple_animal/pet/cat,
					/obj/item/clothing/neck/petcollar,
					/obj/item/toy/cattoy)
	crate_name = "cat crate"

/datum/supply_pack/animal/cat/generate()
	. = ..()
	if(prob(50))
		var/mob/living/simple_animal/pet/cat/C = locate() in .
		qdel(C)
		new /mob/living/simple_animal/pet/cat/Proc(.)

/datum/supply_pack/animal/pug
	name = "Pug Crate"
	desc = "Like a normal dog, but... squished. Comes with a nice collar!"
	cost = 5000
	contains = list(/mob/living/simple_animal/pet/dog/pug,
					/obj/item/clothing/neck/petcollar)
	crate_name = "pug crate"

/datum/supply_pack/animal/corgi
	name = "Corgi Crate"
	desc = "Considered the optimal dog breed by thousands of research scientists, this Corgi is but one dog from the millions of Ian's noble bloodline. Comes with a cute collar!"
	cost = 5000
	contains = list(/mob/living/simple_animal/pet/dog/corgi,
					/obj/item/clothing/neck/petcollar)
	crate_name = "corgi crate"

/datum/supply_pack/animal/corgi/generate()
	. = ..()
	if(prob(50))
		var/mob/living/simple_animal/pet/dog/corgi/D = locate() in .
		if(D.gender == FEMALE)
			qdel(D)
			new /mob/living/simple_animal/pet/dog/corgi/Lisa(.)

/datum/supply_pack/animal/corgis/exotic
	name = "Exotic Corgi Crate"
	desc = "Corgis fit for a king, these corgis come in a unique color to signify their superiority. Comes with a cute collar!"
	cost = 5500
	contains = list(/mob/living/simple_animal/pet/dog/corgi/exoticcorgi,
					/obj/item/clothing/neck/petcollar)
	crate_name = "exotic corgi crate"

/*
		Exotic pets
*/

/datum/supply_pack/animal/parrot
	name = "Bird Crate"
	desc = "Contains five expert telecommunication birds."
	cost = 4000
	contains = list(/mob/living/simple_animal/parrot)
	crate_name = "parrot crate"

/datum/supply_pack/animal/parrot/generate()
	. = ..()
	for(var/i in 1 to 4)
		new /mob/living/simple_animal/parrot(.)

/datum/supply_pack/animal/fox
	name = "Fox Crate"
	desc = "The fox goes...? Comes with a collar!"//what does the fox say // awful //yip
	cost = 5000
	contains = list(/mob/living/simple_animal/pet/fox,
					/obj/item/clothing/neck/petcollar)
	crate_name = "fox crate"

/datum/supply_pack/animal/butterfly
	name = "Butterflies Crate"
	desc = "Not a very dangerous insect, but they do give off a better image than, say, flies or cockroaches."//is that a motherfucking worm reference
	cost = 5000
	contains = list(/mob/living/simple_animal/butterfly)
	crate_name = "entomology samples crate"

/datum/supply_pack/animal/butterfly/generate()
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/simple_animal/butterfly(.)

/datum/supply_pack/animal/snake
	name = "Snake Crate"
	desc = "Tired of these MOTHER FUCKING snakes on this MOTHER FUCKING spaceplane? Then this isn't the crate for you. Contains three poisonous snakes."
	cost = 5000
	contains = list(/mob/living/simple_animal/hostile/retaliate/poison/snake,
					/mob/living/simple_animal/hostile/retaliate/poison/snake,
					/mob/living/simple_animal/hostile/retaliate/poison/snake)
	crate_name = "snake crate"

/*
		Insane
*/

/datum/supply_pack/animal/crab
	name = "Crab Rocket"
	desc = "CRAAAAAAB ROCKET. CRAB ROCKET. CRAB ROCKET. CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB ROCKET. CRAFT. ROCKET. BUY. CRAFT ROCKET. CRAB ROOOCKET. CRAB ROOOOCKET. CRAB CRAB CRAB CRAB CRAB CRAB CRAB CRAB ROOOOOOOOOOOOOOOOOOOOOOCK EEEEEEEEEEEEEEEEEEEEEEEEE EEEETTTTTTTTTTTTAAAAAAAAA AAAHHHHHHHHHHHHH. CRAB ROCKET. CRAAAB ROCKEEEEEEEEEGGGGHHHHTT CRAB CRAB CRAABROCKET CRAB ROCKEEEET."//fun fact: i actually spent like 10 minutes and transcribed the entire video.
	cost = 10000
	contains = list(/mob/living/simple_animal/crab)
	crate_name = "look sir free crabs"
	// DropPodOnly = TRUE

/datum/supply_pack/animal/crab/generate()
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/simple_animal/crab(.)
