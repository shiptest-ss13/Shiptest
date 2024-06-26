//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu


////////////////////////////////////////////FISH////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/cubancarp
	name = "\improper Cuban carp"
	desc = "An spicy sandwich featuring fillets of space carp. Often enjoyed on colonies and stations where fishing trawls stalk their swarming grounds."
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
	desc = "A fillet of fish."
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
	desc = "A fillet of moonfish."
	icon_state = "moonfish_fillet"

/obj/item/reagent_containers/food/snacks/fishmeat/gunner_jellyfish
	name = "filleted gunner jellyfish"
	desc = "A gunner jellyfish with the stingers removed. Mildly hallucinogenic."
	icon_state = "jellyfish_fillet"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/toxin/mindbreaker = 2)

/obj/item/reagent_containers/food/snacks/fishmeat/armorfish
	name = "cleaned armorfish"
	desc = "An armorfish with its guts and shell removed, ready for use in cooking."
	icon_state = "armorfish_fillet"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/fishmeat/donkfish
	name = "donkfillet"
	desc = "The dreaded donkfish fillet. No sane person would eat this - the insides seemingly come undone, the anatomy mixing into itself as the separate organs and bones lose coherence into each other."
	icon_state = "donkfillet"
	list_reagents = list(/datum/reagent/yuck = 3)

/obj/item/reagent_containers/food/snacks/fishmeat/carp
	name = "carp fillet"
	desc = "A fillet of space carp."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/toxin/carpotoxin = 2, /datum/reagent/consumable/nutriment/vitamin = 2)

/obj/item/reagent_containers/food/snacks/fishmeat/carp/imitation
	name = "imitation carp fillet"
	desc = "An imitation of space carp, usually used as a vegetarian alternative."

