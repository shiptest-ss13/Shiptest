
////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/store/cheesewheel
	name = "cheese wheel"
	desc = "A wheel of yellow cheese, typically cut into wedges and slices."
	icon_state = "cheesewheel"
	slice_path = /obj/item/reagent_containers/food/snacks/cheesewedge
	slices_num = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/nutriment/vitamin = 5)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/store/tiris_cheese_wheel
	name = "tiris cheese"
	desc = "A bold cheese with a salty header. Tradition says to let the cheese age and form a crust before consuming it, but even without being aged, it has a strong, distinctive flavor."
	icon_state = "tiris-wheel"
	slice_path = /obj/item/food/tiris_cheese_slice
	slices_num = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/nutriment/vitamin = 5)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("rock salt" = 1, "rich cheese" = 4, "faint mushroom" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/cheesewedge
	name = "cheese wedge"
	desc = "A wedge of cheese, originating from a wheel. You wonder where the original wheel is."
	icon_state = "cheesewedge"
	filling_color = "#FFD700"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cheese" = 1)
	foodtype = DAIRY

/obj/item/food/tiris_cheese_slice
	name = "tiris cheese wedge"
	desc = "A wedge of bold tiris cheese. You wonder where the original wheel is."
	icon_state = "tiris-wedge"
	//filling_color = "#FFD700"
	//dried_type = /obj/item/reagent_containers/food/snacks/lifosa/homemade
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("rock salt" = 1, "rich cheese" = 4, "faint mushroom" = 1)
	foodtypes = DAIRY

/obj/item/food/watermelonslice
	name = "watermelon slice"
	desc = "A water-rich slice of watermelon. Little black seeds decorate the wedge."
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 5)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/candy_corn
	name = "candy corn"
	desc = "A singular candy corn, originating as a Solarian tradition. Interestingly, they are traditionally stored in the interior of a fedora or trilby."
	icon_state = "candy_corn"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2)
	filling_color = "#FF8C00"
	tastes = list("candy corn" = 1)
	foodtype = JUNKFOOD | SUGAR
	//food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/candy_corn/prison
	name = "desiccated candy corn"
	desc = "A thoroughly dried, dense piece of candy corn. It's difficult to even leave bite marks on."
	force = 1 // the description isn't lying
	throwforce = 1 // if someone manages to bust out of jail with candy corn god bless them
	tastes = list("bitter wax" = 1)
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/chocolatebar
	name = "chocolate bar"
	desc = "A bar of tempered milk chocolate, arranged into pre-shaped squares for easy measurement."
	icon_state = "chocolatebar"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/hugemushroomslice
	name = "huge mushroom slice"
	desc = "An immense slice of a mushroom's fruiting body. The gills on the underside have since been flattened."
	icon_state = "hugemushroomslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/popcorn
	name = "popcorn"
	desc = "A bag of popped corn kernels, traditionally topped with butter and other seasonings. Typically eaten while watching something, due to its ability to last for some time as an idle finger-food."
	icon_state = "popcorn"
	trash = /obj/item/trash/popcorn
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	filling_color = "#FFEFD5"
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/popcorn/Initialize()
	. = ..()
	eatverb = pick("bite","nibble","gnaw","gobble","chomp")

/obj/item/reagent_containers/food/snacks/loadedbakedpotato
	name = "loaded baked potato"
	desc = "A potato that's been cut and spread down the middle, then filled with toppings and baked."
	icon_state = "loadedbakedpotato"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#D2B48C"
	tastes = list("potato" = 1)
	foodtype = VEGETABLES | DAIRY

/obj/item/food/miras_potato
	name = "Miras Loaded Potato"
	desc = "A Lanchester classic, Miras is baked over a potato, and then topped with Luna-Town cheese and sour cream."
	icon_state = "miras-potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("potato" = 2, "sweet meat" = 1, "cheese" = 1, "sour cream" = 1)
	foodtypes = MEAT | SUGAR | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/fries
	name = "space fries"
	desc = "A form of fried potato sticks. While there are many shapes and seasonings available, the original is considered straight, thinly cut, and salted."
	icon_state = "fries"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	filling_color = "#FFD700"
	tastes = list("fries" = 3, "salt" = 1)
	foodtype = VEGETABLES | GRAIN | FRIED

