/obj/item/reagent_containers/food/snacks/burger
	filling_color = "#CD853F"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "hburger"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtype = GRAIN | MEAT //lettuce doesn't make burger a vegetable.

/obj/item/reagent_containers/food/snacks/burger/plain
	name = "burger"
	desc = "A Solarian culinary cornerstone: a beef patty between a sliced bun or roll, with additional condiments and ingredients included between them."
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/plain/Initialize()
	. = ..()
	if(prob(1))
		new/obj/effect/particle_effect/smoke(get_turf(src))
		playsound(src, 'sound/effects/smoke.ogg', 50, TRUE)
		visible_message("<span class='warning'>Oh, ye gods! [src] is ruined! But what if...?</span>")
		name = "steamed ham"
		desc = pick("Ahh, Head of Personnel, welcome. I hope you're prepared for an unforgettable luncheon!",
		"And you call these steamed hams despite the fact that they are obviously microwaved?",
		"Aurora Station 13? At this time of shift, in this time of year, in this sector of space, localized entirely within your freezer?",
		"You know, these hamburgers taste quite similar to the ones they have at the Maltese Falcon.")
		tastes = list("fast food hamburger" = 1)

/obj/item/reagent_containers/food/snacks/burger/human
	var/subjectname = ""
	var/subjectjob = null
	name = "human burger"
	desc = "A hamburger prepared with oddly lean cut of meat. Something feels off..."
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("bun" = 2, "long pork" = 4)
	foodtype = MEAT | GRAIN | GORE

/obj/item/reagent_containers/food/snacks/burger/human/CheckParts(list/parts_list)
	..()
	var/obj/item/reagent_containers/food/snacks/meat/M = locate(/obj/item/reagent_containers/food/snacks/meat/steak/plain/human) in contents
	if(M)
		subjectname = M.subjectname
		subjectjob = M.subjectjob
		if(subjectname)
			name = "[subjectname] burger"
		else if(subjectjob)
			name = "[subjectjob] burger"
		qdel(M)


/obj/item/reagent_containers/food/snacks/burger/corgi
	name = "corgi burger"
	desc = "A hamburger prepared with dog meat. An aura of desperation hangs around it..."
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT | GORE

/obj/item/reagent_containers/food/snacks/burger/appendix
	name = "appendix burger"
	desc = "A hamburger made with an appendix, a vestigial organ from human beings. That doesn't make this count as a culinary delicacy."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	icon_state = "appendixburger"
	tastes = list("bun" = 4, "vestigial meat" = 2)
	foodtype = GRAIN | MEAT | GORE

/obj/item/reagent_containers/food/snacks/burger/fish
	name = "fillet -o- carp sandwich"
	desc = "A breaded and fried square of space carp, usually with tartar sauce and cheese kept between a sliced, steamed bun."
	icon_state = "fishburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("bun" = 4, "fish" = 4)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/tofu
	name = "tofu burger"
	desc = "A vegetarian alternative to a hamburger. The tofu is noticeably softer than meat."
	icon_state = "tofuburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("bun" = 4, "firm tofu" = 4)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/burger/roburger
	name = "roburger"
	desc = "A hamburger made from metal parts. You can't imagine how you'll manage to get a bite in..."
	icon_state = "roburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/nanomachines = 2, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/nanomachines = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("bun" = 4, "lettuce" = 2, "copper" = 1)
	foodtype = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/burger/roburgerbig
	name = "roburger"
	desc = "A hamburger made from a \"cut\" of some machinery. Your mind struggles to understand how this came to be."
	icon_state = "roburger"
	volume = 120
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/nanomachines = 70, /datum/reagent/consumable/nutriment/vitamin = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/nanomachines = 70, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("bun" = 4, "lettuce" = 2, "wires" = 1)
	foodtype = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/burger/xeno
	name = "xenoburger"
	desc = " hamburger made with a neon green patty of... something. You notice that the meat is starting to emulcify the rest of the burger."
	icon_state = "xburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("bun" = 4, "coppery acid" = 4)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/bearger
	name = "bearger"
	desc = "A hamburger made from a local variant of ursa stellaris. It's a challenge to tear a bite out of it."
	icon_state = "bearger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 6)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/clown
	name = "clown burger"
	desc = "A hamburger made out of bananas, shaped into a loose patty, and garnished with... is this a prank?"
	icon_state = "clownburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/banana = 6)
	foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/burger/mime
	name = "mime burger"
	desc = "A monotone-looking burger, from a bygone era. It tastes like nothing at all."
	icon_state = "mimeburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nothing = 6)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/burger/brain
	name = "brainburger"
	desc = "A hamburger whose patty is made from a brain. A... delicacy, to say the least."
	icon_state = "brainburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/medicine/mannitol = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/medicine/mannitol = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("bun" = 4, "soft meat" = 2)
	foodtype = GRAIN | MEAT | GORE