/obj/item/reagent_containers/food/snacks/fishfingers
	name = "fish fingers"
	desc = "Uniformly sized and shaped finger food, made from breaded fish."
	icon_state = "fishfingers"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bitesize = 1
	filling_color = "#CD853F"
	tastes = list("fish" = 1, "breadcrumbs" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/fishandchips
	name = "fish and fries"
	desc = "A meal consisting of a battered and fried fish fillet, along with thickly cut and fried potato fries."
	icon_state = "fishandchips"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#FA8072"
	tastes = list("fish" = 1, "fries" = 1)
	foodtype = MEAT | VEGETABLES | FRIED

/obj/item/reagent_containers/food/snacks/vegetariansushiroll
	name = "vegetarian sushi roll"
	desc = "A roll of simple vegetarian sushi, with rice, carrots, and potatoes. Sliceable into pieces!"
	icon_state = "vegan-sushi-roll"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#7daa70"
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtype = VEGETABLES
	slice_path = /obj/item/reagent_containers/food/snacks/vegetariansushislice
	slices_num = 4

/obj/item/reagent_containers/food/snacks/vegetariansushislice
	name = "vegetarian sushi slice"
	desc = "A slice of simple vegetarian sushi, with rice, carrots, and potatoes."
	icon_state = "vegan-sushi-slice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#7daa70"
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/spicyfiletsushiroll
	name = "spicy filet sushi roll"
	desc = "A roll of spicy sushi, made with finely cut fish and vegetables. Sliceable into pieces!"
	icon_state = "spicy-sushi-roll"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#d8b02c"
	tastes = list("boiled rice" = 4, "fish" = 2, "spiciness" = 2)
	foodtype = VEGETABLES | MEAT
	slice_path = /obj/item/reagent_containers/food/snacks/spicyfiletsushislice
	slices_num = 4

/obj/item/reagent_containers/food/snacks/spicyfiletsushislice
	name = "spicy filet sushi slice"
	desc = "A roll of spicy sushi, made with finely cut fish and vegetables. Best eaten slowly."
	icon_state = "spicy-sushi-slice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#d8b02c"
	tastes = list("boiled rice" = 4, "fish" = 2, "spiciness" = 2)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/onigiri
	name = "onigiri"
	desc = "A ball of cooked rice surrounding a filling formed into a triangular shape and wrapped in seaweed."
	icon_state = "onigiri"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#d3ceba"
	tastes = list("rice" = 1, "dried seaweed" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/fishi
	name = "Ahktura-ruzhi"
	desc = "An entire fish, wrapped in a blanket of seaweed with no cuts made to it. Technically having existed as an Antechannel meal separate from Sol's concept of sushi, but the comparison is there. The meal has not had a graceful transition to using space carp, though."
	icon_state = "fi-shi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/toxin/carpotoxin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 18, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/toxin/carpotoxin = 8)
	filling_color = "#eac57b"
	tastes = list("raw fish" = 6, "dried seaweed" = 3)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/nigiri_sushi
	name = "nigiri sushi"
	desc = "A shaped base of rice bound to a thin cut of fish with seaweed. Served with soy sauce."
	icon_state = "nigiri_sushi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6)
	filling_color = "#d3ceba"
	tastes = list("boiled rice" = 2, "fish filet" = 2, "soy sauce" = 2, "dried seaweed" = 1)
	foodtype = VEGETABLES | MEAT

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/tofu
	name = "tofu"
	desc = "Shaped and pressed soybean milk curds. Extremely versatile in its usage, and comes in many forms of firmness."
	icon_state = "tofu"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	filling_color = "#F0E68C"
	tastes = list("tofu" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/tofu/prison
	name = "soggy tofu"
	desc = "Coagulated soymilk curds that failed to form real tofu. Technically even softer than silken tofu, but..."
	tastes = list("sour, rotten water" = 1)
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/spiderleg
	name = "spider leg"
	desc = "A thick arachnid leg, originating from the invasive giant arachnid. While technically edible, the giant arachnid's unnatural evolution results in dozens of stored and inert venom glands all across the viscera, making it a tough sell."
	icon_state = "spiderleg"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/boiledspiderleg
	filling_color = "#000000"
	tastes = list("unwelcome popping and acrid mouthfuls" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/cornedbeef
	name = "corned beef and cabbage"
	desc = "Corned beef served alongside boiled cabbage and potatoes."
	icon_state = "cornedbeef"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("meat" = 1, "cabbage" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/bearsteak
	name = "Bear's Spirit"
	desc = "A specially prepared meal, originating from the Saint Roumain's trapper's advice on cooking xenofauna. Served still aflame, it neutralizes the soporific in the meat."
	icon_state = "bearsteak"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("meat" = 1, "fire" = 1)
	foodtype = MEAT | ALCOHOL

/obj/item/reagent_containers/food/snacks/meatball
	name = "meatball"
	desc = "Ground beef, shaped into a ball and cooked."
	icon_state = "meatball"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#800000"
	tastes = list("meat" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/sausage
	name = "sausage"
	desc = "A length of finely minced meat, fed into a length of sausage casing typically made of intestine."
	icon_state = "sausage"
	filling_color = "#CD5C5C"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("meat" = 1)
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/salami
	foodtype = MEAT | BREAKFAST
	var/roasted = FALSE

/obj/item/reagent_containers/food/snacks/sausage/Initialize()
	. = ..()
	eatverb = pick("bite","chew","nibble","gobble","chomp")

/obj/item/reagent_containers/food/snacks/salami
	name = "salami"
	desc = "A slice of cured salami."
	icon_state = "salami"
	filling_color = "#CD4122"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("meat" = 1, "smoke" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/rawkhinkali
	name = "raw khinkali"
	desc = "One of the many Solarian styles of dumpling. The twisted tops and spiced filling makes this one unique."
	icon_state = "khinkali"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/garlic = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/khinkali
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/khinkali
	name = "khinkali"
	desc = "One of the many Solarian styles of dumpling. The twisted tops and spiced filling makes this one unique."
	icon_state = "khinkali"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/garlic = 1)
	bitesize = 3
	filling_color = "#F0F0F0"
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "A (horrifying)/(scientifically revolutionizing) invention, the monkey cube stores a lifeform \"more or less similar\" to the Terran chimp, which can then be used for scientific experiments. Sometimes used out of desperation for food by spacers. Do not consume."
	icon_state = "monkeycube"
	bitesize = 12
	list_reagents = list(/datum/reagent/monkey_powder = 30)
	filling_color = "#CD853F"
	tastes = list("supercompressed living matter" = 1, "meat, vaguely" = 1)
	foodtype = MEAT | SUGAR
	var/faction
	var/spawned_mob = /mob/living/carbon/monkey
	custom_price = 300

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
	desc = "A weaponized variation on the monkey cube, which rapidly deploys a Terran gorilla in a permanent fit of rage. Do not consume."
	bitesize = 20
	list_reagents = list(/datum/reagent/monkey_powder = 30, /datum/reagent/medicine/strange_reagent = 5)
	tastes = list("ultracompressed living matter" = 1, "meat, vaguely" = 1)
	spawned_mob = /mob/living/simple_animal/hostile/gorilla

/obj/item/reagent_containers/food/snacks/enchiladas
	name = "Enchiladas"
	desc = "A corn tortilla wrapped around a meaty filling, smothered and topped with a savory sauce and preferred toppings."
	icon_state = "enchiladas"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 4
	filling_color = "#FFA07A"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/capsaicin = 6)
	tastes = list("hot peppers" = 1, "meat" = 3, "cheese" = 1, "sour cream" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/stewedsoymeat
	name = "stewed tofu"
	desc = "A type of braised, spiced tofu placed into a stew."
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
	desc = "A thoroughly boiled and prepared giant arachnid leg. With the various venom glands removed and the meat steamed from within the carapace, it takes on a crab-like texture. The spice, however, is a mystery."
	icon_state = "spiderlegcooked"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/capsaicin = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/capsaicin = 2)
	filling_color = "#000000"
	tastes = list("hot peppers" = 1, "crab, sorta" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/spidereggsham
	name = "green eggs and ham"
	desc = "Would you eat them on Haruspex? Would you eat them with Gorlex? Would you eat them on a Tranquility? Would you eat them, just you and me?"
	icon_state = "spidereggsham"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 4
	filling_color = "#7FFF00"
	tastes = list("meat" = 1, "the colour green" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/sashimi
	name = "carp sashimi"
	desc = "Thinly sliced cuts of space carp. With the toxic portions removed, this time."
	icon_state = "sashimi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/capsaicin = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5)
	filling_color = "#FA8072"
	tastes = list("fish" = 1, "hot peppers" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/nugget
	name = "chicken nugget"
	filling_color = "#B22222"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("\"chicken\"" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/nugget/Initialize()
	. = ..()
	var/shape = pick("lump", "star", "lizard", "corgi")
	desc = "A 'chicken' nugget vaguely shaped like a [shape]."
	icon_state = "nugget_[shape]"

/obj/item/reagent_containers/food/snacks/pigblanket
	name = "pig in a blanket"
	desc = "A small sausage wrapped in a flakey, buttery roll."
	icon_state = "pigblanket"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#800000"
	tastes = list("meat" = 1, "butter" = 1)
	foodtype = MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/bbqribs
	name = "bbq ribs"
	desc = "Barbeque ribs, slathered in it's namesake sauce."
	icon_state = "ribs"
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/bbqsauce = 5)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("meat" = 3, "smoky sauce" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meatclown
	name = "meat clown"
	desc = "A delicious, round piece of meat clown. You're not sure why this is here."
	icon_state = "meatclown"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/banana = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("meat" = 5, "clowns" = 3)
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
	desc = "A human meat, on a stick."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("tender meat" = 3, "metal" = 1)
	foodtype = MEAT | GORE

/obj/item/reagent_containers/food/snacks/kebab/monkey
	name = "meat-kebab"
	desc = "Delicious meat, on a stick."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("meat" = 3, "metal" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/kebab/tofu
	name = "tofu-kebab"
	desc = "Extra firm tofu, on a stick."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("tofu" = 3, "metal" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/kebab/rat
	name = "rat-kebab"
	desc = "Not so delicious rat meat, on a stick."
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
	desc = "A delicious fish stir fry."
	icon_state = "fish_fry"
	list_reagents = list (/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	filling_color = "#ee7676"
	tastes = list("fish" = 1, "pan seared vegtables" = 1)
	foodtype = MEAT | VEGETABLES | FRIED
