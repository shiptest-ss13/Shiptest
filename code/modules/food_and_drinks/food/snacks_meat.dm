//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu


////////////////////////////////////////////FISH////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/cubancarp
	name = "\improper Cuban carp"
	desc = "A sandwich consisting of heavily spiced and batter-fried fish. It's very hot!"
	icon_state = "cubancarp"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	bitesize = 3
	filling_color = "#CD853F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 1)
	tastes = list("fish" = 4, "batter" = 1, "hot peppers" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/fishmeat
	name = "fish fillet"
	desc = "A fillet of fresh fish."
	icon_state = "fishfillet"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 6
	filling_color = "#FA8072"
	tastes = list("fish" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/fishmeat/Initialize()
	. = ..()
	eatverb = pick("bite","chew","gnaw","swallow","chomp")

/obj/item/reagent_containers/food/snacks/fishmeat/moonfish
	name = "moonfish fillet"
	desc = "A fillet of moonfish, native to Kalxicis and notable for its unique hue and texture."
	icon_state = "moonfish_fillet"

/obj/item/reagent_containers/food/snacks/fishmeat/gunner_jellyfish
	name = "filleted gunner jellyfish"
	desc = "A gunner jellyfish's main mass, with the stingers safely removed. Mildly hallucinogenic when consumed raw."
	icon_state = "jellyfish_fillet"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/toxin/mindbreaker = 2)

/obj/item/reagent_containers/food/snacks/fishmeat/armorfish
	name = "cleaned armorfish"
	desc = "An armorfish, properly gutted and unshelled."
	icon_state = "armorfish_fillet"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/fishmeat/donkfish
	name = "donkfillet"
	desc = "A fillet of the proprietary organism and affront to Solarian ethical genetic experimentation known as the \"donkfish\". The interior mass is a mess of chaotic meat and cancerous growths, with semi-formed organs and teratomas giving it a dire texture."
	icon_state = "donkfillet"
	list_reagents = list(/datum/reagent/yuck = 3)

/obj/item/reagent_containers/food/snacks/fishmeat/carp
	name = "carp fillet"
	desc = "A fillet of space carp meat. It's not suitable for consumption raw, due to their unique biology of bearing an unsafe chemical within its body."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/toxin/carpotoxin = 2, /datum/reagent/consumable/nutriment/vitamin = 2)

/obj/item/reagent_containers/food/snacks/fishmeat/carp/imitation
	name = "imitation carp fillet"
	desc = "Firm, shaped tofu in the style of a fish fillet."