/obj/item/reagent_containers/food/snacks/fries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/soydope
	name = "soy dope"
	desc = "Prepared soybeans, or a \"dope\", used for a variety of vegetarian recipes."
	icon_state = "soydope"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	filling_color = "#DEB887"
	tastes = list("soy" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/cheesyfries
	name = "cheesy fries"
	desc = "Fried potato sicks smothered in cheese."
	icon_state = "cheesyfries"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#FFD700"
	tastes = list("fries" = 3, "cheese" = 1)
	foodtype = VEGETABLES | GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cheesyfries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/badrecipe
	name = "burned mess"
	desc = "A mass of semi-carbonized matter. The idea of eating this only makes you realize the desperation in the act."
	icon_state = "badrecipe"
	list_reagents = list(/datum/reagent/toxin/bad_food = 30)
	filling_color = "#8B4513"
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/carrotfries
	name = "carrot fries"
	desc = "Thinly sliced sticks of carrots, salted and fried."
	icon_state = "carrotfries"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/oculine = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FFA500"
	tastes = list("carrots" = 3, "salt" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/carrotfries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/candiedapple
	name = "candied apple"
	desc = "An apple coated in caramel and skewered on a stick. A common treat."
	icon_state = "candiedapple"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/caramel = 5)
	filling_color = "#FF4500"
	tastes = list("apple" = 2, "caramel" = 3)
	foodtype = JUNKFOOD | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/mint
	name = "mint"
	desc = "A small mint chocolate wafer. The confectionary company's symbol on the top isn't any you recognize..."
	icon_state = "mint"
	bitesize = 1
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/toxin/minttoxin = 2)
	filling_color = "#800000"
	foodtype = TOXIC | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/eggwrap
	name = "egg wrap"
	desc = "Thinly cooked egg, intended as a wrapper for a filling."
	icon_state = "eggwrap"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#F0E68C"
	tastes = list("egg" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/chawanmushi
	name = "chawanmushi"
	desc = "A savory egg custard originating from Earth, named after being prepared by being steamed in a tea bowl or teacup."
	icon_state = "chawanmushi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#FFE4E1"
	tastes = list("custard" = 1)
	foodtype = GRAIN | MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/spidereggs
	name = "spider eggs"
	desc = "A cluster of immense, translucent eggs. The spawn inside quicken to life at being disturbed..."
	icon_state = "spidereggs"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin = 2)
	filling_color = "#008000"
	tastes = list("warm not-grapes" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/mirasegg
	name = "miras eggs"
	desc = "The eggs of a Miras Lizard are typically extracted from their nest. The individual eggs are small and unfertilized, unless the Miras has mated recently."
	icon_state = "miras-egg"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/eggyolk = 2)
	dried_type = /obj/item/reagent_containers/food/snacks/reti/homemade
	filling_color = "#bae1ba"
	tastes = list("egg" = 1, "hints of spice" = 1)
	foodtype = MEAT | RAW