/obj/item/reagent_containers/food/snacks/burger/ghost
	name = "ghost burger"
	desc = "This burger oozes a sickly green substance that causes your fingers to tingle. It seems to float supernaturally..."
	icon_state = "ghostburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 12, /datum/reagent/consumable/sodiumchloride = 5)
	tastes = list("frightening bun" = 2, "terrifying ooze" = 4)
	foodtype = GRAIN
	alpha = 170
	verb_say = "moans"
	verb_yell = "wails"

/obj/item/reagent_containers/food/snacks/burger/ghost/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/burger/ghost/process()
	if(!isturf(loc)) //no floating out of bags
		return
	var/paranormal_activity = rand(100)
	switch(paranormal_activity)
		if(97 to 100)
			audible_message("[src] rattles a length of chain.")
			playsound(loc,'sound/spookoween/chain_rattling.ogg', 300, TRUE)
		if(91 to 96)
			say(pick("OoOoOoo.", "OoooOOooOoo!!"))
		if(84 to 90)
			dir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			step(src, dir)
		if(71 to 83)
			step(src, dir)
		if(65 to 70)
			var/obj/machinery/light/L = locate(/obj/machinery/light) in view(4, src)
			if(L)
				L.flicker()
		if(62 to 64)
			playsound(loc,pick('sound/hallucinations/i_see_you1.ogg', 'sound/hallucinations/i_see_you2.ogg'), 50, TRUE, ignore_walls = FALSE)
		if(61)
			visible_message("[src] spews out a glob of ectoplasm!")
			new /obj/effect/decal/cleanable/greenglow/ecto(loc)
			playsound(loc,'sound/effects/splat.ogg', 200, TRUE)

		//If i was less lazy i would make the burger forcefeed itself to a nearby mob here.