/obj/item/reagent_containers/food/snacks/fishfingers
	name = "fish fingers"
	desc = "A rectangular serving of fish, battered and fried."
	icon_state = "fishfingers"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bitesize = 1
	filling_color = "#CD853F"
	tastes = list("fish" = 1, "breadcrumbs" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/fishandchips
	name = "fish and fries" //we have destroyed the british
	desc = "Battered, fried fish alongside a side of potato fries."
	icon_state = "fishandchips"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#FA8072"
	tastes = list("fish" = 1, "chips" = 1)
	foodtype = MEAT | VEGETABLES | FRIED

/obj/item/reagent_containers/food/snacks/vegetariansushiroll
	name = "vegetarian sushi roll"
	desc = "A sushi roll consisting of rice, carrots, and potatoes wrapped in seaweed. A techncial sibling to the \"california\" roll, but the origins of the name are unknown. Can be sliced into individual servings."
	icon_state = "vegan-sushi-roll"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#7daa70"
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtype = VEGETABLES
	slice_path = /obj/item/reagent_containers/food/snacks/vegetariansushislice
	slices_num = 4

/obj/item/reagent_containers/food/snacks/vegetariansushislice
	name = "vegetarian sushi roll slice"
	desc = "A slice of sushi consisting of rice, carrots, and potatoes."
	icon_state = "vegan-sushi-slice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#7daa70"
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/spicyfiletsushiroll
	name = "spicy fish roll"
	desc = "A makizushi roll containing spicy, raw fish wrapped with rice and other vegetables. can be sliced into individual servings."
	icon_state = "spicy-sushi-roll"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#d8b02c"
	tastes = list("boiled rice" = 4, "fish" = 2, "spiciness" = 2)
	foodtype = VEGETABLES | MEAT
	slice_path = /obj/item/reagent_containers/food/snacks/spicyfiletsushislice
	slices_num = 4

/obj/item/reagent_containers/food/snacks/spicyfiletsushislice
	name = "spicy fish roll slice"
	desc = "A slice of a makizushi roll containing spicy, raw fish wrapped with rice and other vegetables."
	icon_state = "spicy-sushi-slice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#d8b02c"
	tastes = list("boiled rice" = 4, "fish" = 2, "spiciness" = 2)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/onigiri
	name = "onigiri"
	desc = "A specially-shaped rice ball shaped around a filling, wrapped in seaweed. This one seems to lack a filling entirely..."
	icon_state = "onigiri"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#d3ceba"
	tastes = list("rice" = 1, "dried seaweed" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/fishi
	name = "Zohil temaki roll"
	desc = "A form of temaki roll originating from Zohil, which consists of a whole, specially prepared fish that is wrapped in seaweed. While this recipe saw success there, space carp's natural toxicity makes this... difficult."
	icon_state = "fi-shi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/toxin/carpotoxin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 18, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/toxin/carpotoxin = 8)
	filling_color = "#eac57b"
	tastes = list("raw fish" = 6, "dried seaweed" = 3)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/nigiri_sushi
	name = "nigiri sushi"
	desc = "A form of sushi, consisting of a hand-shaped rice mound with a topping of choice bound to it with seaweed. This one appears to have a topping of raw fish."
	icon_state = "nigiri_sushi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6)
	filling_color = "#d3ceba"
	tastes = list("boiled rice" = 2, "fish filet" = 2, "soy sauce" = 2, "dried seaweed" = 1)
	foodtype = VEGETABLES | MEAT

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/tofu
	name = "tofu"
	desc = "A culinary cornerstone of soy milk bean curds. Comes in many consistencies."
	icon_state = "tofu"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	filling_color = "#F0E68C"
	tastes = list("tofu" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/tofu/prison
	name = "soggy tofu"
	desc = "Tofu, while made of curds of soybean milk, isn't supposed to end up this way..."
	tastes = list("sour, rotten water" = 1)
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/spiderleg
	name = "spider leg"
	desc = "A monstrously-sized leg of a giant arachnid. Their bizarre anatomy reveals smaller venom sacs stored in their muscle tissue - each twitch threatens you with its payload."
	icon_state = "spiderleg"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/boiledspiderleg
	filling_color = "#000000"
	tastes = list("venom-laden meat" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/cornedbeef
	name = "corned beef and cabbage"
	desc = "A meal consisting of cured beef boiled alongside a serving of cabbage. Fairly simple, but still filling."
	icon_state = "cornedbeef"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("meat" = 1, "cabbage" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/bearsteak
	name = "Filet migrawr"
	desc = "A sauteed cut of \"ursus aurora\", or a space bear. With enough heat, it neutralizes the naturally produced morphine within it."
	icon_state = "bearsteak"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("meat" = 1, "salmon" = 1)
	foodtype = MEAT | ALCOHOL

/obj/item/reagent_containers/food/snacks/meatball
	name = "meatball"
	desc = "Ground meat shaped into small balls, popularly eaten in sandwiches and alongside pasta."
	icon_state = "meatball"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#800000"
	tastes = list("meat" = 1)
	foodtype = MEAT
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/sausage
	name = "sausage"
	desc = "A serving of sausage, created by grinding meat and storing it in lengths of sausage casing."
	icon_state = "sausage"
	filling_color = "#CD5C5C"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("meat" = 1)
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/salami
	foodtype = MEAT | BREAKFAST
	/*food_flags = FOOD_FINGER_FOOD*/
	var/roasted = FALSE

/obj/item/reagent_containers/food/snacks/sausage/Initialize()
	. = ..()
	eatverb = pick("bite","chew","nibble","gobble","chomp")

/obj/item/reagent_containers/food/snacks/salami
	name = "salami"
	desc = "A slice of cured, fermented meat."
	icon_state = "salami"
	filling_color = "#CD4122"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("meat" = 1, "smoke" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/rawkhinkali
	name = "raw khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic. This one needs to be boiled."
	icon_state = "khinkali"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/garlic = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/khinkali
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/khinkali
	name = "khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic."
	icon_state = "khinkali"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/garlic = 1)
	bitesize = 3
	filling_color = "#F0F0F0"
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "Specially created by for use in research labs by the Student-Union Association of Naturalistic Sciences, this cube contains a lifeform \"technically considered adjacent enough to qualify as\" the Terran chimpanzee. Just add water!"
	icon_state = "monkeycube"
	bitesize = 12
	list_reagents = list(/datum/reagent/monkey_powder = 30)
	filling_color = "#CD853F"
	tastes = list("hypercompressed proteins" = 1, "bananas" = 1)
	foodtype = MEAT | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY
	var/faction
	var/spawned_mob = /mob/living/carbon/monkey
	custom_price = 5

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Expand()
	var/mob/spammer = get_mob_by_key(fingerprintslast)
	var/mob/living/bananas = new spawned_mob(drop_location(), TRUE, spammer)
	if(faction)
		bananas.faction = faction
	if (!QDELETED(bananas))
		visible_message("<span class='notice'>[src] expands!</span>")
		bananas.log_message("Spawned via [src] at [AREACOORD(src)], Last attached mob: [key_name(spammer)].", LOG_ATTACK)
	else if (!spammer) // Visible message in case there are no fingerprints
		visible_message("<span class='notice'>[src] fails to expand!</span>")
	qdel(src)

/obj/item/reagent_containers/food/snacks/monkeycube/syndicate
	faction = list("neutral", ROLE_SYNDICATE)

/obj/item/reagent_containers/food/snacks/monkeycube/gorilla
	name = "gorilla cube"
	desc = "Specially created by for use in research labs by the The Student-Union Association of Naturalistic Sciences (then modified by an unscruplus third party), this cube contains a lifeform \"technically considered adjacent enough to qualify as\" the Terran silverback gorilla. These ones are often seen deployed in combat situations."
	bitesize = 20
	list_reagents = list(/datum/reagent/monkey_powder = 30, /datum/reagent/medicine/strange_reagent = 5)
	tastes = list("hypercompressed matter" = 1, "bananas" = 1, "rage" = 1)
	spawned_mob = /mob/living/simple_animal/hostile/gorilla

/obj/item/reagent_containers/food/snacks/enchiladas
	name = "enchiladas"
	desc = "A warm meal of filled corn tortillas and coated in a savory, chili-based sauce."
	icon_state = "enchiladas"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 4
	filling_color = "#FFA07A"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/capsaicin = 6)
	tastes = list("hot peppers" = 1, "meat" = 3, "cheese" = 1, "sour cream" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/stewedsoymeat
	name = "stewed soy meat"
	desc = "Heavily stewed firm tofu, meant to emulate braised beef."
	icon_state = "stewedsoymeat"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#D2691E"
	tastes = list("soy" = 1, "vegetables" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/stewedsoymeat/Initialize()
	. = ..()
	eatverb = pick("slurp","sip","inhale","drink")

/obj/item/reagent_containers/food/snacks/boiledspiderleg
	name = "boiled spider leg"
	desc = "A monstrously-sized leg from an immense spider, now rendered palatable after being boiled and steamed. The venom has neutralized into an intense spice, and the meat is not disimilar to crab." //Its cooked and not GORE, so it shouldnt imply that its gross to eat
	icon_state = "spiderlegcooked"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/capsaicin = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/capsaicin = 2)
	filling_color = "#000000"
	tastes = list("tongue tingling heat" = 1, "crab(?) meat" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/spidereggsham
	name = "green eggs and ham"
	desc = "Food color-dyed fried eggs and ham. Would you eat them on Zohil? Would you eat them to have your fill? Would you eat it with a kepori? Would you eat it with just you and me?"
	icon_state = "spidereggsham"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 4
	filling_color = "#7FFF00"
	tastes = list("meat" = 1, "the color green" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/sashimi
	name = "carp sashimi"
	desc = "Carefully prepared, thinly cut space carp sashimi. Thanks to the preparation, the carpotoxin has denatured into an intensely pungent spice."
	icon_state = "sashimi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/capsaicin = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5)
	filling_color = "#FA8072"
	tastes = list("fish" = 1, "tongue-searing heat" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/nugget
	name = "chicken nugget"
	filling_color = "#B22222"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("\"chicken\"" = 1)
	foodtype = MEAT
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/nugget/Initialize()
	. = ..()
	var/shape = pick("lump", "star", "lizard", "corgi")
	desc = "A nugget of chicken, shaped into the form of a [shape]."
	icon_state = "nugget_[shape]"

/obj/item/reagent_containers/food/snacks/pigblanket
	name = "pig in a blanket"
	desc = "A small sausage wrapped in a buttery breadroll."
	icon_state = "pigblanket"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#800000"
	tastes = list("meat" = 1, "butter" = 1)
	foodtype = MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/bbqribs
	name = "barbeque ribs"
	desc = "A rack of ribs slathered in a healthy coating of BBQ sauce before being braised."
	icon_state = "ribs"
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/bbqsauce = 5)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("meat" = 3, "smokey sauce" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meatclown
	name = "meat clown"
	desc = "A cylindrical slice of bologna, rendered into the expression of a clown. Its cheerful, meaty smile weakens you."
	icon_state = "meatclown"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/banana = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("meat" = 5, "poor decisions" = 3, "discomfort" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meatclown/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 30)

//////////////////////////////////////////// KEBABS AND OTHER SKEWERS ////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/kebab
	trash = /obj/item/stack/rods
	icon_state = "kebab"
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("meat" = 3, "metal" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/kebab/human
	name = "human-kebab"
	desc = "Chunks of meat that have been cooked and served on a skewer. This one is oddly tender."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("tender meat" = 3, "metal" = 1)
	foodtype = MEAT | GORE

/obj/item/reagent_containers/food/snacks/kebab/monkey
	name = "meat-kebab"
	desc = "Chunks of meat that have been cooked and served on a skewer."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("meat" = 3, "metal" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/kebab/tofu
	name = "tofu-kebab"
	desc = "Chunks of firm, seasoned tofu that have been cooked and served on a skewer."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("tofu" = 3, "metal" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/kebab/rat
	name = "rat-kebab"
	desc = "A body of a rat that has been cooked and served on a skewer. Not for the faint of heart."
	icon_state = "ratkebab"
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("rat meat" = 1, "metal" = 1)
	foodtype = MEAT | GORE

/obj/item/reagent_containers/food/snacks/kebab/rat/double
	name = "double rat-kebab"
	icon_state = "doubleratkebab"
	tastes = list("rat meat" = 2, "metal" = 1)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)

/obj/item/reagent_containers/food/snacks/kebab/fiesta
	name = "fiesta skewer"
	icon_state = "fiestaskewer"
	tastes = list("tex-mex" = 3, "cumin" = 2)
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/capsaicin = 3)

/obj/item/reagent_containers/food/snacks/fishfry
	name = "fish fry"
	desc = "A plate full of pan-fried fish and vegetables. A side of fries would be nice."
	icon_state = "fish_fry"
	list_reagents = list (/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	filling_color = "#ee7676"
	tastes = list("fish" = 1, "pan seared vegtables" = 1)
	foodtype = MEAT | VEGETABLES | FRIED