/obj/item/reagent_containers/food/snacks/spiderling
	name = "spiderling"
	desc = "Seemingly a small spider, this is actually a nymph of the much larger giant arachnid."
	icon_state = "spiderling"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin = 4)
	filling_color = "#00800"
	tastes = list("crunchy exterior" = 1, "silty filling" = 2)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/spiderlollipop
	name = "spider lollipop"
	desc = "A spider encased in candy. Sometimes sold as a gag souvenir, or as a genuine confection... though you're not sure if the species of spider inside is safe to eat."
	icon_state = "spiderlollipop"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin = 1, /datum/reagent/iron = 10, /datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/omnizine = 2) //lollipop, but vitamins = toxins
	filling_color = "#00800"
	tastes = list("candied insect" = 1, "sugar" = 2)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/chococoin
	name = "chocolate coin"
	desc = "A wafer of chocolate stylized as a coin."
	icon_state = "chococoin"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fudgedice
	name = "fudge dice"
	desc = "A little cube of solid fudge, with each face marked with a numerical pip."
	icon_state = "chocodice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	trash = /obj/item/dice/fudge
	tastes = list("fudge" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/chocoorange
	name = "chocolate orange"
	desc = "A traditional Solarian confectionary consisting of orange-infused chocolate, made in the mimicry of the orange fruit."
	icon_state = "chocoorange"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 3, "oranges" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/eggplantparm
	name = "eggplant parmigiana"
	desc = "Sliced and breaded eggplant, baked in cheese and marinara sauce."
	icon_state = "eggplantparm"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#BA55D3"
	tastes = list("eggplant" = 3, "cheese" = 1)
	foodtype = VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/tortilla
	name = "tortilla"
	desc = "A thin, unleavened flatbread used for dozens of dishes. Or eaten as is, if you want."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "tortilla"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#FFEFD5"
	tastes = list("tortilla" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/yakiimo
	name = "yaki imo"
	desc = "A popular winter street food, this is a whole roasted sweet potato."
	icon_state = "yakiimo"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#8B1105"
	tastes = list("sweet potato" = 1)
	foodtype = GRAIN | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/roastparsnip
	name = "roast parsnip"
	desc = "An entire roasted parsnip."
	icon_state = "roastparsnip"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FF5500"
	tastes = list("parsnip" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/melonfruitbowl
	name = "melon fruit bowl"
	desc = "A hollowed out watermelon, filled with other fruits and used as a bowl."
	icon_state = "melonfruitbowl"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FF5500"
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("melon" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/melonkeg
	name = "melon keg"
	desc = "A form of heavily genetically modified watermelon, which functions as a vessel for grain alcohol to ferment inside."
	icon_state = "melonkeg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/ethanol/vodka = 15, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FFD700"
	volume = 80
	bitesize = 5
	tastes = list("grain alcohol" = 1, "fruit" = 1)
	foodtype = FRUIT | ALCOHOL

/obj/item/food/honeybar
	name = "honey nut bar"
	desc = "Oats and nuts compressed together into a bar, held together with a honey glaze."
	icon_state = "honeybar"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/honey = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("oats" = 3, "nuts" = 2, "honey" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/crepe
	name = "jelly crepe"
	desc = "A crepe filled with jelly. It's very sticky."
	icon_state = "powercrepe"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/cherryjelly = 5)
	attack_verb = list("slapped", "slathered")
	tastes = list("cherry" = 1, "crepe" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/chewable
	slot_flags = ITEM_SLOT_MASK
	///How long it lasts before being deleted in seconds
	var/succ_dur = 360
	///The delay between each time it will handle reagents
	var/succ_int = 100
	///Stores the time set for the next handle_reagents
	var/next_succ = 0

	//makes snacks actually wearable as masks and still edible the old fashioned way.
/obj/item/reagent_containers/food/snacks/chewable/proc/handle_reagents()
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(!reagents.trans_to(C, REAGENTS_METABOLISM, method = INGEST))
					reagents.remove_any(REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)

/obj/item/reagent_containers/food/snacks/chewable/process(seconds_per_tick)
	if(iscarbon(loc))
		if(succ_dur <= 0)
			qdel(src)
			return
		succ_dur -= seconds_per_tick
		if((reagents && reagents.total_volume) && (next_succ <= world.time))
			handle_reagents()
			next_succ = world.time + succ_int

/obj/item/reagent_containers/food/snacks/chewable/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_MASK)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/chewable/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/reagent_containers/food/snacks/chewable/lollipop
	name = "lollipop"
	desc = "A sugary candy suspended atop a small stick, intended to be placed into the mouth and sucked on to slowly dissolve. Often used as a medium for chemicals, due to their ubiquity in doctor's offices."
	icon = 'icons/obj/lollipop.dmi'
	icon_state = "lollipop_stick"
	item_state = "lollipop_stick"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/iron = 10, /datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/omnizine = 2)	//Honk
	var/mutable_appearance/head
	var/headcolor = rgb(0, 0, 0)
	succ_dur = 15 * 60
	succ_int = 100
	next_succ = 0
	tastes = list("candy" = 1)
	foodtype = JUNKFOOD | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/chewable/lollipop/Initialize()
	. = ..()
	head = mutable_appearance('icons/obj/lollipop.dmi', "lollipop_head")
	change_head_color(rgb(rand(0, 255), rand(0, 255), rand(0, 255)))

/obj/item/reagent_containers/food/snacks/chewable/lollipop/proc/change_head_color(C)
	headcolor = C
	cut_overlay(head)
	head.color = C
	add_overlay(head)

/obj/item/reagent_containers/food/snacks/chewable/lollipop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..(hit_atom)
	throw_speed = 1
	throwforce = 0

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg
	var/spamchecking = TRUE

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(spamcheck)), 1200)

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/equipped(mob/living/user, slot)
	. = ..(user, slot)
	spamchecking = FALSE

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/proc/spamcheck()
	if(spamchecking)
		qdel(src)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum
	name = "bubblegum"
	desc = "A rubbery strip of gum. Not exactly filling, but it keeps you busy."
	icon_state = "bubblegum"
	supports_variations = VOX_VARIATION
	item_state = "bubblegum"
	color = "#E48AB5" // craftable custom gums someday?
	list_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/nicotine
	name = "nicotine gum"
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/consumable/menthol = 5)
	tastes = list("mint" = 1)
	color = "#60A584"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/happiness
	name = "HP+ gum"
	desc = "A rubbery strip of gum, originating from a fad of using gum as a vessel for recreational drugs. This one tastes particularly acrid..."
	list_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("intense chemical sweetness" = 1)
	color = "#EE35FF"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum
	name = "bubblegum gum"
	desc = "A rubbery strip of gum, which reeks of iron and sulfur."
	color = "#913D3D"
	list_reagents = list(/datum/reagent/blood = 15)
	tastes = list("coppery, sulfuric sugar" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/process(seconds_per_tick)
	. = ..()
	if(iscarbon(loc))
		hallucinate(loc)


/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/On_Consume(mob/living/eater)
	. = ..()
	if(iscarbon(eater))
		hallucinate(eater)

///This proc has a 5% chance to have a bubblegum line appear, with an 85% chance for just text and 15% for a bubblegum hallucination and scarier text.
/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/proc/hallucinate(mob/living/carbon/victim)
	if(!prob(5)) //cursed by bubblegum
		return
	if(prob(15))
		new /datum/hallucination/oh_yeah(victim)
		to_chat(victim, span_colossus("<b>[pick("I AM IMMORTAL.","I SHALL TAKE YOUR WORLD.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","NOTHING CAN HOLD ME.")]</b>"))
	else
		to_chat(victim, span_warning("[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]"))

/obj/item/reagent_containers/food/snacks/gumball
	name = "gumball"
	desc = "A colorful, sugary gumball."
	icon = 'icons/obj/lollipop.dmi'
	icon_state = "gumball"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/bicaridine = 2, /datum/reagent/medicine/kelotane = 2)	//Kek
	tastes = list("candy")
	foodtype = JUNKFOOD
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/gumball/Initialize()
	. = ..()
	color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))

