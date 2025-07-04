/datum/supply_pack/animal
	category = "Animals"
	crate_type = /obj/structure/closet/crate/critter
	no_bundle = TRUE

/*
		Vaguely useful animals
*/

/datum/supply_pack/animal/monkey
	name = "Monkey Cube Crate"
	desc = "Stop monkeying around! Contains seven monkey cubes. Just add water!"
	cost = 1500
	contains = list (/obj/item/storage/box/monkeycubes)
	crate_name = "monkey cube crate"
	crate_type = /obj/structure/closet/crate
	no_bundle = FALSE

/datum/supply_pack/animal/chick
	name = "Chicken Crate"
	desc = "A crate containing a chicken."
	cost = 500
	contains = list(/mob/living/simple_animal/chick)
	crate_name = "chicken crate"

/datum/supply_pack/animal/goat
	name = "Goat Crate"
	desc = "A crate containing a goat."
	cost = 750
	contains = list(/mob/living/simple_animal/hostile/retaliate/goat)
	crate_name = "goat crate"

/datum/supply_pack/animal/cow
	name = "Cow Crate"
	desc = "A crate containing a cow."
	cost = 500
	contains = list(/mob/living/simple_animal/cow)
	crate_name = "cow crate"

/*
		Normal pets
*/

/datum/supply_pack/animal/cat
	name = "Cat Crate"
	desc = "The cat goes meow! Comes with a collar and a nice cat toy! Cheeseburger not included."//i can't believe im making this reference
	cost = 1000 //Cats are worth as much as corgis.
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
	cost = 1000
	contains = list(/mob/living/simple_animal/pet/dog/pug,
					/obj/item/clothing/neck/petcollar)
	crate_name = "pug crate"

/datum/supply_pack/animal/corgi
	name = "Corgi Crate"
	desc = "Considered the optimal dog breed by thousands of research scientists, this Corgi is but one dog from the millions of Ian's noble bloodline. Comes with a cute collar!"
	cost = 1000
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
	cost = 1500
	contains = list(/mob/living/simple_animal/pet/dog/corgi/exoticcorgi,
					/obj/item/clothing/neck/petcollar)
	crate_name = "exotic corgi crate"

/*
		Exotic pets
*/

/datum/supply_pack/animal/parrot
	name = "Bird Crate"
	desc = "Contains an expert telecommunication bird."
	cost = 2000
	contains = list(/mob/living/simple_animal/parrot)
	crate_name = "parrot crate"

/datum/supply_pack/animal/fox
	name = "Fox Crate"
	desc = "The fox goes...? Comes with a collar!"//what does the fox say // awful //yip
	cost = 1000
	contains = list(/mob/living/simple_animal/pet/fox,
					/obj/item/clothing/neck/petcollar)
	crate_name = "fox crate"

/datum/supply_pack/animal/butterfly
	name = "Butterflies Crate"
	desc = "Not a very dangerous insect, but they do give off a better image than, say, flies or cockroaches."//is that a motherfucking worm reference
	cost = 500
	contains = list(/mob/living/simple_animal/butterfly)
	crate_name = "entomology samples crate"

/datum/supply_pack/animal/butterfly/generate()
	. = ..()
	for(var/i in 1 to 3)
		new /mob/living/simple_animal/butterfly(.)

/datum/supply_pack/animal/snake
	name = "Snake Crate"
	desc = "Contains a poisonous snake. N+S Logistics are not responsible for any venomous injuries you may sustain."
	cost = 1000
	contains = list(/mob/living/simple_animal/hostile/retaliate/poison/snake)
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

/datum/supply_pack/animal/crab/generate()
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/simple_animal/crab(.)