/obj/item/reagent_containers/food/snacks/burger/ghost/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/reagent_containers/food/snacks/burger/red
	name = "red burger"
	desc = "A food color-dyed burger. Perfect for hiding the fact it's burnt to a crisp."
	icon_state = "cburger"
	color = "#DA0000FF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/red = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/orange
	name = "orange burger"
	desc = "A food color-dyed burger. Despite the color, it contains no fruit juice."
	icon_state = "cburger"
	color = "#FF9300FF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/orange = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/yellow
	name = "yellow burger"
	desc = "A food color-dyed burger. Bright to the last bite."
	icon_state = "cburger"
	color = "#FFF200FF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/yellow = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/green
	name = "green burger"
	desc = "A food color-dyed burger. It's not tainted meat, it's painted meat!"
	icon_state = "cburger"
	color = "#A8E61DFF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/green = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/blue
	name = "blue burger"
	desc = "A food color-dyed burger. Is this blue rare?"
	icon_state = "cburger"
	color = "#00B7EFFF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/blue = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/purple
	name = "purple burger"
	desc = "A food color-dyed burger. Of a more regal line of burger."
	icon_state = "cburger"
	color = "#DA00FFFF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/purple = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/black
	name = "black burger"
	desc = "A food color-dyed burger. It looks overcooked like this..."
	icon_state = "cburger"
	color = "#1C1C1C"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/black = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/white
	name = "white burger"
	desc = "A food color-dyed burger. Pale as a sheet..."
	icon_state = "cburger"
	color = "#FFFFFF"
	bonus_reagents = list(/datum/reagent/colorful_reagent/powder/white = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/spell
	name = "mage burger"
	desc = "A decorated hamburger in the style of a wizard. Usually found alongside a warriorburger and a priestburger."
	icon_state = "spellburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("bun" = 4, "spell components" = 2)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/bigbite
	name = "big bite burger"
	desc = "A hamburger biled high with tons of beef patties and add-ons. You steel yourself for the meal to come..."
	icon_state = "bigbiteburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/burger/jelly
	name = "jelly burger"
	desc = "A hamburger made from a shaped patty of some sort of fruit jelly. How very... sweet?"
	icon_state = "jellyburger"
	tastes = list("bun" = 4, "jelly" = 2)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/jelly/slime
	bonus_reagents = list(/datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/burger/jelly/cherry
	bonus_reagents = list(/datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/burger/superbite
	name = "super bite burger"
	desc = "A true spire of a hamburger, stretching up and threatening the ceiling. You better hope this wasn't made <i>just</i> for you."
	icon_state = "superbiteburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 40, /datum/reagent/consumable/nutriment/vitamin = 5)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 7
	volume = 100
	tastes = list("bun" = 4, "type two diabetes" = 10)
	foodtype = GRAIN | MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/burger/fivealarm
	name = "five alarm burger"
	desc = "An extremely spicy hamburger, prepared typically for challenges to bear the heat. Remember to tap out before you can't breathe anymore!"
	icon_state = "fivealarmburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5, /datum/reagent/consumable/condensedcapsaicin = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/rat
	name = "rat burger"
	desc = "A burger made with an entire rat in lieu of a bun. Any port in a storm...?"
	icon_state = "ratburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | MEAT | GORE

/obj/item/reagent_containers/food/snacks/burger/baseball
	name = "home run baseball burger"
	desc = "A hamburger with a crushed baseball instead of a beef patty. The leather is technically edible, but..."
	icon_state = "baseball"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = GRAIN | GROSS

/obj/item/reagent_containers/food/snacks/burger/baconburger
	name = "bacon burger"
	desc = "A commonly observed variation of the Solarian hamburger. The cuts of bacon add a pleasant crunch."
	icon_state = "baconburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("bacon" = 4, "bun" = 2)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/empoweredburger
	name = "empowered burger"
	desc = "An experiment in attempting to adapt food for consumption by elzuose. While they still can't taste it, you shouldn't go eating it for them."
	icon_state = "empoweredburger"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/liquidelectricity = 5)
	tastes = list("bun" = 2, "painful tingling" = 4)
	foodtype = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/burger/crab
	name = "crab burger"
	desc = "A hamburger made with a compressed patty of crab meat. It's very savory, if a little too easy to come apart."
	icon_state = "crabburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("bun" = 2, "crab meat" = 4)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/soylent
	name = "soylent burger"
	desc = "A hamburger made out of recycled biomass, shaped and textured into a meat patty. The origins of said biomass isn't known."
	icon_state = "soylentburger"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("bun" = 2, "assistant" = 4)
	foodtype = GRAIN | MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/burger/rib
	name = "mcrib"
	desc = "A long hamburger with an imitiation of a shortrib, smothered in barbeque sauce and onions. No one's sure where the name originates from, beyond its terran origins."
	icon_state = "mcrib"
	bonus_reagents = list(/datum/reagent/consumable/bbqsauce = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("bun" = 2, "pork patty" = 4)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/burger/mcguffin
	name = "mcguffin"
	desc = "A sliced intersolar muffin with a patty-shaped steamed and fried egg between. No one's sure where the name originates from, beyond its terran origins."
	icon_state = "mcguffin"
	tastes = list("muffin" = 2, "bacon" = 3)
	bonus_reagents = list(/datum/reagent/consumable/eggyolk = 3, /datum/reagent/consumable/nutriment = 1)
	foodtype = GRAIN | MEAT | BREAKFAST

/obj/item/reagent_containers/food/snacks/burger/chicken
	name = "chicken sandwich"
	desc = "A breaded and fried chicken breast, usually with lettuce and mayo between a sliced bun. A popular alternative to the beef-based hamburger."
	icon_state = "chickenburger"
	tastes = list("bun" = 2, "chicken" = 4, "lettuce" = 1)
	bonus_reagents = list(/datum/reagent/consumable/mayonnaise = 3, /datum/reagent/consumable/cooking_oil = 2, /datum/reagent/consumable/nutriment = 2)
	foodtype = GRAIN | MEAT | FRIED

/obj/item/reagent_containers/food/snacks/burger/cheese
	name = "cheese burger"
	desc = "A common enough variant of the hamburger with the inclusion of a slice of specifically made cheese. This type of cheese is not often used for any other cheese-based meals, interestingly enough."
	icon_state = "cheeseburger"
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 3)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	foodtype = GRAIN | MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/burger/cheese/Initialize()
	. = ..()
	if(prob(33))
		icon_state = "cheeseburgeralt"