/obj/item/reagent_containers/food/snacks/gumball/cyborg
	var/spamchecking = TRUE

/obj/item/reagent_containers/food/snacks/gumball/cyborg/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(spamcheck)), 1200)

/obj/item/reagent_containers/food/snacks/gumball/cyborg/equipped(mob/living/user, slot)
	. = ..(user, slot)
	spamchecking = FALSE

/obj/item/reagent_containers/food/snacks/gumball/cyborg/proc/spamcheck()
	if(spamchecking)
		qdel(src)

/obj/item/reagent_containers/food/snacks/branrequests
	name = "Bran Cereal"
	desc = "A box of cereal, consisting mainly of bran and raisins for the fiber content. Salt has been added for... some reason?"
	icon_state = "bran_requests"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("bran" = 4, "raisins" = 3)
	foodtype = GRAIN | FRUIT | BREAKFAST

/obj/item/reagent_containers/food/snacks/butter
	name = "stick of butter"
	desc = "A stick of rendered, churned cream. Used for many recipes."
	icon_state = "butter"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#FFD700"
	tastes = list("butter" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/butter/examine(mob/user)
	. = ..()
	. += span_notice("If you had a rod you could make <b>butter on a stick</b>. But... why would you?")

/obj/item/reagent_containers/food/snacks/butter/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = W
		if(!R.use(1))//borgs can still fail this if they have no metal
			to_chat(user, span_warning("You do not have enough metal to put [src] on a stick!"))
			return ..()
		to_chat(user, span_notice("You stick the rod into the stick of butter."))
		var/obj/item/reagent_containers/food/snacks/butter/on_a_stick/new_item = new(usr.loc)
		var/replace = (user.get_inactive_held_item() == R)
		if(!R && replace)
			user.put_in_hands(new_item)
		qdel(src)
		return TRUE
	..()

/obj/item/reagent_containers/food/snacks/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "butter on a stick"
	desc = "A stick of rendered, churned cream... on a stick."
	icon_state = "butteronastick"
	trash = /obj/item/stack/rods
	/*food_flags = FOOD_FINGER_FOOD*/

/obj/item/food/onionrings
	name = "onion rings"
	desc = "Onion slices coated in batter and fried."
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("batter" = 3, "onion" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pineappleslice
	name = "pineapple slice"
	desc = "A slice of pineapple."
	icon_state = "pineapple_slice"
	juice_results = list(/datum/reagent/consumable/pineapplejuice = 3)
	tastes = list("pineapple" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/tinychocolate
	name = "chocolate"
	desc = "A small, sweet milk chocolate."
	icon_state = "tiny_chocolate"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/canned
	name = "Canned Air"
	desc = "A canister of canned air, sold as a health fad for supposedly inhaling luxuriously purified air."
	list_reagents = list(/datum/reagent/oxygen = 6, /datum/reagent/nitrogen = 24)
	icon_state = "peachcan"
	in_container = TRUE
	reagent_flags = NONE
	spillable = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	volume = 30

/obj/item/reagent_containers/food/snacks/canned/proc/open_can(mob/user)
	to_chat(user, span_notice("You pull back the tab of \the [src]."))
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	reagents.flags |= OPENCONTAINER
	spillable = TRUE

/obj/item/reagent_containers/food/snacks/canned/attack_self(mob/user)
	if(!is_drainable())
		open_can(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/reagent_containers/food/snacks/canned/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, span_warning("[src]'s lid hasn't been opened!"))
		return 0
	return ..()

/obj/item/reagent_containers/food/snacks/canned/beans
	name = "tin of beans"
	desc = "A tin can of pre-cooked beans."
	icon_state = "beans"
	trash = /obj/item/trash/can/food/beans
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#B22222"
	tastes = list("beans" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/canned/peaches
	name = "canned peaches"
	desc = "A can of ripe peaches, suspended in syrup."
	icon_state = "peachcan"
	trash = /obj/item/trash/can/food/peaches
	list_reagents = list(/datum/reagent/consumable/peachjuice = 20, /datum/reagent/consumable/sugar = 8, /datum/reagent/consumable/nutriment = 2)
	filling_color = "#ffdf26"
	tastes = list("peaches" = 7, "syrup" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/canned/peaches/maint
	name = "maintenance peaches"
	desc = "A thoroughly dented can of peaches. This hasn't seen the light in some time..."
	icon_state = "peachcanmaint"
	trash = /obj/item/trash/can/food/peaches/maint
	tastes = list("peaches" = 1, "congealed syrup" = 7)

/obj/item/reagent_containers/food/snacks/crab_rangoon
	name = "crab rangoon"
	desc = "A form of fried dumpling, consisting of crab meat and cream cheese in a wonton wrapper."
	icon_state = "crabrangoon"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	filling_color = "#f2efdc"
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cream cheese" = 4, "crab" = 3, "crispiness" = 2)
	foodtype = MEAT | DAIRY | GRAIN

/obj/item/reagent_containers/food/snacks/cornchips
	name = "boritos corn chips"
	desc = "Lightly salted tortilla chips, usually served alongside a dipping sauce."
	icon_state = "boritos"
	trash = /obj/item/trash/boritos
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/cooking_oil = 2, /datum/reagent/consumable/sodiumchloride = 3)
	junkiness = 20
	filling_color = "#ECA735"
	tastes = list("tortilla chips" = 1, "salt" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/food/stuffed_refa
	name = "Stuffed Refa"
	desc = "Tiris cheese is removed from its crust and added to the fruits of a Refa-Li plant before being baked"
	icon_state = "stuff-refa"
	bite_consumption = 2
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	//filling_color = "#ECA735"
	tastes = list("hint of spice" = 1, "subtle fruitiness" = 1, "rich cheese" = 2)
	foodtypes = FRUIT | DAIRY

/obj/item/food/tiris_fondue
	name = "Fondue Tiris-Dotu"
	desc = "Fusion cuisine originating from travelling Solarians. This fondue is made of Tiris Cheese, and filled with small cubes of Dotu-Fime fruit. The flavor profile is reputed to be incredibly rich, especially with crackers."
	icon_state = "tiris-fondue"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/dotu_juice = 2)
	//filling_color = "#ECA735"
	tastes = list("hint of spice" = 1, "subtle fruitiness" = 1, "rich cheese" = 2)
	foodtypes = FRUIT | DAIRY

/obj/item/food/remes_roe
	name = "remes roe"
	desc = "The roe of a Remes is a topping that rose to prominence due to its serving during talks with Zohilese diplomats. The slight <i>pop</i> of the eggs was hailed as incredibly satisfying."
	icon_state = "remes-roe"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	//filling_color = "#ECA735"
	tastes = list("condensed salt" = 1, "satisfying pop" = 2)
	foodtypes = MEAT

/obj/item/food/fara_reti
	name = "fara-reti"
	desc = "The flesh of a fara-li fruit, once all the seeds have been removed, is quite mellow. Adding Remes roe into the flesh creates an experience filled with salty pops."
	icon_state = "stuff-refa"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2,)
	//filling_color = "#ECA735"
	tastes = list("condensed salt" = 1, "satisfying pop" = 1, "mellow fruitflesh" = 3)
	foodtypes = MEAT | FRUIT

/obj/item/food/roe_tiris
	name = "reti-tiris"
	desc = "Remes roe and Tiris plasma mixed together into a thick drink. Acquired taste is the nicest that can be said of it."
	icon_state = "sludge"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2,)
	//filling_color = "#ECA735"
	tastes = list("blood and salt" = 3, "umami" = 1, "subdued pops" = 1)
	foodtypes = MEAT | GROSS | GORE
